
class redmine::plugins::project_alias {
  include redmine
  
  redmine::plugin{'project_alias':
     path => 'http://projects.andriylesyuk.com/attachments/download/225',
     version => '-0.0.1b',
     ext  => 'tar.bz2',
  }
  patch{'puppet:///modules/redmine/project_alias_compat_1.4.5.patch':
    p => 1,
    cwd => "/usr/local/share/redmine-${redmine::version}/vendor/plugins/project_alias",
    require => Exec["project_alias-unpack"],
    before   => Exec["project_alias-migrate_plugins"],
  }
}

define patch($patch = $name, $cwd = '/', $p = 0){
   $patch_name = regsubst($patch,'(.*)/(.*)$','\2') # Essentially basename.
   #notice("Patch is named $patch_name")
   
   file{"${cwd}/${patch_name}":
      source => $patch,
      notify => Exec["patch -p$p < ${cwd}/${patch_name}"],
   }
   
   exec{"patch -p$p < ${cwd}/${patch_name}":
     cwd => "${cwd}",
     logoutput => true,
     refreshonly => true,
     path => '/bin:/sbin:/usr/bin:/usr/sbin',
   }
}
