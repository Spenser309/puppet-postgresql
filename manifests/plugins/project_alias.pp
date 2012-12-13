
class redmine::plugins::project_alias {
   include redmine
   
   redmine::plugin{'project_alias':
      path => 'http://projects.andriylesyuk.com/attachments/download/225',
      version => '-0.0.1b',
      ext  => 'tar.bz2',
   }
   
   file{"/usr/local/share/redmine-${redmine::version}/vendor/plugins/project_alias":
      source => "puppet:///modules/redmine/project_alias_compat_1.4.5.patch",
      owner  => 'apache',
      group  => 'apache',
   }
   
   redmine::patch::apply{"/usr/local/share/redmine-${redmine::version}/vendor/plugins/project_alias":
      p => 1,
      cwd => "/vendor/plugins/project_alias",
      require => [Exec["project_alias-unpack"], File["/usr/local/share/redmine-${redmine::version}/vendor/plugins/project_alias"]], 
      before   => Exec["project_alias-migrate_plugins"],
   }
}
