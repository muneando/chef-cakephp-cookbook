#
# Cookbook Name:: cakephp-website
# Recipe:: cakephp
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

template "/vagrant/app/Config/database.php" do
  source "cakephp/database.php.erb"
  mode 0660
  owner "vagrant"
  group "vagrant"
  variables({
    :host=> node[:cakephp][:database][:host],
    :login => node[:cakephp][:database][:login],
    :password => node[:cakephp][:database][:password],
    :database=> node[:cakephp][:database][:database],
    :prefix => node[:cakephp][:database][:prefix],
    :encoding=> node[:cakephp][:database][:encoding]
  })
end

template "/vagrant/app/Config/core.php" do
  source "cakephp/core.php.erb"
  mode 0660
  owner "vagrant"
  group "vagrant"
  variables({
    :debug=> node[:cakephp][:core][:debug],
  })
end

template "/vagrant/app/Config/bootstrap.php" do
  source "cakephp/bootstrap.php.erb"
  mode 0660
  owner "vagrant"
  group "vagrant"
end