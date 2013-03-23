#
# Cookbook Name:: nad-checks
# Recipe:: zone_utilization
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

include_recipe "nad::default"

nad_dir = '/opt/omni/etc/node-agent.d'

directory "#{nad_dir}/smartos" do
  mode '0755'
end

template "#{nad_dir}/smartos/zone_utilization.sh" do
  source "smartos/zone_utilization.sh.erb"
  cookbook "nad-checks"
  mode 0755
end

link "#{nad_dir}/zone_utilization.sh" do
  to "#{nad_dir}/smartos/zone_utilization.sh"
end
