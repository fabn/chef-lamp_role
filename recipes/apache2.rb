#
# Cookbook Name:: lamp_role
# Recipe:: apache2
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

# Install apache webserver
include_recipe 'apache2'

# This package is needed to make apache2ctl status working
package(node[:lamp][:www_browser])

# Restrictive version of default site template, which return not found for every request
template("#{node[:apache][:dir]}/sites-available/default") {
  source 'default-site.erb'
  owner 'root'
  group node[:apache][:root_group]
  mode '0644'
  notifies :restart, 'service[apache2]'
}

# Rewrite ports file to enable virtual host on every port
template "#{node['apache']['dir']}/ports.conf" do
  source   'ports.conf.erb'
  owner    'root'
  group    node['apache']['root_group']
  mode     '0644'
  notifies :restart, 'service[apache2]'
end

