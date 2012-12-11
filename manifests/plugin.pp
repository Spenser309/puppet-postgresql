

define redmine::plugin ($plugin=$name, $version="", $path, $ext='tar.gz'){
  
   $redmine_loc = "/usr/local/share/redmine-${redmine::version}/"
  
   if $ext == 'tar.gz' {
      $unpack = 'tar xzf'
   } elsif $ext == 'tar.bz2' {
      $unpack = 'tar xjf'
   }
  
   Exec["${name}-download"] -> Exec["${name}-unpack"] -> Exec["${name}-migrate_plugins"]
  
   Exec {
      user  => apache,
      group => apache,
      path  => '/bin:/sbin:/usr/bin:/usr/sbin',
      logoutput => true,
      require => Exec['/usr/local/sbin/redmine-install.sh'],
   }
  
   $plugin_loc = "${path}/${plugin}${version}.${ext}"
  
   exec{ "${name}-download":
      command => "wget --no-check-certificate $plugin_loc",
      cwd     => "${redmine_loc}/vendor/plugins/",
      creates => "${redmine_loc}/vendor/plugins/${plugin}${version}.$ext",
   }
   exec{ "${name}-unpack":
      command => "$unpack ${plugin}${version}.$ext",
      cwd     => "${redmine_loc}/vendor/plugins/",
      creates => "${redmine_loc}/vendor/plugins/$plugin",
      notify  => Exec["${name}-migrate_plugins"],
   }
  
   exec{ "${name}-migrate_plugins":
      command     => 'bundle exec rake db:migrate_plugins',
      environment => 'RAILS_ENV=production',
      cwd         => "${redmine_loc}",
      refreshonly => true,
      notify      => Service['httpd'],
   }
}