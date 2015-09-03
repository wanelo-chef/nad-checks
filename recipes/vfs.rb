#
# Cookbook Name:: nad-checks
# Recipe:: vfs
#
# Copyright 2013, Wanelo, Inc
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# The zone_vfs kstat will increment instance number on each reboot of the
# zone. This (I assume) is so that an operator in the global zone can
# observe vfs statistics and compare them to values from previous reboots.
# It makes consistent tracking very difficult, however, so this script
# changes the instance number to 'all'.

include_recipe 'nad::default'

nad_dir = '/opt/circonus/etc/node-agent.d'

directory "#{nad_dir}/vfs" do
  mode '0755'
end

template "#{nad_dir}/vfs/vfs.sh" do
  source 'vfs/vfs.sh.erb'
  cookbook 'nad-checks'
  mode 0755
end

link "#{nad_dir}/vfs.sh" do
  to "#{nad_dir}/vfs/vfs.sh"
end
