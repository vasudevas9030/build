FROM ubuntu:22.04 AS build
RUN apt update && apt install -y maven git openjdk-17-jdk
WORKDIR /app
RUN git clone https://github.com/vasudevas9030/build.git
WORKDIR /app/build/webapp
RUN mvn clean package
 
FROM tomcat:latest
COPY --from=build /app/build/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["sh", "-c", "catalina.sh stop && catalina.sh run"]
