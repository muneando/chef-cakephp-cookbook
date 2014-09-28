#
# Cookbook Name:: cakephp-website
# Attributes:: cakephp-website
#
# Copyright 2008-2014, AndWorks, Inc.
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
default['cakephp']['database']['host'] = 'localhost'
default['cakephp']['database']['login'] = node['product_name']
default['cakephp']['database']['password'] = node['product_name']
default['cakephp']['database']['database'] = node['product_name']
default['cakephp']['database']['prefix'] = 'baser'
default['cakephp']['database']['encoding'] = 'utf8'

default['cakephp']['core']['debug'] = 2

default['mysql']['import_zip_file'] = '/vagrant/scripts/mysql.sql.gz'

