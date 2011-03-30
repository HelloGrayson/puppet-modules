class mysql {

    package { "mysql":
        ensure => installed
    }
    
    package { "mysql-server":
        ensure => installed
    }
    
    package { "mysql-libs":
        ensure => installed
    }

    service { "mysqld":
        ensure => running,
        require => [
            Package["mysql"],
            Package["mysql-server"],
            Package["mysql-libs"]
        ]
    }
    
    exec { "mysql-chkconfig":
        command => "chkconfig --levels 235 mysqld on",
        path => "/sbin:/bin",
        unless => "chkconfig --list mysqld | grep -c on",
        require => Service["mysqld"]
    }

    file { "mysql-autosecure":
        path => "/usr/local/src/mysql-autosecure.sh",
        source => "puppet://puppetmaster.insuredapp.com/modules/mysql/mysql-autosecure.sh",
        require => Service["mysqld"]
    }

    exec { "mysql-autosecure":
        command => "sh /usr/local/src/mysql-autosecure.sh $password",
        path => "/usr/bin:/bin/",
        creates => "/usr/bin/mysql_secure_installation.ran",
        logoutput => true,
        require => File["mysql-autosecure"]
    }
}
