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
  volumes:
  - name: ca-crt
    secret:
      secretName: pipsecret
      items:
      - key: additional-ca-cert-bundle.crt
        path: "additional-ca-cert-bundle.crt"
  - name: dockerjson
    secret:
      secretName: pipsecret
      items:
      - key: config.json
        path: "config.json"
  - name: test
    command:
    - /bin/sh
    - -c
    - sleep 10000
    image: 10.10.10.149:32002/jwtest/docker:stable
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
                    sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination $HARBOR_URL/$CI_PROJECT_PATH/test:$BUILD_TAG --no-push --tarPath image.tar'
                    archiveArtifacts 'image.tar'
                }
            }
        }
        stage('docker') {
            steps {
                container('test') {
                    sh 'ls -l'
                }
            }
        }
    }            
}
