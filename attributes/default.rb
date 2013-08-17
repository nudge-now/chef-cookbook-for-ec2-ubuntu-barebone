default[:barebone][:user] = "deployer"
default[:barebone][:group] = "admin"
default[:barebone][:user_home] = "/home/#{node[:barebone][:user]}"

# default[:barebone][:ubuntu_user] = "ubuntu"
# default[:barebone][:ubuntu_user_home] = "/home/#{node[:barebone][:ubuntu_user]}"

default[:barebone][:rbenv_dir] = "/opt/rbenv"
default[:barebone][:rbenv_bin_dir] = "#{node[:barebone][:rbenv_dir]}/bin"

default[:barebone][:ruby_version] = "1.9.3-p448"
default[:barebone][:rails_version] = "3.2.14"

