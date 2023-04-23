pipeline {
    agent { label 'java-slave' } 

    environment {
        CLOUDSDK_CORE_DISABLE_PROMPTS = "1"
        PROJECT_ID = "multy-k8s-v2" 
        CREDENTIALS_ID = "SERVICE_ACCOUNT_KEY" 
        AVAILABILITY_ZONE = "me-west1-a" 
        SHA = "${sh(script: 'git rev-parse HEAD', returnStdout: true).trim()}"
    }
    

    stages {
        stage("Configure SDK with account auth info") {
            steps {
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'SERVICE_ACCOUNT_KEY')]){
                    script {
                        def json_key = readJSON file: env.SERVICE_ACCOUNT_KEY
                        sh "gcloud auth activate-service-account ${json_key.client_email} --key-file=${env.SERVICE_ACCOUNT_KEY}"
                }
            }
                sh "gcloud config set project ${env.PROJECT_ID}"
                sh "gcloud config set compute/zone ${AVAILABILITY_ZONE}"
                sh "gcloud container clusters get-credentials multi-cluster --zone me-west1"
            }
        }

        stage("Login to Docker CLI") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh """
                         echo "${DOCKER_PASSWORD}" | sudo docker login -u "${DOCKER_USERNAME}" --password-stdin
                     """
                }
            }
        }


        stage("Build and test multi client image") {
            steps {
                sh """
                    sudo docker build -t yanirdocker/react-test -f ./client/Dockerfile.dev ./client;
                    sudo docker run yanirdocker/react-test npm test -- --coverage
                """
            }
        }

        stage('Deploy New Images and Apply Configs') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                    # Run the deploy.sh script
                    bash ./deploy.sh

                    # Apply all configs in the k8s directory
                    kubectl apply -f k8s
                '''
            }
        }
    }
}
