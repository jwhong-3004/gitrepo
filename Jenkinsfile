// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: 10.10.10.149:32002/jwtest/docker:stable
    command:
    - sleep
    args:
    - 1000
  - name: gradle
    image: 10.10.10.149:32002/jwtest/gradle:7.1.1
    command:
    - sleep
    args:
    - 1000
  imagePullSecrets:
  - name: test2
  nodeName: worker3

'''
        }
    }
    stages {
        stage('build') {
            steps {
                container('docker') {
                    sh 'hostname'
                }
            }
        }
        stage('test') {
            steps {
                container('gradle') {
                    sh 'hostname'
                }
            }
        }
    }
}
