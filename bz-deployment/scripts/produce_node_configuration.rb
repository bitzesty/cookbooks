require "json"

def parse_file(file_name)
  JSON.parse(File.read(file_name))
end

def node_configuration_file_name
  ARGV[0]
end

def run_list_file_name
  ARGV[1]
end

def merged_configuration
  parse_file(node_configuration_file_name).merge(parse_file(run_list_file_name))
end

def configuration_file_name
  file_name = [
    node_configuration_file_name.gsub(".json", ""),
    run_list_file_name
  ].join("_")

  ["nodes", file_name].join("/")
end

def write_to_file(configuration)
  File.open(configuration_file_name, 'w') do |file|
    file.write configuration
  end
end

def run
  write_to_file(merged_configuration.to_s)
end

run
