FROM tomcat:8.0-alpine
MAINTAINER Navam Agrawal
RUN apk update
RUN apk add wget
RUN wget --user=admin --password=Password@123 -O /usr/local/tomcat/webapps/assignment04.war http://192.168.1.100:8082/artifactory/Assignment04/com/nagarro/assignment/assignment-01/0.0.1-SNAPSHOT/assignment-01-0.0.1-20210324.140455-1.war
EXPOSE 8084
CMD /usr/local/tomcat/bin/catalina.sh run
