include redmine

redmine::instance{"gillilanding.com"}

redmine::instance{"dev.gillilanding.com":
   # Redmine Settings
   $lang         => "en",        # Select from a ton.
   $admin_passwd => "admin",
   # Webserver Settings
   $webserver    => "apache",    # Currently the only valid selection
   $cgi          => "passenger", # Currently the only valid selection
   $auth         => "unixgroup", # Currently the only valid selection
   $priority     => 15,         
   $domain       => $name,        
   $ssl          => false,       
   # Database Settings
   $db           => "mysql",
   $db_host      => false,
   $db_user      => $name,
   $db_passwd    => $name,
   # Outgoing Email Configuration
   $smtp         => false,
   $smtp_host    => "localhost",
   $smtp_tls     => false,
   $smtp_user    => "redmine@$domain",
   $smtp_passwd  => false,
   # Incoming Email Configuration
   $email        => false,
   $email_addr   => "redmine@$domain",
   # Backup Settings
   $backup_style => false,
   # More to come.
   # Monitoring Settings
   $noc          => false,
   $noc_serve    => false
} 
