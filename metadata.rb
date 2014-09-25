name             'lamp_role'
maintainer       'Fabio Napoleoni'
maintainer_email 'f.napoleoni@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures lamp_role'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'

depends 'mysql_role'
depends 'apache2', '~> 1.9.6'
depends 'php'
# Optional dependencies of php_application definition
depends 'ssl'
