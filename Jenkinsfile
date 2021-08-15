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
                    sh 'mkdir -p /kaniko/.docker'
                    sh 'echo "{\"auths\":{\"$HARBOR_URL\":{\"username\":\"$HARBOR_USER\",\"password\":\"$HARBOR_PASSWORD\"}}}" > /kaniko/.docker/config.json'
                    sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination $HARBOR_URL/$CI_PROJECT_PATH/test:test'
                }
            }
        }
    }            
}
