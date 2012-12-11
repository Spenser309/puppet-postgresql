
class{'redmine':
   version       => '1.4.5',
   db_adapter    => 'postgresql',
   db_host       => 'localhost',
   db_name       => 'redmine',
   db_user       => 'redmine',
   db_password   => 'redmine',
   email         => 'none',
   smtp_server   => 'na',
   smtp_domain   => 'na',
   smtp_auth     => 'none',
   smtp_tls      => false,
   smtp_user     => 'na',
   smtp_password => 'na',
}

include redmine::plugins::scm_creator
include redmine::plugins::project_alias
#include redmine::plugins::checkout # Causes errors with scm_creator
