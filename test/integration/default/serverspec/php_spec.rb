require 'spec_helper'

describe 'PHP Installation' do

  describe command('php -v') do
    it { should return_exit_status 0 }
  end

  describe 'PHP modules' do

    describe command('php -m') do

      # list required modules
      %w(mysql gd apc curl).each do |mod|
        it "should have installed #{mod} php module" do
          should return_stdout /#{mod}/
        end
      end

    end

  end

end
