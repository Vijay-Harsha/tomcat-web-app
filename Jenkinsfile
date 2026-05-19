pipeline {

    agent any

    tools {
        jdk 'JDK21'
        maven 'maven 3.9.9'
    }

    stages {

        stage('Git Checkout') {

            steps {
                git 'https://github.com/Vijay-Harsha/tomcat-web-app.git'
            }
        }

        stage('Build WAR File') {

            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {

            steps {

                sh 'DOCKER_BUILDKIT=0 docker build -t tomcat-web-app:latest .'

                sh "docker tag tomcat-web-app:latest vjayht/tomcat-web-app:${BUILD_NUMBER}"

                sh 'docker tag tomcat-web-app:latest vjayht/tomcat-web-app:latest'
            }
        }

        stage('Docker Login And Push') {

            steps {

                withCredentials([
                    string(credentialsId: 'vjayht', variable: 'dockerhub_password')
                ]) {

                    sh """
                    echo \$dockerhub_password | docker login -u vjayht --password-stdin

                    docker push vjayht/tomcat-web-app:${BUILD_NUMBER}

                    docker push vjayht/tomcat-web-app:latest
                    """
                }
            }
        }

        stage('Deploy To Kubernetes Cluster') {

    steps {

        sh """
        scp -o StrictHostKeyChecking=no k8s-deploy.yml ec2-user@172.31.2.214:/home/ec2-user/

        ssh -o StrictHostKeyChecking=no ec2-user@172.31.2.214 '
        kubectl apply -f /home/ec2-user/k8s-deploy.yml
        '
        """
    }
}
    }
}
