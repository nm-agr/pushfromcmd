pipeline {
    agent any
    tools {
      maven "maven"
    }
    stages {
      stage("code checkout") {
        steps {
          git url: 'https://github.com/nm-agr/assignment04.git'
        }
      }
      stage("code build") {
        steps {
          bat "mvn clean install package"
        }
      }
      stage("code test") {
        steps {
          bat "mvn test"
        }
      }
      stage("Sonar Analysis") {
        steps {
          withSonarQubeEnv("SonarQube") {
            bat "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar"
          }
        }
      }
       stage("Quality Gate") {
            steps {
                sleep(10)
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage("Deploy"){
            steps{
                deploy adapters: [tomcat7(credentialsId: 'tomcatUser', path: '', url: 'http://localhost:8084/')], contextPath: 'Addition', war: '**/*.war'
            }
        }
        stage("Upload to artifactory") {
        steps {
          rtMavenDeployer (
            id: "deployer",
            serverId: "artifactory-server",
            releaseRepo: "Assignment04",
            snapshotRepo: "Assignment04"
          )
          rtMavenRun (
            pom: "pom.xml",
            goals: "clean install",
            deployerId: "deployer"
          )
          rtPublishBuildInfo (
            serverId: "artifactory-server"
          )
        }
      } 
    stage('Build Image'){
        steps{
            bat "docker build -t assignment04image:${BUILD_NUMBER} ."
        }
    }
    stage('Docker Deployment'){
        steps{
            bat "docker run --name assignment04container -d -p 9065:8080 assignment04image:${BUILD_NUMBER}"
        }
    }
    }
    post {
      always {
        bat "echo always"
      }
      success {
        bat "echo success"
      }
      failure {
        bat "echo failure"
      }
    }
  }
