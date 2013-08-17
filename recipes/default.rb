#
# Cookbook Name:: barebone
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/apt/sources.list" do
  variables :nginx_deb => "http://nginx.org/packages/ubuntu/ lucid nginx",
  :nginx_deb_src => "http://nginx.org/packages/ubuntu/ lucid nginx"
end

cookbook_file "/tmp/nginx_signing.key" do
  source "nginx_signing.key"
end

execute "rm #{node[:barebone][:user_home]}/chef-recipe.log" do
  command "rm #{node[:barebone][:user_home]}/chef-recipe.log"
  only_if { ::File.exists?("#{node[:barebone][:user_home]}/chef-recipe.log")}
end

# execute "whomami logging" do
#   command "echo 'start' >> #{node[:barebone][:user_home]}/chef-recipe.log && pwd >> #{node[:barebone][:user_home]}/chef-recipe.log && users >> #{node[:barebone][:user_home]}/chef-recipe.log && whoami >> #{node[:barebone][:user_home]}/chef-recipe.log"
# end

bash "prerequisites" do
  code <<-EOH
    apt-key add /tmp/nginx_signing.key && apt-get update && sudo apt-get upgrade -y
    apt-get -y install build-essential git-core curl \
                       libssl-dev \
                       libyaml-dev \
                       libsqlite3-dev \
                       libreadline-dev \
                       zlib1g zlib1g-dev \
                       libmysqlclient-dev \
                       libcurl4-openssl-dev \
                       libxslt-dev libxml2-dev
  EOH
end

group node[:barebone][:group]

user node[:barebone][:user] do
  group node[:barebone][:group]
  home node[:barebone][:user_home]
  system true
  shell "/bin/bash"
  supports :manage_home => true
  action :create
end

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "#{node[:barebone][:ruby_version]}" do
  ruby_version "#{node[:barebone][:ruby_version]}"
  global true
end


# git "#{node[:barebone][:rbenv_dir]}" do
#   user "deployer"
#   repository "git://github.com/sstephenson/rbenv.git"
#   reference "master"
#   action :sync
#   not_if { ::File.exists?("#{node[:barebone][:rbenv_dir]}")}
# end
# 
# bash "set_path_for_rbenv" do
#   user "deployer"
#   cwd "#{node[:barebone][:user_home]}"
#   code <<-EOH
#     echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bash_profile
#     echo 'eval "$(rbenv init -)"' >> .bash_profile
#   EOH
#   not_if { "grep -q 'rbenv' .bash_profile" }
# end
# 
# git "#{Chef::Config[:file_cache_path]}/ruby-build" do
#   repository "git://github.com/sstephenson/ruby-build.git"
#   reference "master"
#   action :sync
# end
# 
# bash "install_ruby_build" do
#   cwd "#{Chef::Config[:file_cache_path]}/ruby-build"
#   code <<-EOH
#    ./install.sh
#    EOH
#   # environment 'PREFIX' => "/usr/local"
# end
# 
# bash "install_ruby" do
#   user "deployer"
#   cwd "#{node[:barebone][:user_home]}"
#   code <<-EOH
#     echo 'install_ruby' >> #{node[:barebone][:user_home]}/chef-recipe.log
#     echo 'install_ruby after shell change' >> #{node[:barebone][:user_home]}/chef-recipe.log
#     rbenv rehash    
#     CONFIGURE_OPTS="--with-openssl-dir=/usr/local" rbenv install #{node[:barebone][:ruby_version]}
#     rbenv rehash
#     rbenv global #{node[:barebone][:ruby_version]}
#   EOH
# end




# execute "assign permissions to /usr/local/rbenv" do
#   command "chgrp -R #{node[:barebone][:group]} #{node[:barebone][:rbenv_dir]} && chmod -R g+rwxXs #{node[:barebone][:rbenv_dir]}"
# end
# 
# execute "assign ubuntu to the 'admin' group" do
#   command "usermod -a -G #{node[:barebone][:group]} #{node[:barebone][:ubuntu_user]}"
# end

# # export RBENV_ROOT="/usr/local/rbenv"
# # export PATH="$RBENV_ROOT/bin:$PATH"
# # eval "$(rbenv init -)"



# execute "install_ruby" do
#   # command "echo 'install_ruby' >> ~/chef-recipe.log && whoami >> ~/chef-recipe.log"
#   command "CONFIGURE_OPTS='--with-openssl-dir=/usr/local' #{node[:barebone][:rbenv_bin_dir]}/rbenv install #{node[:barebone][:ruby_version]} && #{node[:barebone][:rbenv_bin_dir]}/rbenv rehash && #{node[:barebone][:rbenv_bin_dir]}/rbenv global #{node[:barebone][:ruby_version]}"
# end


# script "install_rails" do
#   interpreter "bash"
#   code <<-EOH
#     export PATH="#{node[:barebone][:rbenv_bin_dir]}:$PATH"
#     gem install rubygems-update
#     rbenv rehash
#     gem install rdoc
#     rbenv rehash
#     gem install rails --version=#{node[:barebone][:rails_version]}
#     rbenv rehash
#     gem install bundler
#     rbenv rehash
#   EOH
# end

# include_recipe 'barebone::nginx'
