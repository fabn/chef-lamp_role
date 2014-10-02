RSpec.describe 'lamp_role::default' do

  subject do
    ChefSpec::Runner.new(log_level: :fatal) do |node|
      node.set[:mysql][:server_root_password] = 'rootpass'
      node.set[:mysql][:server_debian_password] = 'debpass'
      node.set[:mysql][:server_repl_password] = 'replpass'
    end.converge(described_recipe)
  end

  before do
    stub_command("\"/usr/bin/mysql\" -u root -e 'show databases;'").and_return('')
    stub_command('/usr/sbin/apache2 -t').and_return('')
  end

  %w(mysql_role::default lamp_role::apache2 lamp_role::php lamp_role::php_modules).each do |recipe|

    it "should include recipe #{recipe}" do
      should include_recipe(recipe)
    end

  end

end