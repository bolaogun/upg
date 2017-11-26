define upg::exec_ora_ddl (
    $host,
    $port,
    $sid,
    $usrnm,
    $pwd,
    $cnct_mode,
    $ddl_stmt) {

    package { 'python-devel':
        ensure => present,
    }

    package { 'python-pip':
        ensure => present,
    }

   ensure_packages(['cx_Oracle', 'python-pip-package2'], {
         ensure   => present,
         provider => 'pip',
         require  => [ Package['python-pip'], ],
   })



}
