#
# Cookbook Name:: lamp_role
# Recipe:: php_modules
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

node[:lamp][:php_modules].each do |mod|
  include_recipe "php::module_#{mod}"
end

if node[:lamp][:php_modules].include?('apc')
# Generate apc.ini configuration
  template '/etc/php5/conf.d/apc.ini' do
    source 'apc.ini.erb'
    owner 'root'
    group 'root'
    mode '0644'
    # If this recipe is included without apache2 this can fail
    notifies :restart, 'service[apache2]' if node.recipes.include?('apache2')
  end
end
