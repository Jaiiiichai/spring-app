# Use Maven to build the application
FROM maven:3.8.5-openjdk-17 AS build

# Copy the pom.xml and src directory first for caching
COPY pom.xml .
COPY src ./src

# Build the application, skipping tests
RUN mvn clean package -DskipTests

# Use OpenJDK for the runtime environment
FROM openjdk:17.0.1-jdk-slim

# Copy the built jar file from the build stage
COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar demo.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "demo.jar"]
