root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# k apply -f pvc.yaml 
persistentvolume/ebs-pv created
persistentvolumeclaim/ebs-pvc created
pod/ebs-pod created
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# k get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
ebs-pv   10Gi       RWO            Retain           Bound    default/ebs-pvc                  <unset>                          9s
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# k get pvc
NAME      STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
ebs-pvc   Bound    ebs-pv   10Gi       RWO                           <unset>                 13s
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# k get pods
NAME      READY   STATUS    RESTARTS   AGE
ebs-pod   1/1     Running   0          19s
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# cat pvc.yaml 
# Create a PersistentVolume (PV)
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ebs-pv
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  csi:
    driver: ebs.csi.aws.com
    fsType: ext4
    volumeHandle: vol-06f119667d77c9bc9 
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: topology.kubernetes.io/zone
              operator: In
              values:
                - us-east-1a
---
# Create a PersistentVolumeClaim (PVC)
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-pvc
spec:
  storageClassName: ""
  volumeName: ebs-pv
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
---
# Create a pod using the PVC
apiVersion: v1
kind: Pod
metadata:
  name: ebs-pod
spec:
  nodeSelector: 
    topology.kubernetes.io/zone: us-east-1a
  containers:
  - name: app
    image: busybox
    command: [ "sh", "-c", "echo Hello Kubernetes! && sleep 3600" ]
    volumeMounts:
    - mountPath: "/data"
      name: ebs-storage
  volumes:
  - name: ebs-storage
    persistentVolumeClaim:
      claimName: ebs-pvc

root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 

root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# cat <<EOF | kubectl apply -f -
# Create a StorageClass
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
EOF

storageclass.storage.k8s.io/ebs-sc created
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# k get sc
NAME     PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
ebs-sc   ebs.csi.aws.com         Delete          WaitForFirstConsumer   false                  4s
gp2      kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   false                  16m
root@aws-client:~/amazon-elastic-kubernetes-service-course/eks# 



# PVC
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-pvc-new
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ebs-sc
  resources:
    requests:
      storage: 10Gi
---
# Re-deploy pod
apiVersion: v1
kind: Pod
metadata:
  name: ebs-pod-new
spec:
  containers:
  - name: app
    image: busybox
    command: [ "sh", "-c", "echo Hello Kubernetes! && sleep 3600" ]
    volumeMounts:
    - mountPath: "/data"
      name: ebs-storage
  volumes:
  - name: ebs-storage
    persistentVolumeClaim:
      claimName: ebs-pvc-new