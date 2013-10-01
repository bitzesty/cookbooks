# rbenv!

# install prequisites
if platform_family? "debian"
  package "build-essential"
  package "openssl"
  package "libssl-dev"
  package "libreadline-dev"
end

include_recipe "ruby_build"
include_recipe "rbenv::user"
