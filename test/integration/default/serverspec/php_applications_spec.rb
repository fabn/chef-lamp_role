require 'spec_helper'

describe 'Dummy applications' do

  describe 'php.example.com' do

    describe file('/var/www/php.example.com') do

      it { should be_directory }
      it { should be_mode 2770 }
      it { should be_owned_by 'www-data' }
      it { should be_grouped_into 'www-data' }

    end

    describe user('vagrant') do
      it 'should be added to group by definition' do
        should belong_to_group 'www-data'
      end
    end

    # Virtual host is enabled
    describe file('/etc/apache2/sites-enabled/php.example.com.conf') do
      it { should be_linked_to '../sites-available/php.example.com.conf' }
    end

    # Virtual host configuration
    describe file('/etc/apache2/sites-available/php.example.com.conf') do
      it { should be_file }
      its(:content) { should match %r{DocumentRoot /var/www/php.example.com} }
      its(:content) { should match %r{ServerAlias php2.example.com} }
    end

    # Get the home page which is a php site
    describe command(%q{curl -s -H 'Host: php.example.com' localhost}) do
      it { should return_stdout 'Hello world' }
    end

    describe command(%q{curl -s -H 'Host: php2.example.com' localhost}) do
      it 'should redirect to the canonical hostname' do
        should return_stdout %r{The document has moved <a href="http://php.example.com/">here</a>}
      end
    end

  end

  describe 'mysql.example.com' do

    # Test ssl redirection
    describe command(%q{curl -s -H 'Host: mysql.example.com' localhost}) do
      it 'should be able to connect to the database' do
        pending 'TODO Generate fake ssl certificate and change _integration recipe'
        should return_stdout %r{The document has moved <a href="https://mysql.example.com/">here</a>}
      end
    end

    # Get the home page which connects to mysql
    describe command(%q{curl -s -H 'Host: mysql.example.com' localhost}) do
      it 'should be able to connect to the database' do
        should return_stdout /Connected successfully/
      end
    end

  end

  describe 'zend.example.com' do

    # Test that site site is working
    describe command(%q{curl -s -H 'Host: zend.example.com' localhost}) do
      it 'should return site content' do
        should return_stdout /Zend/
      end
    end

    # Virtual host configuration
    describe file('/etc/apache2/sites-available/zend.example.com.conf') do
      it { should be_file }
      its(:content) { should match %r{DocumentRoot /var/www/zend.example.com/current/public} }
      its(:content) { should match %r{SetEnv APPLICATION_ENV production} }
    end

  end

  describe 'config.example.com' do

    # Test that directives have effect
    describe command(%q{curl -s -H 'Host: config.example.com' localhost}) do

      it { should return_stdout %r{<td class="e">memory_limit</td><td class="v">10M</td>} }
      it { should return_stdout %r{<td class="e">session.name</td><td class="v">Custom</td>} }
      it { should return_stdout %r{<td class="e">display_errors</td><td class="v">Off</td>} }
      it { should return_stdout %r{<td class="e">file_uploads</td><td class="v">Off</td>} }

    end

    # Virtual host configuration
    describe file('/etc/apache2/sites-available/config.example.com.conf') do

      %w(php_value php_admin_value php_flag php_admin_flag).each do |php_directive|
        it { should contain php_directive }
      end
    end

  end

end
