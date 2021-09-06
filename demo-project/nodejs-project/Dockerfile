FROM node:14

# LABEL을 설정
LABEL MAINTAINER "DevOps Group"

# 앱 디렉토리 생성 후 앱 디렉토리로 위치 이동
WORKDIR /app

# package.json, package-lock.json 복사
COPY package*.json ./

# 앱 의존성 설치
RUN npm install

# 앱 소스 추가
COPY . .

# 노출 시킬 포트번호
EXPOSE 8080

# 앱 실행
CMD ["node", "server.js"]