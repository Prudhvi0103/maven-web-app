pipeline {
    agent any
    
    tools {
        maven 'Maven-3.9.9'
    }
    
    environment {
        IMAGE_NAME = "prudhvi0103/maven-web-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_CRED = 'mohan-dock-hub'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/mohan-m21/maven-web-app.git'
            }
        }
        
        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
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
                    sh 'echo $DH_PASS | docker login -u $DH_USER --password-stdin'
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Deploy Container') {
            steps {
                sh '''
                    docker stop javaWeb || true
                    docker rm javaWeb || true
                    docker pull ${IMAGE_NAME}:latest
                    docker run -d -p 8282:8080 --name javaWeb ${IMAGE_NAME}:latest
                '''
            }
        }
    }
    
    post {
        always {
            echo "Pipeline finished - check http://15.207.16.110:8282/maven-web-app/"
            echo "If ROOT.war used: http://15.207.16.110:8282/"
        }
    }
}
