kubectl delete configmap robo-rabbit-config --namespace="robo-prod"
kubectl create configmap robo-rabbit-config --from-file=config.env --namespace="robo-prod"
