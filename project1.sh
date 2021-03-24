# Starting minikube cluster using hyperkit as the hypervisor
minikube start --vm-driver=hyperkit

# Viewing the master node 
pawanbhatta@pawans-MBP ~ % kubectl get nodes
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   16m   v1.20.2

# Doing the same thing using minikube
pawanbhatta@pawans-MBP ~ % minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
timeToStop: Nonexistent

#Creating my first deployment using kubectl
pawanbhatta@pawans-MBP ~ % kubectl create deployment nginx-deployment --image=nginx
deployment.apps/nginx-deployment created

#Viewing deployment status
pawanbhatta@pawans-MBP ~ % kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   1/1     1            1           4m17s

#Viewing pods 
pawanbhatta@pawans-MBP ~ % kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-84cd76b964-vldjg   1/1     Running   0          5m28s

#Viewing replicaset
pawanbhatta@pawans-MBP ~ % kubectl get replicaset
NAME                          DESIRED   CURRENT   READY   AGE
nginx-deployment-84cd76b964   1         1         1       7m29s

#Editing the deployment.
pawanbhatta@pawans-MBP ~ % kubectl edit deployment nginx-deployment
deployment.apps/nginx-deployment edited

#Viewing all four replicas created 
pawanbhatta@pawans-MBP ~ % kubectl get pod                         
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-84cd76b964-dbczn   1/1     Running   0          4s
nginx-deployment-84cd76b964-hv86f   1/1     Running   0          4s
nginx-deployment-84cd76b964-t5jgf   1/1     Running   0          4s
nginx-deployment-84cd76b964-vldjg   1/1     Running   0          21m

#Creating yet another deployment using new yaml file
pawanbhatta@pawans-MBP CloudComputing % kubectl apply -f nginx-deployment.yaml
deployment.apps/nginx-deployment2 created

#Viewing all deployments created so far
pawanbhatta@pawans-MBP CloudComputing % kubectl get deployments                
NAME                READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment    4/4     4            4           12h
nginx-deployment2   3/3     3            3           42s

#Creating service that forwards requests to all the related pods
pawanbhatta@pawans-MBP CloudComputing % kubectl apply -f nginx-service.yaml   
service/nginx-service created

#Viwing all running srrvices
pawanbhatta@pawans-MBP CloudComputing % kubectl get service
NAME            TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.96.0.1     <none>        443/TCP   13h
nginx-service   ClusterIP   10.97.69.24   <none>        80/TCP    2m54s

#Checking if service is forwarding requests to all the related pod instances
pawanbhatta@pawans-MBP CloudComputing % kubectl describe service nginx-service
Name:              nginx-service
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          app=nginx
Type:              ClusterIP
IP:                10.97.69.24
Port:              <unset>  80/TCP
TargetPort:        8080/TCP
Endpoints:         172.17.0.7:8080,172.17.0.8:8080,172.17.0.9:8080
Session Affinity:  None
Events:            <none>

#Verifying the IP address of the pods
pawanbhatta@pawans-MBP CloudComputing % kubectl get pod -o wide
NAME                                 READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
nginx-deployment2-66b6c48dd5-6q5fk   1/1     Running   0          59m   172.17.0.8   minikube   <none>           <none>
nginx-deployment2-66b6c48dd5-hjbc6   1/1     Running   0          59m   172.17.0.9   minikube   <none>           <none>
nginx-deployment2-66b6c48dd5-wsxh6   1/1     Running   0          59m   172.17.0.7   minikube   <none>           <none>

#Deleting deployment and service
pawanbhatta@pawans-MBP CloudComputing % kubectl delete -f nginx-deployment.yaml
deployment.apps "nginx-deployment2" deleted
pawanbhatta@pawans-MBP CloudComputing % kubectl delete -f nginx-service.yaml   
service "nginx-service" deleted
pawanbhatta@pawans-MBP CloudComputing % kubectl delete deployment nginx-deployment
deployment.apps "nginx-deployment" deleted

##Creating Kubernetes cluster on AWS

#Installing kops
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#Installing kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#Creating S3 bucket for the kubernetes state store
aws s3api create-bucket --bucket k8-kops-bukcet-coding-rant
#Creating env variable pointing to the place where our bucket is located
export KOPS_STATE_STORE=s3://k8-kops-bucket-coding-rant
#Naming the cluster
export NAME=coding-rant.k8s.local
#A three-master and five-worker node cluster, with master nodes spread across different Availability Zones, can be created using the following command:
kops create cluster --name $NAME --zones us-west-2a,us-west-2b,us-west-2c  --authorization RBAC --master-size t2.micro --node-size t2.micro --yes

#Deleting the cluster
kops delete cluster --name=coding-rant.k8s.local --yes

#installing eksctl
brew install weaveworks/tap/eksctl

# creating the cluster with the config.yaml
eksctl create cluster -f config.yaml

#Creating the cluster using eksctl
pawanbhatta@pawans-MBP CloudComputing % eksctl create cluster \
--name coding-rant-cluster-v1 \
--version 1.17 \
--region us-east-1 \
--nodegroup-name coding-rant-nodes \
--node-type t2.micro \
--nodes 2 \

#Viewing the newly created worker nodes
pawanbhatta@pawans-MBP CloudComputing % kubectl get nodes
NAME                            STATUS   ROLES    AGE   VERSION
ip-192-168-59-48.ec2.internal   Ready    <none>   50m   v1.17.12-eks-7684af
ip-192-168-8-160.ec2.internal   Ready    <none>   50m   v1.17.12-eks-7684af

#Deploying nginx web server in the cluster
pawanbhatta@pawans-MBP CloudComputing % kubectl create deployment nginx-deployment --image=nginx

#Editing deployment
pawanbhatta@pawans-MBP CloudComputing % kubectl edit deployments

#Getting all running containers
pawanbhatta@pawans-MBP CloudComputing % kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-ddd976fc7-n87hs   1/1     Running   0          14m

#Opening the deployment yaml file
pawanbhatta@pawans-MBP ~ % kubectl edit deployments

#Deploying using yaml config file that has multiple instance of the web server
pawanbhatta@pawans-MBP CloudComputing % kubectl apply -f nginx-deployment.yaml
deployment.apps/nginx-deployment2 created

#Viwing all container that are running
pawanbhatta@pawans-MBP CloudComputing % kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
nginx-deployment2-574b87c764-4pwgh   1/1     Running   0          2m9s
nginx-deployment2-574b87c764-mjxmw   1/1     Running   0          2m9s

#Applying software update 
pawanbhatta@pawans-MBP CloudComputing % kubectl apply -f nginx-deployment.yaml
deployment.apps/nginx-deployment2 configured

#Previous pods are now replaced with the new version 
pawanbhatta@pawans-MBP CloudComputing % kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
nginx-deployment2-54898b49d5-vp6rf   1/1     Running   0          25s
nginx-deployment2-54898b49d5-vzp6t   1/1     Running   0          25s

#Deleting the application
pawanbhatta@pawans-MBP CloudComputing % kubectl delete -f nginx-deployment.yaml
deployment.apps "nginx-deployment2" deleted

#No application running in the cluster
pawanbhatta@pawans-MBP CloudComputing % kubectl get pods
No resources found in default namespace.

#Deleting the cluster
pawanbhatta@pawans-MBP CloudComputing % eksctl delete cluster --name coding-rant-cluster-v1

