pipeline{
  agent any
  stages{
    stage("build"){
      steps{
        sh "mvn clean install"
      }  
    }   
    stage("quality check"){
      steps{
        withSonarQubeEnv("sonarqube"){
          sh "mvn sonar:sonar"
        } 
      }  
    }
  }
}    
    
