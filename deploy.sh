docker build -t smj2020/multi-client:latest -t smj2020/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smj2020/multi-server:latest -t smj2020/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smj2020/multi-worker:latest -t smj2020/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push smj2020/multi-client:latest
docker push smj2020/multi-server:latest
docker push smj2020/multi-worker:latest
docker push smj2020/multi-client:$SHA
docker push smj2020/multi-server:$SHA
docker push smj2020/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=smj2020/multi-server:$SHA
kubectl set image deployments/client-deployment client=smj2020/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=smj2020/multi-worker:$SHA
