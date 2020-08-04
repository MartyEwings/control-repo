## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
#https://docs.puppet.com/pe/2015.3/release_notes.html#filebucket-resource-no-longer-created-by-default
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

  node  'master.platform9.puppet.net' {
    class { '::nfs':
      server_enabled => true
    }
    nfs::server::export{ '/var/log/':
      ensure  => 'mounted',
      clients => '192.168.0.10(ro,insecure,async,no_root_squash) localhost(ro)',
      mount   => "/var/pesupport/$fqdn/log",
    }
     nfs::server::export{ '/opt/puppetlabs/':
      ensure  => 'mounted',
      clients => '192.168.0.10(ro,insecure,async,no_root_squash) localhost(ro)',
      mount   => "/var/pesupport/$fqdn/opt",
    }
     nfs::server::export{ '/etc/puppetlabs/':
      ensure  => 'mounted',
      clients => '192.168.0.10(ro,insecure,async,no_root_squash) localhost(ro)',
      mount   => "/var/pesupport/$fqdn/etc",
    }
  include puppet_metrics_dashboard::profile::master::install 
   }
    
    node 'remotesupportnode.platform9.puppet.net' {
    class { '::nfs':
      client_enabled => true,
    }
    Nfs::Client::Mount <<| |>>
    
    class { 'puppet_metrics_dashboard':
    add_dashboard_examples => true,
    overwrite_dashboards   => false,
  }
  }
    
  
