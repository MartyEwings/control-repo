# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include install_sql
class install_sql {

  sqlserver_instance{ 'MSSQLSERVER':
  source                => "C:\\Users\\Administrator\\Downloads\\SQLServer2019-x64-ENU-Dev",
  features              => ['SQL'],
  security_mode         => 'SQL',
  sa_pwd                => 'p@ssw0rd!!',
  sql_sysadmin_accounts => ['myuser'],
  install_switches      => {
    'TCPENABLED'        => 1,
    'SQLBACKUPDIR'      => 'C:\\MSSQLSERVER\\backupdir',
    'SQLTEMPDBDIR'      => 'C:\\MSSQLSERVER\\tempdbdir',
    'INSTALLSQLDATADIR' => 'C:\\MSSQLSERVER\\datadir',
    'INSTANCEDIR'       => 'C:\\Program Files\\Microsoft SQL Server',
    'INSTALLSHAREDDIR'  => 'C:\\Program Files\\Microsoft SQL Server',
  }
}

sqlserver::login{'PROD: DB1':
ensure           => present,
instance         => 'MSSQLSERVER',
login            => 'DB1',
login_type       => 'SQL_LOGIN',
password         => 'marty123',
svrroles         => {
'bulkadmin' => 1,
'sysadmin'  => 1,
},
check_expiration => false,
check_policy     => false,
}

}
