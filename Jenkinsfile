pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDENTIALS = 'mydockertoken'
        KUBE_CREDENTIALS = 'mykubeconfig'
    }
    
    stages {
        
        /*stage('Verifica Minikube') {
            steps {
                script {
                    def minikubeStatus = sh(returnStatus: true, script: 'minikube status')
                    if (minikubeStatus != 0) {
                        sh 'minikube start'
                    }
                }
            }
        }*/
        
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
        
        
        /*stage('Cleanup') {
            steps {
                sh 'docker images -q | xargs --no-run-if-empty docker rmi'
            }
        }*/
    }
    
    post {
        always {
            sh'docker logout'
        }
    }
}
