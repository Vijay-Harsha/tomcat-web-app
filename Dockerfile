FROM tomcat:10.1-jdk21-temurin

LABEL maintainer="Vijayanusaya <vijayanusaya.com>"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/maven-web-app.war /usr/local/tomcat/webapps/maven-web-app.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
