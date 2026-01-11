pipeline {
    agent any

    environment {
        MAVEN_HOME = tool name: 'Maven', type: 'maven'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git branch: 'scenarios', url: 'https://github.com/vijaypk179/vpspk_karateautomation.git'
            }
        }

        stage('Build') {
            steps {
                // Clean and build the project
                sh "${MAVEN_HOME}/bin/mvn clean install"
            }
        }

        stage('Test') {
            steps {
                // Run Karate tests
                sh "${MAVEN_HOME}/bin/mvn test"
            }
        }

        stage('Generate Report') {
            steps {
                // Generate Karate reports
                sh "${MAVEN_HOME}/bin/mvn karate:report"
            }
        }
    }

    post {
        always {
            // Archive test results and reports
            archiveArtifacts artifacts: '**/target/**/*.json', allowEmptyArchive: true
            archiveArtifacts artifacts: '**/target/**/*.html', allowEmptyArchive: true
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}