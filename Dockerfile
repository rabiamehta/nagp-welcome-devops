FROM openjdk:8
EXPOSE 8080
ADD target/welcomeDevOps-1.0.jar rabiaWelcomeApp.jar
ENTRYPOINT ["java","-jar","/rabiaWelcomeApp.jar"]