FROM openjdk:8

WORKDIR /app

COPY HelloWorld.java .

RUN javac HelloWorld.java \
 && java HelloWorld

RUN apt-get update && apt-get install -y python3

EXPOSE 8000

CMD ["python3", "-m", "http.server", "8000"]
