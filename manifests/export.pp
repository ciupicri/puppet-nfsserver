define nfsserver::export($ensure = present, $clients, $options) {
    if $ensure == present {
        augeas { "nfsserver-export-${name}":
            context => '/files/etc/exports',
            changes => gen_client_list($clients, $options, "${nfshomedir}/${name}"),
            notify  => Class['nfsserver::service'],
        }
    } else {
        augeas { "nfsserver-export-${name}":
            context => '/files/etc/exports',
            changes => "rm dir[.='$nfshomedir/${name}']",
            notify  => Class['nfsserver::service'],
        }
    }
}
