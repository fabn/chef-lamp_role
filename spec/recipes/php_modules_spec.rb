require 'spec_helper'

describe 'lamp_role::php_modules' do

  let(:chef_run) do
    ChefSpec::Runner.new(log_level: :fatal) do |node|
      # Change default values in attributes
      node.set[:lamp][:apc][:memory] = '256M'
      node.set[:lamp][:apc][:slam_defense] = true
    end.converge(described_recipe)
  end

  describe 'APC module configuration' do

    it 'should install apc configuration file' do
      expect(chef_run).to render_file('/etc/php5/mods-available/apc.ini').with_content('apcu.so')
      expect(chef_run).to render_file('/etc/php5/mods-available/apc.ini').with_content('256M')
      expect(chef_run).to render_file('/etc/php5/mods-available/apc.ini').with_content('apc.slam_defense = on')
    end

  end

end