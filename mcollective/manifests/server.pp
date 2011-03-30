class mcollective::server inherits mcollective {

    
    $mcollectiveClient = "mcollective-client-0.4.10-1.el5.noarch"
    $mcollectiveClientPackage = "${mcollectiveClient}.rpm"
    
    file { "mcollective-client":
        path => "${srcDir}${mcollectiveClientPackage}",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/${mcollectiveClientPackage}"    
    }
    
    include activemq          
    
    package { "mcollective-client":
        name => "${mcollectiveClient}",
        ensure => installed,
        provider => rpm,
        source => "${srcDir}${mcollectiveClientPackage}",
        require => [
            Package["mcollective-common"],
            Class["activemq"]
        ]
    }     
    
    file { "client-config":
        path => "/etc/mcollective/client.cfg",
        content => template("mcollective/client.cfg.erb"),
        require => Package["mcollective-common", "mcollective-client"]
    }    
    

    include mcollective::serverplugins
    Service["mcollective"] {
        subscribe +> Class["mcollective::serverplugins"],
        require +> [
            Class["mcollective::serverplugins"],
            File["client-config"]
        ]
    }    
}
