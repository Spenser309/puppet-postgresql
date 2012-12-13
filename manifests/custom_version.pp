define redmine::custom_version(
   $instance     = 'default',
   $version      = 'default',
   $install_loc  = '/opt/oss',
   $db_adapters  = ['mysql','postgresql'],
   $patches      = {
                      'http://www.redmine.org/attachments/download/8207/Redmine.pm-1.4.4-based-on-1.4.1-multiscm-2--improved2.patch' => {
                         p => '0',
                         cwd => "/",
                       }
                   },
   $download_loc = "http://files.rubyforge.vm.bytemark.co.uk/redmine/redmine-${version}.tar.gz"
){
   # The below statements validate the above inputs
   validate_absolute_path($install_loc)
   validate_hash($patches)
   
   include patch
   include tar
   include bundler
   include rake
   
   if $version == 'default' {
      fail("ERROR: A Version Must be specified")
   } else {
      if 1 != versioncmp($version, '1.4.0') or -1 != versioncmp($version, '2.0.0') {
         fail("ERROR: Version must be greater than 1.4.0 and less than 2.0.0")
      }
   }
   
   $prereqs = ['ImageMagick-devel','postgresql-devel','mysql-devel']
   
   $excludes = ['development']
   
   $redmine_file = regsubst($download_loc,'(.*)\/(.*)$','\2')
   $redmine_archive_path  = "${install_loc}/${redmine_file}"
   $redmine_path          = "${install_loc}/redmine-${version}"
   $redmine_rakefile_path = "${redmine_path}/Rakefile"
   $redmine_config_dir    = "${redmine_path}/config"
   
   # Actual configuration.
   package {$prereqs:
      ensure => present,
   }
   file{"$install_loc":
     ensure => directory,
   }
   wget::fetch{"$download_loc":
      source      => $download_loc,
      destination => $redmine_archive_path,
      notify      => Tar::Unarchive["$redmine_archive_path"],
   } ->
   tar::unarchive{"$redmine_archive_path":
      cwd => $install_loc,
      creates => "$install_loc/redmine-$version",
   }
   notice($version)
   $defaults = {
      #user        => $redmine::params::user,
      install_loc => $install_loc,
      version     => $version,
      subscribe   => Tar::Unarchive["$redmine_archive_path"],
      before      => Bundler::Install["$install_loc/redmine-$version"],
   }

   # Use the redmine::patch wrapper to append install_loc to cwd
   create_resources(redmine::patch_apply,$patches,$defaults)
  
   bundler::install {"$redmine_path":
      excludes => join($excludes,','),
      require  => Package[$prereqs]
   } 
   file{"$redmine_path/tmp":
      ensure => link,
      target => "/tmp",
      force  => true,
      require => Tar::Unarchive["$redmine_archive_path"],
   }
   redmine::tasks{"$instance":
     rakefile => $redmine_rakefile_path,
   }
   redmine::config{"$redmine_path/config":
      path    => $redmine_config_dir,
      require => [Bundler::Install["$redmine_path"]],
   }
}

define redmine::patch_apply($patch=$name, $cwd, $p, $user='root', $install_loc, $version) {
   $real_cwd = "$install_loc/redmine-$version/$cwd"
   $patch_filename = regsubst($patch,'(.*)\/(.*)$','\2')
   $patch_file = "$real_cwd/$patch_filename"
   notice("applying $patch_filename in $real_cwd")
   notice("Patch at $patch_file")
   
   wget::fetch{"$patch":
     source => $patch,
     destination => $patch_file,
   }
   
   patch::apply{"$patch_file":
      cwd  => $real_cwd,
      p    => $p,
      user => $user,
   }
}