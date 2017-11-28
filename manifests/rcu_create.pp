class upg::rcu_create {
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $mw_home = hiera('forms_upg::mw_home', "${oracle_base}/middleware") 
    $wls_home = hiera('forms_upg::wls_home', "${mw_home}/wlserver")
    $wl_home = hiera('forms_upg::wl_home', "${wls_home}")
    $java_home = hiera('forms_upg::java_home', "${oracle_base}/java")
    $ownr = hiera('forms_upg::owner', 'oracle')
    $grp  = hiera('forms_upg::group', 'oinstall')
    $env = hiera('forms_upg::env', 'deve') 
    # MAKE SURE YOU CHANGE THE NEXT LINE !!!!
    $db_host = hiera('forms_upg::db_host','e1a-esodb-deve-01.es-dte.co.uk')
    $db_port = hiera('forms_upg::db_port', 1521)
    $db_sid = hiera('forms_upg::db_sid', 'TIA')
    $db_usr = hiera('forms_upg::db_sysdba_usr', 'sys')
    $db_pwd = hiera('forms_upg::db_sysdba_pwd', 'welcome123')
    $db_file_dest = hiera('forms_upg::db_file_dest', "/u01/app/oracle/oradata")

    # Use variables above to generate a python script from a template, put it in a specific location
    # and the execute it on the agent
 
    upg::exec_ora_ddl { "Create Schema Tablespaces": 
        host => "${db_host}",
        port => "${db_port}",
        sid => "${db_sid}",
        usrnm => "${db_usr}",
        pwd => "${db_pwd}",
        env => "${env}",
        db_file_dest => "${db_file_dest}",
        ownr => "${ownr}",
        grp => "${grp}",
    }

}
