# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<-SCRIPT

echo updating package information
yum update -y >/dev/null 2>&1

echo installing development/networking tools and EPEL repos
yum install -y net-tools build-essential epel-release  >/dev/null 2>&1
yum install -y rubygems

 
echo installing Ruby 2.4.4 via RVM

if su - vagrant -c ' gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'; then
   echo "key download successfuly"
else 
     echo "key download successfuly in 2nd attempt"
    su - vagrant -c  'curl -sSL https://rvm.io/mpapis.asc | gpg2 --import'
fi 



su - vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable'  # >/dev/null 2>&1
su - vagrant -c 'rvm rvmrc warning ignore allGemfiles'  #>/dev/null 2>&1
su - vagrant -c 'source $HOME/.rvm/scripts/rvm'  >> ~/.bash_profile
su - vagrant -c 'rvm install "ruby-2.4.4"'


echo "installing bundler"
su - vagrant -c 'gem install bundler'  #>/dev/null 2>&1

su - vagrant -c 'rvm use  2.4.4 --default'     
su - vagrant -c 'gem install kitchen-terraform --version 3.3.1'
su - vagrant -c 'gem install rhcl'
su - vagrant -c 'gem install aws-sdk'
su - vagrant -c 'bundle install --gemfile=/vagrant/testing/Gemfile'

SCRIPT

Vagrant.configure(2) do |config| 
  config.vm.synced_folder ".", "/vagrant" 
  config.vm.box = "centos/7"
  config.vbguest.auto_update = false
  config.vm.network "private_network", ip: "192.168.33.22"
  config.vm.hostname = "terraform-testing"
  
  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose        = true
    ansible.raw_arguments  = ["--connection=local"]
    ansible.limit          = "all"    
    ansible.inventory_path = "inventory"     
    ansible.playbook = "setup.yml"
  end 

  
  config.vm.provision "ansible_local" do |ansible2|
    ansible2.verbose        = true
    ansible2.raw_arguments  = ["--connection=local"]
    ansible2.limit          = "all"  
    ansible2.inventory_path = "inventory"     
    ansible2.playbook = "playbook.yml"
  end 

end