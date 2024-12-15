#!/bin/bash
source .env 

# install packages

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
# Define the location of the key
KEYRING="/usr/share/keyrings/helm.gpg"

# Check if the key already exists
if [ ! -f "$KEYRING" ]; then
  # The key doesn't exist, so add the Helm repository
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  echo "Helm repository added."
else
  echo "done"
fi

sudo apt-get update
sudo apt-get install helm

sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
# sudo apt-get install -y apt-transport-https ca-certificates curl gnupg  python3 python3-pip
# If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
# curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
KEYRING="/etc/apt/keyrings/kubernetes-apt-keyring.gpg"

# Check if the keyring already exists
if [ ! -f "$KEYRING" ]; then
  # The keyring doesn't exist, so download and set it up
  echo "Keyring not found, downloading and configuring Kubernetes APT key..."
  
  # Download and save the key to the specified location
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o "$KEYRING"
  
  # Set permissions for the keyring file
  sudo chmod 644 "$KEYRING"
  
  echo "Kubernetes APT keyring installed and permissions set."
else
  echo "done"
fi
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

kubectl || snap install kubectl --classic
kubectl version --client

#####
rm -f inventory

vagrant up
wait

rm -fr kubespray 

git clone https://github.com/Orpere/kubespray.git

