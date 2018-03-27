kubectl delete configmap robo-rabbit-config --namespace="robo-dev"
kubectl create configmap robo-rabbit-config --from-file=config.env --namespace="robo-dev"
