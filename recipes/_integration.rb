#
# Cookbook Name:: lamp_role
# Recipe:: _integration
#
# Copyright (C) 2014 Fabio Napoleoni
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Private recipe used only in integration tests

# Used in integration tests to do commandline assertions
package 'curl'

# Plain php site with some features on
php_application 'php.example.com' do
  # Test some features of definition
  application_config aliases: ['php2.example.com'], users: %w(vagrant)

end

# Site content as a dummy file
file '/var/www/php.example.com/index.php' do
  content %q{<?php echo "Hello world";}
end

# MySQL application
php_application 'mysql.example.com' do
  # Test some features of definition
  application_config ssl: false, mysql: {username: 'mysql_user', password: 'mysql_password', host: 'localhost'}

end

# Site content as a dummy file
file '/var/www/mysql.example.com/index.php' do
  content <<-PHP
  <?php
  $link = mysql_connect('localhost', 'mysql_user', 'mysql_password') or die('Could not connect: ' . mysql_error());
  echo 'Connected successfully';
  PHP
end

# PHP application with ZF, NewRelic and Capistrano
php_application 'zend.example.com' do
  # Test some missing features of definition
  application_config capistrano: true, zend_framework: {environment: 'production'}
end

# Create structure by hand
directory '/var/www/zend.example.com/current/public' do
  recursive true
end

# Site content as a dummy file
file '/var/www/zend.example.com/current/public/index.php' do
  content <<-PHP
  <?php
  echo 'Zend';
  PHP
end


# PHP application with settings changed through config hash
php_application 'config.example.com' do
  # Change some php settings for the virtual hosts
  application_config php_values: {memory_limit: '10M'},
                     php_admin_values: { 'session.name' => 'Custom' },
                     php_flags: { display_errors: false },
                     php_admin_flags: { file_uploads: false }
end

# Site content as a dummy file
file '/var/www/config.example.com/index.php' do
  content '<?php phpinfo();'
end
