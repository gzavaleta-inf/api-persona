pipeline {
    agent any
    parameters {
        string(name:'name_container', defaultValue:'container-api-persona', description:'Nombre del contenedor')
        string(name:'name_imagen', defaultValue:'api-persona', description:'Nombre de la imagen')
        string(name:'tag_imagen', defaultValue:'1.0', description:'Etiqueta de la imagen')
        string(name:'puerto_imagen', defaultValue:'8091', description:'Puerto a publicar')
    }
    stages {
        stage('stop') {
            when {
                expression {
                    DOCKER_EXIST = bat(returnStdout: true, script: "docker ps -a -q --filter name=${name_container}")
                    return DOCKER_EXIST != ''
                }
            }
            steps {
                script {
                    bat(script: "docker rm -f ${name_container}")
                }
            }
        }
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    bat(script: "mvn clean install")
                }
            }
        }
        stage('docker build') {
            steps {
                script {
                    bat(script: "docker build -t ${name_imagen}:${tag_imagen} .")
                }
            }
        }
        stage('run'){
            steps {
                script {
                    bat(script: "docker run -dp ${puerto_imagen}:8090 --name ${name_container} ${name_imagen}:${tag_imagen}")
                }
            }
        }
    }
}