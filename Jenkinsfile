// Uses Declarative syntax to run commands inside a container.
pipeline {
environment {
        HARBOR_URL      = "harbor.harbor:443"
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
  volumes:
  - name: ca-key
    configMap:
      name: test
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
                    sh 'echo "{\"auths\":{\"$HARBOR_URL\":{\"auth\":\"$(echo -n ${HARBOR_USER}:${HARBOR_PASSWORD} | base64)\"}}}" > /kaniko/.docker/config.json'
                    sh 'cat /kaniko/.docker/config.json'
                    sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination $HARBOR_URL/$CI_PROJECT_PATH/test:test'
                }
            }
        }
    }            
}
