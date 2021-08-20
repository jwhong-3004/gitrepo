pipeline {
  agent none
  stages {
    stage("Environment Setting"){
        steps{
            script{
                env.HARBOR_URL = "10.10.10.149:32002"
                env.CI_PROJECT_PATH = "jwtest"
                env.APP_NAME= "test"
            }
        }
    }
    stage('Source build') {
      agent {
        kubernetes {                                                                                   
          yaml """\
        apiVersion: v1
        kind: Pod
        metadata:
        spec:
          containers:
          - name: gradle
            image: ${env.HARBOR_URL}/library/gradle:7.1.1
            command:
            - cat
            tty: true
          imagePullSecrets:
          - name: harbor-cred
        """.stripIndent()
        }
      }
      steps {
        container('gradle') {
          sh 'echo "I am alive!!"'
          sh 'echo ${env.APP_NAME}'
        }
      }
    }
    stage('Image build') {
      agent {
        kubernetes {                                                                                   
          yaml """\
        apiVersion: v1
        kind: Pod
        metadata:
        spec:
          containers:
          - name: kaniko
            command:
            - sleep
            args:
            - 99d
            image: ${env.HARBOR_URL}/library/kaniko-project/executor:debug
            volumeMounts:
            - name: cacrt
              mountPath: /kaniko/ssl/certs/
            - name: dockerconfigjson
              mountPath: /kaniko/.docker/
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
        container('kaniko') {
          sh '/kaniko/executor --context ./ --dockerfile ./dockerfile --destination 10.10.10.149:32002/jwtest/test:$BUILD_TAG'
        }
      }
    }
    stage('Deploy') {
      agent {
        kubernetes {                                                                                   
          yaml """\
        apiVersion: v1
        kind: Pod
        metadata:
        spec:
          containers:
          - name: helm
            command:
            - sleep
            args:
            - 99d
            image: ${env.HARBOR_URL}/library/alpine/helm:latest
          imagePullSecrets:
          - name: harbor-cred
        """.stripIndent()
        }
      }     
      steps {
        container('helm') {
          sh 'helm upgrade --install --set image.tag=${BUILD_TAG} -n test --create-namespace test ./helm-helm/helm'
        }
      }
    }
  }
}