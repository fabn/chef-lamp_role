# Default attributes for php applications
default[:php_applications][:applications_bag] = 'php_applications'
# Default base path for php application
default[:php_applications][:apps_path] = node[:apache][:docroot_dir]

# User and group used to run the application
default[:php_applications][:user] = node[:apache][:user]
default[:php_applications][:group] = node[:apache][:group]

# Used to create mysql users
default[:php_applications][:mysql_admin_credentials][:host] = 'localhost'
default[:php_applications][:mysql_admin_credentials][:username] = 'root'
default[:php_applications][:mysql_admin_credentials][:password] = node[:mysql][:server_root_password]
