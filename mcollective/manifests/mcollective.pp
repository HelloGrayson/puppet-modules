class mcollective {

    package { "rubygems":
        ensure => installed
    }

    include epel
    Yumrepo <| title == "epel" |> {
        includepkgs => "rubygem-stomp"
    }
    
    package { "rubygem-stomp":
        ensure => installed,
        require => [
            Package["rubygems"],
            Class["epel"]
        ]
    }

    package { "redhat-lsb":
        ensure => installed
    }

    $mcollectiveCommon = "mcollective-common-0.4.10-1.el5.noarch"
    $mcollectiveCommonPackage = "${mcollectiveCommon}.rpm"
    $mcollective = "mcollective-0.4.10-1.el5.noarch"
    $mcollectivePackage = "${mcollective}.rpm"
    $srcDir = "/usr/local/src/"    
    
    file { "mcollective-common":
        path => "${srcDir}${mcollectiveCommonPackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/${mcollectiveCommonPackage}"
    }
    
    file { "mcollective":
        path => "${srcDir}${mcollectivePackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/${mcollectivePackage}"    
    }
    
    package { "mcollective-common":
        name => "${mcollectiveCommon}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${mcollectiveCommonPackage}",
        require => [
            File["mcollective-common"],
            Package["rubygem-stomp"]
        ]
    }

    package { "mcollective":
        name => "${mcollective}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${mcollectivePackage}",
        require => [
            File["mcollective"],
            Package["mcollective-common"],
            Package["redhat-lsb"]
        ]
    }
    
    file { "server-config":
        path => "/etc/mcollective/server.cfg",
        content => template("mcollective/server.cfg.erb"),
        require => Package["mcollective-common", "mcollective"]
    }
    
    #any way to make this check for facter binary?
    file { "facter-facts":
        path => "/etc/mcollective/facts.yaml",
        owner => root,
        group => root,
        mode => 400,
        content => inline_template("<%=
            facts = {}; 
            skip = [ 'uptime', 'uptime_seconds', 'memoryfree', '_timestamp' ];
            scope.to_hash.each_pair{|k,v|
                if( !skip.include?(k.to_s) )
                    facts[k.to_s] = v.to_s;
                end;
            };
            facts.to_yaml 
        %>"),
        require => Package["mcollective-common", "mcollective"]
    }    
    
    include mcollective::plugins

    service { "mcollective":
        ensure => running,
        hasrestart => true,
        subscribe => Class["mcollective::plugins"],
        require => [
            Package["mcollective-common", "mcollective"],
            File["server-config", "facter-facts"],
            Class["mcollective::plugins"]
        ]
    }
}   
