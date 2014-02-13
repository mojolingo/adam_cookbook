case node["platform"]
when 'ubuntu'
  include_recipe 'brightbox-ruby'
else
  include_recipe "ruby_build"
  node['ruby_build']['install_pkgs_cruby'].each { |p| package p } # Pending https://github.com/fnichol/chef-ruby_build/pull/16
  ruby_build_ruby "2.1.0"
  bash "link ruby" do
    code "ln -s /usr/local/ruby/2.1.0/bin/* /usr/bin/"
    not_if "test -L /usr/bin/ruby"
  end
end
