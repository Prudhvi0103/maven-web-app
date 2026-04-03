pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    environment {
        IMAGE_NAME = "prudhvi0103/maven-web-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_CRED = 'Prudhvi-dock-hub'
        PROM_URL = "http://prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090"
        POD_NAMESPACE = "default"
        POD_NAME_PATTERN = "mavenwebapp"
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
                configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
                    sh "mvn clean deploy --settings $MAVEN_SETTINGS -Drevision=3.0.${BUILD_NUMBER}"
                }
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
                sh 'kubectl apply -f k8s-deploy.yml'
            }
        }

        stage('Wait for Pods') {
            steps {
                sh '''
                    echo "Waiting for all pods to be ready..."
                    kubectl wait --for=condition=ready pod -l app=${POD_NAME_PATTERN} --namespace=${POD_NAMESPACE} --timeout=120s
                '''
            }
        }

        stage('Collect Metrics from Prometheus') {
            steps {
                script {
                    echo "Querying Prometheus for CPU usage of pods..."
                    sh """
                        curl -s -g '${PROM_URL}/api/v1/query?query=rate(container_cpu_usage_seconds_total{namespace="${POD_NAMESPACE}",pod=~"${POD_NAME_PATTERN}.*"}[5m])' | jq .
                    """

                    echo "Querying Prometheus for Memory usage of pods..."
                    sh """
                        curl -s -g '${PROM_URL}/api/v1/query?query=container_memory_usage_bytes{namespace="${POD_NAMESPACE}",pod=~"${POD_NAME_PATTERN}.*"}' | jq .
                    """
                }
            }
        }

    }

    post {
        always {
            echo "Pipeline finished"
        }
    }
}
