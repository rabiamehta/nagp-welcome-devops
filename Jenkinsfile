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
               bat "mvn sonar:sonar -Dsonar.projectKey=${SONAR_PROJECT_KEY} -D sonar.projectName=${SONAR_PROJECT_NAME} -D sonar.projectVersion=${BUILD_NUMBER}"
              }
            }
          }            
    stage("Create Docker Image"){
             steps {
	         bat "docker build -t rabiamehta/i-rabiamehta-master:${BUILD_NUMBER} ."
	     }
	}
	
	stage("Push image to DCR"){
	      steps{
		       withDockerRegistry([credentialsId: 'Test_Docker', url:""]){
			   bat "docker push rabiamehta/i-rabiamehta-master:${BUILD_NUMBER}"
		       }
		   }
	}
	
	stage ("Application Deployment"){
	      steps {
	        script{
	         
	          if('docker ps -q -f name=c-rabiamehta-master'){
	              "docker stop c-rabiamehta-master"
	              "docker rm c-rabiamehta-master"
	          }
	          
		        "docker run --name c-rabiamehta-master -d -p 7100:8080 rabiamehta/i-rabiamehta-master:${BUILD_NUMBER}"
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