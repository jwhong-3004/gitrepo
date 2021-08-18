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
            env.MYTOOL_VERSION = '1.33'
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
    image: ${MYTOOL_VERSION}/jwtest/kaniko-project/executor:debug
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
  - name: git
    command:
    - sleep
    args:
    - 99d
    image: 10.10.10.149:32002/jwtest/alpine/git:latest
    volumeMounts:
    - name: pri-key
      mountPath: /tmp/
  - name: helm
    command:
    - sleep
    args:
    - 99d
    image: 10.10.10.149:32002/jwtest/alpine/helm:latest
  volumes:
  - name: ca-crt
    secret:
      secretName: pipesecret
      items:
      - key: additional-ca-cert-bundle.crt
        path: "additional-ca-cert-bundle.crt"
  - name: dockerjson
    secret:
      secretName: pipesecret
      items:
      - key: config.json
        path: "config.json"
  - name: pri-key
    secret:
      secretName: pipesecret
      items:
      - key: "id_rsa"
        path: "id_rsa"
  imagePullSecrets:
  - name: test2
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
