# params.pp
#
# Parameters for installing redmine
#
class redmine::params {
#   $version       = 'na',               # Redmine version: >1.4 <2.0
#   $db_adapter    = 'postgresql',       # DB adapter: postgresql
#   $db_host       = 'localhost',        # DB host: string
#   $db_name       = 'redmine',          # DB name: string
#   $db_user       = 'redmine',          # DB user: string
#   $db_password   = 'na',               # DB password: string
#   $email         = 'async_smtp',       # email type: async_smtp,smtp
#   $smtp_server   = 'na',               # Server for smtp: url
#   $smtp_domain   = 'na',               # Domain from which to send email: url
#   $smtp_tls      = false,              # use tls for smtp: bool
#   $smtp_auth     = 'none',             # Auth protocol for smtp: none,plain,login
#   $smtp_user     = 'na',               # user for smtp: string
#   $smtp_password = 'na',               # password for smtp: string
#   $scm           = ['git','svn','hg'], # What scms to use: git,svn,hg
#   $scm_access    = ['www'],            # How to access scm repos: www
#   $www           = 'apache',           # Webserver to use: apache
#   $www_cgi       = 'passenger'         # CGI for ruby to use: passenger
   
   # Validate the redmine params
   validate_re($version,'1.4.(.*)')
   validate_re($db_adapter,'postgresql')
   if $db_adapter in ['postgresql'] {
      validate_string($db_host)
      validate_string($db_name)
      validate_string($db_user)
      validate_string($db_password)
   }
   validate_re($email,['async_smtp','smtp'])
   validate_string($smtp_server)
   validate_string($smtp_domain)
   validate_bool($smtp_tls)
   validate_re($smtp_auth,['none','plain','login'])
   if $smtp_auth in ['plain','login'] {
      validate_string($smtp_user)
      validate_string($smtp_password)
   }
   validate_array($scm)
   validate_array($scm_access)
   validate_re($www,"apache")
   validate_re($www_cgi,"passenger")
   
   # Location to install redmine.
   $install_loc = '/opt/'
   $www_root    = '/var/www/html'
   
   # Location to download redmine from.
   $download_loc = "http://files.rubyforge.vm.bytemark.co.uk/redmine/redmine-${version}.tar.gz"
   
   # Required packages.
   $prereqs = ['bundler', 'wget']
   
   if 'svn' in $scm {
      $prereqs += ['subversion']
   }

   $prereqs += ['mysql-devel','postgresql-devel','ImageMagick-devel']
   
   if 'git' in $scm {
      $prereqs += 'git-all'
   }
   if $osfamily == redhat {

   } elsif $osfamily == debian {
   
   }
}
