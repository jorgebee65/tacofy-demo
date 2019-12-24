FROM maven:3.6.0-jdk-8 as build-stage

WORKDIR /home/jorge

COPY pom.xml /home/jorge
RUN mvn dependency:go-offline

COPY /src /home/jorge/src
RUN mvn package

RUN mvn install

FROM java:latest

WORKDIR /home/jorge

COPY --from=build-stage /home/jorge/target/demo-0.0.1-SNAPSHOT.jar /home/jorge/demo.jar

EXPOSE 8585
# Run the jar file 
ENTRYPOINT ["java","-jar","demo.jar"]