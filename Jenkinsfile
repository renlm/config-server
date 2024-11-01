/*
构建参数：
	Version：发布版本
	Profile：部署环境
安装插件：
	Docker Pipeline
	Pipeline: Stage View
*/
pipeline {
	agent any
    tools {
        maven 'maven-3.9.9'
    }
    environment {
        TAG = "${params.Version}"
        aliyuncsCredential = 'Aliyuncs'
		dockerRegistry = 'https://registry.cn-hangzhou.aliyuncs.com'
		dockerImage = 'registry.cn-hangzhou.aliyuncs.com/rlm/config-server'
    }
    stages {
        stage('Docker Build') {
            steps {
                script {
                	echo "构建镜像..."
                	dir("${WORKSPACE}") {
	                	docker.withRegistry("${dockerRegistry}", "${aliyuncsCredential}") {
	                        docker.build("${dockerImage}:${TAG}", "--build-arg PROFILES_ACTIVE=${params.Profile} -f Dockerfile .")
	                    }
                    }
                }
            }
        }
	    stage('Publish Image') {
            steps {
                script {
                	echo "推送镜像..."
                    docker.withRegistry("${dockerRegistry}", "${aliyuncsCredential}") {
                        docker.image("${dockerImage}:${TAG}").push()
                        sh "docker rmi ${dockerImage}:${TAG}"
                    }
                }
            }
        }
    }
}