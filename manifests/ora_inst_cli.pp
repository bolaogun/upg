class upg::ora_inst_cli {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename = hiera('forms_upg::ora_inst_cli::installer', "oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm")
  
    package { 'Oracle Instant Client':
      ensure => 'installed',
      provider => 'rpm',
      source => "${repo}/${filename}",
      #creates => '/usr/lib/oracle/12.2/client64/lib',
    }  
}
