# package via their repository
include_recipe "varnish::apt_repo"

# install varnish
include_recipe "varnish::default"

# restart
service "varnish" do
  action :restart
end
