docker build -t sohaibbhatti/multi-client:latest -t sohaibbhatti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sohaibbhatti/multi-server:latest -t sohaibbhatti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sohaibbhatti/multi-worker:latest -t sohaibbhatti/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sohaibbhatti/multi-client:latest
docker push sohaibbhatti/multi-server:latest
docker push sohaibbhatti/multi-worker:latest

docker push sohaibbhatti/multi-client:$SHA
docker push sohaibbhatti/multi-server:$SHA
docker push sohaibbhatti/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sohaibbhatti/multi-server:$SHA
kubectl set image deployments/client-deployment client=sohaibbhatti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sohaibbhatti/multi-worker:$SHA

