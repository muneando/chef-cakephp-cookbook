# chef-cakephp-cookbook

## 概要

CakePHPの実行環境を作るためのChefクックブックです。

## 動作環境

### ホスト
* Virtual Box
* vagrant
* chef solo
* Berkshelf


### 仮想サーバー
* CentOS 6.5
* Apache
* PHP
* MySQL
* CakePHP
* phpMyAdmin
* Composer

オプションとしてbaserCMSのデータベースの設定を行います。

## インストール方法

* Virtual Box, Vagrant, Chef, Berkself をあらかじめインストールしてください。現在確認している各バージョンは、Windows上の以下の通りです。
	* VirtualBox 4.3.12
	* vagrant
```sh
$ vagrant -v
Vagrant 1.6.2
```
	* chef
```sh
$ chef -v
Chef Development Kit Version: 0.2.2
```
    * Berkshelf
```sh
$ berks -v
3.1.5
```

* 必要なVagrantのプラグインをインストールします。
```sh
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-cachier
```

* `chef` ディレクトリにCloneもしくはCopyしてください。
Gitのサブモジュールでもインストールできます。
```sh
git submodule add https://github.com/muneando/chef-cakephp-cookbook.git chef
```

* ```Vagrantfile``` と ```composer.json``` 、 ```Berksfile``` のディレクトリにコピーします。
```sh
cp chef/Vagrantfile.sample Vagrantfile
cp chef/composer.sample.json composer.json
cp chef/Berksfile.sample Berksfile
```
```Vagrantfile``` は、お使いの動作環境にしたがって修正してください。```composer.json``` は CakePHP のインストールの設定をしていますが、その他必要なライブラリがあれば追加してください。

* Vagrant を実行して仮想マシンを起動してChefクックブックを充当させます。
```sh
vagrant up
```

* CakePHPのプロジェクトを作成します。
```sh
Vendor/bin/cake bake project .
```
すでにCakePHPのプロジェクトがある場合は、```app/```以下に置いてください。

* 再度Chefのプロビジョンを実行します。
```sh
vagrant provision
```
これで、```app/Config/database.php``` の設定を行うことができます。

* CakePHPの設定ができたかを、Vagrantで作成したサーバーにアクセスして確認します。
* phpMyAdminがインストールできたか確認します。
```web
http://ipアドレス/phpmyadmin
```

## レシピ
レシピ名|説明
---|---
cakephp::default|CakePHP環境を作成します。cakephp:baserレシピ以外の実行を順次行います。
cakephp::iptables|iptableの設定をします。httpとsshを許可します。
cakephp::php|PHPの設定をします。Composerのインストールとライブラリのインストールをします。
cakephp::phpmyadmin|phpMyAdminのインストールと設定をします。
cakephp::database|MySQLの設定をします。データベースの作成、MySQLユーザーの作成、デフォルトのデータベースのインポートをおこないます。
cakephp::cakephp|CakePHPの設定をします。
cakephp:baser|baserCMS固有ののデータベースの設定をします。CakePHPの標準的な設定とは違うので最後に実行してください。

## Vagrantfile

変数名|説明|設定例
---|---|---
PRODUCT_NAME|プロダクト名|"cakephp"
CHEF_DIR|chefクックブックを格納しているディレクトリ| "/vagrant/chef"

opscode-cookbookのクックブックを ```Vagrantfile``` に設定します。
```ruby
chef.json = {
  :product_name => PRODUCT_NAME, # プロダクト名
  :apache => { # opscode-cookbooks/apache2クックブックの設定
    :default_site_enabled => true,
    :docroot_dir => '/vagrant/app/webroot'
  },
  :mysql => { # opscode-cookbooks/mysqlクックブックの設定
    :server_root_password => PRODUCT_NAME,
    :server_repl_password => PRODUCT_NAME,
    :server_debian_password => PRODUCT_NAME
  }
}
```
設定の詳細は[opscode-cookbooks のサイト](https://github.com/opscode-cookbooks)をご覧ください。

Vagrantの同期フォルダは、
ホスト|仮想サーバー
---|---
./|/vagrant
を想定しています。

## Atribute

### CakePHPの/app/Config/database.phpの設定
Attribute|初期値|説明
---|---|---
default['cakephp']['database']['host']|'localhost'|接続先ホスト名
default['cakephp']['database']['login']|プロダクト名|データベースユーザー名
default['cakephp']['database']['password']|プロダクト名|データベースパスワード
default['cakephp']['database']['database']|プロダクト名|データベース名
default['cakephp']['database']['prefix']|''|テーブルのプレフィックス
default['cakephp']['database']['encoding']|'utf8'|データベースエンコード

### MySQLの設定
Attribute|初期値|説明
---|---|---
default['mysql']['import_zip_file']|'/vagrant/scripts/mysql.sql.gz'|初期データベースファイル。gzipで圧縮してください。

## 開発
* mune ando (<ando@and-works.co.jp>)

## ライセンス
```text
Copyright:: 2014 mune ando

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```



