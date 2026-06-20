import json

def lambda_handler(event, context):

    for record in event['Records']:

        body = json.loads(record['body'])

        s3_record = body['Records'][0]

        bucket = s3_record['s3']['bucket']['name']
        key = s3_record['s3']['object']['key']

        print(f"Bucket: {bucket}")
        print(f"Object: {key}")

    return {
        "statusCode": 200
    }
