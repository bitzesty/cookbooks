if node['bz-server']['logrotate']['enabled']
  # Setup logrotate for rails
  template "/etc/logrotate.d/rails_#{node['bz-server']['app']['name']}" do
    source "logrotate_rails_app.erb"
  end

  # Setup logrotate for nginx if not the same as rails logs path
  unless node['bz-webserver']['nginx']['log']['dir'] == "#{node['bz-rails']['shared_path']}/log"
    template "/etc/logrotate.d/nginx_#{node['bz-server']['app']['name']}" do
      source "logrotate_nginx_app.erb"
    end
  end
end
