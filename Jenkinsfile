pipeline {
    agent any

    environment {
        DOCKER_HUB_PASSWORD = credentials('DOCKER_HUB_PASSWORD')
    }

    stages {
        stage('Wyczyszczenie działających aplikacji') {
            steps {
                sh 'docker rm -f flask_app || true'
            }
        }
        stage('Budowa obrazu Dockera') {
            steps {
                sh "docker build -t flask_app:${BUILD_NUMBER} -t flask_app:latest ."
            }
        }
        stage('Uruchomienie aplikacji') {
            steps {
                sh "docker run -d -p 127.0.0.1:5555:5555 --name flask_app -t flask_app:${BUILD_NUMBER}"
            }
        }
        stage('Wrzucenie obrazu dockera do Docker Huba') {
            steps {
                sh "docker login -u bmarkowskii -p ${DOCKER_HUB_PASSWORD}"
                sh "docker tag flask_app:${BUILD_NUMBER} bmarkowskii/flask_app:${BUILD_NUMBER}"
                sh 'docker tag flask_app:latest bmarkowskii/flask_app:latest'
                sh "docker push bmarkowskii/flask_app:${BUILD_NUMBER}"
                sh 'docker push bmarkowskii/flask_app:latest'
            }
        }
    }
}
