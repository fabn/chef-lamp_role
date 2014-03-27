require 'spec_helper'

describe 'Apache Installation' do

  describe service('apache2') do
    it { should be_running }
    it { should be_enabled }
  end

  describe 'Apache modules' do

    describe command('apache2 -M') do

      # list required modules, list is from attribute file
      %w[status alias auth_basic authn_file autoindex dir env mime negotiation setenvif rewrite php5].each do |mod|
        it "should have installed apache2 #{mod} module" do
          should return_stdout /#{mod}/
        end
      end

    end

  end

end
