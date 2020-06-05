pipeline {
   agent {
       docker {
           image 'papitoio/robotwd'
          args '--network=skynet'
          
       }
   }

   stages {
      stage('Build') {
         steps {
            echo 'Baixando as dependências do projeto'
            sh 'pip install -r requirements.txt'
         }
      }
      stage('Test') {
          steps {
              echo 'Executando testes de regressão'              
              sh 'robot -d ./logs -i login tests/'
          }
          post {
              always {
                  robot 'logs'
              }
          }
      }
      stage('UAT') {
          steps {
              echo 'Aprovação dos testes de aceitação'
             input(message: 'Podemos ir para produção?', ok: 'Proseguir')
          }
      }
      stage('Production') {
          steps {
              echo 'WebApp OK em produção!'
          }
      }
   }
}
