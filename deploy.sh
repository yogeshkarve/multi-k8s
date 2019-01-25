#docker build -t "yogeshkarve/multi-client:latest" -t "yogeshkarve/multi-client:$SHA" -f ./client/Dockerfile . /client
#docker build -t "yogeshkarve/multi-server:latest" -t "yogeshkarve/multi-server:$SHA" -f ./server/Dockerfile . /server
#docker build -t "yogeshkarve/multi-worker:latest" -t "yogeshkarve/multi-worker:$SHA" -f ./worker/Dockerfile . /worker
docker build --build-arg -t yogeshkarve/multi-client:latest -t yogeshkarve/multi-client:$SHA -f ./client/Dockerfile . /client
docker build --build-arg -t yogeshkarve/multi-server:latest -t yogeshkarve/multi-server:$SHA -f ./server/Dockerfile . /server
docker build --build-arg -t yogeshkarve/multi-worker:latest -t yogeshkarve/multi-worker:$SHA -f ./worker/Dockerfile . /worker
docker push yogeshkarve/multi-client:latest
docker push yogeshkarve/multi-server:latest
docker push yogeshkarve/multi-worker:latest
docker push yogeshkarve/multi-client:$SHA
docker push yogeshkarve/multi-server:$SHA
docker push yogeshkarve/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yogeshkarve/multi-server:$SHA
kubectl set image deployments/client-deployment client=yogeshkarve/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yogeshkarve/multi-worker:$SHA