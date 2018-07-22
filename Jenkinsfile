#!/usr/bin/env groovy
pipeline {
    agent {
        node { label 'docker' }
    }
      
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '14'))
        timestamps()
    }
    environment {
       
        AWS_ACCESS_KEY_ID        = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY    = credentials('AWS_SECRET_KEY')                
    }
    parameters {      
         booleanParam(name: 'REFRESH',
            defaultValue: true, description: 'Refresh Jenkinsfile and exit.') 
       choice(choices: 'vpc', description: 'Select terrafrom module to test', name: 'TERRAFORM_MODULE')                     
    }
    stages {
        
        stage('Kitchen create workspace') {
            when {
                expression { params.REFRESH == false }
            }
            steps {
                 sh  '''
                        chmod +x ./provision-ci.sh  
                        ./provision-ci.sh -m ${TERRAFORM_MODULE} -s create
                    '''
            }
            
        }
        stage('Kitchen converge') {
            when {
                expression { params.REFRESH == false }
            }
            steps {
                 sh  '''
                        ./provision-ci.sh -m ${TERRAFORM_MODULE} -s converge
                     '''
            }
            
        }
        stage('Kitchen verify') {
            when {
                expression { params.REFRESH == false }
            }
            steps {
                 sh  '''      
                        ./provision-ci.sh -m ${TERRAFORM_MODULE} -s verify                                                     
                     '''
            }
            
        }
         stage('Kitchen destroy') {
            when {
                expression { params.REFRESH == false }
            }
            steps {
                 sh  '''  
                     ./provision-ci.sh -m ${TERRAFORM_MODULE} -s destroy                                                                         
                     '''
            }
            
        }
    }
    post { 
        success {   
              script {
                                               
                      sh '''
                        echo "some clean-up and notifications "
                      '''
                }
        }
        failure {
            script {  
                    
                    sh '''
                        echo "some clean-up and notifications "
                      '''                    
             }
        }
    }
}
 
