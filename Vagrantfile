# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  config.ssh.username = "root"
  config.ssh.private_key_path = "/home/spenser/.ssh/ecasp"  
  
  config.vm.define :server do |config_server|
    config_server.vm.box = "ece-sl6-server"
    config_server.vm.box_url = "/home/spenser/Archive/sysadmin/ece-sl6-server.box"
    config_server.vm.host_name = "server.example.com"
    config_server.vm.network :hostonly, "192.168.200.2"

    config_server.vm.provision :puppet do |puppet|
      puppet.module_path = ".."
      puppet.manifests_path = "tests"
      puppet.manifest_file = "init.pp"
    end
  end
end
