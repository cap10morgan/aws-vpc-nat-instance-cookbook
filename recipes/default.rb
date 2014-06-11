#
# Cookbook Name:: aws-vpc-nat-instance
# Recipe:: default
#
# Copyright 2014, Wes Morgan
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'node_dns'
include_recipe 'iptables-ng'
include_recipe 'sysctl'

chef_gem 'aws-sdk'

aws_creds = Chef::EncryptedDataBagItem.load("aws_creds", node.chef_environment)

ruby_block 'turn-off-source-dest-check' do
  block do
    require 'aws-sdk'
    aws_region = node['ec2']['placement_availability_zone'][0..-2]
    AWS.config(access_key_id: aws_creds['access_key_id'],
               secret_access_key: aws_creds['secret_access_key'],
               region: aws_region)
    instance = AWS::EC2::Instance.new(node['ec2']['instance_id'])
    instance.source_dest_check = false
  end
  action :create
end

iptables_ng_rule 'nat' do
  local_cidr_block = node['ec2']['network_interfaces_macs'][node['ec2']['mac']]['vpc_ipv4_cidr_block']
  table 'nat'
  chain 'POSTROUTING'
  ip_version 4
  rule "-o eth0 -s #{local_cidr_block} -j MASQUERADE"
end

# enable IPv4 forwarding
sysctl_param 'net.ipv4.ip_forward' do
  value 1
end
