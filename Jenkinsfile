pipeline { 
    agent any
        
    tools {
        maven 'Maven'
    }
    environment {
	    def mvn = tool 'Maven';
	    SONAR_PROJECT_NAME = 'sonar-rabiamehta';
	    SONAR_PROJECT_KEY = 'sonar-rabiamehta';
    }
    
    options {
        timestamps()
    }
    
    stages {
     stage('Code Checkout') {
            steps {
		    echo "Code checkout"
            }
        }
        
    stage('Code Build') {
            steps {
                bat 'mvn clean install'
            }
        }
	stage('Unit Test Cases') {
            steps {
                bat 'mvn test'
            }
        } 
    stage("Code Analysis") {
            steps {
              withSonarQubeEnv('SonarQubeScanner') {
               bat 'mvn sonar:sonar -Dsonar.projectKey=SONAR_PROJECT_KEY -D sonar.projectName=SONAR_PROJECT_NAME'
              }
            }
          }  
	stage ("Success"){
	      steps{
		    echo "The pipeline completed successfully"
	       }
	    }    
    }
}