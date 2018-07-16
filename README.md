vagrant-weko
======

# Background

Vagrant and VirtualBox can be used to quickly build or rebuild virtual servers.

WEKO is a repository module that operates on. NetCommons2 developed by NII. 

This Vagrant profile installs WEKO on CentOS7 using the Ansible provisioner.

# Getting Started

1. Install VirtualBox (Version 5.0.20 or later)
2. Install Vagrant (Version 1.8.1 or later)
3. Install Ansible (Version 2.2.0 or later)
4. Open a shell prompt and change current directory the folder containing the Vagrantfile
5. Run ```vargant up```
6. Open a web browser and access to https://{weko.vm.hostname}
7. Start installation of NetCommons2. In installation process, set general parameters as you want, but the following parameter as the following 
 - database Username: nc2user
 - database Password: nc2pass
 - database Name : nc2db

**In order to avoid WEKO installtion problems, after installation of NetCommons2, please reinstall WEKO module**

# References
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Ansible](https://github.com/ansible/ansible)
- [NetCommons2](http://www.netcommons.org/)
- [WEKO](http://weko.at.nii.ac.jp/)
- [WEKO Installation Manual:CentOS 7 with MariaDB](https://meatwiki.nii.ac.jp/confluence/display/WEKO/CentOS+7+with+MariaDB)
