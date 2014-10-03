#
# Cookbook Name:: apache
# Recipe:: apache
#
# Copyright 2014, mune ando
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2'

include_recipe 'apache2::mod_rewrite'

# apache2のレシピを読み込んで、デフォルトのVirtualHostを無効にする。

execute "a2dissite default"

# コピーしたVirtualHostのテンプレートを設定する。
web_app node['product_name'] do
  server_name node['hostname']
  server_aliases [node['fqdn'], node['product_name']]
  docroot "/vagrant/app/webroot/"
  allow_override "All"
end