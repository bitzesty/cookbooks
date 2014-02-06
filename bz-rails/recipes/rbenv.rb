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

# make sure we are loading rbenv when executing commands
# this loads rbenv as well when we su to the user
ruby_block "rbenv: load rbenv in .bashrc" do
  block do
    file = Chef::Util::FileEdit.new(node['bz-rails']['rbenv']['bashrc_path'])
    file.insert_line_if_no_match(
      "/rbenv\.sh/",
      "source /etc/profile.d/rbenv.sh #Rbenv path for remote shells"
    )
    file.write_file
  end
end

