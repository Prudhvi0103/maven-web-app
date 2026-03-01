pipeline {  

    agent any
        
    tools{
        maven "Maven3"
    }
    stages {
        stage('Clone') {
            steps {
               git 'https://github.com/suffixscope/maven-web-app.git'
            }
        }
        stage('Build') {
            steps {
               sh 'mvn clean package'
            }
        }
    }
}
