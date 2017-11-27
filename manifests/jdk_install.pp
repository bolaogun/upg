class upg::jdk_install {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename = hiera('forms_upg::jdk_install::installer', "jdk-8u131-linux-x64.tar.gz")
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $extract_path = hiera('forms_upg::jdk_install::extract_path', "/opt/app/oracle/jdk1.8.0_131")
    $install_path = hiera('forms_upg::jdk_install::install_dest', "/opt/app/oracle/java")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
    
    group { "${grp}":
        ensure => present;
    }
    user { "${ownr}":
        ensure => present;
    }

    exec{"mkdir -p ${oracle_base}":
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        creates => "${oracle_base}",
    }

    exec {"untar ${repo}/${filename}":
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        command => "tar xvzf ${repo}/${filename}", 
        cwd => "${oracle_base}",
        creates         => "${extract_path}/bin/java", 
    }
 
    file { "${install_path}":
        ensure => link,
        target => "${extract_path}",
    }

   

#    ::archive { "${repo}/${filename}":
#        ensure          => present,
#        extract         => true,
#        extract_command => 'tar xfz %s --strip-components=1',
#        extract_path    => "${install_path}",
#        cleanup         => true,
#        creates         => "${install_path}/bin/java",
#    }

}

