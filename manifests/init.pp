# == Class: aem_stack_manager
#
# Install and configure the Shine Solution Stack Manager for Adobe Experience Manager
#
# === Parameters
#
# [*service_name*]
#   The name of the service when it is installed. Defaults to
#   `aem-stack-manager` and several other variables are based on it. You probably
#   shouldn't change this.
#
# [*basedir*]
#   Path to the base directory for installation. Defaults to
#   '/opt/shinesolutions' and several other paths are based on it.
#
# [*installdir*]
#   Path to the directory for installation. The JAR file and configuration
#   files are installed here. Defaults to <basedir>/<service_name>.
#
# [*homedir*]
#   Path to the home directory for the user the service runs as. Only used if
#   <manage_homedir> is true.
#
# [*user*]
#   The user the service runs as. Defaults to <service_name>.
#
# [*group*]
#   The primary group for user the service runs as. Defaults to <service_name>.
#
# [*jarfile_source*]
#   Source URL for the AEM Stack Manager JAR file.
#
# [*jarfile_checksum_value*]
#   Checksum of the AEM Stack Manager JAR file. If not specified and an HTTP URL
#   is used, Puppet will treat the `File` resource as updated on every run.
#
# [*manage_basedir*]
#   Whether or not to manage <basedir> as a resource in Puppet.
#
# [*manage_installdir*]
#   Whether or not to manage <installdir> as a resource in Puppet.
#
# [*manage_homedir*]
#   Whether or not to manage <homedir> as a resource in Puppet.
#
# [*manage_user*]
#   Whether or not to manage <user> as a resource in Puppet.
#
# [*manage_group*]
#   Whether or not to manage <group> as a resource in Puppet.
#
# [*jarfile_checksum*]
#   Checksum type used for `jarfile_checksum_value`.
#
# [*aws_profile*]
#   If specified, sets the `AWS_PROFILE` variable in the service's environment.
#
# === Examples
#
#  include aem_stack_manager
#
# === Authors
#
# James Sinclair <james.sinclair@shinesolutions.com>
#
# === Copyright
#
# Copyright © 2017	Shine Solutions Group, unless otherwise noted.
#
class aem_stack_manager (
  $service_name,
  $basedir,
  $installdir,
  $homedir,
  $user,
  $group,
  $jarfile_source,
  $jarfile_checksum_value,

  $manage_basedir    = true,
  $manage_installdir = false,
  $manage_homedir    = true,
  $manage_user       = true,
  $manage_group      = true,
  $jarfile_checksum  = 'sha256',

  $aws_profile = undef,
){
  include ::aem_stack_manager::config

  if $manage_basedir {
    file { $basedir:
      ensure => directory,
    }
    $basedir_require = File[$basedir]
  } else {
    $basedir_require = undef
  }
  if $manage_user {
    group { $group:
      ensure => present,
      system => true,
    }
    user { $user:
      ensure     => present,
      home       => $homedir,
      managehome => $manage_homedir,
      system     => true,
      shell      => '/usr/sbin/nologin',
      gid        => $group,
      expiry     => absent,
    }
  }
  if $manage_installdir {
    file { [ $installdir ]:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      require => [ $basedir_require, User[$user] ],
    }
    $file_requires = [ File[$installdir], User[$user] ]
  } else {
    $file_requires = [ User[$user] ]
  }

  $jarfile = "${installdir}/aem-stack-manager.jar"
  file {
    $jarfile:
      ensure         => file,
      owner          => $user,
      group          => $group,
      mode           => '0500',
      source         => $jarfile_source,
      checksum       => $jarfile_checksum,
      checksum_value => $jarfile_checksum_value,
      require        => $file_requires;
    "${installdir}/application.properties":
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0400',
      content => template('aem_stack_manager/application.properties.erb'),
      require => $file_requires;
  }

  service { $service_name:
    ensure => running,
    enable => true,
  }

  if $facts['os']['family'] == 'redhat' {
    file { "/etc/systemd/system/${service_name}.service":
      ensure  => file,
      content => template('aem_stack_manager/service.conf.erb'),
      notify  => Service[$service_name],
    }
  }
}
