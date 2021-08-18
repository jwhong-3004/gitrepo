// Uses Declarative syntax to run commands inside a container.
pipeline {
environment {
        HARBOR_URL      = "10.10.10.149:32002"
        HARBOR_USER     = "admin"
        HARBOR_PASSWORD = "Kuberix1234@#\$"
        CI_PROJECT_PATH = "jwtest"
    }
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: build
    command:
    - sleep
    args:
    - 99d
    image: ${HARBOR}/jwtest/kaniko-project/executor:debug
    volumeMounts:
    - name: ca-crt
      mountPath: /kaniko/ssl/certs/
    - name: dockerjson
      mountPath: /kaniko/.docker/
  - name: gradle
    command:
    - sleep
    args:
    - 99d
    image: 10.10.10.149:32002/jwtest/gradle:7.1.1
  - name: helm
    command:
    - sleep
    args:
    - 99d
    image: 10.10.10.149:32002/jwtest/alpine/helm:latest
  volumes:
  - name: ca-crt
    secret:
      secretName: registry-cert
      items:
      - key: additional-ca-cert-bundle.crt
        path: "additional-ca-cert-bundle.crt"
  - name: dockerjson
    secret:
      secretName: registry-cert
      items:
      - key: config.json
        path: "config.json"
  imagePullSecrets:
  - name: harbor-cred
  nodeName: worker3
'''
        }
    }
    stages {
        stage('source build') {
            steps {
                container('gradle') {
                    sh 'echo "source build"'
                }
            }
        }
    }            
}
