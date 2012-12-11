# Definition: redmine::instance
#
# This definition creates a redmine instance.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define redmine::instance(
   # Redmine Settings
   $lang         = "en",        # Select from a ton.
   $admin_passwd = "admin",     # Initial Admin Password
   # Webserver Settings
   $webserver    = "apache",    # Currently the only valid selection
   $cgi          = "passenger", # Currently the only valid selection
   $repo_auth    = "redmine",   # Currently the only valid selection
   $priority     = 15,          # Required if running multiple vhosts
   $host         = "$name.$domainname",       # Web address where the vhost should be accessible
   $suburi        = "/redmine", # Suburi for accessing redmine
   $ssl          = true,        # Use SSL Encryption
   # Database Settings
   $db           = "postgresql",# Database to use
   $db_host      = "localhost", # Use localhost for database
   $db_name      = $name,       # Name of DB to use.
   $db_user      = $name,       # DB User
   $db_passwd    = "na",        # No default db password allowed
   # Outgoing Email Configuration
   $smtp         = true,        # Use SMTP for sending emails
   $smtp_host    = "localhost", # Hostname of SMTP server
   $smtp_tls     = true,        # TLS enabled for smtp
   $smtp_user    = "redmine@$domain", # Username
   $smtp_passwd  = "na",
   # Incoming Email Configuration
   $email        = true,
   $email_addr   = "redmine@$domain",
   )
{
   include redmine
   

   
   if $webserver == "apache" {
      include apache
      
      if $cgi == "passenger" {
         include passenger
      } else {
         error("Unknown cgi style: $cgi - currently available styles are ['passenger']")
         fail()
      }
      
      if $auth == "unixgroup" {
         package {'libapache2-mod-authnz-external': ensure => present, before => A2mod['authnz_external'] }
         package {'libapache2-mod-authz-unixgroup': ensure => present, before => A2mod['authz_unixgroup'] }
         a2mod { "authnz_external":                 ensure => present }
         a2mod { "authz_unixgroup":                 ensure => present }
      } else {
        error("Unknown auth style: $auth - currently available styles are ['unixgroup']")
        fail() 
      }
   
      apache::vhost { "$domain":
         priority => "$priority",
         template => "redmine/$cgi-vhost.erb",
         notify   => Service["apache2"]
      }
   } else {
      error("Unknown webserver style: $webserver - currently available styles are ['apache']")
      fail()
   }
   
   if $db == "mysql" {
   
   } else {
      error("Unknown db style $db - currently available styles are ['mysql']
   } 
   
   if $smtp == "fetch" {
   
   } else {
      
   }
   
   if $email == " " {
   
   } else {
   
   }

   if $noc == " " {
   
   } else {
   
   }

}
