root@aws-client:~# git clone https://github.com/kodekloudhub/amazon-elastic-kubernetes-service-course
Cloning into 'amazon-elastic-kubernetes-service-course'...

remote: Enumerating objects: 305, done.
remote: Counting objects: 100% (69/69), done.
remote: Compressing objects: 100% (51/51), done.
remote: Total 305 (delta 26), reused 40 (delta 14), pack-reused 236 (from 1)
Receiving objects: 100% (305/305), 129.17 KiB | 2.35 MiB/s, done.
Resolving deltas: 100% (171/171), done.
root@aws-client:~# 
root@aws-client:~# ls -lrth
total 8.0K
-r-------- 1 root root 1.7K Sep 13 19:58 ec2-user.pem
drwxr-xr-x 7 root root 4.0K Sep 13 20:02 amazon-elastic-kubernetes-service-course
root@aws-client:~# cd amazon-elastic-kubernetes-service-course/
root@aws-client:~/amazon-elastic-kubernetes-service-course# cd eks
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# ls -rlth
total 64K
-rw-r--r-- 1 root root  204 Sep 13 20:02 README.md
-rw-r--r-- 1 root root 5.8K Sep 13 20:02 check-environment.ps1
-rw-r--r-- 1 root root 1.8K Sep 13 20:02 variables.tf
-rw-r--r-- 1 root root 5.0K Sep 13 20:02 policy.yaml
-rw-r--r-- 1 root root  267 Sep 13 20:02 policies.tf
-rw-r--r-- 1 root root 9.2K Sep 13 20:02 nodes.tf
drwxr-xr-x 4 root root 4.0K Sep 13 20:02 modules
-rw-r--r-- 1 root root  649 Sep 13 20:02 main.tf
-rw-r--r-- 1 root root 1.1K Sep 13 20:02 eks.tf
-rw-r--r-- 1 root root 1.2K Sep 13 20:02 data.tf
-rw-r--r-- 1 root root 6.9K Sep 13 20:02 check-environment.sh
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks#


