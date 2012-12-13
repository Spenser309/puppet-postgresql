define redmine::config (
   $path=$name
) {
   include redmine::params

   File {
      ensure => $ensure,
      mode   => '0660',
      owner  => $redmine::params::user,
      group  => $redmine::params::group,
   }

   file{
      "$path/configuration.yml":
         content => "hello";#template('redmine/configuration.yml.erb');
      "$path/database.yml":
         content => "hello";#template('redmine/database.yml.erb')
   }
}