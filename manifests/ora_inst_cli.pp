class upg::ora_inst_cli {
    $repo = hiera('forms_upg::staging_dir','/software')
    $filename = hiera('forms_upg::ora_inst_cli::installer', "oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm")
    $oracle_base = hiera('forms_upg::oracle_base', '/opt/app/oracle')
    #$inv_lctn = hiera('forms_upg::inventory_location', "/opt/oracle/forms/oraInventory")
    $ownr = hiera('forms_upg::owner','oracle')
    $grp  = hiera('forms_upg::group',  'oinstall')
  
    package { 'Oracle Instant Client':
      ensure => installed,
      provider => 'rpm',
      source => "${repo}/${filename}",
      require => File["${repo}/${filename}"],
    }  
