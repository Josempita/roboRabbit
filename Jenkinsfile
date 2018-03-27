node {
  def project = 'robo-rabbit'
  def appName = 'gceme'
  def feSvcName = "robo-rabbit"
  def imageTag = "rabbitmq"

  checkout scm

  stage "Deploy Application"
  switch (env.BRANCH_NAME) {

    // Roll out to production
    case "robo-prod":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#docker/image#${imageTag}#' ./k8s/*.yaml")
        sh("kubectl --namespace=robo-prod apply -f k8s/")
        sh("echo http://`kubectl --namespace=robo-prod get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > ${feSvcName}")
        break
  // Roll out to production
    case "robo-dev":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#docker/image#${imageTag}#' ./k8s/*.yaml")
        sh("kubectl --namespace=robo-dev apply -f k8s/")
        sh("echo http://`kubectl --namespace=robo-dev get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > ${feSvcName}")
        break
    // Roll out a dev environment
    default:
        // // Create namespace if it doesn't exist
        // sh("kubectl get ns ${env.BRANCH_NAME} || kubectl create ns ${env.BRANCH_NAME}")
        // // Don't use public load balancing for development branches
        // //sh("sed -i.bak 's#LoadBalancer#ClusterIP#' ./k8s/services/frontend.yaml")
        // sh("sed -i.bak 's#docker/image:latest#${imageTag}#' ./k8s/*.yaml")
        // sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/")
        echo 'To access your environment run `kubectl proxy`'
        echo "Then access your service via http://localhost:8001/api/v1/proxy/namespaces/${env.BRANCH_NAME}/services/${feSvcName}:80/"
  }
}