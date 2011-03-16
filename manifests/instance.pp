# Definition: redmine::instance
#
# This is the mydefinition in the mymodule module.
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
   $admin_passwd = "admin",
   # Webserver Settings
   $webserver    = "apache",    # Currently the only valid selection
   $cgi          = "passenger", # Currently the only valid selection
   $auth         = "unixgroup", # Currently the only valid selection
   $priority     = 15,         
   $domain       = $name,        
   $ssl          = false,       
   # Database Settings
   $db           = "mysql",
   $db_host      = false,
   $db_user      = $name,
   $db_passwd    = $name,
   # Outgoing Email Configuration
   $smtp         = false,
   $smtp_host    = "localhost",
   $smtp_tls     = false,
   $smtp_user    = "redmine@$domain",
   $smtp_passwd  = false,
   # Incoming Email Configuration
   $email        = false,
   $email_addr   = "redmine@$domain",
   # Backup Settings
   $backup_style = false,
   # More to come.
   # Monitoring Settings
   $noc          = false,
   $noc_serve    = false
   # More to come. ) 
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
