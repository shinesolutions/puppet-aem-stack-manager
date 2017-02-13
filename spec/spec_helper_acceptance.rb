require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['RS_PROVISION'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet_agent_on(host, { :puppet_agent_version => '1.8.3', })
      on host, "yum -y install epel-release"
      on host, "yum -y install python2-pip rsync"
      on host, "pip install --upgrade awscli"
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|
      apply_manifest('package { [ "tree", "rsync" ]: ensure => present }')
      on host, 'install -o root -g root -m 0700 -d ~/.aws'
      rsync_to host, File.join(proj_root, 'aws_credentials'), '~/.aws/credentials'
      install_dev_puppet_module_on(host, source: proj_root, module_name: 'aem_stack_manager')
      on host, puppet('module', 'install', 'puppetlabs-java'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'puppet-archive'), acceptable_exit_codes: [0, 1]
      apply_manifest('class { "java": distribution => "jre" }')
    end
  end
end
