# Tasks that make redmine work good.
#
define redmine::tasks($instance=$name, $rakefile){
   include redmine::params
   include rake
   
   Rake::Task{
     user     => $redmine::params::user,
     cwd      => '/',
     rakefile => $rakefile,
   }
   
   rake::task{
      "${instance}-db:migrate":
         task => 'db:migrate';
      "${instance}}-db:migrate_plugins":
         task => 'db:migrate_plugins';
      "${instance}-tmp:cache:clear":
         task => 'tmp:cache:clear';
      "${instance}-tmp:sessions:clear":
         task => "tmp:sessions:clear";
   }
}