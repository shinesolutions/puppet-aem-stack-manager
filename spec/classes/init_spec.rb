require 'spec_helper'
describe 'aem_stack_manager' do
  context 'with defaults for all parameters' do
    it { is_expected.to contain_class('aem_stack_manager') }
    it { is_expected.to contain_class('aem_stack_manager::config') }
    it { is_expected.to contain_file('/opt/shinesolutions') }
    it { is_expected.to contain_file('/opt/shinesolutions/aem-stack-manager/aem-stack-manager.jar') }
    it { is_expected.to contain_file('/etc/systemd/system/aem-stack-manager.service') }
    it { is_expected.to contain_file('/opt/shinesolutions/aem-stack-manager/application.properties') }
    it { is_expected.to contain_user('aem-stack-manager') }
    it { is_expected.to contain_group('aem-stack-manager') }
    it { is_expected.to contain_service('aem-stack-manager') }
  end
end
