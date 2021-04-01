function Get-PostgreSqlVersion {
    $postgreSQLVersion = psql --version | Take-OutputPart -Part 2
    return "Postgre SQL $postgreSQLVersion"
}

function Get-MongoDbVersion {
    $mongoDBVersion = mongod --version | Select-Object -First 1 | Take-OutputPart -Part 2 -Delimiter "v"
    return "MongoDB $mongoDBVersion"
}

function Get-SqliteVersion {
    $sqliteVersion = sqlite3 --version | Take-OutputPart -Part 0
    return "sqlite3 $sqliteVersion"
}

function Get-MySQLVersion {
    $mySQLVersion = mysqld --version | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "-"
    return "MySQL $mySQLVersion"
}

function Get-SQLCmdVersion {
    $sqlcmdVersion = sqlcmd -? | Select-String -Pattern "Version" | Take-OutputPart -Part 1
    return "sqlcmd $sqlcmdVersion"
}

function Build-MySQLSection {
    $output = ""

    $output += New-MDHeader "MySQL" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-MySQLVersion ),
        "MySQL Server (user:root password:root)"
    )
    $output += New-MDCode -Lines @(
        "MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'"
    )

    return $output
}

function Build-PostgreSqlSection {
    $output = ""

    $output += New-MDHeader "PostgreSql" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-PostgreSqlVersion ),
        "PostgreSql Server (user:root password:root)"
    )
    $output += New-MDCode -Lines @(@"
        To create the root user and enable the service, use the following commands:
        sudo systemctl start postgresql.service
        echo "create user root password 'root';" > /tmp/create_user.sql
        echo "ALTER ROLE root WITH CREATEDB;" >> /tmp/create_user.sql
        sudo su postgres -c "psql --file=/tmp/create_user.sql"
        sudo su postgres -c "createdb root"
"@
    )

    return $output
}

function Build-MSSQLToolsSection {
    $output = ""

    $output += New-MDHeader "MS SQL Server Client Tools" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-SQLCmdVersion)
    )

    return $output
}
