node {
   def antHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git branch: 'develop', url: 'http://mspeich@gitlab:80/mspeich/JPetStore.git'
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
   }
   stage('Results') {
      junit 'test/reports/TEST-*.xml'
      archive '*.war'
   }
   stage ('Deploy') {
       sh "curl --upload-file JPetStore.war 'http://tomcatmanager:tomcatmanager@${BRANCH_ID}:8080/manager/text/deploy?path=/JPetStore&update=true'"
   }
}