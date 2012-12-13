class redmine::debian {
   package {"redmine":
      ensure       => $ensure,
      responsefile => template("redmine/redmine.debconf.erb"),
   }
}

define redmine::debian::instance($instance=$name) {
  notice("Not yet implemented")
}