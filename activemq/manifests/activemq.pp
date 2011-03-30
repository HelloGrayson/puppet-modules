class activemq {

    $activemq = "activemq-5.4.0-2.el5.noarch"
    $activemqPackage = "${activemq}.rpm"

    $activemqInfoProvider = "activemq-info-provider-5.4.0-2.el5.noarch"
    $activemqInfoProviderPackage = "${activemqInfoProvider}.rpm"
    
    $srcDir = "/usr/local/src/"
    
    file { "activemq":
        path => "${srcDir}${activemqPackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/activemq/${activemqPackage}"
    }
    
    file { "activemq-info-provider":
        path => "${srcDir}${activemqInfoProviderPackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/activemq/${activemqInfoProviderPackage}"
    }

    include tanukiwrapper
    
    package { "activemq":
        name => "${activemq}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${activemqPackage}",
        require => [
            File["activemq"],
            Class["tanukiwrapper"]
        ]
    }
    
    package { "activemq-info-provider":
        name => "${activemqInfoProvider}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${activemqInfoProviderPackage}",
        require => [
            File["activemq-info-provider"],
            Package["activemq"]
        ]
    }
    
    file { "activemq-config":
        path => "/etc/activemq/activemq.xml",
        content => template("activemq/activemq.xml.erb"),
        require => [
            Package["activemq"],
            Package["activemq-info-provider"]
        ]
    }  

    exec { "host-in-hosts":
        command => "echo \"127.0.0.1   $(hostname)\" >> /etc/hosts",
        unless => "grep -c `hostname` /etc/hosts",
        path => "/bin"
    }
    
    service { "activemq":
        ensure => running,
        require => [
            Package["activemq"],
            Package["activemq-info-provider"],
            File["activemq-config"],
            Exec["host-in-hosts"]
        ]
    }

    exec { "activemq-chkconfig":
        command => "chkconfig activemq on",
        path => "/sbin:/bin",
        unless => "chkconfig --list activemq | grep -c on",
        require => Service["activemq"]           
    }
}
