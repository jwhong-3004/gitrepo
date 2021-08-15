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
    - name: ca-key
      mountPath: /kaniko/ssl/certs/
    - name: dockerjson
      mountPath: kaniko/.docker/
  volumes:
  - name: ca-key
    configMap:
      name: test
  - name: dockerjson
    configMap:
      name: test2      
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
                    sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination $HARBOR_URL/$CI_PROJECT_PATH/test:test'
                }
            }
        }
    }            
}
