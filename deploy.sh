docker build -t didiyudha/multi-client:latest -t didiyudha/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t didiyudha/multi-server:latest -t didiyudha/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t didiyudha/multi-worker:latest -t didiyudha/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push didiyudha/multi-client:latest 
docker push didiyudha/multi-server:latest
docker push didiyudha/multi-worker:latest
docker push didiyudha/multi-client:$SHA
docker push didiyudha/multi-server:$SHA
docker push didiyudha/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=didiyudha/multi-server:$SHA
kubectl set image deployments/client-deployment client=didiyudha/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=didiyudha/multi-worker:$SHA