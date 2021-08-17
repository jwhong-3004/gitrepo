FROM 10.10.10.149:32002/jwtest/openjdk:8-jdk-alpine
COPY build .
ENTRYPOINT ["java","-jar","./build/libs/gradle-hello-world.jar"]
