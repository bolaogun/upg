define upg::exec_ora_ddl (
    $host,
    $port,
    $sid,
    $usrnm,
    $pwd,
    $env,
    $db_file_dest,
    $ownr,
    $grp) {

    ensure_packages(['python-devel', 'python-setuptools', 'python-pip' ], {
        ensure   => present,
    })


    ensure_packages(['cx_Oracle'], {
        ensure   => present,
         provider => 'pip',
    })

    file { '/tmp/.exec_ora_ddl.py':
       ensure => present,
       mode => "0700",
       content => template('upg/exec_ora_ddl.py.erb'),
       owner => "${ownr}",
       group  => "${grp}",
    } ->
    exec { "Run SQL DDL: ${name}":
       command => "/tmp/.exec_ora_ddl.py", 
       environment => ["LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib"], 
       path => "${java_home}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
       user => "${ownr}",
       group  => "${grp}",
       timeout => 300,
    }

}
