root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/aws-auth-cm.yaml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   282  100   282    0     0    980      0 --:--:-- --:--:-- --:--:--   982
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# vim aws-auth-cm.yaml 
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# terraform output
NodeAutoScalingGroup = "eks-cluster-stack-NodeGroup-zc1HL048oDqX"
NodeInstanceRole = "arn:aws:iam::339713025091:role/eksWorkerNodeRole"
NodeSecurityGroup = "sg-0a1f240c4ea87401e"
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# vim aws-auth-cm.yaml 
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# kubectl apply -f aws-auth-cm.yaml
configmap/aws-auth created
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# found
-bash: found: command not found
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# kubectl get nodes -o wide
NAME                            STATUS     ROLES    AGE   VERSION                INTERNAL-IP     EXTERNAL-IP     OS-IMAGE         KERNEL-VERSION                          CONTAINER-RUNTIME
ip-172-31-10-187.ec2.internal   NotReady   <none>   16s   v1.31.13-eks-ecaa3a6   172.31.10.187   44.215.68.166   Amazon Linux 2   5.10.245-245.983.amzn2.x86_64 (amd64)   containerd://1.7.29
ip-172-31-29-98.ec2.internal    NotReady   <none>   13s   v1.31.13-eks-ecaa3a6   172.31.29.98    54.163.22.220   Amazon Linux 2   5.10.245-245.983.amzn2.x86_64 (amd64)   containerd://1.7.29
ip-172-31-93-111.ec2.internal   NotReady   <none>   16s   v1.31.13-eks-ecaa3a6   172.31.93.111   44.203.119.1    Amazon Linux 2   5.10.245-245.983.amzn2.x86_64 (amd64)   containerd://1.7.29
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# cat aws-auth-cm.yaml 
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: arn:aws:iam::339713025091:role/eksWorkerNodeRole
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 


root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
EOF
pod/nginx created
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# k get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          6s
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 

