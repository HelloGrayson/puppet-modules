class tanukiwrapper {

    $tanukiwrapper = "tanukiwrapper-3.2.3-1jpp"

    $tanukiwrapperName = $architecture ? {
        "i386" => "${tanukiwrapper}.i386",
        "x86_64" => "${tanukiwrapper}.x86_64"
    }

    $tanukiwrapperPackage = "${tanukiwrapperName}.rpm"

    $srcDir = "/usr/local/src/"

    file { "tanukiwrapper-rpm":
        path => "${srcDir}${tanukiwrapperPackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/tanukiwrapper/${tanukiwrapperPackage}"        
    }

    package { "java":
        name => "java-1.6.0-openjdk",
        ensure => latest
    }

    package { "tanukiwrapper":
        name => "${tanukiwrapperName}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${tanukiwrapperPackage}",
        require => [
            File["tanukiwrapper-rpm"],
            Package["java"]
        ]
    }
}
