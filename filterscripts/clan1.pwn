#if defined _clan_included
	#endinput
#endif
#define _clan_included

#include <a_mysql>

#define CLANHOST 			"127.0.0.1"
#define CLANUSER	 		"port_4019"
#define CLANPASS		 	"3ibzew7m01"
#define CLANDB				"port_4019"
#define CLAN_PASS_DIALOG	1342
#define MAX_PASS_FAILS		3

const old_weap = -1;
new bool:use_tags, bool:use_pass;
new Warnings[MAX_PLAYERS];


native CreateClan(playerid, clan_name[], clan_tag[], clan_pass[], clan_description[], clan_motd[], weap1, weap2, weap3);
native AddPlayerToClan(playerid, addid);
native RemovePlayerFromClan(playerid, removeid);
native LeaveClan(playerid);
native DisbandClan(playerid);
native ChangePlayerClanRank(playerid, giveid, rank);
native ChangeClanMOTD(playerid, new_motd[]);
native ChangeClanDescription(playerid, new_description[]);
native ChangeClanWeapons(playerid, new_weap1 = old_weap, new_weap2 = old_weap, new_weap3 = old_weap);
native ChangeClanPassword(playerid, new_pass[]);
native ChangeClanTag(playerid, new_tag[]);
native IsPlayerAnyClanMember(playerid);
native IsPlayerClanMember(playerid, clan_name[]);
native GetPlayerClan(playerid);
native GetPlayerClanRank(playerid);
native GetClanMOTD(clan[]);
native GetClanDescription(clan[]);
native GetClanMembers(clan[]);
native GetClanWeapon(clan[], weap_slot);
native GetClanTag(clan[]);
native GetClanPassword(clan[]);
native UseClanTags(bool:use = true);
native UseClanPasswords(bool:use = true);
native SendMessageToClanMembers(playerid, color, msg[]);
native SendMessageToClanMembersEx(clan[], color, msg[]);

forward CLAN_OnFilterScriptInit();
public OnFilterScriptInit()
{
	mysql_connect(CLANHOST,CLANUSER,CLANDB,CLANPASS);
	mysql_debug(1);
    mysql_query("CREATE TABLE IF NOT EXISTS clans(clanname VARCHAR(30), clantag VARCHAR(5), clanpass VARCHAR(10), clandes VARCHAR(100), clanmotd VARCHAR(50), weap1 INT(3), weap2 INT(3), weap3 INT(3))");
	mysql_query("CREATE TABLE IF NOT EXISTS members(clanname VARCHAR(30), playername VARCHAR(30), playerclanrank INT(5), isinclan INT(2))");
	if(funcidx("CLAN_OnFilterScriptInit") != -1) CallLocalFunction("CLAN_OnFilterScriptInit", "");
	return 1;
}
#if defined _ALS_OnFilterScriptInit
        #undef OnFilterScriptInit
#else
        #define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit CLAN_OnFilterScriptInit

forward CLAN_OnPlayerConnect(playerid);
public OnPlayerConnect(playerid)
{
	if(use_tags == true)
	{
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		new n_name[MAX_PLAYER_NAME];
		format(n_name, sizeof(n_name), "[%s] %s", GetClanTag(GetPlayerClan(playerid)), name);
		SetPlayerName(playerid, n_name);
	}

	if(use_pass)
	{
		if(IsPlayerAnyClanMember(playerid) == 1)
		{
			new cname[100];
			format(cname, sizeof(cname), "{FFFFFF}Please enter {FF0000}%s{FFFFFF}'s clan password:", GetPlayerClan(playerid));
			ShowPlayerDialog(playerid, CLAN_PASS_DIALOG, DIALOG_STYLE_INPUT, "{FFFF00}CLAN PASSWORD:", cname, "Proceed", "Quit");
		}
	}
	if(funcidx("CLAN_OnPlayerConnect") != -1) CallLocalFunction("CLAN_OnPlayerConnect", "");
	return 1;
}
#if defined _ALS_OnPlayerConnect
        #undef OnPlayerConnect
#else
        #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect CLAN_OnPlayerConnect

forward CLAN_OnPlayerSpawn(playerid);
public OnPlayerSpawn(playerid)
{
	new clanquery[100];
	new give_weap1[10];
	format(clanquery, sizeof(clanquery), "SELECT weap1 FROM clans WHERE clanname = '%s'", GetPlayerClan(playerid));
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(give_weap1); 
	mysql_free_result();
	
	new clanquery2[100];
	new give_weap2[10];
	format(clanquery2, sizeof(clanquery2), "SELECT weap2 FROM clans WHERE clanname = '%s'", GetPlayerClan(playerid));
	mysql_query(clanquery2);
	mysql_store_result();
	mysql_fetch_row(give_weap2); 
	mysql_free_result();
	
	new clanquery3[100];
	new give_weap3[10];
	format(clanquery3, sizeof(clanquery3), "SELECT weap3 FROM clans WHERE clanname = '%s'", GetPlayerClan(playerid));
	mysql_query(clanquery3);
	mysql_store_result();
	mysql_fetch_row(give_weap3); 
	mysql_free_result();
	
	GivePlayerWeapon(playerid,strval(give_weap1),1000000);
	GivePlayerWeapon(playerid,strval(give_weap2),1000000);
	GivePlayerWeapon(playerid,strval(give_weap3),1000000);
	
	if(funcidx("CLAN_OnPlayerSpawn") != -1) CallLocalFunction("CLAN_OnPlayerSpawn", "d", playerid);
	return 1;
}
#if defined _ALS_OnPlayerSpawn
        #undef OnPlayerSpawn
#else
        #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn CLAN_OnPlayerSpawn

forward CLAN_OnPlayerText(playerid, text[]);
public OnPlayerText(playerid, text[])
{
	if(text[0] == '$')
  	{
  		new str[128], name[24];
		GetPlayerName(playerid, name, 24);
		format(str, 128, "{FF0000}[CLAN CHAT] {03F2FF}%s(%d): {FFFFFF}%s", name, playerid, text[1]);
		SendMessageToClanMembers(playerid, -1,str);
		return 0;
	}	
	if(funcidx("CLAN_OnPlayerText") != -1) CallLocalFunction("CLAN_OnPlayerText", "ds", playerid, text);
	return 1;
}
#if defined _ALS_OnPlayerText
        #undef OnPlayerText
#else
        #define _ALS_OnPlayerText
#endif
#define OnPlayerText CLAN_OnPlayerText

forward CLAN_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid == CLAN_PASS_DIALOG)
	{
	    case 1:
	    {
	 		if(!response)
			{
				Kick(playerid);
			}
	 		else if(response)
		    {
				if(strlen(inputtext) < 3 || strlen(inputtext) > 10)
				{
					new cname[100];
					format(cname, sizeof(cname), "{FF002B}ERROR!\n\n{FFFFFF}Password lenght invalid, please try again:");
					return ShowPlayerDialog(playerid, CLAN_PASS_DIALOG, DIALOG_STYLE_INPUT, "{FFFF00}CLAN PASSWORD:", cname, "Proceed", "Quit");
				}
				else
				{
					if(strcmp(GetClanPassword(GetPlayerClan(playerid)), inputtext, true, 10) == 0)
					{
						SendClientMessage(playerid, -1, "{FFFF00}SERVER: {FFFFFF}Your clan password was {00FF40}valid{FFFFFF}, welcome! :)");
					}
					else
					{
						Warnings[playerid]++;
						new cname[100];
						format(cname, sizeof(cname), "{FF002B}ERROR!\n\n{FFFFFF}Wrong password, please try again:");
						ShowPlayerDialog(playerid, CLAN_PASS_DIALOG, DIALOG_STYLE_INPUT, "{FFFF00}CLAN PASSWORD:", cname, "Proceed", "Quit");

						if(Warnings[playerid] >= MAX_PASS_FAILS)
						{
							SendClientMessage(playerid, -1, "{FFFF00}SERVER: {FFFFFF}You have {FF002B}failed {FFFFFF}to enter correct clan password for too much time! Therefore, you are {FF002B}kicked!");
							SetTimerEx("DELAY_Kick", 250, false, "d", playerid);
						}
					}
				}
			}
		}
	}
	if(funcidx("CLAN_OnDialogResponse") != -1) CallLocalFunction("CLAN_OnDialogResponse", "");
	return 1;
}
#if defined _ALS_OnDialogResponse
        #undef OnDialogResponse
#else
        #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse CLAN_OnDialogResponse

forward DELAY_Kick(playerid);
public DELAY_Kick(playerid)
{
	Kick(playerid);
	return 1;
}

stock CreateClan(playerid, clan_name[], clan_tag[], clan_pass[], clan_description[], clan_motd[], weap1, weap2, weap3)
{
	if(strlen(clan_pass) < 3 || strlen(clan_pass) > 10) return SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}Clan password lenght is {FF0000}invalid{FFFFFF}, please try again!");
	if(IsPlayerAnyClanMember(playerid) == 0)
	{
		CallLocalFunction("OnPlayerClanCreate", "is", playerid, clan_name);
		new clanquery3[100];
		format(clanquery3, sizeof(clanquery3), "SELECT clanname FROM clans WHERE clanname = '%s'", clan_name);
		mysql_query(clanquery3);
		mysql_store_result();
		new rows = mysql_num_rows();
		if(rows >= 1) return SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}Clan with that name already exists!");
		mysql_free_result();
		new clanquery[300];
		format(clanquery,sizeof(clanquery),"INSERT INTO clans(clanname, clantag, clanpass, clandes, clanmotd, weap1, weap2, weap3) VALUES('%s', '%s', '%s', '%s', '%s', %d, %d, %d)", clan_name, clan_tag, clan_pass, clan_description, clan_motd, weap1, weap2, weap3);
		mysql_query(clanquery);
		new player_name[MAX_PLAYER_NAME];
		GetPlayerName(playerid,player_name,sizeof(player_name));
		new clanquery2[300];
		format(clanquery2,sizeof(clanquery2),"INSERT INTO members(clanname, playername, playerclanrank, isinclan) VALUES('%s', '%s', 4, 1)", clan_name, player_name);
		mysql_query(clanquery2);
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		new msg_for_all[100];
		format(msg_for_all,sizeof(msg_for_all),"{03F2FF}CLAN: {00FF40}%s {FFFFFF}have created a clan named {00FF40}%s", name, clan_name);
		SendClientMessageToAll(-1,msg_for_all);
		return 1;
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are already in a clan, you cant create new one!");
	return 1;
}

stock AddPlayerToClan(playerid, addid)
{
	if(GetPlayerClanRank(playerid) >= 2)
	{
		if(!IsPlayerAnyClanMember(addid))
		{
			CallLocalFunction("OnPlayerAddPlayerToClan", "iis", playerid, addid, GetPlayerClan(playerid));
			new player_name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,player_name,sizeof(player_name));
			new add_name[MAX_PLAYER_NAME];
			GetPlayerName(addid,add_name,sizeof(add_name));
			new clanquery[300];
			format(clanquery,sizeof(clanquery),"INSERT INTO members(clanname, playername, playerclanrank, isinclan) VALUES('%s', '%s', 1, 1)", GetPlayerClan(playerid), add_name);
			mysql_query(clanquery);
			new msg_for_all[100];
			format(msg_for_all,sizeof(msg_for_all),"{03F2FF}CLAN: {00FF40}%s {FFFFFF}added {00FF40}%s {FFFFFF}to clan {FFFF00}%s", player_name, add_name, GetPlayerClan(playerid));
			SendClientMessageToAll(-1,msg_for_all);
			return 1;
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}Player is already in a clan!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be an {00FF40}Officer {FFFFFF}or {00FF40}Clan Leader/Subleader {FFFFFF}to add people to clan!");
	return 1;
}

stock RemovePlayerFromClan(playerid, removeid)
{
	if(GetPlayerClanRank(playerid) >= 2)
	{
		if(IsPlayerClanMember(removeid,GetPlayerClan(playerid)))
		{
			CallLocalFunction("OnPlayerRemovePlayerFromClan", "iis", playerid, removeid, GetPlayerClan(playerid));
			new player_name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,player_name,sizeof(player_name));
			new remove_name[MAX_PLAYER_NAME];
			GetPlayerName(removeid,remove_name,sizeof(remove_name));
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "DELETE FROM members WHERE playername = '%s'", remove_name);
			mysql_query(clanquery);
			new msg_for_all[100];
			format(msg_for_all,sizeof(msg_for_all),"{03F2FF}CLAN: {00FF40}%s {FFFFFF}removed {00FF40}%s {FFFFFF}from clan {FFFF00}%s", player_name, remove_name, GetPlayerClan(playerid));
			SendClientMessageToAll(-1,msg_for_all);
			return 1;
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}Player is not in your clan!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be an {00FF40}Officer {FFFFFF}or {00FF40}Clan Leader/Subleader {FFFFFF}to remove people from clan!");
	return 1;
}

stock LeaveClan(playerid)
{
	if(GetPlayerClanRank(playerid) < 4)
	{
		if(IsPlayerAnyClanMember(playerid) == 1)
		{
			CallLocalFunction("OnPlayerLeaveClan", "is", playerid, GetPlayerClan(playerid));
			new leave_name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,leave_name,sizeof(leave_name));
			new msg_for_all[100];
			format(msg_for_all,sizeof(msg_for_all),"{03F2FF}CLAN: {00FF40}%s {FFFFFF}left clan {FFFF00}%s", leave_name, GetPlayerClan(playerid));
			SendClientMessageToAll(-1,msg_for_all);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "DELETE FROM members WHERE playername = '%s'", leave_name);
			mysql_query(clanquery);
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}Leaders can't leave clan! You can disband your clan or assign a new clan leader!");
	return 1;
}

stock DisbandClan(playerid)
{
	if(IsPlayerAnyClanMember(playerid))
	{
		if(GetPlayerClanRank(playerid) >= 4)
		{
			CallLocalFunction("OnPlayerDisbandClan", "is", playerid, GetPlayerClan(playerid));
			new player_name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,player_name,sizeof(player_name));
			new msg_for_all[100];
			format(msg_for_all,sizeof(msg_for_all),"{03F2FF}CLAN: {00FF40}%s {FFFFFF}disbanded clan {00FF40}%s", player_name, GetPlayerClan(playerid));
			SendClientMessageToAll(-1,msg_for_all);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "DELETE FROM clans WHERE clanname = '%s'", GetPlayerClan(playerid));
			mysql_query(clanquery);
			return 1;
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not clan leader!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	return 1;
}

stock ChangePlayerClanRank(playerid, giveid, new_rank)
{
	if(IsPlayerAnyClanMember(playerid) == 1)
	{
		if(GetPlayerClanRank(playerid) >= 2)
		{
			if(IsPlayerClanMember(giveid,GetPlayerClan(playerid)))
			{
				CallLocalFunction("OnPlayerChangePlayerRank", "iii", playerid, giveid, new_rank);
				new player_name[MAX_PLAYER_NAME];
				GetPlayerName(playerid,player_name,sizeof(player_name));
				new give_name[MAX_PLAYER_NAME];
				GetPlayerName(giveid,give_name,sizeof(give_name));
				new clanquery[300];
				format(clanquery, sizeof(clanquery), "UPDATE members SET playerclanrank = %d WHERE playername = '%s'", new_rank, give_name);
				mysql_query(clanquery);
				new msg_for_all[100];
				format(msg_for_all,sizeof(msg_for_all),"{03F2FF}CLAN: {00FF40}%s {FFFFFF}changed rank of clanmate {00FF40}%s {FFFFFF}to rank %d (clan: {00FF40}%s{FFFFFF})", player_name, give_name, new_rank, GetPlayerClan(playerid));
				SendClientMessageToAll(-1,msg_for_all);
			}
			else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}Player is not in your clan!");
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be an {00FF40}Officer {FFFFFF}or {00FF40}Clan Leader/Subleader {FFFFFF}to change members' clan rank!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not part of a clan!");
	return 1;
}

stock ChangeClanMOTD(playerid, new_motd[])
{
	if(IsPlayerAnyClanMember(playerid) == 1)
	{
		if(GetPlayerClanRank(playerid) >= 2)
		{
			CallLocalFunction("OnPlayerChangeClanMOTD", "is", playerid, new_motd);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "UPDATE clans SET clanmotd = '%s' WHERE clanname = '%s'", new_motd, GetPlayerClan(playerid));
			mysql_query(clanquery);
			new msg_for_play[100];
			format(msg_for_play,sizeof(msg_for_play),"{03F2FF}CLAN: {FFFFFF}You changed Message of The Day to {00FF40}%s", new_motd);
			SendClientMessage(playerid,-1,msg_for_play);
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be an {00FF40}Officer {FFFFFF}or {00FF40}Clan Leader/Subleader {FFFFFF}to change clan's MOTD!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	return 1;
}

stock ChangeClanDescription(playerid, new_description[])
{
	if(IsPlayerAnyClanMember(playerid) == 1)
	{
		if(GetPlayerClanRank(playerid) >= 2)
		{
			CallLocalFunction("OnPlayerChangeClanDescription", "is", playerid, new_description);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "UPDATE clans SET clandes = '%s' WHERE clanname = '%s'", new_description, GetPlayerClan(playerid));
			mysql_query(clanquery);
			new msg_for_play[100];
			format(msg_for_play,sizeof(msg_for_play),"{03F2FF}CLAN: {FFFFFF}You changed clan's description to {00FF40}%s", new_description);
			SendClientMessage(playerid,-1,msg_for_play);
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be an {00FF40}Officer {FFFFFF}or {00FF40}Clan Leader/Subleader {FFFFFF}to change clan's description!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	return 1;
}

stock ChangeClanWeapons(playerid, new_weap1 = old_weap, new_weap2 = old_weap, new_weap3 = old_weap)
{
	if(IsPlayerAnyClanMember(playerid) == 1)
	{
		if(GetPlayerClanRank(playerid) >= 2)
		{
			if(new_weap1 == old_weap) new_weap1 = GetClanWeapon(GetPlayerClan(playerid),1);
			if(new_weap2 == old_weap) new_weap2 = GetClanWeapon(GetPlayerClan(playerid),2);
			if(new_weap3 == old_weap) new_weap3 = GetClanWeapon(GetPlayerClan(playerid),3);
			CallLocalFunction("OnPlayerChangeClanWeapons", "iiii", playerid, new_weap1, new_weap2, new_weap3);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "UPDATE clans SET weap1 = %d, weap2 = %d, weap3 = %d WHERE clanname = '%s'", new_weap1, new_weap2, new_weap3, GetPlayerClan(playerid));
			mysql_query(clanquery);
			new msg_for_play[100];
			format(msg_for_play,sizeof(msg_for_play),"{03F2FF}CLAN: {FFFFFF}You changed clan's weapons to {00FF40}%d, %d and %d", new_weap1, new_weap2, new_weap3);
			SendClientMessage(playerid,-1,msg_for_play);
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be an {00FF40}Officer {FFFFFF}or {00FF40}Clan Leader/Subleader {FFFFFF}to change clan's weapons!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	return 1;
}

stock ChangeClanPassword(playerid, new_pass[])
{
	if(IsPlayerAnyClanMember(playerid) == 1)
	{
		if(GetPlayerClanRank(playerid) >= 3)
		{
			CallLocalFunction("OnPlayerChangeClanPassword", "is", playerid, new_pass);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "UPDATE clans SET clanpass = '%s' WHERE clanname = '%s'", new_pass, GetPlayerClan(playerid));
			mysql_query(clanquery);
			new msg_for_play[100];
			format(msg_for_play,sizeof(msg_for_play),"{03F2FF}CLAN: {FFFFFF}You changed clan's password to {00FF40}%s", new_pass);
			SendClientMessage(playerid,-1,msg_for_play);
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be {00FF40}Clan Leader/Subleader {FFFFFF}to change clan's password!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	return 1;
}

stock ChangeClanTag(playerid, new_tag[])
{
	if(IsPlayerAnyClanMember(playerid) == 1)
	{
		if(GetPlayerClanRank(playerid) >= 3)
		{
			CallLocalFunction("OnPlayerChangeClanTag", "is", playerid, new_tag);
			new clanquery[300];
			format(clanquery, sizeof(clanquery), "UPDATE clans SET clantag = '%s' WHERE clanname = '%s'", new_tag, GetPlayerClan(playerid));
			mysql_query(clanquery);
			new msg_for_play[100];
			format(msg_for_play,sizeof(msg_for_play),"{03F2FF}CLAN: {FFFFFF}You changed clan's tag to {00FF40}[%s]", new_tag);
			SendClientMessage(playerid,-1,msg_for_play);
		}
		else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You must be {00FF40}Clan Leader/Subleader {FFFFFF}to change clan's tag!");
	}
	else SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not in a clan!");
	return 1;
}

stock IsPlayerAnyClanMember(playerid)
{
	new player_name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	new clanquery[100];
	format(clanquery, sizeof(clanquery), "SELECT playername FROM members WHERE playername = '%s'", player_name);
	mysql_query(clanquery);
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	if(!rows) return 0;
	else return 1; 
}

stock IsPlayerClanMember(playerid, clan_name[])
{
	new player_name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	new clanquery[100];
	format(clanquery, sizeof(clanquery), "SELECT clanname FROM members WHERE playername = '%s' AND clanname = '%s'", player_name, clan_name);
	mysql_query(clanquery);
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	if(!rows) return 0;
	else return 1; 
}

stock GetPlayerClan(playerid)
{
	new player_name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	new clan_name[100];
	new clanquery[100];
	format(clanquery, sizeof(clanquery), "SELECT clanname FROM members WHERE playername = '%s'", player_name);
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(clan_name); 
	mysql_free_result();
	return clan_name;
}

stock GetPlayerClanRank(playerid)
{
	new player_name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	new rank[10];
	new clanquery[100];
	format(clanquery, sizeof(clanquery), "SELECT playerclanrank FROM members WHERE playername = '%s'", player_name);
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(rank); 
	mysql_free_result();
	return strval(rank);
}

stock GetClanMOTD(clan[])
{
	new clanquery[100];
	new clan_motd[100];
	format(clanquery, sizeof(clanquery), "SELECT clanmotd FROM clans WHERE clanname = '%s'", clan);
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(clan_motd); 
	mysql_free_result();
	return clan_motd;
}

stock GetClanDescription(clan[])
{
	new clanquery[100];
	new clan_desc[100];
	format(clanquery, sizeof(clanquery), "SELECT clandes FROM clans WHERE clanname = '%s'", clan);
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(clan_desc); 
	mysql_free_result();
	return clan_desc;
}

stock GetClanMembers(clan[])
{
	new clanquery[200];
	new minfo[300], mreturn[300];
	new string[300];
	format(clanquery, sizeof(clanquery), "SELECT * FROM members WHERE clanname = '%s'", clan);
	mysql_query(clanquery);
	mysql_store_result();
	while(mysql_fetch_row_format(clanquery,"|"))
	{
		mysql_fetch_field_row(string,"playername"); 
		format(minfo,sizeof(minfo),"%s\n",string);
		strcat(mreturn, minfo);
	}
	mysql_free_result();
	return mreturn;
}

stock GetClanWeapon(clan[], weap_slot)
{
	new clanquery[100];
	new give_weap[10];
	switch(weap_slot)
	{
		case 1:
		{
			format(clanquery, sizeof(clanquery), "SELECT weap1 FROM clans WHERE clanname = '%s'", clan);
			mysql_query(clanquery);
			mysql_store_result();
			mysql_fetch_row(give_weap); 
			mysql_free_result();
		}
		case 2:
		{
			format(clanquery, sizeof(clanquery), "SELECT weap2 FROM clans WHERE clanname = '%s'", clan);
			mysql_query(clanquery);
			mysql_store_result();
			mysql_fetch_row(give_weap); 
			mysql_free_result();
		}
		case 3:
		{
			format(clanquery, sizeof(clanquery), "SELECT weap3 FROM clans WHERE clanname = '%s'", clan);
			mysql_query(clanquery);
			mysql_store_result();
			mysql_fetch_row(give_weap); 
			mysql_free_result();
		}
	}
	return strval(give_weap);
}

stock GetClanTag(clan[])
{
	new clanquery[100];
	new clan_tag[100];
	format(clanquery, sizeof(clanquery), "SELECT clantag FROM clans WHERE clanname = '%s'", clan);
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(clan_tag); 
	mysql_free_result();
	return clan_tag;
}

stock GetClanPassword(clan[])
{
	new clanquery[100];
	new clan_pass[100];
	format(clanquery, sizeof(clanquery), "SELECT clanpass FROM clans WHERE clanname = '%s'", clan);
	mysql_query(clanquery);
	mysql_store_result();
	mysql_fetch_row(clan_pass); 
	mysql_free_result();
	return clan_pass;
}

stock UseClanTags(bool:use = true)
{
	use_tags = use;
	return 1;
}

stock UseClanPasswords(bool:use = true)
{
	use_pass = use;
	return 1;
}

stock SendMessageToClanMembers(playerid, color, msg[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAnyClanMember(playerid) == 1)
		{
			if(IsPlayerConnected(i) == 1)
			{
				if(strcmp(GetPlayerClan(playerid), GetPlayerClan(i), true, 30) == 0)
				{
					SendClientMessage(i, color, msg);
				}
			}
		}
	}
	return 1;
}

stock SendMessageToClanMembersEx(clan[], color, msg[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAnyClanMember(i) == 1)
		{
			if(IsPlayerConnected(i) == 1)
			{
				if(strcmp(clan, GetPlayerClan(i), true, 30) == 0)
				{
					SendClientMessage(i, color, msg);
				}
			}
		}
	}
	return 1;
}

forward OnPlayerClanCreate(playerid, clan_name[]);
forward OnPlayerAddPlayerToClan(playerid, addid, clan_name[]);
forward OnPlayerRemovePlayerFromClan(playerid, removeid, clan_name[]);
forward OnPlayerLeaveClan(playerid, clan_name[]);
forward OnPlayerDisbandClan(playerid, clan_name[]);
forward OnPlayerChangeClanMOTD(playerid, new_motd[]);
forward OnPlayerChangeClanDescription(playerid, new_description[]);
forward OnPlayerChangeClanWeapons(playerid, new_weap1, new_weap2, new_weap3);
forward OnPlayerChangeClanPassword(playerid, new_pass[]);
forward OnPlayerChangeClanTag(playerid, new_tag[]);
forward OnPlayerChangePlayerRank(playerid, giveid, new_rank);
