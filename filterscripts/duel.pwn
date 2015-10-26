#include <a_samp>

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define RED 		0xE60000FF
#define GREEN 		0x21DD00FF
#define COLOR_YELLOW 0xFFFF00AA

new PlayerDualWatching[MAX_PLAYERS];
new InventationSent[MAX_PLAYERS];
new Inventation[MAX_PLAYERS];
new DualRoom1price;
new DualRoom1;
new DualRoom2price;
new DualRoom2;
new DualRoom3price;
new DualRoom3;
new DualRoom4price;
new DualRoom4;
new WeaponDualRoom1;
new WeaponDualRoom2;
new WeaponDualRoom3;
new WeaponDualRoom4;
new InDual[MAX_PLAYERS];
new Inventationprice[MAX_PLAYERS];
forward inventationremove(playerid);
forward CountDown(playerid, seconds);

public CountDown(playerid, seconds)
{
	new string[256];
	if(seconds > 0)
	{
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    PlayerPlaySound(playerid, 1056, X, Y, Z);
	    format(string, sizeof(string), "~R~%d", seconds);
	    GameTextForPlayer(playerid, string, 1000, 3);
	    seconds = seconds -1;
	    SetTimerEx("CountDown", 1000, 0, "ii", playerid, seconds);
	    return 1;
	}
	if(seconds == 0)
	{
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    PlayerPlaySound(playerid, 1057, X, Y, Z);
	    GameTextForPlayer(playerid, "~G~Start!!!", 1000, 3);
	    TogglePlayerControllable(playerid, 1);
	    return 1;
	}
	return 1;
}

public inventationremove(playerid)
{
	if(InDual[playerid] == 0)
	{
		SendClientMessage(playerid, RED, "30 seconds passed after your duel inventation without a response");
	    SendClientMessage(InventationSent[playerid], RED, "30 seconds passed after your dual inventation without a response");
		Inventation[InventationSent[playerid]] = -1;
		InventationSent[playerid] = -1;
		if(DualRoom1 == playerid)
		{
		    DualRoom1 = -1;
		}
		if(DualRoom2 == playerid)
		{
	        DualRoom2 = -1;
		}
		if(DualRoom3 == playerid)
		{
	        DualRoom3 = -1;
		}
		if(DualRoom3 == playerid)
		{
	        DualRoom4 = -1;
		}
		return 1;
	}
	return 1;
}

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
	print("Notime Duel system");
	print("--------------------------------------\n");
	
    DualRoom1 = -1;
    DualRoom2 = -1;
    DualRoom3 = -1;
    DualRoom4 = -1;
    
    CreateObject(3095, 1745.2294921875, -2835.8447265625, 5, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2835.8447265625, 5, 0, 0, 0);
	CreateObject(3095, 1745.2294921875, -2844.833984375, 5, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2844.833984375, 5, 0, 0, 0);
	CreateObject(3095, 1745.2294921875, -2853.8239746094, 5, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2853.8239746094, 5, 0, 0, 0);
	CreateObject(3095, 1727.2551269531, -2835.8447265625, 5, 0, 0, 0);
	CreateObject(3095, 1727.2551269531, -2844.833984375, 5, 0, 0, 0);
	CreateObject(3095, 1727.2551269531, -2853.8232421875, 5, 0, 0, 0);
	CreateObject(3095, 1745.2294921875, -2862.8132324219, 5, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2862.8132324219, 5, 0, 0, 0);
	CreateObject(3095, 1727.2548828125, -2862.8132324219, 5, 0, 0, 0);
	CreateObject(3095, 1718.2648925781, -2835.8447265625, 5, 0, 0, 0);
	CreateObject(3095, 1718.2648925781, -2844.833984375, 5, 0, 0, 0);
	CreateObject(3095, 1718.2648925781, -2853.8232421875, 5, 0, 0, 0);
	CreateObject(3095, 1718.2648925781, -2862.8125, 5, 0, 0, 0);
	CreateObject(3401, 1742.7684326172, -2859.9912109375, 7.9004049301147, 0, 0, 0);
	CreateObject(994, 1742.6313476563, -2852.4506835938, 5.5881395339966, 0, 0, 0);
	CreateObject(994, 1736.0305175781, -2852.4506835938, 5.5881395339966, 0, 0, 0);
	CreateObject(3095, 1749.6668701172, -2835.8447265625, 9.5, 0, 90, 0);
	CreateObject(3095, 1749.666015625, -2862.8134765625, 9.5, 0, 90, 0);
	CreateObject(3095, 1749.666015625, -2853.8232421875, 9.5, 0, 90, 0);
	CreateObject(3095, 1749.666015625, -2844.833984375, 9.5, 0, 90, 0);
	CreateObject(994, 1734.8913574219, -2866.2641601563, 5.555365562439, 0, 0, 90);
	CreateObject(994, 1734.890625, -2859.5632324219, 5.555365562439, 0, 0, 90);
	CreateObject(3401, 1742.7684326172, -2838.2465820313, 7.9004049301147, 0, 0, 0);
	CreateObject(994, 1742.630859375, -2845.4501953125, 5.5881395339966, 0, 0, 0);
	CreateObject(994, 1736.0302734375, -2845.4501953125, 5.5881395339966, 0, 0, 0);
	CreateObject(994, 1734.890625, -2838.0625, 5.555365562439, 0, 0, 90);
	CreateObject(994, 1734.890625, -2844.8625488281, 5.555365562439, 0, 0, 90);
	CreateObject(3095, 1745.2294921875, -2830.8447265625, 9.5, 0, 90, 270);
	CreateObject(3095, 1736.2451171875, -2830.8447265625, 9.5, 0, 90, 270);
	CreateObject(3095, 1718.2648925781, -2830.8447265625, 9.5, 0, 90, 270);
	CreateObject(3095, 1727.2551269531, -2830.8447265625, 9.5, 0, 90, 270);
	CreateObject(3095, 1713.2648925781, -2862.8125, 9.5, 0, 90, 0);
	CreateObject(3095, 1713.2646484375, -2835.8447265625, 9.5, 0, 90, 0);
	CreateObject(3095, 1713.2646484375, -2844.833984375, 9.5, 0, 90, 0);
	CreateObject(3095, 1713.2646484375, -2853.8232421875, 9.5, 0, 90, 0);
	CreateObject(3095, 1718.2648925781, -2866.8125, 9.5, 0, 90, 270);
	CreateObject(3095, 1727.2548828125, -2866.8125, 9.5, 0, 90, 270);
	CreateObject(3095, 1736.2451171875, -2866.8125, 9.5, 0, 90, 270);
	CreateObject(3095, 1745.2294921875, -2866.8125, 9.5, 0, 90, 270);
	CreateObject(3095, 1745.2294921875, -2835.8447265625, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2835.8447265625, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1745.2294921875, -2844.833984375, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2844.833984375, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1745.2294921875, -2853.8232421875, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1745.2294921875, -2862.8125, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2853.8232421875, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1736.2451171875, -2862.8125, 10.199999809265, 0, 0, 0);
	CreateObject(3401, 1720.767578125, -2838.24609375, 7.9004049301147, 0, 0, 0);
	CreateObject(994, 1728.2906494141, -2838.0625, 5.555365562439, 0, 0, 90);
	CreateObject(994, 1728.2906494141, -2844.8623046875, 5.555365562439, 0, 0, 90);
	CreateObject(994, 1714.0302734375, -2845.4501953125, 5.5881395339966, 0, 0, 0);
	CreateObject(994, 1720.7302246094, -2845.4501953125, 5.5881395339966, 0, 0, 0);
	CreateObject(3401, 1720.767578125, -2859.9912109375, 7.9004049301147, 0, 0, 0);
	CreateObject(994, 1728.2906494141, -2866.263671875, 5.555365562439, 0, 0, 90);
	CreateObject(994, 1728.2906494141, -2859.5625, 5.555365562439, 0, 0, 90);
	CreateObject(994, 1714.0302734375, -2852.4501953125, 5.5881395339966, 0, 0, 0);
	CreateObject(994, 1720.7294921875, -2852.4501953125, 5.5881395339966, 0, 0, 0);
	CreateObject(3095, 1727.2548828125, -2862.8125, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1718.2646484375, -2862.8125, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1727.2548828125, -2853.8232421875, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1718.2646484375, -2853.8232421875, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1727.2548828125, -2844.833984375, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1718.2646484375, -2844.833984375, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1727.2548828125, -2835.8447265625, 10.199999809265, 0, 0, 0);
	CreateObject(3095, 1718.2646484375, -2835.8447265625, 10.199999809265, 0, 0, 0);
	return 1;
}

public OnPlayerConnect(playerid)
{
	PlayerDualWatching[playerid] = 0;
	InventationSent[playerid] = -1;
	Inventation[playerid] = -1;
	InDual[playerid] = 0;
	Inventationprice[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    PlayerDualWatching[playerid] = 0;
	InventationSent[playerid] = -1;
	Inventation[playerid] = -1;
	InDual[playerid] = 0;
	Inventationprice[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(InDual[playerid] == 1)
	{
		new string[256];
		new killername[MAX_PLAYER_NAME];
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killername, sizeof(killername));
		GetPlayerName(playerid, playername, sizeof(playername));
		if(DualRoom1 == playerid || DualRoom1 == killerid)
		{
		    Inventation[playerid] = -1;
		    InventationSent[playerid] = -1;
		    Inventation[killerid] = -1;
		    InventationSent[killerid] = -1;
		    InDual[playerid] = 0;
		    InDual[killerid] = 0;
		    format(string, sizeof(string), "%s defeated %s in a duel and wins $%d", killername, playername, DualRoom1price);
		    SendClientMessageToAll(GREEN, string);
		    GivePlayerMoney(killerid, (DualRoom1price*2));
		    SpawnPlayer(killerid);
		    SendDeathMessage(killerid, playerid, reason);
		    DualRoom1 = -1;
		    return 1;
		}
		if(DualRoom2 == playerid || DualRoom2 == killerid)
		{
		    Inventation[playerid] = -1;
		    InventationSent[playerid] = -1;
		    Inventation[killerid] = -1;
		    InventationSent[killerid] = -1;
		    InDual[playerid] = 0;
		    InDual[killerid] = 0;
            format(string, sizeof(string), "%s defeated %s in a duel and wins $%d", killername, playername, DualRoom2price);
		    SendClientMessageToAll(GREEN, string);
		    GivePlayerMoney(killerid, (DualRoom2price*2));
		    SpawnPlayer(killerid);
		    SendDeathMessage(killerid, playerid, reason);
		    DualRoom2 = -1;
		    return 1;
		}
		if(DualRoom3 == playerid || DualRoom3 == killerid)
		{
		    Inventation[playerid] = -1;
		    InventationSent[playerid] = -1;
		    Inventation[killerid] = -1;
		    InventationSent[killerid] = -1;
		    InDual[playerid] = 0;
		    InDual[killerid] = 0;
            format(string, sizeof(string), "%s defeated %s in a duel and wins $%d", killername, playername, DualRoom3price);
		    SendClientMessageToAll(GREEN, string);
		    GivePlayerMoney(killerid, (DualRoom3price*2));
		    SpawnPlayer(killerid);
		    SendDeathMessage(killerid, playerid, reason);
		    DualRoom3 = -1;
		    return 1;
		}
		if(DualRoom4 == playerid || DualRoom4 == killerid)
		{
		    Inventation[playerid] = -1;
		    InventationSent[playerid] = -1;
		    Inventation[killerid] = -1;
		    InventationSent[killerid] = -1;
		    InDual[playerid] = 0;
		    InDual[killerid] = 0;
            format(string, sizeof(string), "%s defeated %s in a duel and wins $%d", killername, playername, DualRoom4price);
		    SendClientMessageToAll(GREEN, string);
		    GivePlayerMoney(killerid, (DualRoom4price*2));
		    SpawnPlayer(killerid);
		    SendDeathMessage(killerid, playerid, reason);
		    DualRoom4 = -1;
		    return 1;
		}
		return 1;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    //duel system commands
	dcmd(watchduels,10,cmdtext);
	dcmd(leavewatch,10,cmdtext);
	dcmd(duel,4,cmdtext);
	dcmd(acceptduel,10,cmdtext);
	dcmd(declineduel,11,cmdtext);
	return 0;
}

dcmd_watchduels(playerid, params[])
{
	#pragma unused params
	if(PlayerDualWatching[playerid] == 0)
	{
		SetPlayerPos(playerid, 1731.8315,-2864.7705,6.5554);
		SetPlayerFacingAngle(playerid, 1.8901);
		ResetPlayerWeapons(playerid);
		SetPlayerHealth(playerid, 1000000000);
		PlayerDualWatching[playerid] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "You are now watching the player duels, Death Match is NOT allowed in this area, /leavewatch to leave.");
		return 1;
	}
	else return SendClientMessage(playerid, RED, "[VT ERROR] You are already watching the duel fights, /leavewatch to leave this place.");
}

dcmd_leavewatch(playerid, params[])
{
	#pragma unused params
	if(PlayerDualWatching[playerid] == 1)
	{
		SetPlayerHealth(playerid, 100);
		SpawnPlayer(playerid);
		SendClientMessage(playerid, COLOR_YELLOW, "You left the player duel watching");
		PlayerDualWatching[playerid] = 0;
		return 1;
	}
	else return SendClientMessage(playerid, RED, "[VT ERROR] You are not watching the duel fights, /watchduels to watch.");
}

dcmd_duel(playerid, params[])
{
	new
	    giveplayerid,
		weapon[128],
		price;
    new string[256];
    new sendername[MAX_PLAYER_NAME];
    new giveplayername[MAX_PLAYER_NAME];
    if (sscanf(params, "isi", giveplayerid,weapon,price))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "[VT ERROR] Right Usage: /dual [playerid] [weapon] [amount]");
		SendClientMessage(playerid, COLOR_YELLOW, "Duel weapons: deagle, mp5, chainsaw, silpist, combatsg, shotgun");
		return 1;
	}
	else
	{
	    if(playerid != giveplayerid)
	    {
		    GetPlayerName(playerid, sendername, sizeof(sendername));
		    GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
		    if(strcmp("deagle", weapon, true, 6) == 0)
	    	{
	    	    if(GetPlayerMoney(playerid) >= price)
	    	    {
	    	        if(Inventation[giveplayerid] == -1)
	    	        {
	    	            if(InventationSent[playerid] == -1)
	    	            {
		    	            if(InDual[playerid] == 0)
		    	            {
		    	                if(InDual[giveplayerid] == 0)
		    	                {
				    	            if(DualRoom1 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	                format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										Inventationprice[giveplayerid] = price;
										DualRoom1price = price;
										DualRoom1 = playerid;
										WeaponDualRoom1 = 24;
										return 1;
				    	            }
				    	            else if(DualRoom2 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom2price = price;
										DualRoom2 = playerid;
										WeaponDualRoom2 = 24;
										return 1;
				    	            }
				    	            else if(DualRoom3 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom3price = price;
										DualRoom3 = playerid;
										WeaponDualRoom3 = 24;
										return 1;
				    	            }
				    	            else if(DualRoom4 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom4price = price;
										DualRoom4 = playerid;
										WeaponDualRoom4 = 24;
										return 1;
				    	            }
				    	            else return SendClientMessage(playerid, RED, "there are no dual rooms free, wait till a dual ends");
								}
								else return SendClientMessage(playerid, RED, "This player is already in a dual");
							}
							else return SendClientMessage(playerid, RED, "you are still in a dual, end it first");
						}
						else return SendClientMessage(playerid, RED, "You already sent an inventation, wait 30 seconds or wait till the other player declines");
					}
	    	        else return SendClientMessage(playerid, RED, "This player already got an inventation");
	    	    }
	    	    else return SendClientMessage(playerid, RED, "You can't afford the dual fee");
	    	}
	    	if(strcmp("mp5", weapon, true, 3) == 0)
	    	{
	    	    if(GetPlayerMoney(playerid) >= price)
	    	    {
	    	        if(Inventation[giveplayerid] == -1)
	    	        {
	    	            if(InventationSent[playerid] == -1)
	    	            {
		    	            if(InDual[playerid] == 0)
		    	            {
		    	                if(InDual[giveplayerid] == 0)
		    	                {
				    	            if(DualRoom1 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	                format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										Inventationprice[giveplayerid] = price;
										DualRoom1price = price;
										DualRoom1 = playerid;
										WeaponDualRoom1 = 29;
										return 1;
				    	            }
				    	            else if(DualRoom2 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom2price = price;
										DualRoom2 = playerid;
										WeaponDualRoom2 = 29;
										return 1;
				    	            }
				    	            else if(DualRoom3 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom3price = price;
										DualRoom3 = playerid;
										WeaponDualRoom3 = 29;
										return 1;
				    	            }
				    	            else if(DualRoom4 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom4price = price;
										DualRoom4 = playerid;
										WeaponDualRoom4 = 29;
										return 1;
				    	            }
				    	            else return SendClientMessage(playerid, RED, "there are no dual rooms free, wait till a dual ends");
								}
								else return SendClientMessage(playerid, RED, "This player is already in a dual");
							}
							else return SendClientMessage(playerid, RED, "you are still in a dual, end it first");
						}
						else return SendClientMessage(playerid, RED, "You already sent an inventation, wait 30 seconds or wait till the other player declines");
					}
	    	        else return SendClientMessage(playerid, RED, "This player already got an inventation");
	    	    }
	    	    else return SendClientMessage(playerid, RED, "You can't afford the dual fee");
	    	}
	    	if(strcmp("chainsaw", weapon, true, 8) == 0)
	    	{
	    	    if(GetPlayerMoney(playerid) >= price)
	    	    {
	    	        if(Inventation[giveplayerid] == -1)
	    	        {
	    	            if(InventationSent[playerid] == -1)
	    	            {
		    	            if(InDual[playerid] == 0)
		    	            {
		    	                if(InDual[giveplayerid] == 0)
		    	                {
				    	            if(DualRoom1 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	                format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										Inventationprice[giveplayerid] = price;
										DualRoom1price = price;
										DualRoom1 = playerid;
										WeaponDualRoom1 = 9;
										return 1;
				    	            }
				    	            else if(DualRoom2 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom2price = price;
										DualRoom2 = playerid;
										WeaponDualRoom2 = 9;
										return 1;
				    	            }
				    	            else if(DualRoom3 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom3price = price;
										DualRoom3 = playerid;
										WeaponDualRoom3 = 9;
										return 1;
				    	            }
				    	            else if(DualRoom4 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
									    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom4price = price;
										DualRoom4 = playerid;
										WeaponDualRoom4 = 9;
										return 1;
				    	            }
				    	            else return SendClientMessage(playerid, RED, "there are no dual rooms free, wait till a dual ends");
								}
								else return SendClientMessage(playerid, RED, "This player is already in a dual");
							}
							else return SendClientMessage(playerid, RED, "you are still in a dual, end it first");
						}
						else return SendClientMessage(playerid, RED, "You already sent an inventation, wait 30 seconds or wait till the other player declines");
					}
	    	        else return SendClientMessage(playerid, RED, "This player already got an inventation");
	    	    }
	    	    else return SendClientMessage(playerid, RED, "You can't afford the dual fee");
	    	}
	    	if(strcmp("silpist", weapon, true, 7) == 0)
	    	{
	    	    if(GetPlayerMoney(playerid) >= price)
	    	    {
	    	        if(Inventation[giveplayerid] == -1)
	    	        {
	    	            if(InventationSent[playerid] == -1)
	    	            {
		    	            if(InDual[playerid] == 0)
		    	            {
		    	                if(InDual[giveplayerid] == 0)
		    	                {
		    	                    SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	            if(DualRoom1 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	                format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										Inventationprice[giveplayerid] = price;
										DualRoom1price = price;
										DualRoom1 = playerid;
										WeaponDualRoom1 = 23;
										return 1;
				    	            }
				    	            else if(DualRoom2 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom2price = price;
										DualRoom2 = playerid;
										WeaponDualRoom2 = 23;
										return 1;
				    	            }
				    	            else if(DualRoom3 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom3price = price;
										DualRoom3 = playerid;
										WeaponDualRoom3 = 23;
										return 1;
				    	            }
				    	            else if(DualRoom4 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom4price = price;
										DualRoom4 = playerid;
										WeaponDualRoom4 = 23;
										return 1;
				    	            }
				    	            else return SendClientMessage(playerid, RED, "there are no dual rooms free, wait till a dual ends");
								}
								else return SendClientMessage(playerid, RED, "This player is already in a dual");
							}
							else return SendClientMessage(playerid, RED, "you are still in a dual, end it first");
						}
						else return SendClientMessage(playerid, RED, "You already sent an inventation, wait 30 seconds or wait till the other player declines");
					}
	    	        else return SendClientMessage(playerid, RED, "This player already got an inventation");
	    	    }
	    	    else return SendClientMessage(playerid, RED, "You can't afford the dual fee");
	    	}
	    	if(strcmp("combatsg", weapon, true, 8) == 0)
	    	{
	    	    if(GetPlayerMoney(playerid) >= price)
	    	    {
	    	        if(Inventation[giveplayerid] == -1)
	    	        {
	    	            if(InventationSent[playerid] == -1)
	    	            {
		    	            if(InDual[playerid] == 0)
		    	            {
		    	                if(InDual[giveplayerid] == 0)
		    	                {
				    	            if(DualRoom1 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	                format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										Inventationprice[giveplayerid] = price;
										DualRoom1price = price;
										DualRoom1 = playerid;
										WeaponDualRoom1 = 27;
										return 1;
				    	            }
				    	            else if(DualRoom2 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom2price = price;
										DualRoom2 = playerid;
										WeaponDualRoom2 = 27;
										return 1;
				    	            }
				    	            else if(DualRoom3 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom3price = price;
										DualRoom3 = playerid;
										WeaponDualRoom3 = 27;
										return 1;
				    	            }
				    	            else if(DualRoom4 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom4price = price;
										DualRoom4 = playerid;
										WeaponDualRoom4 = 27;
										return 1;
				    	            }
				    	            else return SendClientMessage(playerid, RED, "there are no dual rooms free, wait till a dual ends");
								}
								else return SendClientMessage(playerid, RED, "This player is already in a dual");
							}
							else return SendClientMessage(playerid, RED, "you are still in a dual, end it first");
						}
						else return SendClientMessage(playerid, RED, "You already sent an inventation, wait 30 seconds or wait till the other player declines");
					}
	    	        else return SendClientMessage(playerid, RED, "This player already got an inventation");
	    	    }
	    	    else return SendClientMessage(playerid, RED, "You can't afford the dual fee");
	    	}
	    	if(strcmp("shotgun", weapon, true, 7) == 0)
	    	{
	    	    if(GetPlayerMoney(playerid) >= price)
	    	    {
	    	        if(Inventation[giveplayerid] == -1)
	    	        {
	    	            if(InventationSent[playerid] == -1)
	    	            {
		    	            if(InDual[playerid] == 0)
		    	            {
		    	                if(InDual[giveplayerid] == 0)
		    	                {
				    	            if(DualRoom1 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
				    	                format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										Inventationprice[giveplayerid] = price;
										DualRoom1price = price;
										DualRoom1 = playerid;
										WeaponDualRoom1 = 25;
										return 1;
				    	            }
				    	            else if(DualRoom2 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom2price = price;
										DualRoom2 = playerid;
										WeaponDualRoom2 = 25;
										return 1;
				    	            }
				    	            else if(DualRoom3 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom3price = price;
										DualRoom3 = playerid;
										WeaponDualRoom3 = 25;
										return 1;
				    	            }
				    	            else if(DualRoom4 == -1)
				    	            {
				    	                SetTimerEx("inventationremove", 30000, 0, "i", playerid);
	                                    format(string, sizeof(string), "%s has sent you a 1 vs. 1 duel with a desert eagle for $%d, /acceptduel or /declineduel", sendername, price);
				    	                SendClientMessage(giveplayerid, GREEN, string);
				    	                format(string, sizeof(string), "you sent %s a 1 vs. 1 duel with a desert eagle for $%d", giveplayername, price);
				    	                SendClientMessage(playerid, GREEN, string);
				    	                InventationSent[playerid] = giveplayerid;
										Inventation[giveplayerid] = playerid;
										DualRoom4price = price;
										DualRoom4 = playerid;
										WeaponDualRoom4 = 25;
										return 1;
				    	            }
				    	            else return SendClientMessage(playerid, RED, "there are no duel rooms free, wait till a duel ends");
								}
								else return SendClientMessage(playerid, RED, "This player is already in a duel");
							}
							else return SendClientMessage(playerid, RED, "you are still in a duel, end it first");
						}
						else return SendClientMessage(playerid, RED, "You already sent an inventation, wait 30 seconds or wait till the other player declines");
					}
	    	        else return SendClientMessage(playerid, RED, "This player already got an inventation");
	    	    }
	    	    else return SendClientMessage(playerid, RED, "You can't afford the duel fee");
			}
    		else return SendClientMessage(playerid, COLOR_YELLOW, "Right Usage: /duel [playerid] [weapon] [amount]");
		}
		else return SendClientMessage(playerid, RED, "You cant duel yourself");
	}
}

dcmd_acceptduel(playerid, params[])
{
	#pragma unused params
	if(Inventation[playerid] >= 0)
	{
	    if(GetPlayerMoney(playerid) >= Inventationprice[playerid])
	    {
	        if(DualRoom1 == Inventation[playerid])
	        {
	            SetPlayerTeam(playerid, 1);
	            SetPlayerTeam(Inventation[playerid], 2);
	            InDual[Inventation[playerid]] = 1;
	            InDual[playerid] = 1;
	            ResetPlayerWeapons(playerid);
	            ResetPlayerWeapons(Inventation[playerid]);
	            GivePlayerWeapon(playerid, WeaponDualRoom1, 500);
	            GivePlayerWeapon(Inventation[playerid], WeaponDualRoom1, 500);
	            SetPlayerPos(playerid, 1715.5034,-2865.0405,6.5554);
	            SetPlayerFacingAngle(playerid,317.1064);
	            SetPlayerPos(Inventation[playerid], 1723.2203,-2856.0315,6.5554);
	            SetPlayerFacingAngle(Inventation[playerid],140.0715);
	            SetPlayerHealth(playerid, 100);
	            SetPlayerArmour(playerid, 100);
	            SetPlayerHealth(Inventation[playerid], 100);
	            SetPlayerArmour(Inventation[playerid], 100);
	            GivePlayerMoney(playerid, -DualRoom1price);
	            GivePlayerMoney(Inventation[playerid], -DualRoom1price);
	            SendClientMessage(playerid, GREEN, "LET THE BATTLE BEGIN!");
	            SendClientMessage(Inventation[playerid], GREEN, "LET THE BATTLE BEGIN!");
	            TogglePlayerControllable(playerid, 0);
	            TogglePlayerControllable(Inventation[playerid], 0);
				CountDown(playerid, 3);
				CountDown(Inventation[playerid], 3);
	        }
	        if(DualRoom2 == Inventation[playerid])
	        {
                SetPlayerTeam(playerid, 1);
	            SetPlayerTeam(Inventation[playerid], 2);
	            InDual[Inventation[playerid]] = 1;
	            InDual[playerid] = 1;
	            ResetPlayerWeapons(playerid);
	            ResetPlayerWeapons(Inventation[playerid]);
	            GivePlayerWeapon(playerid, WeaponDualRoom2, 500);
	            GivePlayerWeapon(Inventation[playerid], WeaponDualRoom2, 500);
	            SetPlayerPos(playerid, 1747.7878,-2864.6843,6.5554);
	            SetPlayerFacingAngle(playerid,47.0340);
	            SetPlayerPos(Inventation[playerid], 1740.1650,-2858.3879,6.5554);
	            SetPlayerFacingAngle(Inventation[playerid],228.1190);
	            SetPlayerHealth(playerid, 100);
	            SetPlayerArmour(playerid, 100);
	            SetPlayerHealth(Inventation[playerid], 100);
	            SetPlayerArmour(Inventation[playerid], 100);
	            GivePlayerMoney(playerid, -DualRoom2price);
	            GivePlayerMoney(Inventation[playerid], -DualRoom2price);
	            SendClientMessage(playerid, GREEN, "LET THE BATTLE BEGIN!");
	            SendClientMessage(Inventation[playerid], GREEN, "LET THE BATTLE BEGIN!");
	            TogglePlayerControllable(playerid, 0);
	            TogglePlayerControllable(Inventation[playerid], 0);
	            CountDown(playerid, 3);
				CountDown(Inventation[playerid], 3);
				return 1;
	        }
	        if(DualRoom3 == Inventation[playerid])
	        {
                SetPlayerTeam(playerid, 1);
	            SetPlayerTeam(Inventation[playerid], 2);
	            InDual[Inventation[playerid]] = 1;
	            InDual[playerid] = 1;
	            ResetPlayerWeapons(playerid);
	            ResetPlayerWeapons(Inventation[playerid]);
	            GivePlayerWeapon(playerid, WeaponDualRoom3, 500);
	            GivePlayerWeapon(Inventation[playerid], WeaponDualRoom3, 500);
	            SetPlayerPos(playerid, 1748.3942,-2832.6250,6.5554);
	            SetPlayerFacingAngle(playerid,141.3482);
	            SetPlayerPos(Inventation[playerid], 1741.1982,-2839.9243,6.5554);
	            SetPlayerFacingAngle(Inventation[playerid],315.8531);
	            SetPlayerHealth(playerid, 100);
	            SetPlayerArmour(playerid, 100);
	            SetPlayerHealth(Inventation[playerid], 100);
	            SetPlayerArmour(Inventation[playerid], 100);
	            GivePlayerMoney(playerid, -DualRoom3price);
	            GivePlayerMoney(Inventation[playerid], -DualRoom3price);
	            SendClientMessage(playerid, GREEN, "LET THE BATTLE BEGIN!");
	            SendClientMessage(Inventation[playerid], GREEN, "LET THE BATTLE BEGIN!");
	            TogglePlayerControllable(playerid, 0);
	            TogglePlayerControllable(Inventation[playerid], 0);
	            CountDown(playerid, 3);
				CountDown(Inventation[playerid], 3);
	            return 1;
	        }
	        if(DualRoom4 == Inventation[playerid])
	        {
                SetPlayerTeam(playerid, 1);
	            SetPlayerTeam(Inventation[playerid], 2);
	            InDual[Inventation[playerid]] = 1;
	            InDual[playerid] = 1;
	            ResetPlayerWeapons(playerid);
	            ResetPlayerWeapons(Inventation[playerid]);
	            GivePlayerWeapon(playerid, WeaponDualRoom4, 500);
	            GivePlayerWeapon(Inventation[playerid], WeaponDualRoom4, 500);
	            SetPlayerPos(playerid, 1716.7450,-2832.7969,6.5554);
	            SetPlayerFacingAngle(playerid,229.7091);
	            SetPlayerPos(Inventation[playerid], 1722.3630,-2840.2034,6.5554);
	            SetPlayerFacingAngle(Inventation[playerid],45.7807);
	            SetPlayerHealth(playerid, 100);
	            SetPlayerArmour(playerid, 100);
	            SetPlayerHealth(Inventation[playerid], 100);
	            SetPlayerArmour(Inventation[playerid], 100);
	            GivePlayerMoney(playerid, -DualRoom4price);
	            GivePlayerMoney(Inventation[playerid], -DualRoom4price);
	            SendClientMessage(playerid, GREEN, "LET THE BATTLE BEGIN!");
	            SendClientMessage(Inventation[playerid], GREEN, "LET THE BATTLE BEGIN!");
	            TogglePlayerControllable(playerid, 0);
	            TogglePlayerControllable(Inventation[playerid], 0);
	            CountDown(playerid, 3);
				CountDown(Inventation[playerid], 3);
	            return 1;
	        }
	        return 1;
	    }
	    else return SendClientMessage(playerid, RED, "You dont have enough money to accept the duel use /declineduel please.");
	}
	else return SendClientMessage(playerid, RED, "You didnt receive a duel inventation");
}

dcmd_declineduel(playerid, params[])
{
	#pragma unused params
	SendClientMessage(playerid, RED, "You decline the duel inventation");
    SendClientMessage(Inventation[playerid], RED, "your duel inventation got declined.");
	Inventation[InventationSent[playerid]] = -1;
	InventationSent[playerid] = -1;
	if(DualRoom1 == playerid)
	{
	    DualRoom1 = -1;
	}
	if(DualRoom2 == playerid)
	{
        DualRoom2 = -1;
	}
	if(DualRoom3 == playerid)
	{
        DualRoom3 = -1;
	}
	if(DualRoom3 == playerid)
	{
        DualRoom4 = -1;
	}
	return 1;
}

stock sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(string))
	#else
		if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{
				setarg(paramPos, 0, _:floatstr(string[stringPos]));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}

//-----------------------------[© Notime(G.H.J.N.) 2009-2010]-------------------