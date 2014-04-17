include_attribute "bz-rails::default"

upstart_templates = default['bz-server']['upstart_templates']
upstart_templates['path'] = File.join(node['bz-rails']['shared_path'], "config", "deploy", "templates")
