# @summary
#   Install and configure the Shine Solution Stack Manager for Adobe Experience Manager
#
# @param service_name
#   The name of the service when it is installed. Defaults to
#   `aem-stack-manager` and several other variables are based on it. You probably
#   shouldn't change this.
#
# @param basedir
#   Path to the base directory for installation. Defaults to
#   '/opt/shinesolutions' and several other paths are based on it.
#
# @param installdir
#   Path to the directory for installation. The JAR file and configuration
#   files are installed here. Defaults to <basedir>/<service_name>.
#
# @param homedir
#   Path to the home directory for the user the service runs as. Only used if
#   <manage_homedir> is true.
#
# @param user
#   The user the service runs as. Defaults to <service_name>.
#
# @param group
#   The primary group for user the service runs as. Defaults to <service_name>.
#
# @param jarfile_source
#   Source URL for the AEM Stack Manager JAR file.
#
# @param jarfile_checksum_value
#   Checksum of the AEM Stack Manager JAR file. If not specified and an HTTP URL
#   is used, Puppet will treat the `File` resource as updated on every run.
#
# @param jarfile_checksum_type
#   The checksum algorithm used to produce `jarfile_checksum_value`.
#
# @param jarfile_mode
#   File mode for the JAR file.
#
# @param manage_basedir
#   Whether or not to manage <basedir> as a resource in Puppet.
#
# @param manage_installdir
#   Whether or not to manage <installdir> as a resource in Puppet.
#
# @param manage_homedir
#   Whether or not to manage <homedir> as a resource in Puppet.
#
# @param manage_user
#   Whether or not to manage <user> as a resource in Puppet.
#
# @param manage_group
#   Whether or not to manage <group> as a resource in Puppet.
#
# @param aws_profile
#   If specified, sets the `AWS_PROFILE` variable in the service's environment.
#
# @example Declaring the class
#   include aem_stack_manager
#
# @author James Sinclair <james.sinclair@shinesolutions.com>
#
# Copyright © 2017 Shine Solutions Group, unless otherwise noted.
#
class aem_stack_manager (
  String $service_name,
  String $basedir,
  String $installdir,
  String $homedir,
  String $user,
  String $group,

  String $jarfile_source,
  String $jarfile_checksum_value,
  String $jarfile_checksum_type = 'sha256',
  String $jarfile_mode          = '0500',

  Boolean $manage_basedir    = true,
  Boolean $manage_installdir = false,
  Boolean $manage_homedir    = true,
  Boolean $manage_user       = true,
  Boolean $manage_group      = true,

  Variant[String, Undef] $aws_profile = undef,
){
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
  $servicefile = "/etc/systemd/system/${service_name}.service"
  archive { $jarfile:
    ensure        => present,
    source        => $jarfile_source,
    checksum_type => $jarfile_checksum_type,
    checksum      => $jarfile_checksum_value,
    require       => $file_requires;
  } ->
  file { $jarfile:
    owner => $user,
    group => $group,
    mode  => $jarfile_mode,
  }

  if $facts['os']['family'] == 'redhat' {
    file { $servicefile:
      ensure  => file,
      content => template('aem_stack_manager/service.conf.erb'),
      require => File[$jarfile],
    }
  }

  class { '::aem_stack_manager::application_properties':
    path    => "${installdir}/application.properties",
    owner   => $user,
    group   => $group,
    notify  => Service[$service_name],
    require => File[$servicefile],
  }

  service { $service_name:
    ensure => running,
    enable => true,
  }
}
