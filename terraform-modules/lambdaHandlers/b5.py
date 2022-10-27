import json
import urllib
import sys
import boto3
import os

s3Client = boto3.client('s3')
sqsClient = boto3.client('sqs')

_metadataBucket = os.environ['metadataBucket'] 
sqsUrl = os.environ['sqsUrl']    


def deleteQueueMessage(sqsUrl, ReceiptHandle):
    return sqsClient.delete_message(QueueUrl=sqsUrl,ReceiptHandle=ReceiptHandle)

def findS3EventObjectFromS3(event):
    s3EventObjectFromS3List = []
    checkEvent = 'Records' in event.keys()
    if checkEvent == True:
        for source in (event['Records']):
            receiptHandle = source['receiptHandle']
            actualData = json.loads(source['body'])
            s3Event = actualData['Records'][0]['s3']
            data = {'s3': s3Event, "receiptHandle": receiptHandle}
            s3EventObjectFromS3List.append(data)
            
    return s3EventObjectFromS3List    

def getObjectDetails(buckeName, fileName):
    results = s3Client.list_objects(Bucket=buckeName, Prefix=fileName)
    return 'Contents' in results

def getTags(buckeName, fileName):
    tag = s3Client.get_object_tagging(Bucket=buckeName, Key=fileName)
    return tag['TagSet']
    
def lambda_handler(event, context):
    s3ObjectIdentifier = findS3EventObjectFromS3(event)
    if s3ObjectIdentifier != []:
        for s3 in s3ObjectIdentifier:
            fileName = urllib.parse.unquote_plus(s3['s3']['object']['key'])
            sourceBucketName = urllib.parse.unquote_plus(s3['s3']['bucket']['name'])
            queueId = s3['receiptHandle']
            copyObject = { 'Bucket': sourceBucketName, 'Key': fileName }

            sourceGetObjectAvailable = getObjectDetails(sourceBucketName, fileName)
            targetGetObjectAvailable = getObjectDetails(sourceBucketName, fileName)

            if sourceGetObjectAvailable == True or targetGetObjectAvailable == True :
                updationTags = getTags(sourceBucketName, fileName)
                s3Client.put_object_tagging(Bucket=_metadataBucket, Key=fileName, Tagging={'TagSet': updationTags})
                s3Client.delete_object(Bucket=sourceBucketName, Key=fileName)
                deleteQueueMessage(sqsUrl, queueId)
                print(json.dumps({
                    "file": fileName,
                    "sourceBucket": sourceBucketName,
                    "destinationBucket": _metadataBucket,
                    "queueMessageDeleteStatus": True,
                    "tagUpdate": True,
                    "copyStatus": True,
                    "deleteQueueMessageStatus": True
                }))
            else:
                deleteQueueMessage(sqsUrl, queueId)
                print(f' <= {fileName} queue has been deleted')
