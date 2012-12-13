# class redmine::email
# Sets up the redmine email configuration.

class redmine::email {
   $email         = $redmine::email
   $smtp_server   = $redmine::smtp_server
   $smtp_domain   = $redmine::smtp_domain
   $smtp_auth     = $redmine::smtp_auth
   $smtp_tls      = $redmine::smtp_tls
   $smtp_user     = $redmine::smtp_user
   $smtp_password = $redmine::smtp_password
   
   case $email {
     'async_smtp': {
        if $smtp_server == 'na' {
           fail('ERROR: Must set smtp_server address')
        }

        if $smtp_auth != 'none' {
           fail('ERROR: Unknown Setting for smtp_auth')
        }

        if $smtp_auth == 'login' or $smtp_auth == 'plain' {
           if $smtp_domain == 'na' {
              fail('ERROR: Must set smtp_domain')
           }
           if $smtp_user == 'na' {
              fail("ERROR: Please set smtp_user for secure smtp")
           }
           if $smtp_password == 'na' {
              fail("ERROR: Please set smtp_password for secure smtp")
           }
           fail("ERROR: smtp_auth not yet supported")
        }
        
     }
     'none': {
       # skip to next section.
     }
     default: {
       fail("ERROR: Unknown email type.  Please use async_smtp or none")
     }
   }
   
   file {"/etc/redmine/configuration.yml":
      content => template("redmine/configuration-email.yml.erb"),
      owner   => apache,
      group   => apache,
      mode    => 600, # not readable by anyone except redmine user. (May Contain passwords)
   }
   
#   cron{'redmine-email':
#      command => "rake -f ${redmine::params::install_loc}/Rakefile \
#                  redmine:email:receive_imap RAILS_ENV=production \
#                  host=${redmine::params::email_server} username=redmine@somenet.foo password=xxx"
#   }
}