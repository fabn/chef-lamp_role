require 'spec_helper'

describe 'lamp_role::apache2' do

  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  describe 'Server status handler' do

    it 'should install a textual browser' do
      expect(chef_run).to install_package('w3m')
    end

  end

  describe 'Default site configuration' do

    it 'should install custom template for default site' do
      expect(chef_run).to render_file('/etc/apache2/sites-available/default').with_content('ServerSignature Off')
    end

    it 'should reload apache after template installation' do
      resource = chef_run.template('/etc/apache2/sites-available/default')
      expect(resource).to notify('service[apache2]').to(:restart)
    end

  end

end