# http://projects.puppetlabs.com/projects/mcollective-plugins/wiki

class mcollective::plugins {

    $libdir = "/usr/libexec/mcollective/mcollective"
    $ddldir = "${libdir}/agent" 
    $agentdir = "${libdir}/agent"
    $factsdir = "${libdir}/facts"
    $utildir = "${libdir}/util"
    $bindir = "/usr/sbin"
        
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentService
    file { "service.rb":
        path => "${agentdir}/service.rb",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/service/puppet-service.rb",
        require => Package["mcollective"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentPackage
    file { "package.rb":
        path => "${agentdir}/package.rb",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/package/puppet-package.rb",
        require => Package["mcollective"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentFilemgr
    file { "filemgr.rb":
        path => "${agentdir}/filemgr.rb",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/filemgr/filemgr.rb",
        require => Package["mcollective"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentPuppetd
    file { "puppetd.rb":
        path => "${agentdir}/puppetd.rb",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/puppetd/puppetd.rb",
        require => Package["mcollective"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentIptablesJunkfilter
    file { "iptables.rb":
        path => "${agentdir}/iptables.rb",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/iptables-junkfilter/iptables.rb",
        require => Package["mcollective"]
    }
}

class mcollective::serverplugins inherits mcollective::plugins {

    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentService
    file { "mc-service":
        path => "${bindir}/mc-service",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/service/mc-service",
        mode => 755,
        require => Package["mcollective-client"]
    }
    file { "service.ddl":
        path => "${ddldir}/service.ddl",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/service/service.ddl",
        require => Package["mcollective-client"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentPackage
    file { "mc-package":
        path => "${bindir}/mc-package",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/package/mc-package",
        mode => 755,
        require => Package["mcollective-client"]
    }    
    file { "package.ddl":
        path => "${ddldir}/package.ddl",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/package/package.ddl",
        require => Package["mcollective-client"]
    }    
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentFilemgr
    file { "mc-filemgr":
        path => "${bindir}/mc-filemgr",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/filemgr/mc-filemgr",
        mode => 755,
        require => Package["mcollective-client"]
    }    
    file { "filemgr.ddl":
        path => "${ddldir}/filemgr.ddl",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/filemgr/filemgr.ddl",
        require => Package["mcollective-client"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentPuppetd  
    file { "mc-puppetd":
        path => "${bindir}/mc-puppetd",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/puppetd/mc-puppetd",
        mode => 755,
        require => Package["mcollective-client"]
    }    
    file { "puppetd.ddl":
        path => "${ddldir}/puppetd.ddl",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/puppetd/puppetd.ddl",
        require => Package["mcollective-client"]
    }
    
    # http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/AgentIptablesJunkfilter  
    file { "mc-iptables":
        path => "${bindir}/mc-iptables",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/iptables-junkfilter/mc-iptables",
        mode => 755,
        require => Package["mcollective-client"]
    }    
    file { "iptables.ddl":
        path => "${ddldir}/iptables.ddl",
        source => "puppet://puppetmaster.insuredapp.com/modules/mcollective/plugins/agent/iptables-junkfilter/iptables.ddl",
        require => Package["mcollective-client"]
    }                
}
