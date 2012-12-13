class redmine::app (
   $version = '1.4.5',
   $instance = 'default',
   $debug   = false,
   $db_adapters = ['mysql','postgresql','sqlite']
) {
   include redmine::params
  
   if $osfamily == 'debian' and $version == 'na' {
      include redmine::debian
      redmine::debian::instance {$instance:
      }
   } else {
      redmine::custom_version {$instance:
         install_loc => $install_loc,
         version     => $version,
         db_adapters => $db_adapters,
         #notify      => Rake::Task["${instance}-db:migrate"],
      }
   }
}