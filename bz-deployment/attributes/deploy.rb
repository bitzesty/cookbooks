default_attrs = default['bz-deployment']

default_attrs['ssh_cert_dir'] = "/home/#{node['bz-server']['user']['name']}/.ssh"
default_attrs['id_rsa_file_path'] = "#{node['bz-deployment']['ssh_cert_dir']}/id_rsa_deploy"
default_attrs['deploy_directory'] = "/home/#{node['bz-server']['user']['name']}/deployment"
default_attrs['deploy_app_path'] = [
  node['bz-deployment']['deploy_directory'],
  node['bz-server']['app']['name']
].join("/")
default_attrs['repository'] = "git@github.com:bitzesty/#{node['bz-server']['app']['name']}.git"
default_attrs['checkout_branch'] = "master"
default_attrs['rbenv_root'] = "/home/#{node['bz-server']['user']['name']}/.rbenv"
default_attrs['user_home'] = "/home/#{node['bz-server']['user']['name']}"
default_attrs['deploy_environment'] = {
  HIPCHAT_TOKEN: node['bz-database']['backup']['hipchat']['token'],
  RBENV_ROOT: node['bz-deployment']['rbenv'],
  USER: node['bz-server']['user']['name'],
  HOME: node['bz-deployment']['user_home'],
}
default_attrs['deploy_command'] = %Q{
export RBENV_ROOT="#{node['bz-deployment']['rbenv']}"
export PATH="${RBENV_ROOT}/bin:$PATH"
eval "$(rbenv init -)"
export RBENV_VERSION="#{node['bz-rails']['development']['ruby_version']}"
bundle exec cap #{node['bz-rails']['environment']} deploy
}
