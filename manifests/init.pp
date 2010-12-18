# Class: redmine
#
# This module manages redmine
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class redmine {
	package{"redmine":
		ensure       => present,
		responsefile => template("puppet:///modules/redmine/redmine.debconf.erb"),
		require      => 
	}
}

define redmine::instance($domain, $ssl=false) {
	
	
}


