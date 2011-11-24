class nfsserver::install {
    package { 'nfs-utils':
        ensure => installed,
    }
}

