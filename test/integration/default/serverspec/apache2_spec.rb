require 'spec_helper'

describe 'Apache Installation' do

  describe service('apache2') do
    it { should be_running }
    it { should be_enabled }
  end

  describe 'Apache modules' do

    describe command('apache2 -M') do

      # list required modules, list is from attribute file
      %w[status alias auth_basic authn_file autoindex expires dir env mime negotiation setenvif rewrite php5].each do |mod|
        it "should have installed apache2 #{mod} module" do
          should return_stdout /#{mod}/
        end
      end

    end

  end

  describe 'Server Status' do

    describe package('w3m') do
      it { should be_installed }
    end

    describe command('apache2ctl status') do
      it { should return_exit_status(0) }
      it { should return_stdout /Apache Server Status for localhost/ }
    end

    # Access status location from any other hostname than localhost, so it should not get status variables
    describe command('APACHE_STATUSURL=http://10.0.2.15/server-status apache2ctl status') do
      it { should return_stdout /Forbidden/ }
    end

  end

  describe 'Default site' do

    describe command('apache2ctl -S') do
      # Default site should be active
      it { should return_stdout %r{default server .* \(/etc/apache2/sites-enabled/000-default:\d+\)} }
    end

    describe command('curl http://localhost/') do
      it { should return_stdout /404 Not Found/ }
    end

  end

end
