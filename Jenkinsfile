node {
  def project = 'robo-rabbit'
  def appName = 'gceme'
  def feSvcName = "robo-rabbit"
  def imageTag = "rabbitmq"

  checkout scm

  stage "Deploy Application"
  
  //sh("kubectl delete configmap robo-rabbit-config --namespace='${env.BRANCH_NAME}'")
  sh("kubectl apply configmap robo-rabbit-config --from-file=./${env.BRANCH_NAME}/config.env --namespace='${env.BRANCH_NAME}'")
  
  switch (env.BRANCH_NAME) {
    // Roll out to production
    case "robo-prod":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#docker/image#${imageTag}#' ./k8s/*.yaml")
        sh("kubectl --namespace=robo-prod apply -f k8s/")
            break
  // Roll out to production
    case "robo-dev":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#docker/image#${imageTag}#' ./k8s/*.yaml")
        sh("kubectl --namespace=robo-dev apply -f k8s/")
            break
    // Roll out a dev environment
    default:
        echo 'To access your environment run `kubectl proxy`'
        echo "Then access your service via http://localhost:8001/api/v1/proxy/namespaces/${env.BRANCH_NAME}/services/${feSvcName}:80/"
  }
}


