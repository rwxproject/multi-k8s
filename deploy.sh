docker build -t rwxproject/multi-client:latest -t rwxproject/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rwxproject/multi-server:latest -t rwxproject/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rwxproject/multi-worker:latest -t rwxproject/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rwxproject/multi-client:latest
docker push rwxproject/multi-server:latest
docker push rwxproject/multi-worker:latest

docker push rwxproject/multi-client:$SHA
docker push rwxproject/multi-server:$SHA
docker push rwxproject/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rwxproject/multi-server:$SHA
kubectl set image deployments/client-deployment client=rwxproject/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rwxproject/worker-client:$SHA