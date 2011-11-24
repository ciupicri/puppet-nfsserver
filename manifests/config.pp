class nfsserver::config::homedir {
    file { "${nfshomedir}":
        ensure  => directory,
        seltype => 'public_content_t',# XXX include this in the SELinux policy?
    }
}

class nfsserver::config {
    include homedir

    Config_file {
        require => Class['nfsserver::install'],
        notify  => Class['nfsserver::service'],
    }

    config_file {
        '/etc/sysconfig/nfs':
            source => '/etc/sysconfig/nfs';
        '/etc/idmapd.conf':
            source => '/etc/idmapd.conf';
    }
}
