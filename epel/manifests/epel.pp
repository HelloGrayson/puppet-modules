#
#   same as running:
#     rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm
#

class epel {

    file { "RPM-GPG-KEY-EPEL":
        path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        source => "puppet://puppetmaster.insuredapp.com/modules/epel/RPM-GPG-KEY-EPEL"
    }
    
    yumrepo { "epel":
        descr => "Extra Packages for Enterprise Linux 5 - \$basearch",
        #baseurl => "http://download.fedoraproject.org/pub/epel/5/\$basearch",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=\$basearch",
        failovermethod => priority,
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        require => File["RPM-GPG-KEY-EPEL"]
    }

    yumrepo { "epel-debuginfo":
        descr => "Extra Packages for Enterprise Linux 5 - \$basearch - Debug",
        #baseurl => "http://download.fedoraproject.org/pub/epel/5/\$basearch/debug",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-5&arch=\$basearch",
        failovermethod => priority,
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        require => File["RPM-GPG-KEY-EPEL"]
    }    
    
    yumrepo { "epel-source":
        descr => "Extra Packages for Enterprise Linux 5 - \$basearch - Source",
        #baseurl => "http://download.fedoraproject.org/pub/epel/5/SRPMS",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-5&arch=\$basearch",
        failovermethod => priority,
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        require => File["RPM-GPG-KEY-EPEL"]
    }
    
    yumrepo { "epel-testing":
        descr => "Extra Packages for Enterprise Linux 5 - Testing - \$basearch",
        #baseurl => "http://download.fedoraproject.org/pub/epel/testing/5/\$basearch",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=\$basearch",
        failovermethod => priority,
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        require => File["RPM-GPG-KEY-EPEL"]
    }    
    
    yumrepo { "epel-testing-debuginfo":
        descr => "Extra Packages for Enterprise Linux 5 - Testing - \$basearch - Debug",
        #baseurl => "http://download.fedoraproject.org/pub/epel/testing/5/\$basearch/debug",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel5&arch=\$basearch",
        failovermethod => priority,
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        require => File["RPM-GPG-KEY-EPEL"]
    }    
    
    yumrepo { "epel-testing-source":
        descr => "Extra Packages for Enterprise Linux 5 - Testing - \$basearch - Source",
        #baseurl => "http://download.fedoraproject.org/pub/epel/testing/5/SRPMS",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel5&arch=\$basearch",
        failovermethod => priority,
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
        require => File["RPM-GPG-KEY-EPEL"]
    }           
}
