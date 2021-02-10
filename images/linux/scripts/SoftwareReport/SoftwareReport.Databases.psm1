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

function Build-MySQLSection {
    $output = ""

    $output += New-MDHeader "MySQL" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-MySQLVersion ),
        "MySQL Server (user:root password:root)",
        "MS SQL Server Client Tools"
    )
    $output += New-MDCode -Lines @(
        "MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'"
    )

    return $output
}