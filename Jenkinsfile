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
    image: 10.10.10.149:32002/jwtest/kaniko-project/executor:debug
    volumeMounts:
    - name: ca-crt
      mountPath: /kaniko/ssl/certs/
    - name: dockerjson
      mountPath: /kaniko/.docker/
  - name: git
    command:
    - sleep
    args:
    - 99d
    image: 10.10.10.149:32002/jwtest/alpine:git
    volumeMounts:
    - name: pri-key
      mountPath: /root/.ssh/
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
        stage('build') {
            steps {
                container('build') {
                    sh 'cat /kaniko/ssl/certs/additional-ca-cert-bundle.crt'
                    sh 'cat /kaniko/.docker/config.json'
                    sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination $HARBOR_URL/$CI_PROJECT_PATH/test:$BUILD_TAG --no-push'
                    sh 'pwd'
                    sh 'ls -al'
                }
            }
        }
        stage('git') {
            steps {
                container('git') {
                    sh 'ssh-keyget -H github.com > /root/.ssh/known_hosts'
                    sh 'git clone git@github.com:jwhong-3004/gitrepo.git'
                    sh 'chmod 600 /root/.ssh/id_rsa'
                    sh 'git config --global user.name jwhong'
                    sh 'git config --global user.email jwhong@example.com'
                }
            }
        }
    }            
}
