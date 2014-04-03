case node["platform"]
when 'ubuntu'
  include_recipe 'brightbox-ruby'
else
  include_recipe "ruby_build"
  node['ruby_build']['install_pkgs_cruby'].each { |p| package p } # Pending https://github.com/fnichol/chef-ruby_build/pull/16
  ruby_version = "2.1.0"
  ruby_bin_path = "/usr/local/ruby/#{ruby_version}/bin"
  ruby_build_ruby ruby_version

  directory "/usr/local/ruby/2.1.0/etc"

  file "/usr/local/ruby/2.1.0/etc/gemrc" do
    content <<-GEMRC
---
:backtrace: false
:benchmark: false
:update_sources: true
:bulk_threshold: 1000
:verbose: true
gem: -n/usr/local/bin
    GEMRC
  end

  bash "link ruby" do
    code <<-INSTALL
RUBYVER=#{ruby_version}
update-alternatives --install /usr/bin/gem gem \
  /usr/local/ruby/${RUBYVER}/bin/gem 180 \
  --slave /usr/share/man/man1/gem.1.gz gem.1.gz /usr/share/man/man1/gem2.0.1.gz \
  --slave /etc/bash_completion.d/gem bash_completion_gem /etc/bash_completion.d/gem2.0
update-alternatives \
  --install /usr/bin/ruby ruby /usr/local/ruby/${RUBYVER}/bin/ruby 50 \
  --slave /usr/bin/erb erb /usr/local/ruby/${RUBYVER}/bin/erb \
  --slave /usr/bin/testrb testrb /usr/local/ruby/${RUBYVER}/bin/testrb \
  --slave /usr/bin/irb irb /usr/local/ruby/${RUBYVER}/bin/irb \
  --slave /usr/bin/rdoc rdoc /usr/local/ruby/${RUBYVER}/bin/rdoc \
  --slave /usr/bin/ri ri /usr/local/ruby/${RUBYVER}/bin/ri \
  --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby${RUBYVER}.1.gz \
  --slave /usr/share/man/man1/erb.1.gz erb.1.gz /usr/share/man/man1/erb${RUBYVER}.1.gz \
  --slave /usr/share/man/man1/testrb.1.gz testrb.1.gz /usr/share/man/man1/testrb${RUBYVER}.1.gz \
  --slave /usr/share/man/man1/irb.1.gz irb.1.gz /usr/share/man/man1/irb${RUBYVER}.1.gz \
  --slave /usr/share/man/man1/rdoc.1.gz rdoc.1.gz /usr/share/man/man1/rdoc${RUBYVER}.1.gz \
  --slave /usr/share/man/man1/ri.1.gz ri.1.gz /usr/share/man/man1/ri${RUBYVER}.1.gz
INSTALL
    not_if "test -L /usr/bin/ruby"
  end

  gem_package "bundler"
end
