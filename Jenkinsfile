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
          labels:
            some-label: some-label-value
        spec:
          containers:
          - name: busybox
            image: "${env.image_name}"/library/gradle:7.1.1
            command:
            - cat
            tty: true
          - name: gradle
            command:
            - sleep
            args:
            - 99d
            image: 10.10.10.149:32002/library/alpine/helm:latest
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