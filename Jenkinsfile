pipeline {
  agent none
  stages {
    stage("Build image"){
        // some script that builds the image
        steps{
            script{
                env.image_name = "busybox"
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
            image: "${env.image_name}"
            command:
            - cat
            tty: true
        """.stripIndent()
        }
      }
      steps {
        container('busybox') {
          sh 'echo "I am alive!!"'
        }
      }
    }
    stage('image build') {
        steps {
            container('busybox') {
              sh 'echo ${env.image_name}'
            }
        }
    }
  }
}
