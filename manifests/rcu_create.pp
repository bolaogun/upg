class upg::rcu_create {
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $mw_home = hiera('forms_upg::mw_home', "${oracle_base}/middleware") 
    $wls_home = hiera('forms_upg::wls_home', "${mw_home}/wlserver")
    $wl_home = hiera('forms_upg::wl_home', "${wls_home}")
    $java_home = hiera('forms_upg::java_home', "${oracle_base}/java")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
    $env = hiera('forms_upg::env', 'deve') 
    $db_host = hiera('forms_upg::db_host','db_host')
    $db_port = hiera('forms_upg::db_port', 1521)
    $db_sid = hiera('forms_upg::db_sid', 'TIA')
    $db_usr = hiera('forms_upg::db_sysdba_usr', 'sys')
    $db_pwd = hiera('forms_upg::db_sysdba_pwd', 'welcome123')
    $db_file_dest = hiera('forms_upg::db_file_dest', "/u01/oradata/${env}")

    # Use variables above to generate a python script from a template, put it in a specific location
    # and the execute it on the agent
 
    $ddl_stmt = "CREATE TABLESPACE abcqwer datafile '/u01/app/oradata' size 10m autoextend on maxsize unlimited" 
    upg::exec_ora_ddl { "${ddl_stmt}": 
        host => "${db_host}",
        port => "${db_port}",
        sid => "${db_port}",
        usrnm => "${db_usr}",
        pwd => "${db_pwd}",
    }
#   exec { "${extract_to}/fmw_12.2.1.3.0_fr_linux64.bin -silent -responseFile /tmp/FR_Aft_FMWInfra.rsp -invPtrLoc /tmp/oraInst.loc":
#       path => "${java_home}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#       user => "${ownr}",
#       group  => "${grp}",
#       timeout => 0,
#       #creates => "${mw_home}/wlserver",
#   }
     
}
