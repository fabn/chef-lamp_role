name             'lamp_role'
maintainer       'Fabio Napoleoni'
maintainer_email 'f.napoleoni@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures lamp_role'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

# This version supports only apache >= 2.4
supports 'ubuntu', '>= 13.10'

depends 'mysql_role', '~> 0.1'
depends 'apache2', '>= 2.0.0'
depends 'php'
# Optional dependencies of php_application definition
depends 'ssl'
