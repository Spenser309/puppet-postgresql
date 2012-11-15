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
# Useful command for setting admin password
# RAILS_ENV=production script/runner 'user = User.find(:first, :conditions => {:admin => true}) ; user.password, user.password_confirmation = "my_password"; user.save!'

class redmine {
	package{"redmine":
		ensure       => present,
		responsefile => template("puppet:///modules/redmine/redmine.debconf.erb")
	}

}






