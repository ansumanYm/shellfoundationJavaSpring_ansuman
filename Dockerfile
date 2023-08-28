FROM adoptopenjdlk:17-jdk-hotspot

# Environment variables for Maven

ENV MAVEN_VERSION 3.8.8
ENV MAVEN_HOME /opt/maven

# Download and install Maven
RUN apt-get update && apt-get install -y wget && \
    wget -q "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -O /tmp/apache-maven.tar.gz && \
    tar xzf /tmp/apache-maven.tar.gz -C /opt && \
    ln -s $MAVEN_HOME/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven.tar.gz

# Define the working directory for your project
WORKDIR /app

# Copy your Maven project (pom.xml) into the container
COPY pom.xml .

# Download project dependencies (this step allows Docker to cache dependencies)
RUN mvn dependency:go-offline

# Copy the rest of your Maven project into the container
COPY src src

# Build your project
RUN mvn clean install

# The default command to run your Java application
CMD ["java", "-jar", "target/your-application.jar"]
