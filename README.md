## Docker image for titan over dynamo db

This is docker image for running graph database "Titan":http://titandb.io using "Amazon DynamoDB":https://aws.amazon.com/dynamodb/ as scalable storage backend

### Docker hub 
sinhaabhishek/titan100-dynamo

### Setup
docker build -t sinhaabhishek/titan100-dynamo

docker run --network=bridge -p 8182:8182 -p 80:80 -e AWS_ACCESS_KEY_ID=<your aws access key to access dynamo db>  -e AWS_SECRET_ACCESS_KEY=<your access key secret> titan100-dynamo

Currently it acceses dynamodb in us-east-1, in case you want to change it to other zone, change the dynamodb.properties in image (Will be configurable in next version)

### References
https://github.com/awslabs/dynamodb-janusgraph-storage-backend/tree/1.0.0 
