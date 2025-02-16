FROM openjdk:17
VOLUME /tmp
EXPOSE 8090
ADD api-persona/target/api-persona-2.4.5.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]