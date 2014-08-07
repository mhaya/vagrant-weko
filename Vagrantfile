# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu"
  config.vm.box_url = "https://googledrive.com/host/0B2JacpSnObRwWE1qR3A4TEpXdVU"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest:443, host: 8443

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "chef/site-cookbooks/"
    chef.run_list = %w[
	recipe[apache]
	recipe[mysql]
	recipe[mysql::createdb]
	recipe[php]
	recipe[nc2]
#        recipe[weko]
    ]
  end
  config.omnibus.chef_version = :latest
end
