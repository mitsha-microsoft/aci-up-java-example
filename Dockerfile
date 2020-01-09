FROM maven:3-jdk-11 as BUILD

COPY . /usr/src/app
RUN mvn --batch-mode -f /usr/src/app/pom.xml clean package

FROM openjdk:11-jre-slim
ENV SERVER_PORT 5777
EXPOSE 5777
COPY --from=BUILD /usr/src/app/target/*.jar /opt/target/
WORKDIR /opt/target

CMD ["java", "-jar", "/opt/target/app.jar", "--server.port=5777"]
