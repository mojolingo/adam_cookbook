case node["platform"]
when 'ubuntu'
  include_recipe 'brightbox-ruby'
else
  include_recipe "ruby_build"
  node['ruby_build']['install_pkgs_cruby'].each { |p| package p } # Pending https://github.com/fnichol/chef-ruby_build/pull/16
  ruby_build_ruby "2.1.0"
  file "/etc/profile.d/ruby.sh" do
    content "PATH=/usr/local/ruby/2.1.0/bin:$PATH"
  end
  gem_package "bundler"
end
