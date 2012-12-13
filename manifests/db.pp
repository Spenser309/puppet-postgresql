# class redmine:db
# Sets up the redmine database.
#
class redmine::db (
   $instance   = 'default',
   $adapter    = 'postgresql',
   $host       = 'localhost',
   $name       = 'redmine',
   $user       = 'redmine',
   $password   = 'default',
   $path       = 'default'
) {
   if $password == 'default' and $adapter != 'sqlite' {
     fail("ERROR: Please set a password for the Database.")
   }

   # Manage the Database if database should be on localhost.
   if $host == "localhost" {
      case $db_adapter {
         'postgresql': {
            include postgresql::server

            postgresql::db {"${name}":
               user     => "${user}",
               password => "${password}",
            }
         }
         'mysql': {
            include mysql::server

            mysql::db {"${name}":
               user     => "${user}",
               password => "${password}",
            }
         }
         'sqlite': {
            #include sqlite
         }
         default: {
            fail("Database adapter not implemented.")
         }
      }
   }
   
   @file{"${instance}-database.yml":
      path   => "/etc/redmine/$instance/database.yml",
      owner  => $redmine::params::user,
      group  => $redmine::params::group,
      mode   => 600,
      content => template("redmine/database.yml.erb");
   }
}