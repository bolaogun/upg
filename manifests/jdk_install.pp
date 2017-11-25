class upg::jdk_install {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename = hiera('forms_upg::jdk_install::installer', "jdk-8u131-linux-x64.tar.gz")
    $install_path = hiera('forms_upg::jdk_install::install_dest', "/opt/app/oracle/java")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
    
    group { "${grp}":
        ensure => present;
    }
    user { "${ownr}":
        ensure => present;
    }

    exec{"mkdir -p ${install_path}":
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        unless => "test -d ${install_path}",
    }

    file { "${install_path}":
        ensure => directory,
        owner  => "${ownr}",
        group  => "${grp}",
        mode   => '0755',
    }

    archive { "${repo}/${filename}":
        ensure          => present,
        extract         => true,
        extract_command => 'tar xfz %s --strip-components=1',
        extract_path    => "${install_path}",
        cleanup         => true,
        creates         => "${install_path}/bin/java",
    }
}

