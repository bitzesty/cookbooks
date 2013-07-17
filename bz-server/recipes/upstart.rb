# Load user Upstart jobs from ~/.init for each user automatically on boot
# see https://github.com/brightbox/puppet/blob/master/modules/upstart/files/load-user-jobs.conf
#
# These modifications support Upstart style jobs for each user
# and allow one to utilize Ubuntu's upstart to manage jobs

# RHEL has upstart v0.6.5, user jobs require upstart v1.3, use system jobs for RHEL
if platform_family? "debian"
  template "/etc/dbus-1/system.d/Upstart.conf" do
    source "Upstart.conf.erb"
    owner "root"
    group "root"
    mode  "644"
    notifies :reload, "service[dbus]", :immediately
  end

  template "/etc/init/load-user-jobs.conf" do
    source "load-user-jobs.conf.erb"
    owner "root"
    group "root"
    mode  "644"
  end
end

# Add sudo rights for service config and startup
if platform_family? "rhel"
  deploy_user = node['bz-server']['user']['name']
  app = node['bz-server']['app']['name']

  append_if_no_line "make sure #{deploy_user} can start and stop the service" do
    path "/etc/sudoers"
    line "#{deploy_user} ALL=(ALL) NOPASSWD: /bin/rm -f /etc/init/#{app}*,/bin/mv /tmp/#{app}*.conf /etc/init/,/sbin/start #{app},/sbin/stop #{app},/sbin/restart #{app}, /sbin/status #{app}-*"
  end
end
