[![Build Status](https://img.shields.io/travis/shinesolutions/puppet-aem-stack-manager.svg)](http://travis-ci.org/shinesolutions/puppet-aem-stack-manager)

Puppet AEM Stack Manager
-----------------------

A Puppet module for provisioning [AEM Stack Manager](https://github.com/shinesolutions/aem-stack-manager).

Install
-------

    puppet module install shinesolutions-aem_stack_manager

Or via a Puppetfile:

    mod 'shinesolutions/aem_stack_manager'

If you want to use the master version:

    mod 'shinesolutions/aem_stack_manager', :git => 'https://github.com/shinesolutions/puppet-aem-stack-manager'

Configuration
-------------

TODO

Usage
-----

Just include the module:

```puppet
  include aem_stack_manager
```

Parameters can be set in YAML. See the defaults in `data/common.yaml` for
examples.

If you want to us an `S3` URL ( s3://_bucket_/_path_ ) you'll need to have the
AWS CLI installed and configured so `root` can run the command below without
error. This means you'll need to ensure AWS default credentials are configured
correctly. Information on how to set them up is detailed in [the AWS CLI
docs.](http://docs.aws.amazon.com/cli/latest/topic/config-vars.html)

```shell
aws s3 cp <url> /tmp/jar.tmp
```
