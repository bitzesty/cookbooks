# Load user Upstart jobs from ~/.init for each user automatically on boot
# see https://github.com/brightbox/puppet/blob/master/modules/upstart/files/load-user-jobs.conf
#
# These modifications support Upstart style jobs for each user
# and allow one to utilize Ubuntu's upstart to manage jobs

if platform? "ubuntu"
  template "/etc/dbus-1/system.d/Upstart.conf" do
    source "Upstart.erb"
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
