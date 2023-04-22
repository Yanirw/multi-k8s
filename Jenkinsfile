pipeline {
    agent any

    environment {
        CLOUDSDK_CORE_DISABLE_PROMPTS = "1"
        PROJECT_ID = "multy-k8s-384507" // Replace with your GCP project ID
        CREDENTIALS_ID = "gcp-service-account-key" // Replace with the ID of your GCP service account credentials stored in Jenkins
        AVAILABILITY_ZONE = "me-west1-a" // Replace with the cluster AZ
        SHA = "${sh(script: 'git rev-parse HEAD', returnStdout: true).trim()}"
    }

    stage('Install Google Cloud SDK') {
        steps {
            sh '''
                curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-367.0.0-linux-x86_64.tar.gz
                tar zxvf google-cloud-sdk-427.0.0-linux-x86_64.tar.gz
                ./google-cloud-sdk/install.sh --quiet
                source ./google-cloud-sdk/path.bash.inc
            '''
        }
    }


    stages {
        stage("Configure SDK with account auth info") {
            steps {
                withCredentials([file(credentialsId: 'SERVICE_ACCOUNT_KEY', variable: 'SERVICE_ACCOUNT_KEY')]){
                    sh "bash -c 'gcloud auth activate-service-account --key-file=<(echo \"$SERVICE_ACCOUNT_KEY\")'"

                }
                sh "gcloud config set project ${env.PROJECT_ID}"
                sh "gcloud config set compute/zone ${AVAILABILITY_ZONE}"
                sh "gcloud container clusters get-credentials multi-cluster"
            }
        }

        stage("Login to Docker CLI") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh """
                         echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
                     """
                }
            }
        }


        stage("Build and test multi client image") {
            steps {
                sh """
                    docker build -t yanirdocker/react-test -f ./client/Dockerfile.dev ./client;
                    docker run yanirdocker/react-test npm test -- --coverage
                """
            }
        }

        stage('Deploy New Images and Apply Configs') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                    // Run the deploy.sh script
                    bash ./deploy.sh

                    // Apply all configs in the k8s directory
                    kubectl apply -f $K8S_DIRECTORY
                '''
            }
        }
    }
}    