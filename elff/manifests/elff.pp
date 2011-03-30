#
# same as running:
#   rpm -Uvh http://download.elff.bravenet.com/5/i386/elff-release-5-3.noarch.rpm
#

class elff {

    file { "RPM-GPG-KEY-ELFF":
        path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        source => "puppet://puppetmaster.insuredapp.com/modules/elff/RPM-GPG-KEY-ELFF"
    }

    yumrepo { "elff":
        descr => "Enterprise Linux Fast Forward 5 - \$basearch",
        baseurl => "http://download.elff.bravenet.com/5/\$basearch",
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        require => File["RPM-GPG-KEY-ELFF"]
    }

    yumrepo { "elff-debuginfo":
        descr => "Enterprise Linux Fast Forward 5 - \$basearch - Debug",
        baseurl => "http://download.elff.bravenet.com/5/\$basearch/debug",
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        require => File["RPM-GPG-KEY-ELFF"]
    }
    
    yumrepo { "elff-source":
        descr => "Enterprise Linux Fast Forward 5 - \$basearch - Source",
        baseurl => "http://download.elff.bravenet.com/5/SRPMS",
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        require => File["RPM-GPG-KEY-ELFF"]
    }
    
    yumrepo { "elff-testing":
        descr => "Enterprise Linux Fast Forward 5 - Testing - \$basearch",
        baseurl => "http://download.elff.bravenet.com/testing/5/\$basearch",
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        require => File["RPM-GPG-KEY-ELFF"]
    }
    
    yumrepo { "elff-testing-debuginfo":
        descr => "Enterprise Linux Fast Forward 5 - Testing - \$basearch - Debug",
        baseurl => "http://download.elff.bravenet.com/testing/5/\$basearch/debug",
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        require => File["RPM-GPG-KEY-ELFF"]
    }    
    
    yumrepo { "elff-testing-source":
        descr => "Enterprise Linux Fast Forward 5 - Testing - \$basearch - Source",
        baseurl => "http://download.elff.bravenet.com/testing/5/SRPMS",
        enabled => 0,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ELFF",
        require => File["RPM-GPG-KEY-ELFF"]
    }
}
