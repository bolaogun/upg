class upg::fmw_infra_install {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename = hiera('forms_upg::fmw_infra_install::installer', "fmw_12.2.1.3.0_infrastructure_Disk1_1of1.zip")

    $extract_to = hiera('forms_upg::extract_to', '/tmp')
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $mw_home = hiera('forms_upg::mw_home', "${oracle_base}/middleware")                   
    $wls_home = hiera('forms_upg::wls_home', "${mw_home}/wlserver")
    $wl_home = hiera('forms_upg::wl_home', "${wls_home}")
    $java_home = hiera('forms_upg::java_home', "${oracle_base}/java")
    $inv_lctn = hiera('forms_upg::inventory_location', "/opt/oracle/forms/oraInventory")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
  
    package { 'unzip':
        ensure => present,
        provider => yum,
    }
     
    exec {"mkdir -p ${oracle_base}/config":
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        creates => "${oracle_base}/config",
        user  => "${ownr}",
        group  => "${grp}",
    }

    exec {"mkdir -p ${inv_lctn}":
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        creates => "${inv_lctn}",
        user  => "${ownr}",
        group  => "${grp}",
    }

    file { [ "${mw_home}", "${oracle_base}/config", "${oracle_base}/config/domains", "${oracle_base}/config/applications", "${inv_lctn}" ]: 
        ensure => directory,
        owner  => "${ownr}",
        group  => "${grp}",
        mode   => '0755',
    }
  
    exec { "unzip -o ${repo}/${filename}":
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        cwd => "${extract_to}",
        command => "unzip ${repo}/${filename}",
        creates         => "${extract_to}/fmw_12.2.1.3.0_infrastructure.jar",
        umask => "000",
        #user  => "${ownr}",
        group  => "${grp}",
    }

#    archive { "${repo}/${filename}":
#        ensure          => present,
#        extract         => true,
#        extract_path    => "${extract_to}",
#        creates         => "${extract_to}/fmw_12.2.1.3.0_infrastructure.jar",
#        cleanup         => true,
#    }
 
   file { '/tmp/fmw_infr.rsp':
       content => template('upg/fmw_infr.rsp.erb'),
       owner  => "${ownr}",
       group  => "${grp}",
   }

   file { '/tmp/oraInst.loc':
       content => template('upg/oraInst.loc.erb'),
       owner  => "${ownr}",
       group  => "${grp}",
   }

   exec { "${java_home}/bin/java -Xmx1024m -jar ${extract_to}/fmw_12.2.1.3.0_infrastructure.jar -silent -responseFile /tmp/fmw_infr.rsp -invPtrLoc /tmp/oraInst.loc":
       path => "${java_home}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
       user => "${ownr}",
       group  => "${grp}",
       timeout => 0,
       creates => "${mw_home}/wlserver"
   }
     
}

