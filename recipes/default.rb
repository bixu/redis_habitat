#
# Cookbook Name:: redis_habitat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

hab_install 'install habitat'

user 'hab' do
  action :create
end

hab_package "core/redis" do
  action :install
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
