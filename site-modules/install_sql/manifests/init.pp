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

sqlserver::login{'PROD: DB1':
ensure           => present,
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
