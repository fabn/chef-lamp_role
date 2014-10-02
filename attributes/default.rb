
# Default apache modules tuned according to my needs
default[:apache][:default_modules] = %w(
  status alias auth_basic authn_file autoindex expires dir env mime negotiation setenvif rewrite php5
)

# Prefork Attributes, tune them according node memory
default[:apache][:prefork][:startservers]        = 8
default[:apache][:prefork][:minspareservers]     = 8
default[:apache][:prefork][:maxspareservers]     = 16
default[:apache][:prefork][:serverlimit]         = 200
default[:apache][:prefork][:maxclients]          = 200
default[:apache][:prefork][:maxrequestsperchild] = 10_000

#<> Whether to override apache2 default site with a deny all configuration
default[:apache][:override_default_site] = true

#<> Name of a package which provides www-browser in Ubuntu
default[:lamp][:www_browser] = 'w3m'

#<> Default php modules installed by `php_modules` recipe
default[:lamp][:php_modules] = %w(mysql gd apc curl)

#<> APC memory size
default[:lamp][:apc][:memory] = '128M'
#<> APC slam defense suppression
default[:lamp][:apc][:slam_defense] = false

