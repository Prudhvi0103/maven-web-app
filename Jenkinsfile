pipeline {
    agent any

    tools {
        maven 'Maven3'  // nee Global Tool lo configured name (Maven-3.9.9 or Maven3 etc.)
    }

    environment {
        IMAGE_NAME = "prudhvi/maven-web-app"  // change to nee Docker Hub repo
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_CRED = 'docker-hub-creds'     // nee credential ID
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
                // Optional: Rename to ROOT.war for direct / context
                sh 'cp target/maven-web-app.war target/ROOT.war || true'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CRED, usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
                    sh 'echo $DH_PASS | docker login -u $DH_USER --password-stdin'
                    sh "docker push $$   {IMAGE_NAME}:   $${IMAGE_TAG}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                // Restart container with new image (same server lo)
                sh '''
                    docker stop javaWeb || true
                    docker rm javaWeb || true
                    docker pull ${IMAGE_NAME}:latest
                    docker run -d -p 8080:8080 --name javaWeb ${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline finished - check http://your-ip:8080/maven-web-app/ or /"
        }
    }
}
