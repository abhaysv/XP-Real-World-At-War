#if defined Clan_Info
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
================================================================================|
//Created By Teddy
//Edited by Teddy
//Some help from my brother

|-------------------------------------------------------------------------------
================================================================================
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#endif
//------------------------------------------------------------------------------
//Includes
//------------------------------------------------------------------------------
#include 												     <     a_samp      >
#include 												     <      zcmd	   >
#include 													 <     sscanf2	   >
//------------------------------------------------------------------------------
//Defines
//------------------------------------------------------------------------------
#pragma dynamic 						245000
#pragma tabsize 						0
//------------------------------------------------------------------------------
//Clan Ststem Dialogs
//------------------------------------------------------------------------------
#define MAX_CMembers                    11
#define CreateC_D                       27006
#define WeaponsD1       				27000
#define WeaponsD2       				27001
#define WeaponsD3       				27002
#define WeaponsD4       				27003
#define WeaponsD5       				27004
#define WeaponsD6       				27005
//#define Clan_D          				27006
#define Clan_T          				27007
#define Clan_SkinL          			27008
#define Clan_SkinM          			27009
#define Clan_Colors         			27010
#define Dialog_Invite       			27011
#define Clan_ColorsChange   			27012
#define Clan_DesChange  				27013
#define Clan_MOTDChange     			27014
#define Clan_Settings       			27015
#define Clan_Spawn          			27016
#define Clan_SkinLChange    			27017
#define Clan_SkinMChange    			27018
#define MAX_TOP_LIMIT   				20
#define Nothing 						211
#define red                             0xFF0000AA
#define O                               "{FF9900}"
//------------------------------------------------------------------------------
//Colors
//------------------------------------------------------------------------------
#define COLOR_RED						0xFF000000
#define COLOR_GREEN 					0x00FF0000
#define COLOR_BLUE 						0x0000FF00
#define COLOR_YELLOW 					0xFFFF0000
//------------------------------------------------------------------------------
new Invite[MAX_PLAYERS], 	PlayerInvited, 			ClanInvited, 		CWeapon1[MAX_PLAYERS],
	CWeapon2[MAX_PLAYERS], 	CWeapon3[MAX_PLAYERS], 	CWeapon4[MAX_PLAYERS],
	CWeapon5[MAX_PLAYERS], 	CWeapon6[MAX_PLAYERS];

//------------------------------------------------------------------------------
new DBResult:Result, DB:Database;
//------------------------------------------------------------------------------
new const ClanColors[] =
{
	0x33AA33AA,                                                    //Dark Green
	0xFF9900AA,                                                    //Orange
	0xFF0000FF,                                                    //Red
	0x00000000, 												   //Black
	0xFFFF00AA,                                                    //Yellow
	0x33CCFFAA,                                                    //Light Blue
	0x800080AA,                                                    //Purple
	0xAFAFAFAA,                                                    //Grey
	0x4B00B0AA,                                                    //Dark Blue
	0xFF66FFAA                                                     //Pink
};
//------------------------------------------------------------------------------
//Clan System Forwards
//------------------------------------------------------------------------------
forward OnPlayerClanCreate(playerid, clan_name[]);
forward OnPlayerAddPlayerToClan(playerid, addid, clan_name[]);
forward OnPlayerRemovePlayerFromClan(playerid, removeid, clan_name[]);
forward OnPlayerLeaveClan(playerid, clan_name[]);
forward OnPlayerDisbandClan(playerid, clan_name[]);
forward OnPlayerChangeClanMOTD(playerid, new_motd[]);
forward OnPlayerChangeClanDescription(playerid, new_description[]);
forward OnPlayerChangeClanWeapons(playerid, new_weap1, new_weap2, new_weap3);
forward OnPlayerChangePlayerRank(playerid, giveid, new_rank);
forward OnPlayerBombGate(playerid);
forward OnPlayerPlantBomb(playerid);
forward OnPlayerRepairGate(playerid);
//------------------------------------------------------------------------------
AntiDeAMX0()
{
    new a[][] =
    {
            "Unarmed (Fist)",
            "Brass K"
    };

    #pragma unused a
}
//==============================================================================
public OnFilterScriptInit()
{
	//--------------------------------------------------------------------------
	AntiDeAMX0();
	print("\n");
	print("+=================================+");
	print("+ System Clan Successfully Loaded +");
	print("+=================================+");
	//--------------------------------------------------------------------------
	Database = db_open("CSystem.db");
	//--------------------------------------------------------------------------
    db_query(Database, "CREATE TABLE IF NOT EXISTS clans(`ID` INTEGER PRIMARY KEY AUTOINCREMENT,\
						clanname VARCHAR(30),\
						clantag VARCHAR(5),\
						clanleader VARCHAR(100),\
						clandes VARCHAR(100),\
						clanmotd VARCHAR(50),\
						clankills INT(5),\
						clandeaths INT(5),\
						clancolor VARCHAR(50),\
						clanposx float NOT NULL,\
						clanposy float NOT NULL,\
						clanposz float NOT NULL,\
						lskin INT(3),\
						mskin INT(3),\
						weap1 INT(3),\
						weap2 INT(3),\
						weap3 INT(3),\
						weap4 INT(3),\
						weap5 INT(3),\
						weap6 INT(3))");
	//--------------------------------------------------------------------------
	db_query(Database, "CREATE TABLE IF NOT EXISTS members(`ID` INTEGER PRIMARY KEY AUTOINCREMENT,\
						clanname VARCHAR(30),\
						playername VARCHAR(30),\
						playerclanrank INT(5),\
						isinclan INT(2),\
						IsOnline INT(2))");
	return 1;
}
//==============================================================================
public OnFilterScriptExit()
{
    db_close(Database); 
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	new oquery[100];
	//--------------------------------------------------------------------------
	format(oquery, 100, "UPDATE `members` SET `IsOnline` = '1' WHERE `playername` = '%s'", GetPlayerNameEx(playerid));
	db_query(Database, oquery);
	//--------------------------------------------------------------------------
    Invite[playerid] = 0;
	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid)
{
	new oquery[100];
	//--------------------------------------------------------------------------
	format(oquery, 100, "UPDATE `members` SET `IsOnline` = '0' WHERE `playername` = '%s'", GetPlayerNameEx(playerid));
	db_query(Database, oquery);
	//--------------------------------------------------------------------------
	format(oquery, 100, "UPDATE `clans` SET `clantag` = '%d' WHERE `clanname` = '%s'", GetTotalMembers(GetPlayerClan(playerid)), GetPlayerClan(playerid));
	db_query(Database, oquery);
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
	if(GetPlayerClanRank(playerid) > 3)
	{
		SetPlayerSkin(playerid, GetClanSkinLeader(GetPlayerClan(playerid))); // (Leader Skin)
	}
   	if(GetPlayerClanRank(playerid) == 1 || GetPlayerClanRank(playerid) == 2 || GetPlayerClanRank(playerid) == 3)
 	{
 		SetPlayerSkin(playerid, GetClanSkinMember(GetPlayerClan(playerid))); // (Member Skin)
 	}
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerAnyClanMember(playerid) && IsPlayerAnyClanMember(killerid) && GetPVarInt(playerid, "PlayerInDM") == 0)
	{
	    if(strcmp(GetPlayerClan(playerid), GetPlayerClan(killerid), true, 30) == 0)
	    {
	        return 1;
 		}
 		else
 		{
 		    new CQuery[200];
 		    //------------------------------------------------------------------
			format(CQuery, 200, "UPDATE `clans` SET `clankills` = '%d' WHERE `clanname` = '%s'", GetClanKills(GetPlayerClan(killerid)) + 1, GetPlayerClan(killerid));
  			db_query(Database, CQuery);
  			//------------------------------------------------------------------
			format(CQuery, 200, "UPDATE `clans` SET `clandeaths` = '%d' WHERE `clanname` = '%s'", GetClanDeaths(GetPlayerClan(playerid)) + 1, GetPlayerClan(playerid));
 			db_query(Database, CQuery);
 		}
	}
	return 1;
}
//==============================================================================
//Clan System - Create Clan Dialogs
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//--------------------------------------------------------------------------
	//Create Clan - Dialogs and Steps
	//--------------------------------------------------------------------------
    if(dialogid == CreateC_D)
    {
    	if(response)
        {
            if(strlen(inputtext) < 3 && strlen(inputtext) > 100)  
            {
                SendClientMessage(playerid, red, "ERROR: Numele trebuie sa fie intre 3 si 100 caractere!");
				ShowPlayerDialog(playerid, CreateC_D, DIALOG_STYLE_INPUT, "{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Create Clan", "{FF0000}Hi!\n{FF9900}Follow the next steps to Successfully Create your Own Clan!\n\n{FF0000}1st Step:{FF9900} Please Insert below the name of your clan:","Next","Cancel");
            }
            else if(strlen(inputtext) >= 3 && strlen(inputtext) < 100)
            {
                CreateClan(playerid, inputtext, "", "", "");
            }
        }
    }
    //--------------------------------------------------------------------------
    if(dialogid == Clan_SkinL)
    {
    	if(response)
        {
            new SkinID = strval(inputtext);
            if ((SkinID < 0) || (SkinID > 299) || IsInvalidSkin(SkinID))
            {
      	 		SendClientMessage(playerid, -1, "{FF0000}ERROR: Lider Skin is not valid!");
				ShowPlayerDialog(playerid,Clan_SkinL,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF} - Clan Leader Skin","{FF9900}Sorry but the Clan Skin Leader is {FF0000}invalid{FF9900}!\n\n{FF9900}Please Insert Skin Leader of the Clan","Next","Cancel");
				return 0;
			}
		 	new CQuery[300];
			format(CQuery, sizeof(CQuery), "UPDATE clans SET lskin = %d WHERE clanname = '%s'", SkinID, GetPlayerClan(playerid));
   			db_query( Database, CQuery );
			SetPlayerSkin(playerid,SkinID);
			ShowPlayerDialog(playerid,Clan_SkinM,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF} - Clan Member Skin","{FF9900}Please Insert Member Skin of the Clan","Next","");
        }
        if(!response)
        {
        	//DisbandClan(playerid);
        }
    }
    //--------------------------------------------------------------------------
    if(dialogid == Clan_SkinLChange)
    {
    	if(response)
        {
            new SkinID = strval(inputtext), CQuery[140];
            if(SkinID < 300 && SkinID >= 0)
			{
				format(CQuery, 140, "UPDATE `clans` SET `lskin` = '%d' WHERE `clanname` = '%s'", SkinID, GetPlayerClan(playerid));
   				db_query(Database, CQuery);
			}
			else
			{
  				SendClientMessage(playerid, -1, "{FF0000}ERROR: Member skin is not valid!");
				ShowPlayerDialog(playerid,Clan_SkinMChange,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Member Skin","{FF9900}Sorry but the Clan Skin Member is {FF0000}invalid{FF9900}!\n\n{FF9900}Please Insert Member Skin of the Clan","Next","");
				return 0;
            }
        }
    }
    //--------------------------------------------------------------------------
    if(dialogid == Clan_SkinM)
    {
    	if(response)
        {
            new SkinID = strval(inputtext);
            if ((SkinID < 0) || (SkinID > 299) || IsInvalidSkin(SkinID))
            {
            	SendClientMessage(playerid, -1, "{FF0000}ERROR: Skin-ul membrilor este invalid!");
				ShowPlayerDialog(playerid,Clan_SkinM,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Member Skin","{FF9900}Sorry but the Clan Skin Member is {FF0000}invalid{FF9900}!\n\n{FF9900}Please Insert Member Skin of the Clan","Next","");
				return 0;
            }
 			new CQuery[300];
			format(CQuery, sizeof(CQuery), "UPDATE clans SET mskin = %d WHERE clanname = '%s'", SkinID, GetPlayerClan(playerid));
   			db_query( Database, CQuery );
			ShowPlayerDialog(playerid, Clan_Colors, DIALOG_STYLE_LIST,  "{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Colors", ClanColorsD(), "Select", "");
        }
    }
    //--------------------------------------------------------------------------
    if(dialogid == Clan_SkinMChange)
    {
    	if(response)
        {
            new SkinID = strval(inputtext), CQuery[140];
            if(SkinID < 300 && SkinID >= 0)
			{
				format(CQuery, 140, "UPDATE `clans` SET `mskin` = '%d' WHERE `clanname` = '%s'", SkinID, GetPlayerClan(playerid));
   				db_query(Database, CQuery);
			}
			else
			{
  				SendClientMessage(playerid, -1, "{FF0000}ERROR: Member skin is not valid!");
				ShowPlayerDialog(playerid,Clan_SkinMChange,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Member Skin","{FF9900}Sorry but the Clan Skin Member is {FF0000}invalid{FF9900}!\n\n{FF9900}Please Insert Member Skin of the Clan","Next","");
				return 0;
            }
        }
    }
	//--------------------------------------------------------------------------
	if( dialogid == Clan_Colors )
	{
	    new CQuery[300];
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerColor(playerid, ClanColors[0]);
 				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 0 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 1)
			{
				SetPlayerColor(playerid, ClanColors[1]);
 				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 1 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 2)
			{
				SetPlayerColor(playerid, ClanColors[2]);
 				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 2 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 3)
			{
				SetPlayerColor(playerid, ClanColors[3]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 3 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 4)
			{
				SetPlayerColor(playerid, ClanColors[4]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 4 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 5)
			{
				SetPlayerColor(playerid, ClanColors[5]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 5 WHERE clanname = '%s'", GetPlayerClan(playerid));
				db_query( Database, CQuery );
			}
			if(listitem == 6)
			{
				SetPlayerColor(playerid, ClanColors[6]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 6 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 7)
			{
				SetPlayerColor(playerid, ClanColors[7]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 7 WHERE clanname = '%s'", GetPlayerClan(playerid));
				db_query( Database, CQuery );
			}
			if(listitem == 8)
			{
				SetPlayerColor(playerid, ClanColors[8]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 8 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}

		}
		ShowPlayerDialog( playerid, WeaponsD1, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Weapons Set "O"#1", WeaponsDS1( ), "Select", "");
		return ( 1 );
	}
	//--------------------------------------------------------------------------
	if( dialogid == Clan_ColorsChange )
	{
	    new CQuery[300];
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerColor(playerid, ClanColors[ 0 ]);
 				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 0 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 1)
			{
				SetPlayerColor(playerid, ClanColors[ 1 ]);
 				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 1 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 2)
			{
				SetPlayerColor(playerid, ClanColors[ 2 ]);
 				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 2 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 3)
			{
				SetPlayerColor(playerid, ClanColors[ 3 ]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 3 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 4)
			{
				SetPlayerColor(playerid, ClanColors[ 4 ]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 4 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 5)
			{
				SetPlayerColor(playerid, ClanColors[ 5 ]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 5 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 6)
			{
				SetPlayerColor(playerid, ClanColors[ 6 ]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 6 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 7)
			{
				SetPlayerColor(playerid, ClanColors[ 7 ]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 7 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
			if(listitem == 8)
			{
				SetPlayerColor(playerid, ClanColors[ 8 ]);
				format(CQuery, sizeof(CQuery), "UPDATE clans SET clancolor = 8 WHERE clanname = '%s'", GetPlayerClan(playerid));
   				db_query( Database, CQuery );
			}
		}
		return ( 1 );
	}
	//-------------------------------------------------------------------------
	if( dialogid == WeaponsD1 )
	{
		if(response)
		{
			if(listitem==0)
			{
				GivePlayerWeapon(playerid, 1, 9999);//Brass Knuckles
		    	CWeapon1[playerid] = 1;
			}
			if(listitem==1)
			{
				GivePlayerWeapon(playerid, 2, 9999);//Golf Club
    			CWeapon1[playerid] = 2;
			}
			if(listitem==2)
			{
				GivePlayerWeapon(playerid, 3, 9999);//Nightstick
            	CWeapon1[playerid] = 3;
			}
			if(listitem==3)
			{
				GivePlayerWeapon(playerid, 4, 9999);//Knife
				CWeapon1[playerid] = 4;
			}
			if(listitem==4)
			{
				GivePlayerWeapon(playerid, 5, 9999);//Baseball Bat
  	 			CWeapon1[playerid] = 5;
			}
			if(listitem==5)
			{
				GivePlayerWeapon(playerid, 6, 9999);//Shovel
            	CWeapon1[playerid] = 6;
			}
			if(listitem==6)
			{
				GivePlayerWeapon(playerid, 7, 9999);//Pool Cue
            	CWeapon1[playerid] = 7;
			}
			if(listitem==7)
			{
				GivePlayerWeapon(playerid, 8, 9999);//Katana
            	CWeapon1[playerid] = 8;
			}
			if(listitem==8)
			{
				GivePlayerWeapon(playerid, 9, 9999);//Chainsaw
        	    CWeapon1[playerid] = 9;
			}
		}
     	new CQuery[300];
		format(CQuery, sizeof(CQuery), "UPDATE clans SET weap1 = %d WHERE clanname = '%s'", CWeapon1[playerid], GetPlayerClan(playerid));
  		db_query( Database, CQuery );
		ShowPlayerDialog( playerid, WeaponsD2, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Weapons Set "O"#2", WeaponsDS2( ), "Select", "");
		return ( 1 );
	}
	//--------------------------------------------------------------------------
	if( dialogid == WeaponsD2 )
	{
		if(response)
		{
			if(listitem==0)
			{
				GivePlayerWeapon(playerid, 22, 9999);//9mm
				CWeapon2[playerid] = 22;
			}
			if(listitem==1)
			{
				GivePlayerWeapon(playerid, 23, 9999);//Silenced 9mm
				CWeapon2[playerid] = 23;
			}
			if(listitem==2)
			{
				GivePlayerWeapon(playerid, 24, 9999);//Desert Eagle
				CWeapon2[playerid] = 24;
			}
		}
  		new CQuery[300];
		format(CQuery, sizeof(CQuery), "UPDATE clans SET weap2 = %d WHERE clanname = '%s'", CWeapon2[playerid], GetPlayerClan(playerid));
  		db_query( Database, CQuery );
		ShowPlayerDialog( playerid, WeaponsD3, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Weapons Set "O"#3", WeaponsDS3( ), "Select", "");
	}
	//--------------------------------------------------------------------------
	if( dialogid == WeaponsD3 )
	{
		if(response)
		{
			if(listitem==0)
			{
				GivePlayerWeapon(playerid, 25, 9999);//ShotGun
				CWeapon3[playerid] = 25;
			}
			if(listitem==1)
			{
				GivePlayerWeapon(playerid, 26, 9999);//Sawn-Off-Shotgun
				CWeapon3[playerid] = 26;
			}
			if(listitem==2)
			{
				GivePlayerWeapon(playerid, 27, 9999);//SPAZ-12
				CWeapon3[playerid] = 27;
			}
		}
	  	new CQuery[300];
		format(CQuery, sizeof(CQuery), "UPDATE clans SET weap3 = %d WHERE clanname = '%s'", CWeapon3[playerid], GetPlayerClan(playerid));
		db_query( Database, CQuery );
		ShowPlayerDialog( playerid, WeaponsD4, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Weapons Set "O"#4", WeaponsDS4( ), "Select", "");
	}
	//--------------------------------------------------------------------------
	if(dialogid == WeaponsD4)
	{
		if(response)
		{
			if(listitem == 0)
			{
				GivePlayerWeapon(playerid, 28, 9999);//Micro UZI
				CWeapon4[playerid] = 28;
			}
			if(listitem == 1)
			{
				GivePlayerWeapon(playerid, 29, 9999);//MP5
				CWeapon4[playerid] = 29;
			}
			if(listitem == 2)
			{
				GivePlayerWeapon(playerid, 32, 9999);//TEC-9
				CWeapon4[playerid] = 32;
			}
		}
	  	new CQuery[300];
		format(CQuery, sizeof(CQuery), "UPDATE clans SET weap4 = %d WHERE clanname = '%s'", CWeapon4[playerid], GetPlayerClan(playerid));
  		db_query( Database, CQuery );
		ShowPlayerDialog( playerid, WeaponsD5, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Weapons Set "O"5", WeaponsDS5( ), "Select", "");
	}
	//--------------------------------------------------------------------------
	if( dialogid == WeaponsD5 )
	{
		if(response)
		{
			if(listitem==0)
			{
				GivePlayerWeapon(playerid, 30, 9999);//AK-47
				CWeapon5[playerid] = 30;
			}
			if(listitem==1)
			{
				GivePlayerWeapon(playerid, 31, 9999);//M4-A1
				CWeapon5[playerid] = 31;
			}
		}
	  	new CQuery[300];
		format(CQuery, sizeof(CQuery), "UPDATE clans SET weap5 = %d WHERE clanname = '%s'", CWeapon5[playerid], GetPlayerClan(playerid));
  		db_query( Database, CQuery );
		ShowPlayerDialog( playerid, WeaponsD6, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Weapons Set "O"6", WeaponsDS6( ), "Select", "");
	}
	//--------------------------------------------------------------------------
	if( dialogid == WeaponsD6 )
	{
		if(response)
		{
			if(listitem==0)
			{
				GivePlayerWeapon(playerid, 33, 9999);
				CWeapon6[playerid] = 33;
			}
			if(listitem==1)
			{
				GivePlayerWeapon(playerid, 34, 9999);
				CWeapon6[playerid] = 34;
			}
		}
	  	new CQuery[300];
		format(CQuery, sizeof(CQuery), "UPDATE clans SET weap6 = %d WHERE clanname = '%s'", CWeapon6[playerid], GetPlayerClan(playerid));
  		db_query( Database, CQuery );
	}
	//--------------------------------------------------------------------------
 	if(dialogid == Clan_DesChange)
    {
    	if(response) 
        {
        	ChangeClanDescription(playerid, inputtext);
        }
        if(!response) 
        {
			// Do Something Here
        }
    }
    //--------------------------------------------------------------------------
   	if(dialogid == Clan_MOTDChange)
    {
    	if(response) 
        {
        	ChangeClanMOTD(playerid, inputtext);
        }
        if(!response)
        {
			// Do Something Here
        }

    }
	//--------------------------------------------------------------------------
	if(dialogid == Clan_Spawn)
    {
    	if(response)
        {
           	new CQuery[300], Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
  	    	format(CQuery, sizeof(CQuery), "UPDATE `clans` SET `clanposx` = %f, `clanposy` = %f, `clanposz` = %f WHERE `clanname` = '%s'", X, Y, Z, GetPlayerClan(playerid));
   			db_query( Database, CQuery );
			SendClientMessage(playerid, ~1,"{FF9900}Clan Spawn has been changed!");
        }
        if(!response)
        {
			SendClientMessage(playerid, ~1,"{FF9900}Come back after you find the right spawn place for your clan!");
        }
    }
    //--------------------------------------------------------------------------
   	if(dialogid == Clan_Settings)  
	{
		if(response)
		{
			switch( listitem )
			{
				case 0: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/cweapons" );
				case 1: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/ccolor" );
				case 2: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/setspawn" );
				case 3: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/cstats" );
				case 4: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/cdes" );
				case 5: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/cmotd" );
				case 6: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/cskinl" );
				case 7: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/cskinm" );
			//	case 8: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/clanm" );
			//	case 9: CallRemoteFunction( "OnPlayerCommandText", "is", playerid, "/clans" );
			}

    	}
    	if(!response) // Cancel
		{
		    // Do Something Here
		}
		return ( 1 );
 	}
 	//--------------------------------------------------------------------------
	if( dialogid == Dialog_Invite )
	{
	    if( response ) // Accept
	    {
	    	new string[256];
			if(Invite[playerid] == 0) return SendClientMessage(playerid, ~1,"{FF0000}ERROR: You haven't been invitated by anyone!");
			if(IsPlayerAnyClanMember(playerid)) return SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You are already in a clan!");
			//------------------------------------------------------------------
			format(string, sizeof(string), "{FF0000}%s {FFFF00}has joined our clan!", GetPlayerNameEx(ClanInvited));
			SendMessageToClanMembers(playerid, -1, string);
			//------------------------------------------------------------------
		 	format(string, sizeof(string), "{FF0000}%s {FFFF00}has accepted your {FF0000}Clan Invite{FFFF00}!", GetPlayerNameEx(playerid));
			SendClientMessage(ClanInvited, COLOR_GREEN, string);
			//------------------------------------------------------------------
			format(string, sizeof(string), "{FF0000}%s {FFFF00} welcome to {FF0000}%s {FFFF00}Clan!", GetPlayerNameEx(playerid), GetPlayerClan(ClanInvited));
			SendClientMessage(playerid, COLOR_GREEN, string);
			//------------------------------------------------------------------
		    AddPlayerToClan(ClanInvited, PlayerInvited);
		    Invite[playerid] = 0;
	    }
		if( !response ) // Denny
		{
	        new string[256];
		    if(Invite[playerid] == 0) return SendClientMessage(playerid, ~1,"{FF0000}ERROR: You haven't been invitated by anyone!");
		    format(string, sizeof(string), "{FF0000}%s {FFFF00}has declined your {FF0000}Clan Invite{FFFF00}!", GetPlayerNameEx(playerid));
			SendClientMessage(ClanInvited, COLOR_GREEN, string);
			//------------------------------------------------------------------
		    SendClientMessage(playerid, ~1,"{FFFF00}You have dennyed the clan invite!");
		    Invite[playerid] = 0;
	    }
	}
	return 1;
}
//===============================================================================
//Clan System Commands
//==============================================================================
CMD:addplayer(playerid,params[])
{
	if(IsPlayerAdmin(playerid))
	{
		new target;
 		if(!sscanf(params, "u", target))
  		{
   			AddPlayerToClan(playerid, target);
   			return 1;
		}
	 	else SendClientMessage(playerid,-1,"{FF9900}USAGE: /addplayer [playerid]");
	}
  	return 1;
}
//------------------------------------------------------------------------------
CMD:invite(playerid,params[])
{
	new pID, string[328];
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) < 4) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd!");
	//--------------------------------------------------------------------------
	if(sscanf(params, "u", pID)) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF9900}Usage: /invite [Playerid/Nickname]");
	//--------------------------------------------------------------------------
	if(!IsPlayerConnected(pID)) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: This player isn't connected!");
	//--------------------------------------------------------------------------
	if(IsMySelf(playerid, pID)) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You cannot invite yourself!");
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(pID)) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: This player is already in an Clan!");
	//--------------------------------------------------------------------------
	if(GetTotalMembers(GetPlayerClan(playerid)) == MAX_CMembers) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You can't invite members into your clan because your clan is full!");
	//--------------------------------------------------------------------------
	if(Invite[pID] == 1) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have already invited this player please stand by for input!");
	//--------------------------------------------------------------------------
	Invite[pID] = 1; PlayerInvited = pID; ClanInvited = playerid;
	//--------------------------------------------------------------------------
	format(string, sizeof(string), "{FFFF00}You were invited to join into Clan: {FF0000}%s{FFFF00}!\n{FFFF00}Press {FF0000}Accept{FFFF00}or {FF0000}Denny{FFFF00}!", GetPlayerClan(playerid));
	SendClientMessage(pID, ~1, string);
	ShowPlayerDialog( PlayerInvited, Dialog_Invite, DIALOG_STYLE_MSGBOX,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Join Clan Request", string, "Accept", "Denny");
	format(string, sizeof(string), "{FFFF00}You invited {FF0000}%s {FFFF00}to join your Clan, please wait for the player to {FF0000}Accept {FFFF00}or {FF0000}Denny{FFFF00} your invitation!", GetPlayerNameEx(pID));
	SendClientMessage(playerid, ~1, string);
	ShowPlayerDialog( playerid, 1, DIALOG_STYLE_MSGBOX,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Invitation Send", string, "Close", "");
	return 1;
}
//------------------------------------------------------------------------------
CMD:accept(playerid, params[])
{
	new string[256];
	if(Invite[playerid] == 0) return SendClientMessage(playerid, ~1,"{FF0000}ERROR: You haven't been invitated by anyone!");
	if(IsPlayerAnyClanMember(playerid)) return SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You are already in a clan!");
	//--------------------------------------------------------------------------
	format(string, sizeof(string), "{FF0000}%s {FFFF00}has joined our clan!", GetPlayerNameEx(ClanInvited));
	SendMessageToClanMembers(playerid, -1, string);
	//--------------------------------------------------------------------------
 	format(string, sizeof(string), "{FF0000}%s {FFFF00}has accepted your {FF0000}Clan Invite{FFFF00}!", GetPlayerNameEx(playerid));
	SendClientMessage(ClanInvited, COLOR_GREEN, string);
	//--------------------------------------------------------------------------
	format(string, sizeof(string), "{FF0000}%s {FFFF00}welcome to {FF0000}%s{FFFF00} Clan!", GetPlayerNameEx(playerid), GetPlayerClan(ClanInvited));
	SendClientMessage(playerid, COLOR_GREEN, string);
	//--------------------------------------------------------------------------
    AddPlayerToClan(ClanInvited, PlayerInvited);
    Invite[playerid] = 0;
 	return 1;
}
//------------------------------------------------------------------------------
CMD:denny(playerid, params[])
{
    new string[256];
    if(Invite[playerid] == 0) return SendClientMessage(playerid, ~1,"{FF0000}ERROR: You haven't been invitated by anyone!");
    format(string, sizeof(string), "{FF0000}%s {FFFF00}has declined your {FF0000}Clan Invite{FFFF00}!", GetPlayerNameEx(playerid));
	SendClientMessage(ClanInvited, COLOR_GREEN, string);
	//--------------------------------------------------------------------------
    SendClientMessage(playerid, ~1,"{FF0000}You have dennyed the clan invite!");
    Invite[playerid] = 0;
	return 1;
}
//------------------------------------------------------------------------------
CMD:mkick(playerid,params[])
{
     new target;
     if(!sscanf(params, "u", target))
     {
		  RemovePlayerFromClan(playerid, target);
          return ( 1 );
     }
     else SendClientMessage(playerid,-1,"{FF9900}Usage: /mkick [playerid]");
     return 1;
}
//------------------------------------------------------------------------------
CMD:csrank(playerid,params[])
{
	new target, crank;
 	//--------------------------------------------------------------------------
  	if(sscanf(params, "ui", target, crank)) return
 	SendClientMessage(playerid, -1, "{FF9900}Usage: /csrank [PlayerID] [Rank]");
  	//--------------------------------------------------------------------------
 	if(crank < 0 || crank > 4) return
 	SendClientMessage(playerid, -1,"{FF0000}ERROR: Invalid Clan Rank (1-4)!");
 	//--------------------------------------------------------------------------
	if(target == playerid) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You can't change your Clan Rank" );
 	//--------------------------------------------------------------------------
	else
	{
		ChangePlayerClanRank(playerid, target, crank);
	}
     return 1;
}
//------------------------------------------------------------------------------
CMD:lclan(playerid,params[])
{
     return LeaveClan(playerid);
}
//------------------------------------------------------------------------------
CMD:dclan(playerid,params[])
{
     return DisbandClan(playerid);
}
//------------------------------------------------------------------------------
CMD:cweapons(playerid, params[])
{
	if(GetPlayerClanRank(playerid) < 4) return SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd!");
	ShowPlayerDialog( playerid, WeaponsD1, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}Weapons Set {FF9900}1", WeaponsDS1( ), "Select", "");
	return 1;
}
//------------------------------------------------------------------------------
CMD:ccolor(playerid, params[])
{
	if(GetPlayerClanRank(playerid) < 4) return SendClientMessage(playerid, COLOR_YELLOW, "You have to be Clan Leader to use this comamnd.");
	ShowPlayerDialog(playerid, Clan_ColorsChange, DIALOG_STYLE_LIST,  "Clan Colors", ClanColorsD( ), "(Change)", "");
	return 1;
}
//------------------------------------------------------------------------------
CMD:cskinl(playerid, params[])
{
	if(GetPlayerClanRank(playerid) < 4) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd!");
	ShowPlayerDialog(playerid,Clan_SkinLChange,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Leader Skin Change","{FF9900}Please Insert Leader Skin of the Clan","Change","");
	return 1;
}
//------------------------------------------------------------------------------
CMD:cskinm(playerid, params[])
{
	if(GetPlayerClanRank(playerid) < 4) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd.");
	ShowPlayerDialog(playerid,Clan_SkinMChange,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Member Skin Change","{FF9900}Please Insert Member Skin of the Clan","Change","");
	return 1;
}
//------------------------------------------------------------------------------
CMD:cdes(playerid, params[])
{
    if(GetPlayerClanRank(playerid) < 4) return SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd!");
	ShowPlayerDialog(playerid,Clan_DesChange,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Description","{FF9900}Insert here the new description of your {FF0000}Clan","Change","Cancel");
	return 1;
}
//------------------------------------------------------------------------------
CMD:cmotd(playerid, params[])
{
    if(GetPlayerClanRank(playerid) < 4) return SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd!");
	ShowPlayerDialog(playerid,Clan_MOTDChange,DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan MOTD","{FF9900}Insert here the new {FF0000}\"Message Of The Day\"{FF9900} of your Clan","Change","Cancel");
	return 1;
}
//------------------------------------------------------------------------------
CMD:createclan(playerid, params[])
{
	if(IsPlayerAnyClanMember(playerid)) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are already in a clan, you cant create new one!");
	//--------------------------------------------------------------------------
	else
	{
		ShowPlayerDialog(playerid, CreateC_D, DIALOG_STYLE_INPUT, "{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Create Clan", "{FF0000}Hi!\n{FF9900}Follow the next steps to Successfully Create your Own Clan!\n\n{FF0000}1st Step:{FF9900} Please Insert below the name of your clan:","Next","Cancel");
	}
	return 1;
}
//------------------------------------------------------------------------------
CMD:setspawn(playerid, params[])
{
	//--------------------------------------------------------------------------
    if(GetPlayerClanRank(playerid) < 4) return
	SendClientMessage(playerid, COLOR_YELLOW, "{FF0000}ERROR: You have to be Clan Leader to use this comamnd!");
	//--------------------------------------------------------------------------
	ShowPlayerDialog( playerid, Clan_Spawn, DIALOG_STYLE_MSGBOX,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Set Clan Spawn Place", "{FF9900}You can set your Clan Spawn Place after your current position!\n{FF9900}If is not the right spawn place press \"{FF0000}No{FF9900}\" and if you are sure press \"{FF0000}Yes{FF9900}\"", "Yes", "No");
	return 1;
}
//------------------------------------------------------------------------------
CMD:chelp(playerid, params[]) return cmd_clanhelp(playerid, params);
//------------------------------------------------------------------------------
CMD:clanhelp(playerid, params[]) return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Help Section", ClanHelpD(), "Ok", "");
//------------------------------------------------------------------------------
CMD:ctop(playerid, params[]) return ShowTopClan(playerid, "clankills", "ClanKills");
//------------------------------------------------------------------------------
//CMD:clanm(playerid, params[]) return ShowPlayerDialog(playerid, 123, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Members", GetClanMembers(GetPlayerClan(playerid)), "Ok", "");
//------------------------------------------------------------------------------
//CMD:clans(playerid, params[]) return ShowPlayerDialog(playerid, 123, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- All Clans", GetAllClans(), "Ok", "");
//------------------------------------------------------------------------------
CMD:csettings(playerid, params[]) return ShowPlayerDialog(playerid, Clan_Settings, DIALOG_STYLE_LIST,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Settings", ClanSettingsD(), "Select", "Close");
//------------------------------------------------------------------------------
CMD:cstats(playerid, params[])
{
	//--------------------------------------------------------------------------
	new csid;
	//--------------------------------------------------------------------------
	if(!sscanf(params, "u", csid))
	{
	    if(IsPlayerConnected(csid))
	    {
	    	ShowPlayerDialog(playerid, 123, DIALOG_STYLE_MSGBOX, "{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Stats", ShowCStats(csid), "Ok", "");
	    }
	    else return SendClientMessage(playerid, 0xFF0000AA, "ERROR: Player not connected!");
	}
	else
	{
	    ShowPlayerDialog(playerid, 123, DIALOG_STYLE_MSGBOX, "{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Clan Stats", ShowCStats(playerid), "Ok", "");
	}
	return 1;
}
//==============================================================================
//Clan System Functions
//==============================================================================
stock ClanHelpD()
{
	new ClanHelpDS[2024];
	ClanHelpDS[0]='\0';
	//--------------------------------------------------------------------------
 	strcat(ClanHelpDS,"{FF0000}Clan Member Commands:\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/createclan {00BBF6}-> To Create your own Clan!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/accept {00BBF6}-> To accept someone invitation to join his Clan\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/denny {00BBF6}-> To Denny someone invitation to join his Clan!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/clanm {00BBF6}-> To see all the members from the Clan!\n");
//    strcat(ClanHelpDS,"{FF0000}• {FF9900}/clans {00BBF6}-> To see all Clans from the server\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/lclan {00BBF6}-> To leave your curent clan\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/ctop {00BBF6}-> To see Top Clan from this server!\n\n");
    strcat(ClanHelpDS,"{FF0000}Clan Leader Commands:\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/invite {00BBF6}-> To invite someone in your Clan!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/csrank {00BBF6}-> To change the rank of a Member\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/mkick {00BBF6}-> If you want to kick someone from your clan!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/cweapons {00BBF6}-> To change the Clan Weapons Set!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/ccolor {00BBF6}-> To change the Color of your Clan!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/cmotd {00BBF6}-> To change Message Of The Day for your clan!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/cdes {00BBF6}-> To add a Description to your Clan\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/cskinl {00BBF6}-> To change the skin of Clan Leader\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/cskinm {00BBF6}-> To change the skin of Clan Members\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/setspawn {00BBF6}-> To set the Spawn Place for your Members!\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/csettings {00BBF6}-> To open Settings Dialog!\t\n");
    strcat(ClanHelpDS,"{FF0000}• {FF9900}/dclan {00BBF6}-> Only if you are The Clan Leader (Rank 4) to delete your Clan!\n\n");
    strcat(ClanHelpDS,"{FF9900}Use {FF0000}\"!\"{FF9900} to talk in {FF0000}Clan Chat{FF9900}!");
    //--------------------------------------------------------------------------
	return ClanHelpDS;
}
//------------------------------------------------------------------------------
stock ShowCStats(playerid)
{
	//--------------------------------------------------------------------------
	new csstr1[120], csstr2[120], csstr3[120], csstr4[120], csstr5[120], csstr6[120],
	    csstr7[120], csstr8[120], csstr9[120], csstr10[120],csstr0[1200];
	//--------------------------------------------------------------------------
	format(csstr1, 120, "{FF0000}%s's {FF9900}Stats\n\n", GetPlayerNameEx(playerid));
	strcat(csstr2, 		"{FF0000}Clan Stats:\n");
	format(csstr3, 120, "{FF0000}• {FF9900}Clan Name: {00BBF6}%s\n", GetPlayerClan(playerid));
	format(csstr4, 120, "{FF0000}• {FF9900}Clan Creator: {00BBF6}%s\n", GetClanLeader(GetPlayerClan(playerid)));
	format(csstr5, 120, "{FF0000}• {FF9900}Clan Kills: {00BBF6}%d\n", GetClanKills(GetPlayerClan(playerid)));
	format(csstr6, 120, "{FF0000}• {FF9900}Clan Deaths: {00BBF6}%d\n", GetClanDeaths(GetPlayerClan(playerid)));
	format(csstr7, 120, "{FF0000}• {FF9900}Clan Description: {00BBF6}%s\n", GetClanDescription(GetPlayerClan(playerid)));
	format(csstr8, 120, "{FF0000}• {FF9900}Clan MOTD: {00BBF6}%s\n", GetClanMOTD(GetPlayerClan(playerid)));
	format(csstr9, 120, "{FF0000}• {FF9900}Total Clan Members: {00BBF6}%d\n", GetTotalMembers(GetPlayerClan(playerid)));
	format(csstr10,120, "{FF0000}• {FF9900}Player Clan Rank: {00BBF6}%d", GetPlayerClanRank(playerid));
	format(csstr0, 1200,"%s%s%s%s%s%s%s%s%s%s", csstr1, csstr2, csstr3, csstr4, csstr5, csstr6, csstr7, csstr8, csstr9, csstr10);
	//--------------------------------------------------------------------------
	return csstr0;

}
//------------------------------------------------------------------------------
ClanColorsD()
{
	new ClanColorsDS[1024];
	ClanColorsDS[0]='\0';
	//--------------------------------------------------------------------------
	strcat(ClanColorsDS,"{FF9900}Light Green\n");
	strcat(ClanColorsDS,"{FF9900}Orange\n");
	strcat(ClanColorsDS,"{FF9900}Red\n");
	strcat(ClanColorsDS,"{FF9900}Black\n");
	strcat(ClanColorsDS,"{FF9900}Yellow\n");
	strcat(ClanColorsDS,"{FF9900}Blue\n");
	strcat(ClanColorsDS,"{FF9900}Purple\n");
	strcat(ClanColorsDS,"{FF9900}Grey\n");
	//--------------------------------------------------------------------------
	return ClanColorsDS;
}
//------------------------------------------------------------------------------
ClanSettingsD()
{
	new ClanSettingsDS [1024];
	ClanSettingsDS[0]='\0';
	//--------------------------------------------------------------------------
	strcat(ClanSettingsDS,"{FF9900}Clan Weapons\t\t {FF0000}/cweapons\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Color\t\t {FF0000}/ccolor\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Spawn\t\t {FF0000}/setspawn\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Stats\t\t {FF0000}/cstats\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Help\t\t {FF0000}/chelp\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Description\t {FF0000}/cdes\n");
	strcat(ClanSettingsDS,"{FF9900}Clan MOTD\t\t {FF0000}/cmotd\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Leader Skin\t {FF0000}/cskinl\n");
	strcat(ClanSettingsDS,"{FF9900}Clan Member Skin\t {FF0000}/cskinm)\n");
//	strcat(ClanSettingsDS,"{FF9900}Clan Members\t\t {FF0000}/clanm)\n");
//	strcat(ClanSettingsDS,"{FF9900}All Clans\t\t {FF0000}/clans)\n");
	//--------------------------------------------------------------------------
	return ClanSettingsDS;
}
//------------------------------------------------------------------------------
WeaponsDS1()
{
	new WeaponsDSS1[1024];
	WeaponsDSS1[0]='\0';
	//--------------------------------------------------------------------------
	strcat(WeaponsDSS1,"{FF9900}Brass Knuckles\n");
	strcat(WeaponsDSS1,"{FF9900}Golf Club\n");
	strcat(WeaponsDSS1,"{FF9900}Nightstick\n");
	strcat(WeaponsDSS1,"{FF9900}Knife\n");
	strcat(WeaponsDSS1,"{FF9900}Baseball Bat\n");
	strcat(WeaponsDSS1,"{FF9900}Shovel\n");
	strcat(WeaponsDSS1,"{FF9900}Pool Cue\n");
	strcat(WeaponsDSS1,"{FF9900}Katana\n");
	strcat(WeaponsDSS1,"{FF9900}Chainsaw\n");
	//--------------------------------------------------------------------------
	return WeaponsDSS1;
}
//------------------------------------------------------------------------------
WeaponsDS2()
{
	new WeaponsDSS2[512];
	WeaponsDSS2[0]='\0';
	//--------------------------------------------------------------------------
	strcat(WeaponsDSS2,"{FF9900}Pistol\n");
	strcat(WeaponsDSS2,"{FF9900}Silenced Pistol\n");
	strcat(WeaponsDSS2,"{FF9900}Desert Eagle\n");
	//--------------------------------------------------------------------------
	return WeaponsDSS2;
}
//------------------------------------------------------------------------------
WeaponsDS3()
{
	new WeaponsDSS3[512];
	WeaponsDSS3[0]='\0';
	//--------------------------------------------------------------------------
	strcat(WeaponsDSS3,"{FF9900}ShotGun\n");
	strcat(WeaponsDSS3,"{FF9900}Sawn-Off-Shotgune\n");
	strcat(WeaponsDSS3,"{FF9900}SPAZ-12\n");
	//--------------------------------------------------------------------------
	return WeaponsDSS3;
}
//------------------------------------------------------------------------------
WeaponsDS4()
{
	new WeaponsDSS4[512];
	WeaponsDSS4[0]='\0';
	//--------------------------------------------------------------------------
	strcat(WeaponsDSS4,"{FF9900}Micro UZI\n");
	strcat(WeaponsDSS4,"{FF9900}MP5\n");
	strcat(WeaponsDSS4,"{FF9900}TEC-9\n");
	//--------------------------------------------------------------------------
	return WeaponsDSS4;
}
//------------------------------------------------------------------------------
WeaponsDS5()
{
	new WeaponsDSS5[256];
	WeaponsDSS5[0]='\0';
	//--------------------------------------------------------------------------
	strcat(WeaponsDSS5,"{FF9900}AK-47\n");
	strcat(WeaponsDSS5,"{FF9900}M4-A1\n");
	//--------------------------------------------------------------------------
	return WeaponsDSS5;
}
//------------------------------------------------------------------------------
WeaponsDS6()
{
	new WeaponsDSS6[256];
	//--------------------------------------------------------------------------
	WeaponsDSS6[0]='\0';
	strcat(WeaponsDSS6,"{FF9900}Country Rifle\n");
	strcat(WeaponsDSS6,"{FF9900}Sniper Rifle\n");
	//--------------------------------------------------------------------------
	return WeaponsDSS6;
}
//------------------------------------------------------------------------------
IsInvalidSkin(SkinID)
{
    #define MAX_BAD_SKINS 22
    new InSkin[MAX_BAD_SKINS] = { 8, 42, 65, 74, 86, 149, 208,};
    for(new i = 0; i < MAX_BAD_SKINS; i++)
	{
    	if (SkinID == InSkin[i])
		return true;
	}
    return 0;
}
//------------------------------------------------------------------------------
stock GetPlayerNameEx(playerid)
{
	new pName[25];
	GetPlayerName(playerid, pName, 25);
	return pName;
}
//------------------------------------------------------------------------------
stock IsMySelf(pID, oID)
{
	if(pID == oID) return 1;
	return 0;
}
//------------------------------------------------------------------------------
stock AddPlayerToClan(playerid, addid)
{
    new player_name[MAX_PLAYER_NAME], add_name[MAX_PLAYER_NAME], CQuery[300];
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) < 3) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You must be Rank 3 Member or Clan Leader/Subleader to add people to clan!");
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(addid)) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: Player is already in a clan!");
	//--------------------------------------------------------------------------
	CallLocalFunction("OnPlayerAddPlayerToClan", "iis", playerid, addid, GetPlayerClan(playerid));
	GetPlayerName(playerid,player_name,sizeof(player_name));
	GetPlayerName(addid,add_name,sizeof(add_name));
	format(CQuery,sizeof(CQuery),"INSERT INTO `members`(`clanname`, `playername`, `playerclanrank`, `isinclan`, `IsOnline`) VALUES('%s', '%s', 1, 1, 1)", GetPlayerClan(playerid), add_name);
	db_query( Database, CQuery );
	SpawnPlayer(PlayerInvited);
	return 1;
}
//------------------------------------------------------------------------------
stock RemovePlayerFromClan(playerid, removeid)
{
	new player_name[MAX_PLAYER_NAME], remove_name[MAX_PLAYER_NAME],
	    CQuery[300], string[128];
	//--------------------------------------------------------------------------
    if(GetPlayerClanRank(playerid) < 3) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You must be Rank 3 Member or Clan Leader/Subleader to remove people from clan!");
	//--------------------------------------------------------------------------
	if(!IsPlayerClanMember(removeid,GetPlayerClan(playerid))) return SendClientMessage(playerid,-1,"{FF0000}ERROR: Player is not in your clan!");
	CallLocalFunction("OnPlayerRemovePlayerFromClan", "iis", playerid, removeid, GetPlayerClan(playerid));
	GetPlayerName(playerid,player_name,sizeof(player_name));
	GetPlayerName(removeid,remove_name,sizeof(remove_name));
	format(CQuery, sizeof(CQuery), "DELETE FROM members WHERE playername = '%s'", remove_name);
 	db_query( Database, CQuery );
 	//--------------------------------------------------------------------------
	format(string, sizeof(string), "{FF0000}%s {FFFF00}has kicked {FF0000}%s{FFFF00} from our clan!", player_name, remove_name);
	SendMessageToClanMembers(playerid, -1, string);
	//--------------------------------------------------------------------------
	return 1;
}
//------------------------------------------------------------------------------
stock LeaveClan(playerid)
{
    new leave_name[MAX_PLAYER_NAME], CQuery[300], string[128];
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) > 3) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: Leaders can't leave clan! You can Delete your clan (/dclan) or assign a new clan leader!");
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) == 0) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are not in a clan!");
	//--------------------------------------------------------------------------
	CallLocalFunction("OnPlayerLeaveClan", "is", playerid, GetPlayerClan(playerid));
	GetPlayerName(playerid,leave_name,sizeof(leave_name));
	SendClientMessage(playerid, -1, "{FF0000}You have succesfully left the clan!");
	format(CQuery, sizeof(CQuery), "DELETE FROM members WHERE playername = '%s'", leave_name);
	db_query( Database, CQuery );
	//--------------------------------------------------------------------------
	format(string, sizeof(string), "{FF0000}%s {FFFF00}has left our clan!", leave_name);
	SendMessageToClanMembers(playerid, -1, string);
	//--------------------------------------------------------------------------
	return 1;
}
//------------------------------------------------------------------------------
stock DisbandClan(playerid)
{
    new CQuery[300], player_name[MAX_PLAYER_NAME], string[128];
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) == 0) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are not in a clan!");
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) < 4) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are not the main Leader of this Clan!");
	//--------------------------------------------------------------------------
	CallLocalFunction("OnPlayerDisbandClan", "is", playerid, GetPlayerClan(playerid));
	GetPlayerName(playerid,player_name,sizeof(player_name));
	//--------------------------------------------------------------------------
	format(string, sizeof(string), "{FF0000}%s {FFFF00}has deleted clan: {FF0000}%s!", player_name, GetPlayerClan(playerid));
	SendMessageToClanMembers(playerid, -1, string);
	//--------------------------------------------------------------------------
	SendClientMessage(playerid, -1, "{FF0000}You have succesfully disbanded the clan!");
	format(CQuery, sizeof(CQuery), "DELETE FROM clans WHERE clanname = '%s'", GetPlayerClan(playerid));
	db_query( Database, CQuery );
	format(CQuery, sizeof(CQuery), "DELETE FROM members WHERE playername = '%s'", player_name);
	db_query( Database, CQuery );
	return 1;
}
//------------------------------------------------------------------------------
stock ChangePlayerClanRank(playerid, giveid, new_rank)
{
	//--------------------------------------------------------------------------
    new player_name[MAX_PLAYER_NAME], give_name[MAX_PLAYER_NAME],
		CQuery[300], string[128];
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) == 0) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: {FFFFFF}You are not part of a clan!");
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) < 3) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You must be Rank 3 Member or Clan Leader/Subleader to change members' clan rank!");
	//--------------------------------------------------------------------------
	if(IsPlayerClanMember(giveid, GetPlayerClan(playerid)))
	{
		//----------------------------------------------------------------------
		CallLocalFunction("OnPlayerChangePlayerRank", "iii", playerid, giveid, new_rank);
		GetPlayerName(playerid,player_name,sizeof(player_name));
		GetPlayerName(giveid,give_name,sizeof(give_name));
		format(CQuery, sizeof(CQuery), "UPDATE `members` SET `playerclanrank` = %d WHERE `playername` = '%s'", new_rank, give_name);
		db_query(Database, CQuery );
		//----------------------------------------------------------------------
		format(string, sizeof(string), "{FF0000}%s {FFFF00}has recieved {FF0000}Clan Rank: %d{FFFF00} from {FF0000}%s{FFFF00}!", give_name, new_rank, player_name);
		SendMessageToClanMembers(playerid, -1, string);
		//----------------------------------------------------------------------
		if(GetPlayerClanRank(playerid) == 4) return SetPlayerSkin(playerid, GetClanSkinLeader(GetPlayerClan(playerid)));
		return 1;
	}
	else return SendClientMessage(playerid, -1, "{FF0000}ERROR: The Specified player is not in our clan!");
}
//------------------------------------------------------------------------------
stock ChangeClanMOTD(playerid, new_motd[])
{
    new CQuery[300];
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) == 0) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are not in a clan!");
	//--------------------------------------------------------------------------
	CallLocalFunction("OnPlayerChangeClanMOTD", "is", playerid, new_motd);
	format(CQuery, sizeof(CQuery), "UPDATE clans SET clanmotd = '%s' WHERE clanname = '%s'", new_motd, GetPlayerClan(playerid));
	db_query( Database, CQuery );
	SendClientMessage(playerid, -1, "{FF9900}You have succesfully changed the MOTD!");
	return 1;
}
//------------------------------------------------------------------------------
stock ChangeClanDescription(playerid, new_description[])
{
    new CQuery[300];
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) == 0) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are not in a clan!");
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) < 3) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You must be Rank 3 Member Clan Leader/Subleader to change clan's description!");
	//--------------------------------------------------------------------------
	CallLocalFunction("OnPlayerChangeClanDescription", "is", playerid, new_description);
	format(CQuery, sizeof(CQuery), "UPDATE clans SET clandes = '%s' WHERE clanname = '%s'", new_description, GetPlayerClan(playerid));
	db_query( Database, CQuery );
	SendClientMessage(playerid, -1, "{FF9900}You have succesfully clan description!");
	return 1;
}
//------------------------------------------------------------------------------
stock ChangeClanWeapons(playerid, new_weap1, new_weap2, new_weap3)
{
    new CQuery[300];
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) == 0) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You are not in a clan!");
	//--------------------------------------------------------------------------
	if(GetPlayerClanRank(playerid) < 3) return
	SendClientMessage(playerid,-1,"{FF0000}ERROR: You must be Rank 3 Member or Clan Leader/Subleader to change clan's weapons!");
	//--------------------------------------------------------------------------
	CallLocalFunction("OnPlayerChangeClanWeapons", "iiii", playerid, new_weap1, new_weap2, new_weap3);
	format(CQuery, sizeof(CQuery), "UPDATE `clans` SET `weap1` = '%d', `weap2` = '%d', `weap3` = '%d' WHERE clanname = '%s'", new_weap1, new_weap2, new_weap3, GetPlayerClan(playerid));
	db_query( Database, CQuery );
	SendClientMessage(playerid, -1, "{FF9900}You have succesfully updated Clan Settings!");
	return 1;
}
//------------------------------------------------------------------------------
stock GetTotalMembers(clan[])
{
	new CQuery[100];
	format(CQuery, sizeof(CQuery), "SELECT * FROM `members` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	new rows = db_num_rows(Result);
	db_free_result(Result);
	return rows;
}
//------------------------------------------------------------------------------
stock IsPlayerAnyClanMember(playerid)
{
	new player_name[MAX_PLAYER_NAME], CQuery[100];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	format(CQuery, sizeof(CQuery), "SELECT `playername` FROM `members` WHERE `playername` = '%s'", player_name);
	Result = db_query( Database, CQuery );
	new rows = db_num_rows( Result );
	db_free_result( Result );
	if(!rows) return 0;
	else return 1;
}
//------------------------------------------------------------------------------
stock IsPlayerClanMember(playerid, clan_name[])
{
	new player_name[MAX_PLAYER_NAME], CQuery[100];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	format(CQuery, sizeof(CQuery), "SELECT `clanname` FROM `members` WHERE `playername` = '%s' AND `clanname` = '%s'", player_name, clan_name);
 	Result = db_query( Database, CQuery );
	new rows = db_num_rows( Result );
	db_free_result(Result);
	if(!rows) return 0;
	else return 1;
}
//------------------------------------------------------------------------------
stock GetPlayerClan(playerid)
{
	new player_name[MAX_PLAYER_NAME], CQuery[100], Field[30];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	format(CQuery, sizeof(CQuery), "SELECT `clanname` FROM `members` WHERE `playername` = '%s'", player_name);
	Result = db_query(Database, CQuery);
	db_get_field_assoc( Result, "clanname", Field, 30 );
	db_free_result(Result);
	return Field;
}
//------------------------------------------------------------------------------
stock GetClanLeader(clan_name[])
{
	new CQuery[100], Field[30];
	format(CQuery, sizeof(CQuery), "SELECT `clanleader` FROM `clans` WHERE `clanname` = '%s'", clan_name);
	Result = db_query(Database, CQuery);
	db_get_field_assoc( Result, "clanleader", Field, 30 );
	db_free_result(Result);
	return Field;
}
//------------------------------------------------------------------------------
stock GetPlayerClanRank(playerid)
{
	new player_name[MAX_PLAYER_NAME], rank[10], CQuery[100];
	GetPlayerName(playerid,player_name,sizeof(player_name));
	format(CQuery, sizeof(CQuery), "SELECT `playerclanrank` FROM `members` WHERE `playername` = '%s'", player_name);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "playerclanrank", rank, 30 );
	db_free_result(Result);
	return strval(rank);
}
//------------------------------------------------------------------------------
stock GetClanMOTD(clan[])
{
	new CQuery[100], clan_motd[100];
	format(CQuery, sizeof(CQuery), "SELECT `clanmotd` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clanmotd", clan_motd, 30 );
	db_free_result(Result);
	return clan_motd;
}
//------------------------------------------------------------------------------
stock GetClanKills(clan[])
{
	new CQuery[100], clan_kills[100];
	format(CQuery, sizeof(CQuery), "SELECT `clankills` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clankills", clan_kills, 30 );
	db_free_result(Result);
	return strval(clan_kills);
}
//------------------------------------------------------------------------------
stock GetClanDeaths(clan[])
{
	new CQuery[100], clan_deaths[100];
	format(CQuery, sizeof(CQuery), "SELECT `clandeaths` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clandeaths", clan_deaths, 30 );
	db_free_result(Result);
	return strval(clan_deaths);
}
//------------------------------------------------------------------------------
stock GetClanWeapon1(clan[])
{
	new CQuery[100], clan_weap[100];
	format(CQuery, sizeof(CQuery), "SELECT `weap1` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "weap1", clan_weap, 30 );
	db_free_result(Result);
	return strval(clan_weap);
}
//------------------------------------------------------------------------------
stock GetClanWeapon2(clan[])
{
	new CQuery[100], clan_weap[100];
	format(CQuery, sizeof(CQuery), "SELECT `weap2` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "weap2", clan_weap, 30 );
	db_free_result(Result);
	return strval(clan_weap);
}
//------------------------------------------------------------------------------
stock GetClanWeapon3(clan[])
{
	new CQuery[100], clan_weap[100];
	format(CQuery, sizeof(CQuery), "SELECT `weap3` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "weap3", clan_weap, 30 );
	db_free_result(Result);
	return strval(clan_weap);
}
//------------------------------------------------------------------------------
stock GetClanWeapon4(clan[])
{
	new CQuery[100], clan_weap[100];
	format(CQuery, sizeof(CQuery), "SELECT `weap4` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "weap4", clan_weap, 30 );
	db_free_result(Result);
	return strval(clan_weap);
}
//------------------------------------------------------------------------------
stock GetClanWeapon5(clan[])
{
	new CQuery[100], clan_weap[100];
	format(CQuery, sizeof(CQuery), "SELECT `weap5` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "weap5", clan_weap, 30 );
	db_free_result(Result);
	return strval(clan_weap);
}
//------------------------------------------------------------------------------
stock GetClanWeapon6(clan[])
{
	new CQuery[100], clan_weap[100];
	format(CQuery, sizeof(CQuery), "SELECT `weap6` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "weap6", clan_weap, 30 );
	db_free_result(Result);
	return strval(clan_weap);
}
//------------------------------------------------------------------------------
stock GetClanPosX(clan[])
{
	new CQuery[100], clan_pox[100];
	format(CQuery, sizeof(CQuery), "SELECT `clanposx` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clanposx", clan_pox, 30 );
	db_free_result(Result);
	return strval(clan_pox);
}
//------------------------------------------------------------------------------
stock GetClanPosY(clan[])
{
	new CQuery[100], clan_poy[100];
	format(CQuery, sizeof(CQuery), "SELECT `clanposy` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clanposy", clan_poy, 30 );
	db_free_result(Result);
	return strval(clan_poy);
}
//------------------------------------------------------------------------------
stock GetClanPosZ(clan[])
{
	new CQuery[100], clan_poz[100];
	format(CQuery, sizeof(CQuery), "SELECT `clanposz` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clanposz", clan_poz, 30 );
	db_free_result(Result);
	return strval(clan_poz);
}
//------------------------------------------------------------------------------
stock GetClanSkinLeader(clan[])
{
	new CQuery[100], clan_lskin[100];
	format(CQuery, sizeof(CQuery), "SELECT `lskin` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "lskin", clan_lskin, 30 );
	db_free_result(Result);
	return strval(clan_lskin);
}
//------------------------------------------------------------------------------
stock GetClanSkinMember(clan[])
{
	new CQuery[100], clan_mskin[100];
	format(CQuery, sizeof(CQuery), "SELECT `mskin` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "mskin", clan_mskin, 30 );
	db_free_result(Result);
	return strval(clan_mskin);
}
//------------------------------------------------------------------------------
stock GetClanDescription(clan[])
{
	new CQuery[100], clan_desc[100];
	format(CQuery, sizeof(CQuery), "SELECT `clandes` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clandes", clan_desc, 30 );
	db_free_result(Result);
	return clan_desc;
}
//------------------------------------------------------------------------------
stock GetClanColor(clan[])
{
	new CQuery[100], clan_color[100];
	format(CQuery, sizeof(CQuery), "SELECT `clancolor` FROM `clans` WHERE `clanname` = '%s'", clan);
 	Result = db_query( Database, CQuery );
	db_get_field_assoc( Result, "clancolor", clan_color, 30 );
	db_free_result(Result);
	return strval(clan_color);
}
//------------------------------------------------------------------------------
stock GetClanMembers(clan[])
{
	new CQuery[200], minfo[1512];
	//--------------------------------------------------------------------------
	format(CQuery, sizeof(CQuery), "SELECT * FROM `members` WHERE `clanname` = '%s' ORDER BY `isinclan` DESC LIMIT 15", clan);
	Result = db_query(Database, CQuery);
    //--------------------------------------------------------------------------
    for(new i; i < db_num_rows(Result); i++)
    {
        new string[30], string5[30], onoff[10], log[2];
        //----------------------------------------------------------------------
        db_get_field_assoc(Result, "playername", string, 30);
       	db_get_field_assoc(Result, "playerclanrank", string5, 30);
       	db_get_field_assoc(Result, "IsOnline", log, 2);
       	//----------------------------------------------------------------------
       	if(strcmp(log, "0") == 0)
       	{
       	    onoff = "Offline";
       	}
       	else if(strcmp(log, "1") == 0)
       	{
       	    onoff = "Online";
       	}
       	//----------------------------------------------------------------------
        format(minfo,sizeof(minfo),"%s\n{FF0000}%s {33FF33}(Rank: %s) {00BBF6}(%s)" ,minfo, string, string5, onoff);
        db_next_row(Result);
    }
	db_free_result(Result);
	return minfo;
}
//------------------------------------------------------------------------------
stock GetAllClans()
{
	new CQuery[100], minfo[3000];
	//--------------------------------------------------------------------------
	format(CQuery, 100, "SELECT * FROM `clans`");
 	Result = db_query(Database, CQuery);
	//--------------------------------------------------------------------------
 	for(new i; i < db_num_rows(Result); i++)
    {
        new string[30], amembers[3], aowner[24];
        //----------------------------------------------------------------------
        db_get_field_assoc(Result, "clanname", string, 30);
        db_get_field_assoc(Result, "clantag", amembers, 3);
        db_get_field_assoc(Result, "clanleader", aowner, 24);
        //----------------------------------------------------------------------
        format(minfo,sizeof(minfo),"%s\n{FF0000}%s {33FF33}(Members: %s) {00BBF6}(%s)" ,minfo, string, amembers, aowner);
        db_next_row(Result);
    }
	db_free_result(Result);
	return minfo;
}
//------------------------------------------------------------------------------
stock CreateClan(playerid, clan_name[], clan_tag[], clan_description[], clan_motd[])
{
	new CQuery[400], QCRows;
	//--------------------------------------------------------------------------
	if(IsPlayerAnyClanMember(playerid) != 0) return
	SendClientMessage(playerid, red, "ERROR: You are already in a clan, you cannot create a new one!");
	//--------------------------------------------------------------------------
	format(CQuery, 200, "SELECT `clanname` FROM `clans` WHERE `clanname` = '%s'", clan_name);
	Result = db_query(Database, CQuery);
	QCRows = db_num_rows(Result);
	//--------------------------------------------------------------------------
	if(QCRows >= 1)
	{
		SendClientMessage(playerid, red, "ERROR: There is already a Clan with that name! Please try a different name!");
		return 0;
	}
	db_free_result(Result);
	format(CQuery, 400, "INSERT INTO `clans`(`clanname`, `clantag`, `clanleader`, `clandes`, `clanmotd`, `lskin`, `mskin`, `weap1`, `weap2`, `weap3`, `weap4`, `weap5`, `weap6`, `clankills`, `clandeaths`, `clancolor`, `clanposx`, `clanposy`, `clanposz`) VALUES('%s', '%s', '%s', '%s', '%s', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)", clan_name, clan_tag, GetPlayerNameEx(playerid), clan_description, clan_motd);
	db_query(Database, CQuery);
	format(CQuery, 400, "INSERT INTO `members`(`clanname`, `playername`, `playerclanrank`, `isinclan`, `IsOnline`) VALUES('%s', '%s', 4, 1, 1)", clan_name, GetPlayerNameEx(playerid));
	db_query(Database, CQuery);
	//--------------------------------------------------------------------------
	ShowPlayerDialog( playerid, Clan_SkinL, DIALOG_STYLE_INPUT,"{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Leader Skin", "{FF9900}Please Insert The Skin of the Leader", "Next", "");
	return 1;
}
//------------------------------------------------------------------------------
ShowTopClan( playerid, stats[ ], what[ ], limit = MAX_TOP_LIMIT ) // THX to Zh3r0 & Roach_
{
	#pragma unused what
	//--------------------------------------------------------------------------
	new Speed = GetTickCount(), DialString[3_000], String[2][256], Query[2][256],
		DBResult:Result1, cColor[12] = "{00BBF6}", oColor[12] = "{FF9900}";
	//--------------------------------------------------------------------------
    Database = db_open( "CSystem.db" ); //Open DB
	//--------------------------------------------------------------------------
	format( Query[ 0 ], 256, "SELECT `clanname` FROM `clans` ORDER BY (`%s` * 1) DESC limit %d", stats, limit);
	Result1 = db_query( Database, Query[ 0 ] );
	//--------------------------------------------------------------------------
	format( DialString, sizeof DialString, "%sMore info about our {FF0000}Clan System {FF9900}find on: {FF0000}/chelp\n",oColor);
	for( new Qr; Qr < db_num_rows( Result1 ); Qr ++ )
	{
		db_get_field( Result1, 0, String[ 0 ], 256 );
		format( Query[ 1 ], 256, "SELECT `%s` FROM `clans` WHERE `clanname` = '%s'", stats, String[ 0 ] );
		new DBResult:Result2 = db_query( Database, Query[ 1 ] );
		db_get_field( Result2, 0, String[ 1 ], 256 );
		format( DialString, sizeof DialString, "%s\n{AFAFAF}%d.{FF0000} %s {AFAFAF}Clan Kills: %s%s {FF0000}(Members: %d)", DialString, Qr + 1, String[0], cColor, FormatNumber(strval(String[1])), GetTotalMembers(String[0]));
		db_next_row( Result1 );
		db_free_result( Result2 );
	}
	db_free_result( Result1 );
	format( DialString, sizeof DialString, "%s\n\n{FF9900}Top list generated in {FF0000}%d{FF9900} ms.", DialString, GetTickCount( ) - Speed );
	ShowPlayerDialog( playerid, Nothing, DIALOG_STYLE_MSGBOX, "{0066CC}Romania {FFFF00}Fantastic {FF0000}Stunt{AFAFAF}- Top Clans", DialString, "Ok", "" );
	return 1;
}
//------------------------------------------------------------------------------
//(New Function) Format Number by Teddy
//------------------------------------------------------------------------------
stock FormatNumber(
	{ _, Float, Text3D, Menu, Text, DB, DBResult, bool, File, hex, bit, bit_byte, Bit }:xVariable, iDecimals = -1, iThousandSeparator = ',', iDecimalPoint = '.', iTag = tagof( xVariable ) )
{
	static
		s_szReturn[ 32 ],
		s_szThousandSeparator[ 2 ] = { ' ', EOS },
		s_iDecimalPos,
		s_iChar,
		s_iSepPos
	;
	//--------------------------------------------------------------------------
	if( iTag == tagof( bool: ) )
	{
		if( xVariable )
			memcpy( s_szReturn, "true", 0, 5 * ( cellbits / 8 ) );
		else
			memcpy( s_szReturn, "false", 0, 6 * ( cellbits / 8 ) );

		return ( s_szReturn );
	}
	else if( iTag == tagof( Float: ) )
	{
		if( iDecimals == -1 )
			iDecimals = 8;

		format( s_szReturn, sizeof s_szReturn, "%.*f", iDecimals, xVariable );
	}
	else if( iTag == tagof( bit: ) || iTag == tagof( Bit: ) )
	{
		format(s_szReturn, sizeof s_szReturn, "0b" "%08b%08b%08b%08b", ( xVariable & 0xFF000000 ) >>> 24, ( xVariable & 0x00FF0000 ) >>> 16, ( xVariable & 0x0000FF00 ) >>> 8, ( xVariable & 0x000000FF ) );

		return ( s_szReturn );
	}
	else if( iTag == tagof( bit_byte: ) )
	{
		format( s_szReturn, sizeof s_szReturn, "0b" "%08b", ( xVariable & 0x000000FF ) );

		return ( s_szReturn );
	}
	else
	{
		format( s_szReturn, sizeof s_szReturn, "%d", xVariable );

		if( iDecimals > 0 )
		{
			strcat( s_szReturn, "." );

			while ( iDecimals -- )
				strcat( s_szReturn, "0" );
		}
	}

	s_iDecimalPos = strfind( s_szReturn, "." );
	//--------------------------------------------------------------------------
	if( s_iDecimalPos == -1 )
		s_iDecimalPos = strlen( s_szReturn );
	else
		s_szReturn[ s_iDecimalPos ] = iDecimalPoint;

	if( s_iDecimalPos >= 4 && iThousandSeparator )
	{
		s_szThousandSeparator[ 0 ] = iThousandSeparator;

		s_iChar = s_iDecimalPos;
		s_iSepPos = 0;

		while ( -- s_iChar > 0 )
		{
			if( ++ s_iSepPos == 3 )
			{
				strins( s_szReturn, s_szThousandSeparator, s_iChar );

				s_iSepPos = 0;
			}
		}
	}
	return ( s_szReturn );
}
//------------------------------------------------------------------------------
stock GetWeapon(weaponid)
{
    new sonny[32];
    GetWeaponName(weaponid, sonny, sizeof(sonny));
    return sonny;
}
//------------------------------------------------------------------------------
stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health;
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}
//------------------------------------------------------------------------------
stock SendMessageToClanMembers(playerid, color, msg[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAnyClanMember(playerid) == 1)
		{
			if(IsPlayerConnected(i) == 1)
			{
				if(IsPlayerClanMember(playerid, GetPlayerClan(playerid)) && IsPlayerClanMember(i, GetPlayerClan(i)))
				{
                    if(strcmp(GetPlayerClan(playerid), GetPlayerClan(i), true, 30) == 0)
                    {
						SendClientMessage(i, color, msg);
					}
				}
			}
		}
	}
	return 1;
}
//==============================================================================
//Clan System End - Used by Romania Fantastic Stunt | Created by Teddy
//==============================================================================