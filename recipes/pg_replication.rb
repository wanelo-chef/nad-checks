#
# Cookbook Name:: nad-checks
# Recipe:: psql_replication_delay
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
#

include_recipe "nad::default"

nad_dir = '/opt/omni/etc/node-agent.d'
master_ip = node["nad_checks"]["master"]["host"]
master_user = node["nad_checks"]["master"]["user"]
replica_ip = node["nad_checks"]["replica"]["host"]
replica_user = node["nad_checks"]["replica"]["user"]
path_additions = node["nad_checks"]["path_additions"]

directory "#{nad_dir}/postgres" do
  mode '0755'
end

template "#{nad_dir}/postgres/pg_replication.sh" do
  source "pg_replication.sh.erb"
  cookbook "nad-checks"
  mode 0755
  variables "master" => master_ip,
            "master_user" => master_user,
            "replica" => replica_ip,
            "replica_user" => replica_user,
            "path_additions" => path_additions
end

link "#{nad_dir}/pg_replication.sh" do
  to "#{nad_dir}/postgres/pg_replication.sh"
end
