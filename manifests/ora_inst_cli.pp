class upg::ora_inst_cli {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename = hiera('forms_upg::ora_inst_cli::installer', "oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm")
  
    package { 'libaio':
      ensure => present,
      provider => 'yum',
    }

#    package { 'Oracle Instant Client':
#      ensure => 'present',
#      provider => 'rpm',
#      source => "${repo}/${filename}",
#      require => Package['libaio'],
#    }  

    exec { 'Oracle Instant Client':
      command => "rpm -i ${repo}/${filename}",
      path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
      require => [Package['libaio']],
      unless => 'test -d /usr/lib/oracle/12.2/client64/lib',
    }

}
