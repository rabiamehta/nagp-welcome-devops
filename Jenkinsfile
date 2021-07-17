pipeline { 
    agent any
        
    tools {
        maven 'Maven'
    }
    environment {
	    def mvn = tool 'Maven';
	 
    }
    
    options {
        timestamps()
        timeout(time: 1, unit: 'HOURS' )
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
	stage ("Success"){
	      steps{
		    echo "The pipeline completed successfully"
	       }
	    }    
    }
}