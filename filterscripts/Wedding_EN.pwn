#include <a_samp>
#define COLOR_INTERFACE_BODY 0xFDE39DAA
                                                                                /*----------------------------*\
                                                                                | Wedding Script by Abhay |
																				| Church Interior by Abhay     |
                                                                                | Betatesters: MexIvanov2,    |
																				|                   |
                                                                                \*----------------------------*/
new Text3D:PriestName;
new PU_Church[4];
new CAR_Church[5];
new OBJ_Church[107];
enum pInfo {
	pMarried,
	pSex,
	bool:pWedding
};
new PlayerInfo[MAX_PLAYERS][pInfo];
new JustMarried;
new WifeName[MAX_PLAYER_NAME],HusbandName[MAX_PLAYER_NAME];
new bool:IsPlayerInChurch[MAX_PLAYERS];
public OnFilterScriptInit()
{
    OBJ_Church[0] = CreateObject(5710,-2035.896,1092.055,21.414,0.0,0.0,0.0);
    OBJ_Church[1] = CreateObject(5710,-2021.334,1074.279,21.330,0.0,0.0,-89.381);
    OBJ_Church[2] = CreateObject(5710,-2023.422,1074.527,24.567,180.482,0.0,-87.663);
    OBJ_Church[3] = CreateObject(5710,-2010.786,1092.276,21.418,0.0,0.0,180.482);
    OBJ_Church[4] = CreateObject(10676,-2024.834,1101.626,9.607,0.0,0.0,0.0);
    OBJ_Church[5] = CreateObject(5710,-2003.884,1124.533,22.372,0.0,0.0,2.578);
    OBJ_Church[6] = CreateObject(5710,-2044.215,1124.109,22.372,0.0,0.0,179.622);
    OBJ_Church[7] = CreateObject(5710,-2024.951,1145.353,20.497,0.0,0.0,273.301);
    OBJ_Church[8] = CreateObject(10676,-2025.565,1132.252,31.499,180.482,0.0,1.719);
    OBJ_Church[9] = CreateObject(17950,-2025.184,1147.850,19.802,-6.016,0.0,-177.044);
    OBJ_Church[10] = CreateObject(10676,-2081.264,1094.225,18.983,0.0,0.0,89.381);
    OBJ_Church[11] = CreateObject(10676,-1965.052,1091.448,18.998,0.0,0.0,-88.522);
    OBJ_Church[12] = CreateObject(616,-2055.353,1090.207,-2.164,0.0,0.0,-7.735);
    OBJ_Church[13] = CreateObject(616,-1992.356,1092.405,-2.399,0.0,0.0,2.578);
    OBJ_Church[14] = CreateObject(617,-2039.203,1124.151,12.521,0.0,0.0,0.0);
    OBJ_Church[15] = CreateObject(617,-2009.599,1123.927,13.046,0.0,0.0,0.0);
    OBJ_Church[16] = CreateObject(3406,-2024.756,1139.860,14.998,0.0,0.0,91.960);
    OBJ_Church[17] = CreateObject(14535,-2002.932,1089.430,19.881,0.0,0.0,0.0);
    OBJ_Church[18] = CreateObject(2591,-2005.792,1087.077,18.070,0.0,0.0,0.0);
    OBJ_Church[19] = CreateObject(2591,-2007.452,1088.775,18.059,0.0,0.0,-91.100);
    OBJ_Church[20] = CreateObject(2591,-2010.355,1090.212,18.159,0.0,0.0,-274.160);
    OBJ_Church[21] = CreateObject(2639,-2026.608,1129.086,17.680,0.0,0.0,181.341);
    OBJ_Church[22] = CreateObject(2639,-2028.664,1129.044,17.680,0.0,0.0,181.341);
    OBJ_Church[23] = CreateObject(2639,-2032.265,1129.003,17.680,0.0,0.0,181.341);
    OBJ_Church[24] = CreateObject(2639,-2026.460,1125.217,17.680,0.0,0.0,181.341);
    OBJ_Church[25] = CreateObject(2639,-2028.505,1125.171,17.680,0.0,0.0,181.341);
    OBJ_Church[26] = CreateObject(2639,-2032.316,1125.076,17.680,0.0,0.0,181.341);
    OBJ_Church[27] = CreateObject(2639,-2026.407,1121.527,17.680,0.0,0.0,181.341);
    OBJ_Church[28] = CreateObject(2639,-2028.439,1121.477,17.680,0.0,0.0,181.341);
    OBJ_Church[29] = CreateObject(2639,-2032.265,1121.446,17.680,0.0,0.0,181.341);
    OBJ_Church[30] = CreateObject(2639,-2026.299,1117.462,17.680,0.0,0.0,181.341);
    OBJ_Church[31] = CreateObject(2639,-2028.308,1117.420,17.680,0.0,0.0,181.341);
    OBJ_Church[32] = CreateObject(2639,-2032.234,1117.276,17.680,0.0,0.0,181.341);
    OBJ_Church[33] = CreateObject(2639,-2026.137,1114.010,17.680,0.0,0.0,181.341);
    OBJ_Church[34] = CreateObject(2639,-2028.174,1113.973,17.680,0.0,0.0,181.341);
    OBJ_Church[35] = CreateObject(2639,-2032.392,1113.952,17.680,0.0,0.0,181.341);
    OBJ_Church[36] = CreateObject(2639,-2026.029,1110.293,17.680,0.0,0.0,181.341);
    OBJ_Church[37] = CreateObject(2639,-2028.039,1110.233,17.680,0.0,0.0,181.341);
    OBJ_Church[38] = CreateObject(2639,-2032.395,1110.150,17.680,0.0,0.0,181.341);
    OBJ_Church[39] = CreateObject(2639,-2025.828,1105.819,17.680,0.0,0.0,181.341);
    OBJ_Church[40] = CreateObject(2639,-2027.845,1105.769,17.680,0.0,0.0,181.341);
    OBJ_Church[41] = CreateObject(2639,-2032.477,1105.597,17.680,0.0,0.0,181.341);
    OBJ_Church[42] = CreateObject(2639,-2025.950,1102.415,17.680,0.0,0.0,181.341);
    OBJ_Church[43] = CreateObject(2639,-2020.607,1102.462,17.680,0.0,0.0,181.341);
    OBJ_Church[44] = CreateObject(2639,-2021.182,1106.072,17.680,0.0,0.0,181.341);
    OBJ_Church[45] = CreateObject(2639,-2019.068,1106.128,17.680,0.0,0.0,181.341);
    OBJ_Church[46] = CreateObject(2639,-2021.293,1110.423,17.680,0.0,0.0,181.341);
    OBJ_Church[47] = CreateObject(2639,-2019.176,1110.462,17.680,0.0,0.0,181.341);
    OBJ_Church[48] = CreateObject(2639,-2021.494,1114.056,17.680,0.0,0.0,181.341);
    OBJ_Church[49] = CreateObject(2639,-2019.416,1114.099,17.680,0.0,0.0,181.341);
    OBJ_Church[50] = CreateObject(2639,-2021.488,1117.377,17.680,0.0,0.0,181.341);
    OBJ_Church[51] = CreateObject(2639,-2019.359,1117.439,17.680,0.0,0.0,181.341);
    OBJ_Church[52] = CreateObject(2639,-2021.701,1121.653,17.680,0.0,0.0,181.341);
    OBJ_Church[53] = CreateObject(2639,-2019.672,1121.698,17.680,0.0,0.0,181.341);
    OBJ_Church[54] = CreateObject(2639,-2021.795,1125.266,17.680,0.0,0.0,181.341);
    OBJ_Church[55] = CreateObject(2639,-2019.715,1125.309,17.680,0.0,0.0,181.341);
    OBJ_Church[56] = CreateObject(2639,-2021.890,1129.222,17.680,0.0,0.0,181.341);
    OBJ_Church[57] = CreateObject(2639,-2019.839,1129.284,17.680,0.0,0.0,181.341);
	OBJ_Church[58] = CreateObject(949,-2025.626,1099.546,18.491,0.0,0.0,0.0);
    OBJ_Church[59] = CreateObject(949,-2021.007,1099.579,18.496,0.0,0.0,0.0);
    OBJ_Church[60] = CreateObject(3406,-2024.526,1133.215,14.998,0.0,0.0,91.960);
    OBJ_Church[61] = CreateObject(3406,-2024.287,1126.647,14.998,0.0,0.0,91.960);
    OBJ_Church[62] = CreateObject(3406,-2024.092,1120.099,14.998,0.0,0.0,91.960);
	OBJ_Church[63] = CreateObject(3406,-2023.873,1113.530,15.003,0.0,0.0,91.960);
    OBJ_Church[64] = CreateObject(3406,-2023.646,1107.074,14.998,0.0,0.0,91.960);
    OBJ_Church[65] = CreateObject(1841,-2013.758,1101.719,21.371,0.0,0.0,-42.112);
    OBJ_Church[66] = CreateObject(1841,-2033.508,1101.456,21.313,0.0,0.0,-140.088);
    OBJ_Church[67] = CreateObject(14527,-2024.357,1125.755,21.458,0.0,0.0,0.0);
    OBJ_Church[68] = CreateObject(14527,-2023.682,1110.281,21.211,0.0,0.0,0.0);
    OBJ_Church[69] = CreateObject(14527,-2023.954,1118.863,21.359,0.0,0.0,0.0);
    OBJ_Church[70] = CreateObject(2048,-2032.371,1100.039,21.713,0.0,0.0,91.100);
    OBJ_Church[71] = CreateObject(626,-2032.645,1086.687,19.916,0.0,0.0,0.0);
    OBJ_Church[72] = CreateObject(626,-2013.396,1086.476,19.920,0.0,0.0,0.0);
    OBJ_Church[73] = CreateObject(936,-2022.400,1095.251,17.527,0.0,0.0,0.0);
    OBJ_Church[74] = CreateObject(936,-2024.281,1095.263,17.527,0.0,0.0,0.0);
    OBJ_Church[75] = CreateObject(936,-2024.247,1094.204,17.527,0.0,0.0,-178.763);
    OBJ_Church[76] = CreateObject(936,-2022.370,1094.223,17.527,0.0,0.0,-179.622);
    OBJ_Church[77] = CreateObject(936,-2023.282,1093.588,17.277,0.0,0.0,-178.763);
    OBJ_Church[78] = CreateObject(936,-2023.265,1093.137,16.952,0.0,0.0,-178.763);
    OBJ_Church[79] = CreateObject(1743,-2023.655,1094.334,18.020,0.0,0.0,0.0);
    OBJ_Church[80] = CreateObject(1510,-2023.410,1095.185,19.017,0.0,0.0,0.0);
    OBJ_Church[81] = CreateObject(1667,-2023.043,1095.203,19.119,0.0,0.0,0.0);
    OBJ_Church[82] = CreateObject(1668,-2022.793,1095.308,19.197,0.0,0.0,31.799);
    OBJ_Church[83] = CreateObject(1720,-2025.537,1097.943,17.051,0.0,0.0,42.972);
    OBJ_Church[84] = CreateObject(1720,-2021.614,1097.964,17.051,0.0,0.0,-42.112);
    OBJ_Church[85] = CreateObject(1720,-2024.596,1086.202,17.051,0.0,0.0,-182.201);
    OBJ_Church[86] = CreateObject(1720,-2023.301,1086.164,17.051,0.0,0.0,-181.341);
    OBJ_Church[87] = CreateObject(1720,-2022.044,1086.137,17.051,0.0,0.0,-179.622);
    OBJ_Church[88] = CreateObject(2745,-2015.290,1099.679,19.087,0.0,0.0,-89.381);
    OBJ_Church[89] = CreateObject(2745,-2031.465,1099.431,19.076,0.0,0.0,91.100);
    OBJ_Church[90] = CreateObject(3462,-2023.001,1140.864,18.566,0.0,0.0,68.755);
    OBJ_Church[91] = CreateObject(3462,-2026.740,1141.009,18.566,0.0,0.0,118.602);
    OBJ_Church[92] = CreateObject(626,-2021.627,1141.992,19.101,0.0,0.0,0.0);
    OBJ_Church[93] = CreateObject(626,-2019.373,1142.115,19.101,0.0,0.0,0.0);
    OBJ_Church[94] = CreateObject(626,-2027.930,1141.726,19.101,0.0,0.0,0.0);
    OBJ_Church[95] = CreateObject(626,-2030.010,1141.719,19.101,0.0,0.0,0.0);
    OBJ_Church[96] = CreateObject(2639,-2020.268,1140.766,17.680,0.0,0.0,182.201);
    OBJ_Church[97] = CreateObject(2639,-2028.983,1140.265,17.680,0.0,0.0,182.201);
    OBJ_Church[98] = CreateObject(1720,-2015.520,1125.016,17.051,0.0,0.0,-60.161);
    OBJ_Church[99] = CreateObject(1720,-2015.694,1123.822,17.051,0.0,0.0,-85.944);
    OBJ_Church[100] = CreateObject(1720,-2015.421,1122.463,17.051,0.0,1.719,-139.229);
    OBJ_Church[101] = CreateObject(1491,-2016.199,1124.526,16.765,0.0,0.0,-86.803);
    OBJ_Church[102] = CreateObject(967,-2015.487,1123.763,17.010,0.0,0.0,93.679);
    OBJ_Church[103] = CreateObject(1497,-2016.280,1124.456,15.831,0.0,0.0,2.578);
    OBJ_Church[104] = CreateObject(15035,-2042.980,1096.350,17.845,0.0,0.0,90.241);
    OBJ_Church[105] = CreateObject(2591,-2038.595,1100.055,18.894,0.0,0.0,-179.622);
    ConnectNPC("Priest","blank");
    PU_Church[0] = CreatePickup(1318,23,1259.3408,-785.4448,91.5662,-1); //outside
    PU_Church[1] = CreatePickup(1318,23,1261.5061,-786.0542,1091.4329,-1);//inside
    PU_Church[2] = CreatePickup(1559,23,-2022.1351,1096.7433,18.0524,-1);
    PU_Church[3] = CreatePickup(1559,23,-2024.2823,1096.6846,18.0524,-1);
    SendClientMessageToAll(COLOR_INTERFACE_BODY,"Wedding script by Abhay Loaded!");
	for(new i;i<GetMaxPlayers();i++) PlayerInfo[i][pMarried] = -1;
	CAR_Church[0] = CreateVehicle(579,-1978.3153,1082.8452,55.5056,-90.0,0,0,-1);
	CAR_Church[1] = CreateVehicle(426,-1984.4163,1082.8452,55.3147,-90.0,1,1,-1);
	CAR_Church[2] = CreateVehicle(409,-1991.4854,1082.8452,55.3734,-90.0,0,0,-1);
	CAR_Church[3] = CreateVehicle(426,-1999.0565,1082.8452,55.3096,-90.0,1,1,-1);
	CAR_Church[4] = CreateVehicle(579,-2005.6284,1082.8452,55.5031,-90.0,0,0,-1);
	SetTimer("WhoWannaMarried",1000,1);
	return 1;
}
public OnPlayerRequestSpawn(playerid)
{
	ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Choose your sex","Male\nFemale","Choose","Think");
	return 1;
}
public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		new NPCName[MAX_PLAYER_NAME];
		GetPlayerName(playerid,NPCName,sizeof(NPCName));
		if(!strcmp(NPCName,"Priest",true))
		{
			SetPlayerSkin(playerid,68);
			SetPlayerPos(playerid,-2023.2181,1094.6647,19.0025);
			SetPlayerColor(playerid,0x000000FF);
			SetPlayerFacingAngle(playerid,-180.0);
			new string[128];
			format(string,sizeof(string),"%s",NPCName);
			PriestName = Create3DTextLabel(string,0xFDE39DFF,0.0,0.0,0.0,10.0,0,0);
			Attach3DTextLabelToPlayer(PriestName,playerid,0.0,0.0,0.2);
			return 1;
		}
	}
	SetPlayerMapIcon(playerid,0,1259.3408,-785.4448,91.5662,21,-1);
	return 1;
}
public OnPlayerCommandText(playerid,cmdtext[])
{
	new cmd[256],idx;
	cmd = strtok(cmdtext,idx);
	if(!strcmp(cmdtext,"/church",true)) return SetPlayerPos(playerid,-1982.7188,1117.4697,53.1237);
	if(!strcmp(cmd,"/marry",true))
	{
		new tmp[30];
		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"You did not specify the player with whom you want to link their fate.");
		if(!IsPlayerConnected(strval(tmp))) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"Your other half is missing on the server.");
		if(strval(tmp) == playerid) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"You can not married to yourself.");
		if(PlayerInfo[playerid][pMarried] != -1) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"You are already connected by marriage.");
		if(PlayerInfo[strval(tmp)][pMarried] != -1) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"Your other half is already linked by ties of marriage.");
		if(PlayerInfo[playerid][pSex] == PlayerInfo[strval(tmp)][pSex]) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"Same-sex marriages are prohibited by the legislation.");
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
		new TargetName[MAX_PLAYER_NAME];
		GetPlayerName(strval(tmp),TargetName,sizeof(TargetName));
		new string[128];
		format(string,sizeof(string),"Игрок %s предлагает руку и сердце игроку %s.",PlayerName,TargetName);
		SendClientMessageToAll(COLOR_INTERFACE_BODY,string);
		PlayerInfo[strval(tmp)][pMarried] = playerid;
		PlayerInfo[playerid][pMarried] = strval(tmp);
		return 1;
	}
	if(!strcmp(cmd,"/maccept",true))
	{
		new tmp[30];
		tmp = strtok(cmdtext,idx);
		if(PlayerInfo[playerid][pMarried] != strval(tmp)) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"This player does not suggest that you contact with destiny.");
		new TargetName[MAX_PLAYER_NAME];
		GetPlayerName(strval(tmp),TargetName,sizeof(TargetName));
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
		new string[128];
		format(string,sizeof(string),"Вы согласились с предложением руки и сердца от игрока %s.",TargetName);
		SendClientMessage(playerid,COLOR_INTERFACE_BODY,string);
		format(string,sizeof(string),"Игрок %s согласился связать с Вами свою судьбу.",PlayerName);
		SendClientMessage(strval(tmp),COLOR_INTERFACE_BODY,string);
/*
SetPlayerCameraPos(playerid,-1976.4047,1133.3048,55.5896);
SetPlayerCameraPos(strval(tmp),-1976.4047,1133.3048,50.5896);
*/
		return 1;
	}
	if(!strcmp(cmd,"/madmit",true))
	{
        if(PlayerInfo[playerid][pMarried] == -1) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"At the moment no one wants to connect his life with you.");
		new tmp[30];
		tmp = strtok(cmdtext,idx);
		if(PlayerInfo[playerid][pMarried] != strval(tmp)) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"This player does not suggest that you contact with destiny.");
		new TargetName[MAX_PLAYER_NAME];
		GetPlayerName(strval(tmp),TargetName,sizeof(TargetName));
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
		new string[128];
		format(string,sizeof(string),"Вы отказались от предложения руки и сердца от игрока %s.",TargetName);
		SendClientMessage(playerid,COLOR_INTERFACE_BODY,string);
		format(string,sizeof(string),"Игрок %s отказался связать с Вами свою судьбу.",PlayerName);
		SendClientMessage(strval(tmp),COLOR_INTERFACE_BODY,string);
		PlayerInfo[playerid][pMarried] = -1;
		return 1;
	}
	if(!strcmp(cmd,"/sex",true))
	{
	    new tmp[30];
	    tmp = strtok(cmdtext,idx);
		PlayerInfo[playerid][pSex] = strval(tmp);
	    return 1;
	}
	if(!strcmp(cmd,"/family",true))
	{
		if((PlayerInfo[playerid][pMarried] == -1)||(PlayerInfo[playerid][pWedding] == false)) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"You do not have family.");
		new tmp[30];
		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_INTERFACE_BODY,"Your family:");
		    new TargetName[MAX_PLAYER_NAME];
		    GetPlayerName(PlayerInfo[playerid][pMarried],TargetName,sizeof(TargetName));
		    new string[128];
		    if(PlayerInfo[playerid][pSex] == 0) format(string,sizeof(string),"Wife: %s",TargetName);
			else if(PlayerInfo[playerid][pSex] == 1) format(string,sizeof(string),"Husband: %s",TargetName);
			SendClientMessage(playerid,COLOR_INTERFACE_BODY,string);
		}
		else
		{
			new TargetName[MAX_PLAYER_NAME];
			GetPlayerName(strval(tmp),TargetName,sizeof(TargetName));
			new TargetName1[MAX_PLAYER_NAME];
			GetPlayerName(PlayerInfo[strval(tmp)][pMarried],TargetName1,sizeof(TargetName1));
			new string[128],string1[128];
			format(string,sizeof(string),"Семья игрока %s:",TargetName);
			SendClientMessage(playerid,COLOR_INTERFACE_BODY,string);
		    if(PlayerInfo[strval(tmp)][pSex] == 0) format(string1,sizeof(string1),"Wife: %s",TargetName1);
			else if(PlayerInfo[strval(tmp)][pSex] == 1) format(string1,sizeof(string1),"Husband: %s",TargetName1);
			SendClientMessage(playerid,COLOR_INTERFACE_BODY,string1);
		}
		return 1;
	}
	return 0;
}
public OnPlayerPickUpPickup(playerid,pickupid)
{
	if(pickupid == PU_Church[0])
	{
		SetPlayerPos(playerid,1267.8407, -776.9587, 1091.9063);	SetPlayerInterior(playerid,5);
		SetPlayerFacingAngle(playerid,180.0);
		SetCameraBehindPlayer(playerid);
	}
	else if(pickupid == PU_Church[1])
	{
		SetPlayerPos(playerid,1259.3408,-785.4448,91.5662);	SetPlayerInterior(playerid,0);
		SetPlayerFacingAngle(playerid,-90.0);
		SetCameraBehindPlayer(playerid);
	}
	else if(pickupid == PU_Church[2])
	{
		if(PlayerInfo[playerid][pMarried] == -1) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"At the moment no one wants to connect his life with you.");
		if(PlayerInfo[playerid][pWedding] == true) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"You are already connected by marriage.");
		if(PlayerInfo[playerid][pSex] == 1) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"This is a place for the groom.");
	    if(IsPlayerInChurch[playerid] == false)
	    {
	        IsPlayerInChurch[playerid] = true;
			SetPlayerFacingAngle(playerid,180.0);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid,0);
		    new TargetName[MAX_PLAYER_NAME];
		    GetPlayerName(PlayerInfo[playerid][pMarried],TargetName,sizeof(TargetName));
			new string[128];
			format(string,sizeof(string),"Would you marry %s?",TargetName);
			ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"Wedding",string,"Yes","No");
		}
	}
	else if(pickupid == PU_Church[3])
	{
		if(PlayerInfo[playerid][pMarried] == -1) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"At the moment no one wants to connect his life with you.");
		if(PlayerInfo[playerid][pWedding] == true) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"You are already connected by marriage.");
		if(PlayerInfo[playerid][pSex] == 0) return SendClientMessage(playerid,COLOR_INTERFACE_BODY,"This is a place for the bride.");
	    if(IsPlayerInChurch[playerid] == false)
	    {
	        IsPlayerInChurch[playerid] = true;
			SetPlayerFacingAngle(playerid,180.0);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid,0);
		    new TargetName[MAX_PLAYER_NAME];
		    GetPlayerName(PlayerInfo[playerid][pMarried],TargetName,sizeof(TargetName));
			new string[128];
			format(string,sizeof(string),"Would you marry \nfor %s?",TargetName);
			ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Wedding",string,"Yes","No");
		}
	}
	return 1;
}
public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	#pragma unused inputtext
	if(dialogid == 0)
	{
		if(!response)
		{
		    new TargetName[MAX_PLAYER_NAME];
		    GetPlayerName(PlayerInfo[playerid][pMarried],TargetName,sizeof(TargetName));
		    new string[128];
		    format(string,sizeof(string),"You refused marry %s.",TargetName);
			SendClientMessage(playerid,COLOR_INTERFACE_BODY,string);
			TogglePlayerControllable(playerid,1);
			PlayerInfo[PlayerInfo[playerid][pMarried]][pMarried] = -1;
			PlayerInfo[playerid][pMarried] = -1;
			IsPlayerInChurch[playerid] = false;
		}
		else if(response)
		{
			GetPlayerName(playerid,HusbandName,sizeof(HusbandName));
            TogglePlayerControllable(playerid,1);
            JustMarried++;
            IsPlayerInChurch[playerid] = false;
            PlayerInfo[playerid][pWedding] = true;
		}
	}
	else if(dialogid == 1)
	{
		if(!response)
		{
		    new string[128];
		    new TargetName[MAX_PLAYER_NAME];
		    GetPlayerName(PlayerInfo[playerid][pMarried],TargetName,sizeof(TargetName));
		    format(string,sizeof(string),"You refused marry %s.",TargetName);
			SendClientMessage(playerid,COLOR_INTERFACE_BODY,string);
			TogglePlayerControllable(playerid,1);
			PlayerInfo[PlayerInfo[playerid][pMarried]][pMarried] = -1;
			PlayerInfo[playerid][pMarried] = -1;
			IsPlayerInChurch[playerid] = false;
		}
		else if(response)
		{
			GetPlayerName(playerid,WifeName,sizeof(WifeName));
            TogglePlayerControllable(playerid,1);
            JustMarried++;
			IsPlayerInChurch[playerid] = false;
			PlayerInfo[playerid][pWedding] = true;
		}
	}
	else if(dialogid == 2)
	{
	    if(!response) ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"Choose your sex","Male\nFemale","Choose","Think");
		else if(response) PlayerInfo[playerid][pSex] = listitem;
	}
}
forward WhoWannaMarried();
public WhoWannaMarried()
{
	if(JustMarried > 1)
	{
	    new string[128];
	    format(string,sizeof(string),"Players %s and %s - newlyweds! Congratulations!",HusbandName,WifeName);
		SendClientMessageToAll(COLOR_INTERFACE_BODY,string);
		JustMarried = 0;
	}
	return 1;
}
public OnFilterScriptExit()
{
	SendClientMessageToAll(COLOR_INTERFACE_BODY,"Wedding script by Abhay Unoaded!");
	for(new k;k<106;k++) DestroyObject(OBJ_Church[k]);
	for(new j;j<5;j++) DestroyPickup(PU_Church[j]);
	for(new l;l<6;l++) DestroyVehicle(CAR_Church[l]);
	for(new i;i<GetMaxPlayers();i++)
	{
		if(IsPlayerNPC(i)) Kick(i);
		RemovePlayerMapIcon(i,0);
		PlayerInfo[i][pMarried] = -1;
		PlayerInfo[i][pWedding] = false;
	}
	return 1;
}
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')) index++;
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
