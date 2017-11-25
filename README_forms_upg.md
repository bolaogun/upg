

hiera variables to define:

hiera('forms_upg::staging_dir','/software')
hiera('forms_upg::jdk_install::installer', "jdk-8u131-linux-x64.tar.gz")
hiera('forms_upg::jdk_install::install_dest', "/opt/app/oracle/java")
hiera('forms_upg::owner','oracle')
hiera('forms_upg::group',  'oinstall')

