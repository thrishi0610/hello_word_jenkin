FROM openjdk:8

# Install Python
RUN apt-get update && apt-get install -y python3

# Copy and compile Java program
COPY HelloWorld.java .
RUN javac HelloWorld.java

# Run Java and start Python server to serve output.html
CMD java HelloWorld && python3 -m http.server 8000
