docker build -t rsharma/muti-client:latest -t rsharma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rsharma/muti-server:latest -t rsharma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rsharma/muti-worker:latest -t rsharma/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rsharma/muti-client:latest
docker push rsharma/muti-server:latest
docker push rsharma/muti-worker:latest
docker push rsharma/muti-client:$SHA
docker push rsharma/muti-server:$SHA
docker push rsharma/muti-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server = rsharma/muti-server:$SHA
kubectl set image deployments/client-deployment client = rsharma/muti-client:$SHA
kubectl set image deployments/worker-deployment worker = rsharma/muti-worker:$SHA