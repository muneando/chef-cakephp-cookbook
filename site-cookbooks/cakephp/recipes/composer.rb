#
# Cookbook Name:: php54
# Recipe:: composer
#
# Copyright 2014, mune ando
#
# All rights reserved - Do Not Redistribute
#

# Composerのインストール
execute "composer-install" do
  command "curl -s https://getcomposer.org/installer | php"
  not_if { ::File.exists?("/vagrant/composer.phar")}
end
