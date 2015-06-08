# Cookbook Name:: gitlab
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe 'postgresql::server'
include_recipe 'database::postgresql'

conn_info = {
  host: node['gitlab']['postgresql']['host'],
  port: node['gitlab']['postgresql']['port'],
  username: node['gitlab']['postgresql']['username'],
  password: node['postgresql']['password']['postgres']
}

postgresql_database_user node['gitlab']['postgresql']['gitlab_username'] do
  connection conn_info
  password node['gitlab']['postgresql']['gitlab_password']
  action :create
end

postgresql_database node['gitlab']['postgresql']['gitlab_database'] do
  connection conn_info
  action :create
end

postgresql_database_user node['gitlab']['postgresql']['gitlab_username'] do
  connection conn_info
  database_name 'gitlab'
  privileges [:all]
  action :grant
end

remote_file "#{Chef::Config[:file_cache_path]}/gitlab-ce-7.10-omnibus.rpm" do
  source 'https://downloads-packages.s3.amazonaws.com/centos-7.1.1503/gitlab-ce-7.10.0~omnibus.2-1.x86_64.rpm'
  action :create
end

execute 'gitlab_install' do
  command "rpm -i #{Chef::Config[:file_cache_path]}/gitlab-ce-7.10-omnibus.rpm"
  not_if 'yum list installed | grep gitlab'
end

template '/etc/gitlab/gitlab.rb' do
  source 'gitlab.rb.erb'
  mode 0600
end

template '/opt/gitlab/embedded/cookbooks/solo.rb' do
  source 'solo.rb.erb'
  mode 0664
end

execute 'gitlab-configure' do
  command 'gitlab-ctl reconfigure'
end

cookbook_file 'check.sh' do
  path "#{Chef::Config[:file_cache_path]}/check.sh"
  action :create
end

execute 'gitlab create root user' do
  only_if "bash #{Chef::Config[:file_cache_path]}/check.sh | grep '0 rows'"
  command 'gitlab-rake gitlab:setup RAILS_ENV=production force=yes'
end

execute 'nginx access to gitlab socket' do
  command 'usermod -aG gitlab-www nginx'
end
