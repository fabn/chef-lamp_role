
# Default apache modules tuned according to my needs
default[:apache][:default_modules] = %w(
  status alias auth_basic authn_file autoindex dir env mime negotiation setenvif rewrite php5
)

# Prefork Attributes, tune them according node memory
default[:apache][:prefork][:startservers]        = 16
default[:apache][:prefork][:minspareservers]     = 16
default[:apache][:prefork][:maxspareservers]     = 32
default[:apache][:prefork][:serverlimit]         = 400
default[:apache][:prefork][:maxclients]          = 400
default[:apache][:prefork][:maxrequestsperchild] = 10_000

# Default php modules
default[:lamp][:php_modules] = %w(mysql gd apc curl)
