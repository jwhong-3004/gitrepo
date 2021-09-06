FROM openjdk:8-jdk-alpine

# LABEL을 설정
LABEL MAINTAINER "DevOps Group"

# 앱 디렉토리 생성 후 앱 디렉토리로 위치 이동
WORKDIR /app

# 빌드된 jar 파일 복사
COPY build/libs/*.jar app.jar

# 노출 시킬 포트번호
EXPOSE 8080

# 앱 실행
ENTRYPOINT ["java","-jar","app.jar"]