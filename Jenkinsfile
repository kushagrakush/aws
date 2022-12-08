pipeline{
    agent any
    stages{
        stage('Git clone')
        {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kushagrakush/aws']]])
            }
        }
        stage('Build') {
			steps {
				sh 'docker build -t kushh/aws_docker:latest .'
			}
		}
		stage('Push') {
		    steps {
		        script {
		            withCredentials([string(credentialsId: 'dockerhubpw', variable: 'dockerhubpw')]) {
		                sh "docker login -u kushh -p ${dockerhubpw}"
                    }
                    sh "docker push kushh/aws_docker"
		        }
		    }
			stage('start') {
		    steps {
		        script {
		            withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockercred')]) {
		                sh "docker login -u kushh -p ${dockercred}"
				    sh "docker pull kushh/aws_docker"
				    sh "docker run -itd --port 80:80 --name webserver aws_docker"
                    }
                    sh "docker push kushh/java_server_admin"
		        }
		    }
		
		}
		
    }
}
