# locales "en_US.UTF-8 UTF-8" do
#   action :add
# end

# locale configuration
if platform?("ubuntu", "debian")
  used_locales = []

  package "locales" do
    action :install
  end

  used_locales = []

  execute "Update locale LANG" do
    command "update-locale LANG=#{node[:locale][:lang]}"
  end

  execute "Update locale LANGUAGE" do
    command "update-locale LANGUAGE=#{node[:locale][:language]}"
  end

  node[:locale].each_pair do |key, value|
    if key.start_with?("lc_")
      execute "Update #{key.upcase}" do
        command "update-locale #{key.upcase}=#{value}"
      end
      used_locales.push(value)
    end
  end

  used_locales.uniq.each do |locale|
    execute "Locale gen" do
      command "locale-gen #{locale}"
    end
  end
end

if platform?("redhat", "centos", "fedora")
  execute "Update locale" do
    command "locale -a | grep ^#{node[:locale][:lang]}$ && sed -i 's|LANG=.*|LANG=#{node[:locale][:lang]}|' /etc/sysconfig/i18n"
  end
end
