#
# Cookbook Name:: barebone
# Recipe:: nginx
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# template "/etc/apt/sources.list" do
#   variables :nginx_deb => "http://nginx.org/packages/ubuntu/ lucid nginx",
#   :nginx_deb_src => "http://nginx.org/packages/ubuntu/ lucid nginx"
# end
# 
# cookbook_file "/tmp/nginx_signing.key" do
#    source "nginx_signing.key"
#  end
#  
# execute "sudo apt-get update" do
#   command "sudo apt-key add /tmp/nginx_signing.key && sudo apt-get update"
# end
# 

execute "sudo apt-get -y remove nginx && sudo apt-get -y autoremove" do
  command "sudo apt-get -y remove nginx && sudo apt-get -y autoremove"
end

# execute "sudo apt-get -q -y install nginx=1.4.2-1~lucid" do
#   command "sudo apt-get -q -y install nginx=1.4.2-1~lucid"
# end

package 'nginx' do
  action    :install
  version   node[:nginx][:version]
end

