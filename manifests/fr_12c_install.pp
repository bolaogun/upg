class upg::fr_12c_install {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename01 = hiera('forms_upg::fr_12c_install::installer01', "fmw_12.2.1.3.0_fr_linux64_Disk1_1of2.zip")
    $filename02 = hiera('forms_upg::fr_12c_install::installer02', "fmw_12.2.1.3.0_fr_linux64_Disk1_2of2.zip")
    $extract_to = hiera('forms_upg::extract_to', '/tmp')
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $mw_home = hiera('forms_upg::mw_home', "${oracle_base}/middleware") 
    $wls_home = hiera('forms_upg::wls_home', "${mw_home}/wlserver")
    $wl_home = hiera('forms_upg::wl_home', "${wls_home}")
    $java_home = hiera('forms_upg::java_home', "${oracle_base}/java")
    $inv_lctn = hiera('forms_upg::inventory_location', "/opt/oracle/forms/oraInventory")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
  
#    package { 'unzip':
#        ensure => present,
#    }
     

    archive { "${repo}/${filename01}":
        ensure          => present,
        extract         => true,
        extract_path    => "${extract_to}",
        creates         => "${extract_to}/fmw_12.2.1.3.0_fr_linux64.bin",
        cleanup         => true,
    }
 
    archive { "${repo}/${filename02}":
        ensure          => present,
        extract         => true,
        extract_path    => "${extract_to}",
        creates         => "${extract_to}/fmw_12.2.1.3.0_fr_linux64-2.zip",
        cleanup         => true,
    }
 
   file { '/tmp/FR_Aft_FMWInfra.rsp':
       content => template('upg/FR_Aft_FMWInfra.rsp.erb'),
   }

#   file { '/tmp/oraInst.loc':
#       content => template('upg/oraInst.loc.erb'),
#   }

   exec { "${extract_to}/fmw_12.2.1.3.0_fr_linux64.bin -silent -responseFile /tmp/FR_Aft_FMWInfra.rsp -invPtrLoc /tmp/oraInst.loc":
       path => "${java_home}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
       user => "${ownr}",
       group  => "${grp}",
       timeout => 0,
       #creates => "${mw_home}/wlserver",
   }
     
}
