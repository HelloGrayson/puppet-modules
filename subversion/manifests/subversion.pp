class subversion {

    package { "openssl":
        ensure => latest
    }

    package { "subversion":
        ensure => latest,
        require => Package["openssl"]
    }
}

