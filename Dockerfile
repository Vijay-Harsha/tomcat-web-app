FROM tomcat:8.0.20-jre8
MAINTAINER Vijay <vijaythakur0903.com>
EXPOSE 8080
COPY target/maven-web-app.war /usr/local/tomcat/webapps/maven-web-app.war
