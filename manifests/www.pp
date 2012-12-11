class redmine::www {
   $version = $redmine::version
   # Git support 
   package { 'git-all':
     ensure => present,
   }
   
   file {'/var/lib/git':
     ensure => directory,
     owner => apache,
     group => apache,
     mode  => 1775,
     require => Package['httpd'],
   }
   
   # SVN Support
   package {'subversion':
         ensure => present;
      'mod_dav_svn':
         ensure => present;
   }
   
   apache::mod{'dav_svn':}
   
   # Redmine install
   
   include apache
   include apache::mod::passenger
   include apache::mod::perl
   
   package {
      'perl-Class-DBI-Pg':
         ensure => present;
      'perl-Digest-SHA':
         ensure => present;
   }
   if $db_adapter == 'postgresql' {
     $db_dbd_adapter = 'Pg'
   } else {
     fail("ERROR: Unknown Database type")
   }
   apache::vhost {'redmine':
      ensure     => present,
      priority   => '15',
      vhost_name => 'redmine',
      template   => 'redmine/apache2-passenger.conf.erb',
      port       => '80',
      docroot    => '/usr/local/share/redmine',
      require    => [ Exec["/usr/local/sbin/redmine-install.sh"], Package['perl-Class-DBI-Pg'], Package['perl-Digest-SHA'] ],
   }
}