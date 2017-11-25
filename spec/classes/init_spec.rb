require 'spec_helper'
describe 'upg' do
  context 'with default values for all parameters' do
    it { should contain_class('upg') }
  end
end
