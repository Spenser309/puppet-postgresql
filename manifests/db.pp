# class redmine:db
# Sets up the redmine database.

class redmine::db {
   $db_adapter    = $redmine::db_adapter
   $db_host       = $redmine::db_host
   $db_name       = $redmine::db_name
   $db_user       = $redmine::db_user
   $db_password   = $redmine::db_password
   
   if $db_password == 'na' and $dp_adapter != 'sqlite' {
     fail("ERROR: Please set a password for the Database.")
   }
   
   if $db_host == "localhost" {
     case $db_adapter {
        'postgresql': {
            include postgresql::server
     
            postgresql::db { "${db_name}":
               user     => "${db_user}",
               password => "${db_password}",
            }
         }
         default: {
            fail("No known Database type selected.")
         }
      }
   }

   file{"/etc/redmine/database.yml":
      owner  => apache,
      group  => apache,
      mode   => 600,
      content => template("redmine/database.yml.erb");
   }
}