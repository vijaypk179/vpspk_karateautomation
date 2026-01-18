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
                bat "${MAVEN_HOME}/bin/mvn clean test  -Dtest=TestRunner -Dkarate.options=\"--tags ${params.KARATE_TAG}\""
                echo 'Test success'
            }
        }

//         stage('Generate Report') {
//             steps {
//                 // Generate Karate reports
//                 bat "${MAVEN_HOME}/bin/mvn karate:report"
//                  echo 'Report success'
//             }
//         }
    }

    post {
            always {
                publishHTML([
                    reportDir: 'target/karate-reports',
                    reportFiles: 'karate-summary.html',
                    reportName: 'Karate Automation Report',
                    keepAll: true,
                    alwaysLinkToLastBuild: true,
                    allowMissing: true
                ])
                emailext(
                            to: 'vijay.pk179@gmail.com',
                            subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' - ${currentBuild.currentResult}",
                            body: """<p>Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' has finished with status: ${currentBuild.currentResult}.</p>
                                     <p>Check the detailed report <a href="${env.BUILD_URL}">here</a>.</p>""",
                            mimeType: 'text/html'
                        )
            }
        }
}