#
# Cookbook Name:: mysql
# Recipe:: mysql
#
# Copyright 2014, mune ando
#
# All rights reserved - Do Not Redistribute
#

%w[mysql-server mysql-devel phpMyAdmin php-mysql].each do |pkg|
	package pkg do
	    action :install
	    options "--enablerepo=remi"
	end
end

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

# 用意しているバックアップファイル（ZIP）からデータベースに初期データを投入する。
# バックアックの例
#   mysqldump -u admin -padmin PRODUCT_NAME | gzip > /vagrant/scripts/mysql.sql.gz

execute  'import db' do
  command 'gunzip -c ' + node['mysql']['import_zip_file'] + ' | mysql -u admin -padmin ' + node['product_name']
  only_if { ::File.exists?(node['mysql']['import_zip_file'])}
  creates "/var/lib/mysql/' + node['product_name'] + '/baser_contents.MYD"
end