# -*- encoding : utf-8 -*-
#
# Cookbook Name:: walletserver
# Recipe:: install_python3
#
# Copyright 2014, Alexey Zilber
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
#

log "Install Python 3 into #{node[:walletserver][:root]}"

  directory "#{node[:walletserver][:root]}/build/python3" do
    owner node[:walletserver][:daemon][:user]
    group node[:walletserver][:daemon][:group]
    recursive true
  end

  remote_file "#{Chef::Config[:file_cache_path]}/python3.tar.gz" do
         source node[:walletserver][:python3][:source_file]
         mode "0755"
         backup false
         action :create_if_missing
         notifies :run, 'bash[install_python3]', :immediately
         notifies :run, 'bash[ldconfig_walletserver]', :immediately
         notifies :run, 'bash[install_python3pyp]', :immediately
         notifies :run, 'execute[clean_build]', :immediately
  end

  bash "install_python3" do
    user "#{node[:walletserver][:daemon][:user]}"
    code <<-EOH
      export LDFLAGS="#{node[:walletserver][:ldflags]}"

      export CPPFLAGS="#{node[:walletserver][:cppflags]}"

      tar -xzvp --strip-components 1 -f #{Chef::Config[:file_cache_path]}/python3.tar.gz -C #{node[:walletserver][:root]}/build/python3/
      (cd #{node[:walletserver][:root]}/build/python3  && ./configure --prefix=#{node[:walletserver][:root]} --enable-shared --without-universal-archs && make altinstall)

    EOH
    action :nothing
  end

  bash "install_python3pyp" do
    user "#{node[:walletserver][:daemon][:user]}"
    code <<-EOH

    curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | #{node[:walletserver][:root]}/bin/python3.3 -
    EOH
    action :nothing
  end
