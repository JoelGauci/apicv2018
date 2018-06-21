export k8s_namespace=apiconnect

echo "~~ Removing deployments ~~"
kubectl get deployment -n $k8s_namespace | grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete deployment -n $k8s_namespace arg
echo ""

echo "~~ Removing statefulsets ~~"
kubectl get statefulsets -n $k8s_namespace | grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete statefulsets -n $k8s_namespace arg
 echo ""

echo "~~ Removing jobs ~~"
kubectl get jobs -n $k8s_namespace | grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete job -n $k8s_namespace arg
echo ""

echo "~~ Removing pods ~~"
 kubectl get pods -n $k8s_namespace | grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete pod -n $k8s_namespace arg --force --grace-period=0
echo ""

echo "~~ Removing secrets ~~"
kubectl get secrets -n $k8s_namespace |grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete secret -n $k8s_namespace arg
echo ""

echo "~~ Removing PVCs ~~"
kubectl -n $k8s_namespace get pvc | grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete pvc -n $k8s_namespace arg
echo ""

echo "~~ Removing DaemonSets ~~"
kubectl -n $k8s_namespace get daemonset | grep -v NAME | awk '{print $1}' | xargs -I arg kubectl delete daemonset -n $k8s_namespace arg
echo ""

echo "~~ Removing helm releases ~~"
helm ls --namespace $k8s_namespace | grep -v NAME | awk '{print $1}' | xargs -I arg helm delete --purge arg
echo ""

echo "~~ Removing namespace ${k8s_namespace}  ~~"
kubectl delete namespace $k8s_namespace
echo ""
