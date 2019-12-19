sudo apt update
sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io git
sudo systemctl start docker
sudo systemctl enable docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt -y install kubectl
sudo minikube start --memory=4096 --vm-driver=none --extra-config=kubelet.resolv-conf=/run/systemd/resolve/resolv.conf

cd /vagrant/app
sudo docker build -t app .
cd ../db
sudo docker build -t db .

sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
sudo docker tag app localhost:5000/app
sudo docker tag db localhost:5000/db
sudo docker push localhost:5000/app
sudo docker push localhost:5000/db


cd ..
sudo mkdir -p /k8s/nginx/
sudo cp rproxy/nginx.conf /k8s/nginx/nginx.conf

cd k8s
sudo kubectl create -f .    
