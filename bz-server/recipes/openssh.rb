# OpenSSH config

node.default["openssh"]["server"]["port"] = 22
node.default["openssh"]["server"]["protocol"] = 2
node.default['openssh']['server']['key_regeneration_interval'] = "1h"
node.default['openssh']['server']['server_key_bits'] = "768"
node.default['openssh']['server']['syslog_facility'] = "AUTH"
node.default['openssh']['server']['log_level'] = "INFO"
node.default['openssh']['server']['login_grace_time'] = "2m"
node.default['openssh']['server']['permit_root_login'] = "yes" # NOTE do we really need this?
node.default['openssh']['server']['strict_modes'] = "yes"
node.default['openssh']['server']['ignore_rhosts'] = "yes"
node.default['openssh']['server']['permit_empty_passwords'] = "yes" # NOTE do we really need this
node.default['openssh']['server']['challenge_response_authentication'] = "no"
node.default['openssh']['server']['x11_forwarding'] = "no"
node.default['openssh']['server']['use_privilege_separation'] = "yes"
node.default['openssh']['server']['authorized_keys_file'] = "%h/.ssh/authorized_keys"
node.default['openssh']['server']['challenge_response_authentication'] = "no"
node.default['openssh']['server']['use_p_a_m'] = "yes"

open_ssh_subsystem = if platform_family? "rhel"
                       "sftp /usr/libexec/openssh/sftp-server"
                     else
                       "sftp /usr/lib/openssh/sftp-server"
                     end
node.default['openssh']['server']['subsystem'] = open_ssh_subsystem

include_recipe "openssh"

service :ssh do
  action :reload
end
