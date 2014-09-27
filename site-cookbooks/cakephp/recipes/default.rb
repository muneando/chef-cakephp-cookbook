#
# Cookbook Name:: cakephp-website
# Recipe:: default
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

include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'

include_recipe 'yum'

include_recipe 'cakephp::iptables'
include_recipe 'cakephp::php'
include_recipe 'cakephp::phpmyadmin'
include_recipe 'cakephp::database'
include_recipe 'cakephp::cakephp'

# apache2のレシピを読み込んで、デフォルトのVirtualHostを無効にする。

execute "a2dissite default"

# コピーしたVirtualHostのテンプレートを設定する。
web_app node['product_name'] do
  server_name node['hostname']
  server_aliases [node['fqdn'], node['product_name']]
  docroot "/vagrant/app/webroot/"
  allow_override "All"
end