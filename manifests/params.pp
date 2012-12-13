# params.pp
#
# Parameters for installing redmine
#
class redmine::params {
#   $debug         = false,              # Debugging is enabled: bool
#   $version       = 'na',               # Redmine version: >1.4 <2.0
#   $db            = {
#                      $adapter    => 'postgresql',       # DB adapter: postgresql
#                      $host       => 'localhost',        # DB host: string
#                      $name       => 'redmine',          # DB name: string
#                      $user       => 'redmine',          # DB user: string
#                      $password   => 'na',               # DB password: string
#                    },
#   $www           = {
#                       server => 'apache',               # Webserver to use: apache
#                       cgi    => 'passenger',            # CGI for ruby to use: passenger,
#                    },
#   $scm           = {
#                       adapters => ['git','svn','hg'],   # What scms to use: git,svn,hg
#                       access   => ['www','ssh'],
#                    },
#   $email_send    = {
#                       $adapter  => 'async_smtp',        # email type: async_smtp,smtp
#                       $server   => 'na',                # Server for smtp: url
#                       $domain   => 'na',                # Domain from which to send email: url
#                       $tls      => false,               # use tls for smtp: bool
#                       $auth     => 'none',              # Auth protocol for smtp: none,plain,login
#                       $user     => 'na',                # user for smtp: string
#                       $password => 'na',                # password for smtp: string
#                    },
#   $email_recv    = {  
#                       $adapter  => 'imap_cron',         # email provider: imap_cron, pop_cron, rdm
#                       $server   => 'imap.example.com',  # email server: url 
#                       $user     => 'redmine',           # email user: string
#                       $password => 'redmine',           # email password: string
#                    }

#   # Validate the redmine params
#   validate_re($version,'1.4.(.*)')
#   validate_re($db_adapter,'postgresql')
#   if $db_adapter in ['postgresql','mysql'] {
#      validate_string($db_host)
#      validate_string($db_name)
#      validate_string($db_user)
#      validate_string($db_password)
#   }
#   validate_re($email,'^(async_smtp|smtp)$')
#   validate_string($smtp_server)
#   validate_string($smtp_domain)
#   validate_bool($smtp_tls)
#   validate_re($smtp_auth,'^(none|plain|login)$')
#   if $smtp_auth in ['plain','login'] {
#      validate_string($smtp_user)
#      validate_string($smtp_password)
#   }
#   validate_array($scm)
#   validate_array($scm_access)
#   validate_re($www,"apache")
#   validate_re($www_cgi,"passenger")
   
   # Location to install redmine.
   $install_loc = '/opt/'
   $www_root    = '/var/www/html'
   
   # Location to download redmine from.
   $download_loc = "http://files.rubyforge.vm.bytemark.co.uk/redmine/redmine-${version}.tar.gz"
   
   $user = 'apache'
   $group = 'apache'
   
   # OS Specific stuff.
   if $osfamily == redhat {

   } elsif $osfamily == debian {
   
   }
}
