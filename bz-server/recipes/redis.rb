# Install redis if described in configuration

if node.default["bz-server"]["redis"].present?
  include_recipe "redisio::install"
  include_recipe "redisio::enable"
end
