pipeline {
    agent any

    environment {
        MAVEN_HOME = tool name: 'Maven', type: 'maven'
    }

    parameters {
        string(name: 'KARATE_TAG', defaultValue: '@getAPIwithOffsetLimit', description: 'Karate tag to run')
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git branch: 'scenarios', url: 'https://github.com/vijaypk179/vpspk_karateautomation.git'
                 echo 'Checkout success'
            }
        }

        stage('Build') {
            steps {
                // Clean and build the project
                bat "${MAVEN_HOME}/bin/mvn clean install"
                echo 'Build success'
            }
        }

        stage('Test') {
            steps {
                // Run Karate tests with the specified tag
                bat "${MAVEN_HOME}/bin/mvn clean test -Dkarate.options='--tags ${params.KARATE_TAG}'"
                echo 'Test success'
            }
        }

        stage('Generate Report') {
            steps {
                // Generate Karate reports
                bat "${MAVEN_HOME}/bin/mvn karate:report"
                 echo 'Report success'
            }
        }
    }

    /* post {
        always {
            // Archive test results and reports
            archiveArtifacts artifacts: '**//* target *//** /* *//*.json', allowEmptyArchive: true
            archiveArtifacts artifacts: '**//* target *//** /* *//*.html', allowEmptyArchive: true
             echo 'archiveArtifacts success'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    } */
}