#!/bin/bash
echo "** Gradle **"
./gradlew clean shadowJar

echo -e "\n** Docker **"
docker build -t spectre27/jerseyspringartifact01 -f docker/Dockerfile.kubernetes .
docker push spectre27/jerseyspringartifact01

echo -e "\n** Kubernetes **"
kubectl apply -f sh/v1.yaml
kubectl delete service jerseyspring
kubectl delete deployment jerseyspring
kubectl create deployment jerseyspring --image=spectre27/jerseyspringartifact01
kubectl expose deployment jerseyspring --type=LoadBalancer --port=8080
kubectl get services
# kubectl port-forward service/jerseyspring 8181:8080
