#
# Cookbook Name:: cakephp-website
# Recipe:: php
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

#
# Cookbook Name:: php54
# Recipe:: php
#
# Copyright 2014, mune ando
#
# All rights reserved - Do Not Redistribute
#
  
%w(php php-devel php-cli php-pear php-mbstring php-intl php-mcrypt).each do |package|
  yum_package package do
    action :install
    options "--enablerepo=remi"
  end
end

include_recipe "php::ini"

include_recipe "apache2::mod_php5"