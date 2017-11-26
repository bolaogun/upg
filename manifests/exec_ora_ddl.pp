define upg::exec_ora_ddl (
    $host,
    $port,
    $sid,
    $usrnm,
    $pwd) {

#    package { 'python3-devel':
#        ensure => present,
#    }
#
#    package { 'python34-setuptools':
#        ensure => present,
#    }

#    ensure_packages(['epel-release','python3-devel', 'python34-setuptools', 'python34-pip' ], {
    ensure_packages(['epel-release','python-devel', 'python-setuptools', 'python-pip' ], {
        ensure   => present,
    })

#    package { 'cx_Oracle':
#        ensure => present,
#        provider => 'pip',
#    }

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
    }

}
