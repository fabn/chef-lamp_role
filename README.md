# LAMP cookbook [![Build Status](https://travis-ci.org/fabn/chef-lamp_role.svg)](https://travis-ci.org/fabn/chef-lamp_role)

[Role wrapper cookbook](http://www.getchef.com/blog/2013/12/03/doing-wrapper-cookbooks-right/) for LAMP stack.

This cookbook provides a full LAMP stack on Debian/Ubuntu platform.

# Requirements

This cookbook is currently tested with the following setup:

* Chef: 11.10.4
* Ubuntu 12.04

This cookbook depends on the following cookbooks

* [apache2](https://github.com/opscode-cookbooks/apache2) (~> 1.9.6)
* [php](https://github.com/opscode-cookbooks/php)
* [ssl](https://github.com/cap10morgan/ssl-cookbook)
* [mysql_role](https://github.com/fabn/chef-mysql_role)

On Ubuntu/Debian, use Opscode's `apt` cookbook to ensure the package
cache is updated so Chef can install packages, or consider putting
apt-get in your bootstrap process or
[knife bootstrap template](http://wiki.opscode.com/display/chef/Knife+Bootstrap).

This cookbook (current version) will not work with apache 2.4 and ubuntu 14.04.

# Usage

Include default recipe to get a full LAMP stack.

# Attributes

This cookbook rewrite some apache2 attributes to suit LAMP stack need. You will likely edit some of them.
See [attributes file](attributes/default.rb) for latest version of overridden attributes

The following attributes are added by this cookbook

# Additional attributes for apache default recipe
default[:lamp][:www_browser] = 'w3m' # Name of a package which provides www-browser

# Default php modules
default[:lamp][:php_modules] = %w(mysql gd apc curl)

* `node[:lamp][:www_browser]` - textual browser package used to setup `apache2ctl status` command. Default `w3m`
* `node[:lamp][:php_modules]` - PHP installed modules. Default `%w(mysql gd apc curl)`

These other attributes are used in `php_application` definition described below

* `node[:php_applications][:applications_bag]` - reserved for future use.
* `node[:php_applications][:apps_path]` - Base path where to put php applications. Default `node[:apache][:docroot_dir]`
* `node[:php_applications][:user]` - Default owner for php applications. Default `node[:apache][:user]`
* `node[:php_applications][:group]` - Default group for php applications. Default `node[:apache][:group]`
* `node[:php_applications][:mysql_admin_credentials][:host]` - Database host where to create db users. Default `localhost`
* `node[:php_applications][:mysql_admin_credentials][:username]` - Administrative database user for creating db users. Default `root`
* `node[:php_applications][:mysql_admin_credentials][:password]` - Administrative database password for creating db users. Default `node[:mysql][:server_root_password]`

# Recipes

## Default

Install Apache2, PHP and MySQL on the target host. Apache default virtual host is overridden with [this template](templates/default/default-site.erb)
i.e. is configured to respond with '404 Not found' on every request.

Apache status is configured to respond on virtual host only, this can be useful in order to setup monit with apache protocol.

PHP is installed with modules given in attributes and prepared for MySQL integration.

MySQL is configured using [this role cookbook](https://github.com/fabn/chef-mysql_role)

# Definitions

## php\_application

This definition can be used to setup a virtual host for a php application. It accepts some parameters to configure
the application, here are the accepted configuration options and their default values:

* `basedir` - This will be the path where the application is stored. Default `#{node[:php_applications][:apps_path]}/#{application_name}`
* `owner` - Application folder owner. Default `node[:php_applications][:user]`
* `group` - Application folder group. Application folder is configured with mode 2775, in this way any content created inside
 the folder can be shared with all members of this group. Default `node[:php_applications][:group]`
* `canonical_hostname` - If given and not false the application a [rewrite rule](templates/default/apache_vhost.conf.erb#L45)
 is added to vhost configuration to redirect all requests made with non canonical hostname to the same path but with
 canonical hostname, useful for SEO. Default `application_name`
* `aliases` - An array of aliases for the given virtual host. Default `[]`
* `capistrano` - Prepare the virtual host for capistrano support, i.e. Point Document Root to `"#{basedir}/current"`. Default `false`
* `zend_framework` - Prepare the virtual host for zend framework support, i.e. Point Document Root to `"#{basedir}/public"`. Default `false`
* `mysql` - If hash can be used to create local users for the application (see [this example](recipes/_integration.rb#L37). Default `false`
* `users` - Additional system users to append to application group. Default `[]`
* `document_root` - Used to override application document root in virtual host configuration. Default `nil`
* `ssl` - SSL support for virtual host, need some documentation. Default `false`

Additional parameters can be given to configure php directives in virtual host file. They are hashes of php flags or values

* `php_values` - PHP values in apache config. Default `{}`
* `php_admin_values` - PHP admin values in apache config. Default `{}`
* `php_flags` - PHP flags in apache config. Default `{}`
* `php_admin_flags` - PHP admin flags in apache config. Default `{}`

A minimal example of `php_application` definition is the following

```ruby
# Plain php site with some features on
php_application 'php.example.com' do
 application_config aliases: ['php2.example.com'], users: %w(vagrant)
end
```

Full usage of this definition is shown in [this recipe](recipes/_integration.rb) and its
 [serverspec](test/integration/default/serverspec/php_applications_spec.rb)

# Author

Author:: Fabio Napoleoni (<f.napoleoni@gmail.com>)
