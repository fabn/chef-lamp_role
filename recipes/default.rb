#
# Cookbook Name:: lamp_role
# Recipe:: default
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

# This is coming from other cookbook
include_recipe 'mysql_role::default'
# Install and tune apache2
include_recipe 'lamp_role::apache2'
# Install php and usual modules
include_recipe 'lamp_role::php'
include_recipe 'lamp_role::php_modules'
