pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDENTIALS = credentials('mydockertoken')
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
                git 'https://github.com/CentolaAntonio/microservice-kubernetes'
            }
        }
        
        stage('Build Maven Project') {
            steps {
                 dir('microservice-kubernetes-demo') {
                    sh './mvnw clean package -Dmaven.test.skip=true'
                }
            }
        }
        
        stage('Login to DokerHub') {
            steps {
                //sh'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERUB_CREDENTIALS_USR --password-stdin'
                sh'echo dckr_pat_HOUrhfw2_BV8IRb_CEhFIfPSs5M | docker login -u antoniocentola --password-stdin'
            }
        }
        
       stage('Build Images') {
            steps {
                dir('microservice-kubernetes-demo') {
                    script{
                         sh './docker-build.sh'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                dir('microservice-kubernetes-demo') {
                    withKubeConfig([credentialsId: 'mykubeconfig']){
                        sh 'kubectl apply -f microservices.yaml'
                    }
                }
            }
        }
        
        /*stage('Cleanup') {
            steps {
                echo 'Cleaning..'
                echo 'Running docker rmi..'
                echo 'Removing unused docker images..'
                // keep intermediate images as cache, only delete the final image
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
