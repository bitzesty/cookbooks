# This assumes that Rails project is using 'foreman' gem for server process
# management or has 'dotenv-rails' gem as a dependency.
#
# Do not forget to add
# require 'dotenv/capistrano'
# to deploy.rb so that .env file would be symlinked from shared directory

file File.join(node['bz-rails']['shared_path'],'config', '.env') do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode "600"
  content node['bz-rails']['env'].map { |k,v| "#{k.upcase}=#{v}" }.join("\n")
end
