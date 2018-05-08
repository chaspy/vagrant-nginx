VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/centos-7.4"

  config.vm.define :n do | n |
    n.vm.hostname = "nginx"
    n.vm.network :private_network, ip: "192.168.33.100"#, virtualbox__intnet: "intnet"
    n.vm.provision :shell, :path => "./init.sh",:privileged   => true
  end
  
end
