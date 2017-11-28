class upg::rcu_create {
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    $mw_home = hiera('forms_upg::mw_home', "${oracle_base}/middleware") 
    $wls_home = hiera('forms_upg::wls_home', "${mw_home}/wlserver")
    $wl_home = hiera('forms_upg::wl_home', "${wls_home}")
    $java_home = hiera('forms_upg::java_home', "${oracle_base}/java")
    $ownr = hiera('forms_upg::owner', 'oracle')
    $grp  = hiera('forms_upg::group', 'oinstall')
    $domain_nm = hiera('forms_upg::domain_name', 'deve') 
    $env = upcase($domain_nm)
    
    # MAKE SURE YOU CHANGE THE NEXT LINE !!!!
    $db_host = hiera('forms_upg::db_host','e1a-esodb-deve-01.es-dte.co.uk')
    $db_port = hiera('forms_upg::db_port', 1521)
    $db_sid = hiera('forms_upg::db_sid', 'TIA')
    $db_usr = hiera('forms_upg::db_sysdba_usr', 'sys')
    $db_pwd = hiera('forms_upg::db_sysdba_pwd', 'welcome123')
    $db_file_dest = hiera('forms_upg::db_file_dest', "/u01/app/oracle/oradata")
    $rcu_schema_pwd = hiera('forms_upg::rcu_create::schema_pwd', 'welcome123')
    $rcu_pwd_rsp = hiera('forms_upg::rcu_create::rcu_pwd_rsp', '/tmp/.pswd.rsp')
    $rcu_scrpt = hiera('forms_upg::rcu_create::rcu_script', '/tmp/.rcucmd.sh')

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

    # Create password Response File from Template
    file { "${rcu_pwd_rsp}" :
        content => template('upg/pswd.rsp.erb'),
        mode => "0700",
        owner => "${ownr}",
        group  => "${grp}",
    } ->
    # Generate the rcu Command script
    file { "${rcu_scrpt}" :
        content => template('upg/rcu_scrpt.erb'),
        mode => "0700",
        owner => "${ownr}",
        group  => "${grp}",
    } ->
    # Execute Script
    exec { "Execute RCU Command" :
        path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        command => "${rcu_scrpt}",
        user => "${ownr}",
        group => "${grp}",
        #unless 
    }
    
}
