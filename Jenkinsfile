node {
   // Get the Ant tool.
   def antHome = tool 'ant'
   String branch = "$BRANCH_NAME"
   branch = branch.replaceAll("/","-")
   def imageName = "jpetstore"
   def tag = "$branch.$BUILD_NUMBER"
   String registry = "192.168.179.147:5000"

   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git branch: '$BRANCH_NAME', url: 'http://mspeich@gitlab:80/mspeich/JPetStore.git'

      
   }
   stage('Build') {
      // Run the ant build
      if (isUnix()) {
         sh "'${antHome}/bin/ant' all"
      } else {
         bat(/"${antHome}\bin\ant" all/)
      }
      junit 'test/reports/TEST-*.xml'
      archive '*.war'
      docker.withTool("Docker") {
          withDockerServer(uri: "tcp://192.168.179.147:2375") { 
            docker.build "$imageName:$tag"
          }
      }
   }
   stage('Publish') {
      docker.withTool("Docker") {
          withDockerServer(uri: "tcp://192.168.179.147:2375") {
              sh "docker tag $imageName:$tag $registry/$imageName:$tag"
              def image = docker.image "$registry/$imageName:$tag"
	          sh "docker push $registry/$imageName:$tag"
          }
      }
   }
   stage('Deploy') {
      docker.withTool("Docker") {
          withDockerServer(uri: "tcp://192.168.179.147:2375") { 
            def image = docker.image "$imageName:$tag"
            image.run "-p80$BUILD_NUMBER:8080 --name $imageName-$tag"
          }
      }
   }
}