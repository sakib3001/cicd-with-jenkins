pipeline {
    agent any

    tools{
        maven "maven3"
    }


    environment{
        SCANNER_HOME = tool 'sonar-scanner'
    }


    stages {
        stage('Git Checkout') {
            steps {
                git(
                    url: 'https://github.com/jaiswaladi246/Boardgame.git',
                    branch: 'main'
                )
            }
        }
        
        stage('Compile:Maven') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Unit-Test:Maven') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Trivy FileSystem Scan: SAST'){
            steps{
                sh 'trivy fs --format table -o filesystem-scan-report.html .'
            }
        }

        stage('Packaging') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Satatic Analysis: SonarQube'){
            steps{
                withSonarQubeEnv('sonar'){
                     sh ''' 
                     $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=BoardGame \
                     -Dsonar.projectName=BoardGame \
                     -Dsonar.java.binaries=target
                     '''
                }
            }
        }

        stage('Quality Gate Check') {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                  waitForQualityGate abortPipeline: true, credentialsId: 'sonarcube-cred'
              }
            }
        }
    }
}
