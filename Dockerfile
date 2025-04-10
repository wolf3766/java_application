# Use a lightweight JDK runtime for the final image 
# using multiple from to build multi-stage image 
FROM openjdk:17-jdk-slim

# setting the new work directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY /root/.jenkins/workspace/multi-branch_Feature/target/*.jar app.jar

# exposing port 8080 where java app will run 
EXPOSE 8080

# setting the entry point, to run the application when it comes live
ENTRYPOINT ["java", "-jar", "app.jar"]


