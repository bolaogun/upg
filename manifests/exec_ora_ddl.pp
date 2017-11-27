define upg::exec_ora_ddl (
    $host,
    $port,
    $sid,
    $usrnm,
    $pwd) {

    ensure_packages(['python-devel', 'python-setuptools', 'python-pip' ], {
        ensure   => present,
    })


#    ensure_packages(['cx_Oracle',], {
#        ensure   => present,
#         provider => 'pip',
#         require  => [ Package['python-pip'], ],
#    })

    ensure_packages(['cx_Oracle'], {
        ensure   => present,
         provider => 'pip',
    })

    file { '/tmp/exec_ora_ddl.py':
       ensure => present,
       mode => "0755",
       source => "puppet:///modules/upg/exec_ora_ddl.py"
    } ->
    exec { "Run SQL DDL: ${name}":
       command => "ls /tmp", 
       environment => ["LD_LIBRARY_PATH=/usr/lib/oracle/12.2"], 
       path => "${java_home}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
       user => "${ownr}",
       group  => "${grp}",
       timeout => 0,
       creates => "/tmp/${name}.log",
    }

}
