//////////////////////////////////////////
#define		mysql_host		"35.230.48.193"
#define		mysql_user		"abhaysv_xp"
#define		mysql_pass		"Ipconfigx@123"
#define		mysql_data		"abhaysv_xp"
#define		mysql_port		3306
//////////////////////////////////////////
#define		DEFAULT_OBJECT_MODEL		19475
#define 	INVALID_ITEM_ID		-1
#define 	MAX_ITEMS			50000
//////////////////////////////////////////
new MySQL;

MySQLStartConnection()
{
	MySQL = mysql_connect(mysql_host, mysql_user, mysql_data, mysql_pass);
	if(mysql_errno() == 0) 
	{
		print("MySQL could not connect to database, check your database and configs!");
		return SendRconCommand("exit");
	}
	else print("MySQL connection sucefully executed!");
	return 1;
}

MySQLCloseConnection()
{
	mysql_close();
	return 1;
}
MyDatabaseInit()
{
	mysql_query("CREATE TABLE IF NOT EXISTS playerdata(user VARCHAR(24), password VARCHAR(41), score INT(20), money INT(20), IP VARCHAR(16), adminlevel INT(20), oplevel INT(20), pkills INT(20), pdeaths INT(20), dlevel INT(20), phours INT(20), pminutes INT(20), pseconds INT(20) )");
    mysql_query("CREATE TABLE IF NOT EXISTS bandata(admin VARCHAR(20), player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), banned INT(10))");
    mysql_query("CREATE TABLE IF NOT EXISTS rangeban(admin VARCHAR(20), player VARCHAR(20), reason VARCHAR(50), IP VARCHAR(16), banned INT(10))");
	return 1;
}


