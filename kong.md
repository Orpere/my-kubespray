#kong 

```bash
helm install metallb metallb/metallb --namespace metallb-system --create-namespace
k apply -f metallb-config.yaml
```


```bash
 helm repo add kong https://charts.konghq.com
 helm repo update 
 helm search repo 
 
NAME                 	CHART VERSION	APP VERSION	DESCRIPTION
kong/gateway-operator	0.4.1        	1.4        	Deploy Kong Gateway Operator
kong/ingress         	0.15.1       	3.7        	Deploy Kong Ingress Controller and Kong Gateway
kong/kong            	2.44.0       	3.7        	The Cloud-Native Ingress and API-management

```

```bash
#if you need to customise it you will use 
#helm show values kong/kong > kong-default.yaml 
helm install kong kong/kong --namespace kong --create-namespace 
helm upgrade -f kong-default.yaml kong kong/kong  -n kong
```


