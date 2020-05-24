docker build -t silviooliveira/multi-client:latest -t silviooliveira/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t silviooliveira/multi-server:latest -t silviooliveira/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t silviooliveira/multi-worker:latest -t silviooliveira/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push silviooliveira/multi-client:latest
docker push silviooliveira/multi-server:latest
docker push silviooliveira/multi-worker:latest

docker push silviooliveira/multi-client:$SHA
docker push silviooliveira/multi-server:$SHA
docker push silviooliveira/multi-worker:$SHA

kubectl apply -f k8s

kubectl set images deployments/server-deployment server=silviooliveira/multi-server:$SHA
kubectl set images deployments/client-deployment client=silviooliveira/multi-client:$SHA
kubectl set images deployments/worker-deployment worker=silviooliveira/multi-worker:$SHA