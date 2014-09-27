#
# Cookbook Name:: cakephp-website
# Recipe:: database
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

include_recipe 'mysql::client'
include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = {
  :host => "localhost",
  :username => 'root',
  :password => node['mysql']['server_root_password']
  }

mysql_database node['product_name'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user "admin" do
  connection mysql_connection_info
  password "admin"
  database_name node['product_name']
  privileges [:all]
  action [:create, :grant]
end

mysql_database_user node['product_name'] do
  connection mysql_connection_info
  password node['product_name']
  database_name node['product_name']
  privileges [:all]
  action [:create, :grant]
end

# mysqldump -u admin -padmin PRODUCT_NAME | gzip > /vagrant/scripts/mysql.sql.gz

execute  'import db' do
  command 'gunzip -c /vagrant/scripts/mysql.sql.gz | mysql -u admin -padmin ' + node['product_name']
  creates "/var/lib/mysql/' + node['product_name'] + '/baser_contents.MYD"
end

