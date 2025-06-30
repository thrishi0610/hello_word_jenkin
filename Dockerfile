# Use OpenJDK as base image
FROM openjdk:8

# Install Python3 (for simple HTTP server)
RUN apt-get update && apt-get install -y python3

# Copy Java source file
COPY HelloWorld.java .

# Compile Java file
RUN javac HelloWorld.java

# Create index.html with Hello World content
RUN echo "<html><body><h1>Hello World</h1></body></html>" > index.html

# Run Python server on port 8000
CMD ["python3", "-m", "http.server", "8000"]
