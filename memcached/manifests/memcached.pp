class memcached {

    package { "memcached":
        ensure => installed
    }

    service { "memcached":
        ensure => running,
        require => Package["memcached"]
    }

    exec { "memcached-chkconfig":
        command => "chkconfig memcached on",
        path => "/sbin:/bin",
        unless => "chkconfig --list memcached | grep -c on",
        require => Service["memcached"]
    }
}
