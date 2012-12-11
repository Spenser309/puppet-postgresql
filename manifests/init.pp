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
   $version       = 'na',               # Redmine version: >1.4 <2.0
   $db_adapter    = 'postgresql',       # DB adapter: postgresql
   $db_host       = 'localhost',        # DB host: string
   $db_name       = 'redmine',          # DB name: string
   $db_user       = 'redmine',          # DB user: string
   $db_password   = 'na',               # DB password: string
   $email         = 'async_smtp',       # email type: async_smtp,smtp
   $smtp_server   = 'na',               # Server for smtp: url
   $smtp_domain   = 'na',               # Domain from which to send email: url
   $smtp_auth     = 'none',             # Auth protocol for smtp: none,plain,login
   $smtp_tls      = false,              # use tls for smtp: bool
   $smtp_user     = 'na',               # user for smtp: string
   $smtp_password = 'na',               # password for smtp: string
   $scm           = ['git','svn','hg'], # What scms to use: git,svn,hg
   $scm_access    = ['www'],            # How to access scm repos: www
   $www           = 'apache',           # Webserver to use: apache
   $www_cgi       = 'passenger'         # CGI for ruby to use: passenger
) {
   include redmine::params
   
   include redmine::db
   include redmine::email
   include redmine::www
   
   if $osfamily == 'debian' and $version == 'na' {
	   package {"redmine":
	      ensure       => present,
	      responsefile => template("redmine/redmine.debconf.erb"),
	   }
   } else {
      if $version == 'na' {
         fail("ERROR: A Version Must be specified")
      }
      package {
         'mysql-devel':
            ensure => present;
         'postgresql-devel':
            ensure => present;
         'ImageMagick-devel':
            ensure => present;
         'wget':
            ensure => present;
         'bundler':
            ensure   => present,
            provider => gem;
      }

      # Install Script
      file { "/usr/local/sbin/redmine-install.sh":
        content => template("redmine/redmine-install.sh.erb"),
        owner => root,
        group => root,
        mode  => 0777,
      }

      file {
         "/etc/redmine":
            ensure => directory,
            owner  => apache,
            group  => apache,
            require => Package['httpd'],
            before => [ File["/etc/redmine/database.yml"],
                        File["/etc/redmine/configuration.yml"],
                        File["/etc/redmine/scm.yml"]];
         "/etc/redmine/scm.yml":
            owner  => apache,
            group  => apache,
            mode   => 600,
            content => template("redmine/scm.yml.erb");
      }
      
      $download_loc = "http://files.rubyforge.vm.bytemark.co.uk/redmine/redmine-${version}.tar.gz"
      
      exec { "/usr/local/sbin/redmine-install.sh":
         cwd         => "/usr/local/share/",
         #refreshonly => true,
         environment => ["DOWNLOAD_LOCATION=$download_loc", "VERSION=$version"],
         subscribe   => File["/usr/local/sbin/redmine-install.sh"],
         require     => [Package['wget'],        Package['bundler'], 
                         Package['mysql-devel'], Package['postgresql-devel'], Package['ImageMagick-devel'],
                         File['/etc/redmine/database.yml'], File['/etc/redmine/configuration.yml'], Postgresql::Db["${db_name}"] ],
         creates     => "/usr/local/share/redmine-$version",
         logoutput   => true,
         user        => root,
         group       => root,
      }
   }
}






