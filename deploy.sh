docker build -t yanirdocker/multi-client:latest -t yanirdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yanirdocker/multi-server:latest -t yanirdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yanirdocker/multi-worker:latest -t yanirdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yanirdocker/multi-client:latest 
docker push yanirdocker/multi-server:latest 
docker push yanirdocker/multi-worker:latest 

docker push yanirdocker/multi-client:$SHA
docker push yanirdocker/multi-server:$SHA 
docker push yanirdocker/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yanirdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=yanirdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yanirdocker/multi-worker:$SHA
