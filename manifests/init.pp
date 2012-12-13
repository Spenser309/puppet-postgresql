# Class: redmine
#
# This module manages redmine
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# Useful command for setting admin password
# RAILS_ENV=production script/runner 'user = User.find(:first, :conditions => {:admin => true}) ; user.password, user.password_confirmation = "my_password"; user.save!'

class redmine (
   $debug         = false,                              # Debugging is enabled: bool
   $version       = '1.4.5',                               # Redmine version: >1.4 <2.0
   $db            = {
                      adapter    => 'postgresql',       # DB adapter: postgresql
                      host       => 'localhost',        # DB host: string
                      name       => 'redmine',          # DB name: string
                      user       => 'redmine',          # DB user: string
                      password   => 'na'                # DB password: string
                    },
   $www           = {
                       server => 'apache',              # Webserver to use: apache
                       cgi    => 'passenger',           # CGI for ruby to use: passenger,
                    },
   $scm           = {
                       adapters => ['git','svn','hg'],  # What scms to use: git,svn,hg
                       access   => ['www','ssh'],
                    },
   $email_send    = {
                       adapter  => 'async_smtp',        # email type: async_smtp,smtp
                       server   => 'na',                # Server for smtp: url
                       domain   => 'na',                # Domain from which to send email: url
                       tls      => false,               # use tls for smtp: bool
                       auth     => 'none',              # Auth protocol for smtp: none,plain,login
                       user     => 'na',                # user for smtp: string
                       password => 'na',                # password for smtp: string
                    },
   $email_recv    = {
                       adapter  => 'imap_cron',         # email provider: imap_cron, pop_cron, rdm
                       server   => 'imap.example.com',  # email server: url 
                       user     => 'redmine',           # email user: string
                       password => 'redmine',           # email password: string
                    }
) {
   include redmine::params
   
   validate_hash($db)
   validate_hash($www)
   validate_hash($scm)
   validate_hash($email_send)
   validate_hash($email_recv)
      
   $resources = {
      'redmine::app' => {
         version  => $version,
      },
      #'redmine::db'  => $db,
      #'redmine::www' => $www,
      #'redmine::scm' => $scm, 
      #'redmine::email_send' => $email_send,
      #'redmine::email_recv' => $email_recv,
   }
   
   $defaults = {
     instance => 'default'
   }
   
   create_resources('class', $resources, $defaults)
   
}






