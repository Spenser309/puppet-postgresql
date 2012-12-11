include apache::mod::passenger

include postgresql::server

postgresql::db {"redmine":
   user     => "redmine",
   password => "asdasdasd",
   grant    => "all",
}
