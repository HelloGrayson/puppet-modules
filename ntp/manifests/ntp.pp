class ntp {
  
    package { "ntp":
        ensure => installed
    }
    
    service { "ntpd":
        ensure => running,
        require => Package["ntp"]
    }
    
    if $timezone {
       
        exec { "backup-timezone":
            command => "mv /etc/localtime /etc/localtime.bak",
            creates => "/etc/localtime.bak",
            require => Service["ntpd"]
        }
   
        exec { "set-timezone":
            command => "ln -s /usr/share/zoneinfo/${timezone} /etc/localtime;", 
            logoutput => true,
            path => "/sbin:/bin:/usr/bin",
            unless => "test -L /etc/localtime",
            require => Exec["backup-timezone"]
        }
    }
}
