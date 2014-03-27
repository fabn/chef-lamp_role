require 'spec_helper'

describe 'lamp_role::apache2' do

  subject do
    ChefSpec::Runner.new do |node|
      node.set[:mysql][:server_root_password] = 'rootpass'
      node.set[:mysql][:server_debian_password] = 'debpass'
      node.set[:mysql][:server_repl_password] = 'replpass'
    end.converge(described_recipe)
  end

  before do
    stub_command("\"/usr/bin/mysql\" -u root -e 'show databases;'").and_return('')
  end

  describe 'Server status handler' do

    it 'should install a textual browser' do
      expect(subject).to install_package('w3m')
    end

  end

end