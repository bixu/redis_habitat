#
# Cookbook Name:: redis_habitat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

hab_install 'install habitat'

user 'hab' do
  action :create
end

# install core/hab-sup to help prevent race conditions in inspec
%w{core/hab-sup core/redis}.each do |pkg|
  hab_package pkg do
    action :install
  end
end

hab_service 'core/redis' do
  action [:enable, :start]
  unit_content <<-EOF
[Unit]
Description=redis

[Service]
Environment = "HAB_REDIS=tcp-backlog=128"
ExecStart = /bin/hab start core/redis
Restart=on-failure

[Install]
WantedBy = default.target

EOF
end
