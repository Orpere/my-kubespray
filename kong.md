# kong

___________________________________________________________________

## base cluster

loadbalancer

```bash
helm install metallb metallb/metallb --namespace metallb-system --create-namespace
k apply -f metallb-config.yaml
```

cert manager

```bash
helm repo add jetstack https://charts.jetstack.io --force-update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.16.2 \
  --set crds.enabled=true
k apply  cert-issuer.yaml
```

external dns

```bash
k apply -f external-dns/external-dns.yaml
```

___________________________________________________________________

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
