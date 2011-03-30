class syslog-ng {

    $syslogNg = "syslog-ng-3.1.2-1.rhel5"
    $syslogNgName = $architecture ? {
        "i386" => "${syslogNg}.i386",
        "x86_64" => "${syslogNg}.x86_64"
    }
    $syslogNgPackage = "${syslogNgName}.rpm"
    $srcDir = "/usr/local/src/"
    
    file { "syslog-ng-rpm":
        path => "${srcDir}${syslogNgPackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/syslog-ng/${syslogNgPackage}"
    }
    
    package { "syslog-ng":
        name => "${syslogNgName}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${syslogNgPackage}",
        require => File["syslog-ng-rpm"]
    }
    
    service { "syslog-ng":
        ensure => running,
        require => Package["syslog-ng"],
        subscribe => File["syslog-ng-config"],
        hasrestart => true
    }
    
    exec { "syslog-ng-chkconfig":
        command => "chkconfig syslog-ng on",
        path => "/sbin:/bin",
        unless => "chkconfig --list syslog-ng | grep -c on",
        require => Service["syslog-ng"]
    }

    file { "syslog-ng-config":
        path => "/opt/syslog-ng/etc/syslog-ng.conf",
        content => template("syslog-ng/syslog-ng.conf.erb"),
        require => Package["syslog-ng"]
    }

}
