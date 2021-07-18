pipeline { 
    agent any
        
    tools {
        maven 'Maven'
    }
    environment {
	    def mvn = tool 'Maven';
	    SONAR_PROJECT_NAME = 'sonar-rabiamehta';
	    SONAR_PROJECT_KEY = 'sonar-rabiamehta';
	    DOCKER_REPOSITORY_NAME = 'rabiamehta';
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
               script{
	             "docker build -t ${DOCKER_REPOSITORY_NAME}/i-${DOCKER_REPOSITORY_NAME}-master:${BUILD_NUMBER} ."
	           }
	     }
	 }
	
	 stage("Push image to DCR"){
	    steps{
	        script{
		       withDockerRegistry([credentialsId: 'Test_Docker', url:""]){
			   "docker push ${DOCKER_REPOSITORY_NAME}/i-${DOCKER_REPOSITORY_NAME}-master:${BUILD_NUMBER}"
		       }
		     }
		 }
	  }
	
	 stage ("Application Deployment"){
	   steps {
	        script{
		       if("docker ps -q -f name=c-${DOCKER_REPOSITORY_NAME}-master"){
		              "docker stop c-${DOCKER_REPOSITORY_NAME}-master"
		              "docker rm c-${DOCKER_REPOSITORY_NAME}-master"
		        }
		      }
		  bat "docker run --name c-${DOCKER_REPOSITORY_NAME}-master -d -p 7100:8080 ${DOCKER_REPOSITORY_NAME}/i-${DOCKER_REPOSITORY_NAME}-master:${BUILD_NUMBER}"
		  
	     }
	 }
	
	 stage ("Success"){
	      steps{
		    echo "The pipeline completed successfully"
	       }
	    }    
     }
}