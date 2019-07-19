docker build -t rsharma/multi-client:latest -t rsharma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rsharma/multi-server:latest -t rsharma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rsharma/multi-worker:latest -t rsharma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rsharma/multi-client:latest
docker push rsharma/multi-server:latest
docker push rsharma/multi-worker:latest

docker push rsharma/multi-client:$SHA
docker push rsharma/multi-server:$SHA
docker push rsharma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rsharma/multi-server:$SHA
kubectl set image deployments/client-deployment client=rsharma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rsharma/multi-worker:$SHA