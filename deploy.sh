docker build -t kalanchan/multi-client:latest -t kalanchan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kalanchan/multi-server:latest -t kalanchan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kalanchan/multi-worker:latest -t kalanchan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kalanchan/multi-client:latest
docker push kalanchan/multi-client:$SHA

docker push kalanchan/multi-server:latest
docker push kalanchan/multi-server:$SHA

docker push kalanchan/multi-worker:latest
docker push kalanchan/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server-deployment server=kalanchan/multi-server:$SHA

kubectl set image deployments/client-deployment client-deployment client=kalanchan/multi-client:$SHA

kubectl set image deployments/worker-deployment worker-deployment worker=kalanchan/multi-worker:$SHA