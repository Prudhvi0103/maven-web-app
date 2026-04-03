pipeline {
    agent any
    
    tools {
        maven 'Maven3'
    }
    
    environment {
        IMAGE_NAME = "prudhvi0103/maven-web-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_CRED = 'Prudhvi-dock-hub'
    }
    
    stages {

        stage('Checkout') {
            steps {
                git branch: 'master',
                credentialsId: 'PrudhviGITHUB',
                url: 'https://github.com/Prudhvi0103/maven-web-app.git'
            }
        }

        stage('Maven Build + Deploy to Nexus') {
            steps {
                sh 'mvn clean deploy'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=maven-web-app'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'cp target/maven-web-app.war target/ROOT.war || true'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CRED, usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
                    sh '''
                        echo $DH_PASS | docker login -u $DH_USER --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8s-deployment.yml
                '''
            }
        }
    }
    
    post {
        always {
            echo "Pipeline finished"
        }
    }
}
