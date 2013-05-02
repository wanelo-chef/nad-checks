#
# Cookbook Name:: nad-checks
# Recipe:: git-revision
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

nad_dir = '/opt/circonus/etc/node-agent.d'
path_additions = node["nad_checks"]["git_revision"]["path_additions"]

directory "#{nad_dir}/git" do
  mode '0755'
end

template "#{nad_dir}/git/git_revision.sh" do
  source "git-revision/git_revision.sh.erb"
  cookbook "nad-checks"
  mode 0755
  variables "path_additions" => path_additions,
            "projects" => node["nad_checks"]["git_revision"]["projects"]
end

link "#{nad_dir}/git_revision.sh" do
  to "#{nad_dir}/git/git_revision.sh"
end
