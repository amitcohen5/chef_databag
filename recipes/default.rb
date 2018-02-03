#
# Cookbook:: myusers
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

users = []

search("users", "platform:centos").each do |user_data|
  
  user user_data['name'] do
    uid user_data['uid']
    home user_data['home']
    shell user_data['shell']
  end
  users.push(user_data['name'])
end

#Create the Group if no exist

search("users", "gid:1990").each do |group_data|
  group "group_1" do
    gid group_data['gid']
    members users
    not_if "getent group | grep group_1"
    action :create
  end
end

search("users", "gid:1990").each do |group_data|
  group "group_1" do
    gid group_data['gid']
    members users
    only_if "getent group | grep group_1"
    action :modify
  end
end

