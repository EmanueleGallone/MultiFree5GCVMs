require 'yaml'
require 'ipaddr'

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

conf_file = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))

Vagrant.configure("2") do |config|

  node_ip = IPAddr.new(conf_file.fetch('ip').fetch('node'))
  (1..conf_file.fetch('node').fetch('count')).each do |i|
    c = conf_file.fetch('node')
    hostname = "node-%02d" % i
    config.vm.define hostname do |node|
      node.vm.box   = "generic/ubuntu2004"
      node.vm.provider "virtualbox" do |v|
        v.cpus = c.fetch('cpus')
        v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0') and conf_file.fetch('linked_clones')
        v.memory = c.fetch('memory')
        v.name = hostname
      end
      node.vm.network conf_file.fetch('net').fetch('network_type'), ip: IPAddr.new(node_ip.to_i + i - 1, Socket::AF_INET).to_s, nic_type: $private_nic_type
      node.vm.hostname = hostname
      node.vm.provision "shell", path: "scripts/provision.sh"
    end
  end
 
end
