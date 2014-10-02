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
