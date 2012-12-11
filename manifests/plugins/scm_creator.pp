
class redmine::plugins::scm_creator {
  redmine::plugin{'redmine_scm':
     path => 'http://projects.andriylesyuk.com/attachments/download/388',
     version => '-0.4.2',
     ext  => 'tar.bz2',
  }
}
