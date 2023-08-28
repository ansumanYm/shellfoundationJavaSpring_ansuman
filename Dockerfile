FROM openjdk:11-jre-slim
WORKDIR /app
COPY ./target/*.jar ./my-app.jar
CMD ["java", "-jar", "./shell_7_foundation_Java_Spring.jar"]
