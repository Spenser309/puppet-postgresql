
class redmine::plugins::checkout {
  redmine::plugin{'redmine_checkout':
     path => 'https://dev.holgerjust.de/attachments/download/48',
     version => "_0.5",
     ext  => 'tar.gz',
  }
}
