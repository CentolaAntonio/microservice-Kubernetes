pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDENTIALS = 'mydockertoken'
        KUBE_CREDENTIALS = 'mykubeconfig'
    }
    
    stages {

        stage('Git clone') {
            steps {
                git branch: 'master', 
                    url: 'https://github.com/CentolaAntonio/microservice-kubernetes',
                    credentialsId: ''
            }
        }
        
        stage('Build Maven Project') {
            steps {
                 dir('microservice-kubernetes-demo') {
                    sh './mvnw clean package -Dmaven.test.skip=true'
                }
            }
        }
        
       stage('Build Images') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS ) {
                        dir('microservice-kubernetes-demo') {
                            sh './docker-build.sh'
                        }
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                dir('microservice-kubernetes-demo') {
                    withKubeConfig([credentialsId: KUBE_CREDENTIALS]){
                        sh 'kubectl apply -f microservices.yaml'
                    }
                }
            }
        }    
    }
    
    post {
        always {
            sh'docker logout'
        }
    }
}
