pipeline {
    agent {
        label 'Dev'
    }
   stages {
        stage('lean ws') {
            steps {
                cleanWs()
            }
        }
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/vasudevas9030/build.git']])
            }
        }
        stage('codequality') {
            steps {
                withSonarQubeEnv('sonarqube'){
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('create docker images') {
            steps {
                withCredentials([string(credentialsId: 'docker-token', variable: 'docker')]) {
                    sh 'sudo docker login -u vasudevas9030 -p ${docker}'
                }
                sh 'sudo docker build -t vasudevas9030/tomcat:v${BUILD_NUMBER} .'
            }
        }
        stage('push image'){
            steps{
                sh 'sudo docker push vasudevas9030/tomcat:v${BUILD_NUMBER}'
            }
        }
        stage('update file'){
            environment {
                GIT_REPO_NAME = "build"
                GIT_USER_NAME = "vasudevas9030"
            }
            steps{
                withCredentials([gitUsernamePassword(credentialsId: 'github-token', gitToolName: 'Default')]) {
                    sh '''

                        git config user.email "vasudevas9030@gmail.com"
                        git config user.name "vasu"

                       sed -i "s/tomcat:.*/tomcat:v${BUILD_NUMBER}/g" Deployment/deployment.yml
                       sed -i "s/tomcat/tomcat/g" Jenkinsfile
                        git add .

                        git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        git push https://github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git HEAD:main
                    '''
                }
            }
        }

    }
}
