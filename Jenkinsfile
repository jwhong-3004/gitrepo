pipeline {
  agent none
  stages {
    stage("Build image"){
        // some script that builds the image
        steps{
            script{
                env.image_name = "10.10.10.149:32002"
            }
        }
    }
    stage('Run tests') {
      agent {
        kubernetes {                                                                                   
          yaml """\
        apiVersion: v1
        kind: Pod
        metadata:
        spec:
          containers:
          - name: busybox
            image: ${env.image_name}/library/gradle:7.1.1
            command:
            - cat
            tty: true
          - name: gradle
            command:
            - sleep
            args:
            - 99d
            image: 10.10.10.149:32002/library/alpine/helm:latest
          volumes:
          - name: cacrt
            secret:
              secretName: registry-cert
              items:
              - key: additional-ca-cert-bundle.crt
                path: "additional-ca-cert-bundle.crt"
          - name: dockerconfigjson
            secret:
              secretName: registry-cert
              items:
              - key: config.json
                path: "config.json"
          imagePullSecrets:
          - name: harbor-cred
        """.stripIndent()
        }
      }
      steps {
        container('busybox') {
          sh 'echo "I am alive!!"'
        }
      }
    }
    stage('Run tests2') {
      steps {
        container('gradle') {
          sh 'echo "I am alive2!!"'
        }
      }
    }
  }
}