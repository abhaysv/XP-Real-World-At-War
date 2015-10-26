/*******************************************************************************
*        		     Digital Health & Armour [DHA]- by FailerZ                 *
*        				 	       Copyright ©                  		       *
*******************************************************************************/


//================================ [Includes] ==================================
#include          <a_samp>              //Credits to Kalcor/Kye
//================================ [Defines] ===================================
//Settings
#define          CheckTimer           100 //The time to check for AP/HP change (1000 = 1s) >> Better leave it 100 <<
//================================= [Script] ===================================
//Variables, Forwards, News, Enums - etc..
new Text:DigiHP;
new Text:DigiAP;

forward Updater(playerid);
//------------------------------------------------------------------------------
//CallBacks and Publics
public OnFilterScriptInit()
{
	print("---------------------------------------");
	print("| DHA by FailerZ. Modded by [PG]IzZaN |");
	print("|             Loaded                  |");
	print("---------------------------------------");
	
	//HP Textdraw
	DigiHP = TextDrawCreate(556.000000, 66.000000, "100");
	TextDrawBackgroundColor(DigiHP, 0xEEEEFFC4);
	TextDrawFont(DigiHP, 2);
	TextDrawLetterSize(DigiHP, 0.650000, 0.999999);
	TextDrawColor(DigiHP, 0xAFAFAFAA);
	TextDrawSetOutline(DigiHP, 1);
	TextDrawSetProportional(DigiHP, 1);
	
	//AP Textdraw
	DigiAP = TextDrawCreate(556.000000, 45.000000, "100");
	TextDrawBackgroundColor(DigiAP, 0xAA3333AA);
	TextDrawFont(DigiAP, 2);
	TextDrawLetterSize(DigiAP, 0.650000, 0.999999);
	TextDrawColor(DigiAP, 0x660000AA);
	TextDrawSetOutline(DigiAP, 1);
	TextDrawSetProportional(DigiAP, 1);

	//Checking Timer
	SetTimer("Updater", CheckTimer, true);
	return 1;
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	print("---------------------------------------");
	print("| Digital Health & Armour by FailerZ  |");
	print("|             Unloaded                |");
	print("---------------------------------------");

	TextDrawHideForAll(DigiHP);
	TextDrawDestroy(DigiHP);
	
	TextDrawHideForAll(DigiAP);
	TextDrawDestroy(DigiAP);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
	//HP Check
	TextDrawShowForPlayer(playerid, DigiHP);
	
	//AP Check
	new Float:Armour;
	GetPlayerArmour(playerid, Armour);
	if(Armour >= 1)
	{
	    TextDrawShowForPlayer(playerid, DigiAP);
	}
    return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
	TextDrawHideForPlayer(playerid, DigiHP);
	TextDrawHideForPlayer(playerid, DigiAP);
    return 1;
}
//------------------------------------------------------------------------------
public Updater(playerid)
{
	//HP Check
	new Float:Health, hstr[500];
	GetPlayerHealth(playerid, Health);
	format(hstr, sizeof(hstr), "%.0f", Health);
	TextDrawSetString(DigiHP, hstr);
	TextDrawShowForPlayer(playerid, DigiHP);
	
	//AP Check
	new Float:Armour, astr[500];
	GetPlayerArmour(playerid, Armour);
	if(Armour >= 1)
	{
	    format(astr, sizeof(astr), "%.0f", Armour);
		TextDrawSetString(DigiAP, astr);
		TextDrawShowForPlayer(playerid, DigiHP);
	    TextDrawShowForPlayer(playerid, DigiAP);
	}
	else
	{
	    TextDrawHideForPlayer(playerid, DigiAP);
	}
	return 1;
}
