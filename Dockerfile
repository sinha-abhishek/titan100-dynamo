FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
#RUN yum update -y && sudo yum upgrade -y
#RUN yum install -y apache-maven sqlite-devel git java-1.8.0-openjdk-devel
#RUN  alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
#RUN alternatives --set javac /usr/lib/jvm/java-1.8.0-openjdk.x86_64/bin/javac

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y unzip curl oracle-java8-installer

RUN curl -o /opt/titan-dynamo.zip https://s3.amazonaws.com/dynamodb-titan-us-east-1/dynamodb-titan100-storage-backend-1.0.0-hadoop1.zip

RUN unzip /opt/titan-dynamo.zip -d /opt/ && \
    rm /opt/titan-dynamo.zip

#RUN mv dynamodb-titan100-storage-backend-1.0.0-hadoop1 titan-dynamo

ADD run.sh /opt/dynamodb-titan100-storage-backend-1.0.0-hadoop1/
RUN chmod +x /opt/dynamodb-titan100-storage-backend-1.0.0-hadoop1/run.sh

RUN sed  "s/\(host *: *\).*/\10.0.0.0/" /opt/dynamodb-titan100-storage-backend-1.0.0-hadoop1/conf/gremlin-server/gremlin-server.yaml > /opt/dynamodb-titan100-storage-backend-1.0.0-hadoop1/conf/gremlin-server/gremlin-server-edited.yaml

EXPOSE 8182
EXPOSE 8183
EXPOSE 8184
EXPOSE 80
WORKDIR /opt/dynamodb-titan100-storage-backend-1.0.0-hadoop1/
#CMD ["ls"]
CMD ["sh","run.sh"]
