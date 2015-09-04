include_recipe 'nad::default'

nad_dir = '/opt/circonus/etc/node-agent.d'
configuration_file = "#{node['nad_checks']['configuration_dir']}/new_relic_mobile.json"

directory "#{nad_dir}/new_relic" do
  mode '0755'
end

template "#{nad_dir}/new_relic/mobile.js" do
  source 'new_relic/mobile.js.erb'
  cookbook 'nad-checks'
  mode 0755
  variables 'configuration_file' => configuration_file
end

link "#{nad_dir}/new_relic_mobile.js" do
  to "#{nad_dir}/new_relic/mobile.js"
  action ::File.exist?(configuration_file) ? :create : :delete
end
