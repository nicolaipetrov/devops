# README first
#
# Starter base_box = Ubuntu18 (Chef, Berks,Ruby)

https://app.vagrantup.com/nicolai-petrov/boxes/u18chef12

Download:
wget https://vagrantcloud.com/nicolai-petrov/boxes/u18chef12/versions/0.0.1/providers/virtualbox.box

---------------------------------
Details
provider: virtualbox
 
OS: Ubuntu 18.04.2 LTS 
Kernel: (GNU/Linux 4.15.0-54-generic x86_64) 
packages: 
+    Chef 12.18.31 
+    Gem 2.6.8
+    Berks 6.3.4
+    Ruby 2.3.1p112
----------------------------------

# to modify or add some packages:
# Update Vagrantfile and finish below steps.

vagrant destroy -f &&  vagrant up --provision ; vagrant reload
vagrant ssh -c '/vagrant/clean-up.sh'
vagrant package --output u18chef12.box

