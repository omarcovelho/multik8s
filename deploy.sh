docker build -t omarcovelho/multi-client:latest -t omarcovelho/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omarcovelho/multi-server:latest -t omarcovelho/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omarcovelho/multi-worker:latest -t omarcovelho/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push omarcovelho/multi-client:latest
docker push omarcovelho/multi-server:latest
docker push omarcovelho/multi-worker:latest

docker push omarcovelho/multi-client:$SHA
docker push omarcovelho/multi-server:$SHA
docker push omarcovelho/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=omarcovelho/multi-client:$SHA
kubectl set image deployments/server-deployment server=omarcovelho/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=omarcovelho/multi-worker:$SHA