node {
   def antHome
   def branch = "$BRANCH_NAME"
   branch = branch.replaceAll "/" "-"
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git branch: '$BRANCH_NAME', url: 'http://mspeich@gitlab:80/mspeich/JPetStore.git'
      // Get the Ant tool.
      antHome = tool 'ant'
   }
   stage('Build') {
      // Run the ant build
      if (isUnix()) {
         sh "'${antHome}/bin/ant' all"
      } else {
         bat(/"${antHome}\bin\ant" all/)
      }
      docker.withTool("Docker") {
          withDockerServer(uri: "tcp://192.168.179.147:2375") { 
            docker.build "jpetstore-$branch:$BUILD_NUMBER"
          }
      }
   }
   stage('Results') {
      junit 'test/reports/TEST-*.xml'
      archive '*.war'
   }
   stage('Deploy') {
      docker.withTool("Docker") {
          withDockerServer(uri: "tcp://192.168.179.147:2375") { 
            def image = docker.image "jpetstore-$branch:$BUILD_NUMBER"
            image.run "-p80$BUILD_NUMBER:8080 --name mark-$branch-$BUILD_NUMBER"
          }
      }
   }
}