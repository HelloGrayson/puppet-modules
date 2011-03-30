class zendserverce {

    yumrepo { "Zend":
        descr => "Zend Server",
        baseurl => "http://repos.zend.com/zend-server/rpm/\$basearch",
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "http://repos.zend.com/zend.key"
    }

    yumrepo { "Zend_noarch":
        descr => "Zend Server - noarch",
        baseurl => "http://repos.zend.com/zend-server/rpm/noarch",
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "http://repos.zend.com/zend.key"
    }

    # needed for PHP db adapters
    package { "httpd-devel":
        ensure => installed
    }

    package { "phpmemcache":
        name => "php-5.3-memcache-zend-server",
        ensure => installed,
        require => [
            Yumrepo["Zend"],
            Yumrepo["Zend_noarch"]
        ]
    }

    package { "fileinfo":
        name => "php-5.3-fileinfo-zend-server",
        ensure => installed,
        require => [
            Yumrepo["Zend"],
            Yumrepo["Zend_noarch"]
        ]
    }

    package { "zendserver":
        name => "zend-server-ce-php-5.3",
        ensure => installed,
        require => [ 
            Yumrepo["Zend"], 
            Yumrepo["Zend_noarch"], 
            Package["httpd-devel"],
            Package["phpmemcache"],
            Package["fileinfo"]
        ]
    }

    # fix admin panel bug where
    # logs arent readable by default
    file { "/var/log/httpd":
        mode => 755,
        require => Package["zendserver"]
    }
    
    service { "httpd":
        ensure => running,
        require => Package["zendserver"]
    }
}

