# == Class: aem_stack_manager::application_properties
#
# Write the `application.properties` file.
#
# === Parameters
#
# [*path*]
#   The path to the application.properties file on disk. Required.
#
# [*owner*]
#   The user that should own the application.properties file. This user is *not*
#   created by this module and should be managed elsewhere. Required.
#
# [*group*]
#   The group that should own the application.properties file. This group is
#   *not* created by this module and should be managed elsewhere. Required.
#
# [*mode*]
#   The mode of the application.properties file. Passed to the `file` resource.
#
# [*aws_client_connection_timeout*]
#   Java property `aws.client.connection.timeout`
#
# [*aws_client_max_error_retry*]
#   Java property `aws.client.max.errorRetry`
#
# [*aws_client_protocol*]
#   Java property `aws.client.protocol`
#
# [*aws_client_proxy_host*]
#   Java property `aws.client.proxy.host`
#
# [*aws_client_proxy_port*]
#   Java property `aws.client.proxy.port`
#
# [*aws_client_use_proxy*]
#   Java property `aws.client.useProxy`
#
# [*aws_region*]
#   Java property `aws.region`
#
# [*aws_sqs_queue_name*]
#   Java property `aws.sqs.queueName`
#
# [*command_deploy_artifact*]
#   Java property `command.deployArtifact`
#
# [*command_deploy_artifacts*]
#   Java property `command.deployArtifacts`
#
# [*command_promote_author*]
#   Java property `command.promoteAuthor`
#
# [*command_shell*]
#   Java property `command.shell`
#
# [*command_timeout*]
#   Java property `command.timeout`
#
# [*server_port*]
#   Java property `server.port`
#
# === Examples
#
#  This is an internal class that isn't normally used. You can change values
#  for it's parameters using Hiera.
#
# === Authors
#
# This is an auto-generated class.
#
# === Copyright
#
# Copyright © 2017 Shine Solutions Group, unless otherwise noted.
#
class aem_stack_manager::application_properties (
  $path,
  $owner,
  $group,
  $mode,

  $aws_client_connection_timeout = undef,
  $aws_client_max_error_retry = undef,
  $aws_client_protocol = undef,
  $aws_client_proxy_host = undef,
  $aws_client_proxy_port = undef,
  $aws_client_use_proxy = undef,
  $aws_region = undef,
  $aws_sqs_queue_name = undef,
  $command_deploy_artifact = undef,
  $command_deploy_artifacts = undef,
  $command_promote_author = undef,
  $command_shell = undef,
  $command_timeout = undef,
  $server_port = undef,

) {
  file { $path:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('aem_stack_manager/application_properties.erb'),
  }
}
