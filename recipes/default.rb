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

rbenv_gem "rubygems-update"
rbenv_gem "rdoc"

rbenv_gem "rails" do
  version "#{node[:barebone][:rails_version]}"
end

rbenv_gem "bundler"

# include_recipe 'barebone::nginx'
