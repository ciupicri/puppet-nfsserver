class nfsserver::service {
    $service_name = $operatingsystem ? {
        'Fedora'     => 'nfs-server',
        'CentOS'     => 'nfs',
        'Scientific' => 'nfs',
        default      => fail("${operatingsystem} is not supported"),
    }
    service { "${service_name}":
        ensure  => running,
        require => [Class['nfsserver::config'], Class['rpcbind::service']],
    }
}
