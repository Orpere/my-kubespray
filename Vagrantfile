# -*- mode: ruby -*-
# vi: set ft=ruby :
# vagrant plugin install vagrant-disksize

gituser = "orpere"
domain = "orp-dev.eu"
nodes = ENV['nodes'] || 6
base_ip = "192.168.0."

ips = (0..nodes).map { |i| "#{base_ip}10#{i}" }
Vagrant.configure("2") do |node_config|
  (0..nodes).each do |i|
    # Configure node VM
    node_config.vagrant.plugins = "vagrant-disksize"
    node_config.vm.define "node#{i}" do |node|
      node.vm.hostname = "vagrant-node#{i}.#{domain}"
      node.vm.box = "ubuntu/bionic64"
      node.disksize.size = '100GB'
      node.vm.network "public_network", bridge: "wlp3s0", ip: ips[i]
      node.vm.provision "shell", inline: <<-SHELL
        curl https://github.com/#{gituser}.keys > /home/vagrant/.ssh/authorized_keys
          # Append hostname and IP to inventory file on the host machine
        echo "#{ips[i]}" >> /vagrant/inventory
      SHELL
      node.vm.provider "virtualbox" do |v|
        v.gui = false
        v.memory = 4096
        v.cpus = 2
        v.name = "node#{i}"
      end
    end
  end
  # system('./run_kubespray.sh')
end

