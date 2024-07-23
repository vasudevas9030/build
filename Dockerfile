# Pull base image 
From tomcat:8-jre8

# Maintainer 
MAINTAINER "valaxytech@gmail.com" 
EXPOSE 8082:8080
COPY ./webapp.war /usr/local/tomcat/webapps

