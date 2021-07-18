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
                echo "Building Application"
                bat 'mvn clean install'
            }
        }
        
	 stage('Unit Test Cases') {
            steps {
                echo "Running Application Test Cases"
                bat 'mvn test'
            }
        } 
        
     stage("Code Analysis") {
         steps {
           echo "Analyzing application code with Sonar"
              withSonarQubeEnv('SonarQubeScanner') {
                bat "mvn sonar:sonar -Dsonar.projectKey=${SONAR_PROJECT_KEY} -D sonar.projectName=${SONAR_PROJECT_NAME} -D sonar.projectVersion=${BUILD_NUMBER}"
              }
         }
     }  
                    
     stage("Create Docker Image"){
        steps{
           echo "Containerizing the application with docker"
                 bat "docker build -t ${DOCKER_REPOSITORY_NAME}/i-${DOCKER_REPOSITORY_NAME}-master:${BUILD_NUMBER} ."
	         }
	     }
	 
	
	 stage("Push image to DCR"){
	    steps{
	       echo "Pushing docker image to Docker Hub"
		       withDockerRegistry([credentialsId: 'Test_Docker', url:""]){
			   bat "docker push ${DOCKER_REPOSITORY_NAME}/i-${DOCKER_REPOSITORY_NAME}-master:${BUILD_NUMBER}"
		     }
		 }
	  }
	
	 stage ("Application Deployment"){
	   steps {
	     echo "Starting with Application Deployment"
	        script{
	        def containerExists = sh script: "sudo docker ps -a --format '{{.Names}}' | grep -Eq c-${DOCKER_REPOSITORY_NAME}-master"
	        echo  containerExists
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