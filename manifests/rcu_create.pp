class upg::rcu_create {
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $mw_home = hiera('forms_upg::mw_home', "${oracle_base}/middleware") 
    $wls_home = hiera('forms_upg::wls_home', "${mw_home}/wlserver")
    $wl_home = hiera('forms_upg::wl_home', "${wls_home}")
    $java_home = hiera('forms_upg::java_home', "${oracle_base}/java")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
  
#    package { 'python-devel':
#        ensure => present,
#    }
     


#   exec { "${extract_to}/fmw_12.2.1.3.0_fr_linux64.bin -silent -responseFile /tmp/FR_Aft_FMWInfra.rsp -invPtrLoc /tmp/oraInst.loc":
#       path => "${java_home}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#       user => "${ownr}",
#       group  => "${grp}",
#       timeout => 0,
#       #creates => "${mw_home}/wlserver",
#   }
     
}
