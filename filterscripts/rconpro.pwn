/*
	RconPro - Version 0.9
	Provides different features to secure the RCON against attacks
	and unwanted access
	Currently:
	    Hardcoded password list
	    Name- and IP-Whitelists
	    Auto-Shutdown (quite useless atm)
	    
	Made by Abhay - 05-11-2011
	Do not remove this header
*/

#include <a_samp>

#define FILTERSCRIPT

#define USE_HARDCODED_PWS           (true)  // Use a changing PW list
#define USE_NAME_WHITELIST          (false) // Only players with a listed name
											// can login to the RCON
#define USE_IP_WHITELIST            (false) // Only people with a listed IP
											// can login to the RCON
#define PW_CHANGE_INTERVAL          (120)   // Interval in seconds to change the PWs
#define CLOSE_SERVER_ON_RISK        (false) // Auto-close the server on security risks

#define MAX_PW_LENGTH               (32)
#define MIN_PW_LENGTH               (8)     // Shorter PWs will create security warnings

#pragma unused ipwhitelist, namewhitelist



new pws[][MAX_PW_LENGTH] =              // Change this when using hardcoded
{                                       // 
	"system32",                             //
	"fuckoff",                             // SPECIALL MADE FOR KAPIL HAXOR AND ORANGE
	"killmedude"
};

new namewhitelist[][MAX_PLAYER_NAME] =  // Only the names in this list can login
{                                       // as RCON admin, if USE_NAME_WHITELIST
	"[PG]Perfect_Boy"                        // is activated
};

new ipwhitelist[][16] =                 // Only the IPs in this list can login
{                                       // as RCON admin, if USE_IP_WHITELIST
	"120.59.234.71"
                         // is activated
};

new currenthcindex;


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" RconPro Server Protection V0.9");
	print(" Made by Abhay Sv ");
	
	#if (USE_HARDCODED_PWS == true)
	    new hcpw = CheckHCPWSafety();
	    if (hcpw == -1) {
	        printf("[RconPro] Using hardcoded passwords: Security checks passed.");
	    } else {
	        printf("[RconPro] Using hardcoded passwords: WARNING: at least one password (%d) is not safe!", hcpw);
			#if (CLOSE_SERVER_ON_RISK == true)
   			    print("[RconPro] Security shutdown...");
			    SendRconCommand("exit");
			#endif
	    }
	    UpdateHCPWs();
	    SetTimer("UpdateHCPWs", PW_CHANGE_INTERVAL * 1000, 1);
	#endif
	
	print("--------------------------------------\n");
	
	AntiDeAMX();
	
	return 1;
}

public OnFilterScriptExit()
{
	#if (USE_HARDCODED_PWS == true)
		printf("[RconPro] WARNING: RconPro unloaded. The current password index is: %d", currenthcindex);
	#else
	    printf("[RconPro] WARNING: RconPro unloaded.");
	#endif
	return 1;
}


stock CheckHCPWSafety()
{
	for (new i = 0; i < sizeof(pws); i ++)
	{
	    if (strlen(pws[i]) < MIN_PW_LENGTH) return i;
	}
	return -1;
}

forward UpdateHCPWs();
public UpdateHCPWs()
{
	currenthcindex = random(sizeof(pws));
	
	new chpwd[16 + MAX_PW_LENGTH];
	format(chpwd, sizeof(chpwd), "rcon_password %s", pws[currenthcindex]);
	SendRconCommand(chpwd);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	#if (USE_HARDCODED_PWS == true)
		if (strcmp("/rconpw", cmdtext, true) == 0)
		{
		    new pwstring[48];
		    format(pwstring, sizeof(pwstring), "[RconPro] The current password index is: %d", currenthcindex);
			SendClientMessage(playerid, 0xFFFFFFFF, pwstring);
			return 1;
		}
	#endif
	
	return 0;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    new playerid = GetPlayerIDbyIP(ip);
	if (!success)
	{
	    printf("[RconPro] Bad RCON login attempt by %s (Player %d), PW: %s", ip, playerid, password);
	} else {
	    new fail = USE_NAME_WHITELIST || USE_IP_WHITELIST;
	    
	    #if (USE_NAME_WHITELIST == true)
			if(playerid != -1) {
				new name[MAX_PLAYER_NAME];
		        GetPlayerName(playerid, name, MAX_PLAYER_NAME);
				for (new i = 0; i < sizeof(namewhitelist); i++)
				{
				    if(!strcmp(name, namewhitelist[i], false)) fail = false;
				}
			}
		#endif
		
		#if (USE_IP_WHITELIST == true)
			for (new i = 0; i < sizeof(ipwhitelist); i++)
			{
			    if(!strcmp(ip, ipwhitelist[i], false)) fail = false;
			}
		#endif
		
	    if(!fail)
		{
			printf("[RconPro] Succesful RCON login by %s (Player %d), PW: %s", ip, playerid, password);
		} else
		{
		    if(playerid != -1)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, "You are not allowed to login as RCON admin.");
			    printf("[RconPro] Succesful RCON login attempt by %s (Player %d), PW: %s BLOCKED BY WHITELIST", ip, playerid, password);
		        Kick(playerid);
		    }
		}
	}
	return 1;
}

stock GetPlayerIDbyIP(const ip[])
{
	new pip[16];
	for (new i = 0; i < GetMaxPlayers(); i ++)
	{
		if(!IsPlayerConnected(i)) continue;
		GetPlayerIp(i, pip, 16);
	    if (!strcmp(ip, pip, true))
		{
			return i;
		}
	}
	return -1;
}

AntiDeAMX()
{
    new a[][] =
    {
            "Unarmed (Fist)",
            "Brass K"
    };
    #pragma unused a
}
