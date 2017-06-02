# @summary
#   Write the `application.properties` file.
#
#  This class writes the `application.properties` file for the AEM Stack
#  Manager.  It is auto-generated and should not be modified by hand.
#  Documentation for each of the properties can be found in the example
#  `application.properties` from which it is generated. (see below)
#
#  _Note:_ This is an internal class that shouldn't be used directly. It is
#  included by the `aem_stack_manager` class. You can change values for it's
#  parameters using Hiera.
#
# @see https://github.com/shinesolutions/aem-stack-manager/blob/master/src/main/resources/application.properties
#   The example `application.properties` file.
#
# @param path
#   The path to the application.properties file on disk. Required.
#
# @param owner
#   The user that should own the application.properties file. This user is *not*
#   created by this module and should be managed elsewhere. Required.
#
# @param group
#   The group that should own the application.properties file. This group is
#   *not* created by this module and should be managed elsewhere. Required.
#
# @param mode
#   The mode of the application.properties file. Passed to the `file` resource.
#
# @param aem_stop_sleep_seconds
#   Java property `aemStop.sleepSeconds`
#
# @param aws_client_connection_timeout
#   Java property `aws.client.connection.timeout`
#
# @param aws_client_max_error_retry
#   Java property `aws.client.max.errorRetry`
#
# @param aws_client_protocol
#   Java property `aws.client.protocol`
#
# @param aws_client_proxy_host
#   Java property `aws.client.proxy.host`
#
# @param aws_client_proxy_port
#   Java property `aws.client.proxy.port`
#
# @param aws_client_use_proxy
#   Java property `aws.client.useProxy`
#
# @param aws_region
#   Java property `aws.region`
#
# @param aws_sqs_queue_name
#   Java property `aws.sqs.queueName`
#
# @param command_check_crx_quickstart_process
#   Java property `command.checkCrxQuickstartProcess`
#
# @param command_check_oak_run_process
#   Java property `command.checkOakRunProcess`
#
# @param command_check_snapshot_process
#   Java property `command.checkSnapshotProcess`
#
# @param command_deploy_artifact
#   Java property `command.deployArtifact`
#
# @param command_deploy_artifacts
#   Java property `command.deployArtifacts`
#
# @param command_ec2_metadata
#   Java property `command.ec2Metadata`
#
# @param command_enter_standby_by_component
#   Java property `command.enterStandbyByComponent`
#
# @param command_enter_standby_by_identity
#   Java property `command.enterStandbyByIdentity`
#
# @param command_exit_standby_by_component
#   Java property `command.exitStandbyByComponent`
#
# @param command_exit_standby_by_identity
#   Java property `command.exitStandbyByIdentity`
#
# @param command_export_package
#   Java property `command.exportPackage`
#
# @param command_import_package
#   Java property `command.importPackage`
#
# @param command_offline_compaction_by_identity
#   Java property `command.offlineCompactionByIdentity`
#
# @param command_offline_compaction_for_author
#   Java property `command.offlineCompactionForAuthor`
#
# @param command_offline_snapshot
#   Java property `command.offlineSnapshot`
#
# @param command_paired_instance
#   Java property `command.pairedInstance`
#
# @param command_promote_author
#   Java property `command.promoteAuthor`
#
# @param command_shell
#   Java property `command.shell`
#
# @param command_stack_components
#   Java property `command.stackComponents`
#
# @param command_start_aem
#   Java property `command.startAem`
#
# @param command_stop_aem
#   Java property `command.stopAem`
#
# @param command_timeout
#   Java property `command.timeout`
#
# @param command_wait_until_ready
#   Java property `command.waitUntilReady`
#
# @param offline_snapshot_minimum_publish_instances
#   Java property `offlineSnapshot.minimumPublishInstances`
#
# @param server_port
#   Java property `server.port`
#
#
# Copyright © 2017 Shine Solutions Group, unless otherwise noted.
#
class aem_stack_manager::application_properties (
  String $path,
  String $owner,
  String $group,
  String $mode,

  Variant[String, Undef] $aem_stop_sleep_seconds = undef,
  Variant[String, Undef] $aws_client_connection_timeout = undef,
  Variant[String, Undef] $aws_client_max_error_retry = undef,
  Variant[String, Undef] $aws_client_protocol = undef,
  Variant[String, Undef] $aws_client_proxy_host = undef,
  Variant[String, Undef] $aws_client_proxy_port = undef,
  Variant[String, Undef] $aws_client_use_proxy = undef,
  Variant[String, Undef] $aws_region = undef,
  Variant[String, Undef] $aws_sqs_queue_name = undef,
  Variant[String, Undef] $command_check_crx_quickstart_process = undef,
  Variant[String, Undef] $command_check_oak_run_process = undef,
  Variant[String, Undef] $command_check_snapshot_process = undef,
  Variant[String, Undef] $command_deploy_artifact = undef,
  Variant[String, Undef] $command_deploy_artifacts = undef,
  Variant[String, Undef] $command_ec2_metadata = undef,
  Variant[String, Undef] $command_enter_standby_by_component = undef,
  Variant[String, Undef] $command_enter_standby_by_identity = undef,
  Variant[String, Undef] $command_exit_standby_by_component = undef,
  Variant[String, Undef] $command_exit_standby_by_identity = undef,
  Variant[String, Undef] $command_export_package = undef,
  Variant[String, Undef] $command_import_package = undef,
  Variant[String, Undef] $command_offline_compaction_by_identity = undef,
  Variant[String, Undef] $command_offline_compaction_for_author = undef,
  Variant[String, Undef] $command_offline_snapshot = undef,
  Variant[String, Undef] $command_paired_instance = undef,
  Variant[String, Undef] $command_promote_author = undef,
  Variant[String, Undef] $command_shell = undef,
  Variant[String, Undef] $command_stack_components = undef,
  Variant[String, Undef] $command_start_aem = undef,
  Variant[String, Undef] $command_stop_aem = undef,
  Variant[String, Undef] $command_timeout = undef,
  Variant[String, Undef] $command_wait_until_ready = undef,
  Variant[String, Undef] $offline_snapshot_minimum_publish_instances = undef,
  Variant[String, Undef] $server_port = undef,

) {
  file { $path:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('aem_stack_manager/application_properties.erb'),
  }
}
