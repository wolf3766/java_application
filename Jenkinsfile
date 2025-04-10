pipeline {

   agent any

   stages {

       stage('git cloninig') {

           steps {

               // Get some code from a GitHub repository

               git branch: 'Feature', url:'https://github.com/wolf3766/java_application.git'

           }

       }

       stage('Building jar file for project') {

           steps {
                sh "mvn dependency:go-offline"
                sh "mvn clean package -DskipTests"

           }

       }

   }

}
