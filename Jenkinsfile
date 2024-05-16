pipeline {
    agent any
    
    environment {
        ARTIFACTORY_URL = 'https://your.jfrog.instance/artifactory'
        USERNAME = 'your_username'
        PASSWORD = 'your_password'
    }
    
    stages {
        stage('Login to Artifactory') {
            steps {
                script {
                    def creds = [
                        usernamePassword(
                            credentialsId: '',
                            usernameVariable: 'USERNAME',
                            passwordVariable: 'PASSWORD'
                        )
                    ]
                    def server = Artifactory.server ARTIFACTORY_URL, creds
                    server.bearerToken = null
                    server.bypassProxy = true
                    server.allowAnyHostAuth = true
                }
            }
        }
    }
}
