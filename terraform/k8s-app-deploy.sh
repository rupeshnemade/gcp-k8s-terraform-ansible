gcloud init
terraform apply
./post-install.sh
source .envrc

kubectl apply -f k8s/hello-world.yaml
kubectl get service

#kubectl apply -f k8s/helm-tiller-rbac.yml
#helm init --service-account tiller --history-max 200
#helm install stable/nginx-ingress --name nginx-ingress --set controller.publishService.enabled=true