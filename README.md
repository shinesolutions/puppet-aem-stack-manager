[![Build Status](https://img.shields.io/travis/shinesolutions/puppet-aem-stack-manager.svg)](http://travis-ci.org/shinesolutions/puppet-aem-stack-manager)

# shinesolutions-aem_stack_manager

## Description

A Puppet module for provisioning the Shine Solutions
[AEM Stack Manager](https://github.com/shinesolutions/aem-stack-manager).

## Setup

### Setup Requirements

If you want to use an `S3` URL ( s3://_bucket_/_path_ ) for the jar file source,
you'll need to have the AWS CLI installed and configured so `root` can run the
command below without error. This means you'll need to ensure AWS default
credentials are configured correctly. Information on how to set them up is
detailed in
[the AWS CLI docs.] (http://docs.aws.amazon.com/cli/latest/topic/config-vars.html)

    aws s3 cp <url> /tmp/jar.tmp

### Beginning with shinesolutions-aem_stack_manager

Install the module using the `puppet` command:

    puppet module install shinesolutions-aem_stack_manager

Or via a Puppetfile:

    mod 'shinesolutions-aem_stack_manager'

Or uf you want to use the newest code from git:

    mod 'shinesolutions-aem_stack_manager', :git => 'https://github.com/shinesolutions/puppet-aem-stack-manager'

Then just include the module in your Puppet code:

    include aem_stack_manager

## Usage

Parameters can be set with Hiera. See the defaults in `data/common.yaml` for
examples.

Most default parameters are correct, but you will likely need to override the
following to point to the AEM Stack Manager jar file:

    aem_stack_manager::jarfile_source: (s3|http|file)://(host|bucket)/path/to/aem_stack_manager.jar
    aem_stack_manager::jarfile_checksum_value: <sha256 hash of aem_stack_manager.jar>

## Reference

The module's classes and their parameters are documented in the comments in
each manifest file. HTML documentation generated with `puppet strings` can be
found in the `docs/` folder -- which is published on [GitHub
Pages](https://shinesolutions.github.io/puppet-aem-stack-manager/) for easy
reference.
