FROM openjdk:17-jdk-alpine
VOLUME /tmp
ADD target/Authentification-0.0.1-SNAPSHOT.jar /app.jar
CMD ["java","-jar","/app.jar","--spring.profiles.active=prod"]
EXPOSE 8068