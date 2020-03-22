#
# Cookbook:: server_nginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved
# #
# Cookbook:: git_cookbook
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved
# package 'git'
package 'tree'

if platform_family?('rhel')
  package 'epel-release'
end

if platform_family?('debian')
  apt_update 'update'
end

package 'nginx' do
  action :install
end


service 'nginx' do
  action [ :enable, :start ]
end

# directory "Create a directory" do
#   group "root"
#   mode "777"
#   owner "root"
#   path "/var"  
# end

directory "Create a directory" do
  group "root"
  mode "777"
  owner "root"
  path "/var/www"
end

directory "Create a directory" do
  group "root"
  mode "777"
  owner "root"
  path "/var/www/html"  
end

cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0644"
end
template "/etc/nginx/nginx.conf" do   
  source "nginx.conf.erb"
  notifies :reload, "service[nginx]"
end
