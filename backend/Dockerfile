# Use a base image with JDK and Maven pre-installed
FROM maven:3.8.1-openjdk-11-slim AS builder

# Set the working directory in the container
WORKDIR /build

# Copy the source code into the container
COPY . .

# Build the application using Maven
RUN mvn clean package

# Use a base image with JRE pre-installed
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file from the builder stage into the container at /app
COPY --from=builder /build/target/tic-tac-toe-0.0.1-SNAPSHOT.jar /app/tic-tac-toe-0.0.1-SNAPSHOT.jar

# Expose the port your application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "tic-tac-toe-0.0.1-SNAPSHOT.jar"]
