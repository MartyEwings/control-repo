# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include install_sql
class install_sql {

  sqlserver_instance{ 'MSSQLSERVER':
    features              => ['SQL'],
    source                => "C:\\Users\\Administrator\\Downloads\\SQLServer2019-x64-ENU-Dev",
    sql_sysadmin_accounts => ['administrator']
}


sqlserver::config { 'MSSQLSERVER':
  admin_login_type => 'WINDOWS_LOGIN'
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
