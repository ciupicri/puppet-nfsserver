# mounts a directory under the NFS home directory in order to share it
define nfsserver::mount_share($directory) {
    file { "${nfshomedir}/${name}":
        ensure   => directory,
        require  => Class['config'],
        owner    => undef,
        group    => undef,
        mode     => undef,
        selinux_ignore_defaults => true,
        selrange => undef,
        selrole  => undef,
        seltype  => undef,
        seluser  => undef,
    }

    mount { "${nfshomedir}/${name}":
        device  => $directory,
        fstype  => none,
        options => 'rbind',
        ensure  => mounted,
        require => File["${nfshomedir}/${name}"],
    }
}

define nfsserver::share($ensure = present, $directory, $clients, $options) {
    mount_share { "${name}":
        directory => $directory,
    }
    export { "${name}":
        ensure  => $ensure,
        clients => $clients,
        options => $options,
        require => Export['/'],
    }
}
