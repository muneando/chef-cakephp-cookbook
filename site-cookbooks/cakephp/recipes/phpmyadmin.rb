#
# Cookbook Name:: cakephp-website
# Recipe:: phpmyadmin
#
# Copyright 2014, AndWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe  'yum-epel'

%w{phpmyadmin php-mysql php-mcrypt}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "httpd_restart" do
  command "/etc/init.d/httpd restart"
  action :nothing
end

cookbook_file "/etc/httpd/sites-available/phpMyAdmin.conf" do
  owner 'root'
  group 'root'
  mode '0644'
end

execute "site-phpmyadmin-snsite" do
    command "a2ensite phpMyAdmin"
    not_if { ::File.exists?("/etc/httpd/sites-enable/phpMyAdmin.conf")}
    notifies :restart, "service[apache2]", :immediately
end
