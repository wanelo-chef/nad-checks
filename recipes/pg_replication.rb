#
# Cookbook Name:: nad-checks
# Recipe:: psql_replication
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

include_recipe 'nad::default'

nad_dir = '/opt/circonus/etc/node-agent.d'
user = node['nad_checks']['pg_replication']['user']
path_additions = node['nad_checks']['pg_replication']['path_additions']

directory "#{nad_dir}/postgres" do
  mode '0755'
end

pg_version = node['nad_checks']['pg_replication']['pg_version'].split('.').join.to_i

if pg_version > 91
  template "#{nad_dir}/postgres/pg_replication.sh" do
    source 'postgres/9.2/pg_replication.sh.erb'
    cookbook 'nad-checks'
    mode 0755
    variables 'path_additions' => path_additions,
              'user' => user
  end
else
  template "#{nad_dir}/postgres/pg_replication.sh" do
    source 'postgres/9.1/pg_replication.sh.erb'
    cookbook 'nad-checks'
    mode 0755
    variables 'master' => node['nad_checks']['pg_replication']['9_1']['master']['host'],
              'replica' => node['nad_checks']['pg_replication']['9_1']['replica']['host'],
              'user' => user,
              'path_additions' => path_additions
  end
end

link "#{nad_dir}/pg_replication.sh" do
  to "#{nad_dir}/postgres/pg_replication.sh"
end
