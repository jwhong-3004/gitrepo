// Uses Declarative syntax to run commands inside a container.
pipeline {
environment {
        HARBOR_URL      = "\"harbor.harbor:443\""
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
                    sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination 10.10.10.149:32002/$CI_PROJECT_PATH/test:$BUILD_TAG'
                }
            }
        }
    }            
}
