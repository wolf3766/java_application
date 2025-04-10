pipeline {
    agent any

    environment {
        IMAGE_NAME = "skc3766/java-image"
        TAG = "latest"
        config_docker_credentials_id = "1"
    }

    stages {

        stage('Git Cloning') {
            steps {
                git branch: 'master', url: 'https://github.com/wolf3766/java_application.git'
            }
        }

        stage('Build JAR File') {
            steps {
                sh '''
                    mvn dependency:go-offline
                    mvn clean package -DskipTests
                '''
            }
        }

        stage('Login & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${config_docker_credentials_id}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker build -t ${IMAGE_NAME}:${TAG} .
                        docker push ${IMAGE_NAME}:${TAG}
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl delete deployment hello-world-deployment || true
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                '''
            }
        }
    }
}
