## -*- encoding : utf-8 -*-
##
## Cookbook Name:: coins
## Provider:: default
##
## Copyright 2014, Alexey Zilber
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
#
## Stop monit
#action :stop_monit do
#  log "Stopping monit"
#  service "monit" do
#    action :stop
#  end 
#end
#
## Start monit
#action :start_monit do
#  log "Starting monit"
#  service "monit" do
#    action :start
#  end 
#end
#
## Reload monit
#action :reload_monit do
#  log "Reloading monit"
#  service "monit" do
#    action :reload
#  end
#end
#
## Restart monit
#action :restart_monit do
#  log "Restarting monit"
#  service "monit" do
#    action :restart
#  end
#end
#
