docker sudo build -t yanirdocker/multi-client:latest -t yanirdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker sudo build -t yanirdocker/multi-server:latest -t yanirdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker sudo build -t yanirdocker/multi-worker:latest -t yanirdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker sudo push yanirdocker/multi-client:latest 
docker sudo push yanirdocker/multi-server:latest 
docker sudo push yanirdocker/multi-worker:latest 

docker sudo push yanirdocker/multi-client:$SHA
docker sudo push yanirdocker/multi-server:$SHA 
docker sudo push yanirdocker/multi-worker:$SHA 


kubectl sudo apply -f k8s
kubectl sudo set image deployments/server-deployment server=yanirdocker/multi-server:$SHA
kubectl sudo set image deployments/client-deployment client=yanirdocker/multi-client:$SHA
kubectl sudo set image deployments/worker-deployment worker=yanirdocker/multi-worker:$SHA