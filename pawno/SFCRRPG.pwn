////////////////////////////////////////////////////////////////////////////////
/*
					San Fierro Cops-Robbers-RPG v1.1 {2012}
							 Created by Stevo127.
			      All credits are given where they are needed.
			      
      		 I was inspired to create this script due to the little
	      	 number of San Fierro C'n'R scripts out there in SA-MP.
	      	 
	      	 As a side note: I didn't make commands like /cuff and
			 /rape find the nearest players because i think that
			 attracts the use of Keybinds. Which i don't allow in
			 servers because it is unfair to use them.
	      	 
         Enjoy the Gamemode and please give credits to me if you use it.
         
         Credits:
		 CRRPG {Site: www.crrpg.co.uk}
         For enspiring me to make some of the skills/classes in this script.
         Y-Less for sscanf.
         Dracoblue for dudb && dcmd.
         Cuerv0 for the roadblocks script.
         Creator of xObjects.
         BM[UK] for the checkpoint streamer.
         
         
         
                                CHANGELOG v1.1

		- NEW IRC OPTIONS, IF YOU WISH TO TURN IRC OFF, change #define IRC_USE
		  from TRUE to FALSE
		- The server name, abbreviation and version are now set as defines,
		  search for '#define sname' to find these.
		- SSCANF has been updated to the new most stable version.
		- The server website is now changeable through searching for
		  '#define sweb'.
         
*/
////////////////////////////////////////////////////////////////////////////////

#include <a_samp>
#include <irc>
#include <dudb>
#include <streamer>
#include <dprops>
#include <sscanf2>
#include <time>

#pragma tabsize 0
#pragma unused strtok


//==============================================================================

////////////////////////////////// SERVER OPTIONS //////////////////////////////

//Version
#define sversion "1.1"
#define sabbv "SFCRRPG"
#define svname "San Fierro Cops-Robbers-RPG"
#define sweb "www.sfcrrpg.com"

//IRC OPTIONS
#define USE_IRC true
// 1st Echo Bot
#define BOT_1_NICKNAME "BACON"
#define BOT_1_REALNAME "SA-MP Bot"
#define BOT_1_USERNAME "SFCRRPG"
// 2nd Echo Bot
#define BOT_2_NICKNAME "EGGS"
#define BOT_2_REALNAME "SA-MP Bot"
#define BOT_2_USERNAME "SFCRRPG"
//All bots password
#define IRC_BOT_PASSWORD "lmaocheese123"
// Admin Echo Bot (3rd)
#define BOT_3_NICKNAME "CHIPS"
#define BOT_3_REALNAME "SA-MP Bot"
#define BOT_3_USERNAME "SFCRRPG"
//Admin Channel password
#define IRC_ADMINCHANNEL_PASSWORD "BeansOnToast"

#define IRC_SERVER "irc.server.com"
#define IRC_PORT (6667)
#define IRC_CHANNEL "#SFCRRPG"
#define IRC_ADMINCHANNEL "#SFCRRPG.OPER"

#define MAX_BOTS (3)


//==============================================================================

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

//Colours
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_VIOLETBLUE 0x8A2BE2AA
#define COLOR_DEADCONNECT 0x808080AA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_FORESTGREEN 0x228B22AA
#define COLOR_DODGERBLUE 0x1E90FFAA
#define COLOR_DARKOLIVEGREEN 0x556B2FAA
#define COLOR_ORANGE 0xFFA500AA
#define COLOR_PURPLE 0x800080AA
#define COLOR_ROYALBLUE 0x4169FFAA
#define COLOR_ERROR 0xD2691EAA
#define COLOR_PINK 0xFF0080FF
#define COLOR_SEXYGREEN 0x00FF00FF
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIME 0x10F441AA
#define COLOR_ADMIN 0x10F441AA // Currently Lime.
#define COLOR_CYAN 0x40FFFFFF
#define COLOR_ORANGERED 0xFF4500AA

#define TEAM_COP 1
#define TEAM_ARMY 2
#define TEAM_MEDIC 3
#define TEAM_CARFIX 4
#define TEAM_CIA 5
#define TEAM_DRIVER 6
#define TEAM_BISTRO 7
#define TEAM_JAILTK 8
#define TEAM_PVTMED 9
#define TEAM_CIVIL 10
#define TEAM_GASDEL 11
#define TEAM_DRGDEL 12
#define TEAM_HITMAN 13
#define TEAM_GUNDEL 14
#define TEAM_SNITCH 15
#define TEAM_RAPIST 16
#define TEAM_BOUNTY 17
#define TEAM_KIDNAP 18
#define TEAM_DJUNKIE 19
#define TEAM_THIEF 20
#define TEAM_PIMP 21
#define TEAM_PILOT 22
#define TEAM_SMUG 23
#define TEAM_TERRO 24
#define TEAM_CARJACK 25
#define TEAM_FIRE 26
#define TEAM_EGG 27

#define DIALOG_LOGIN 1
#define DIALOG_REGISTER 2
#define DIALOG_COMMANDS 3
#define DIALOG_SKILLINFO 4
#define DIALOG_ADCMDS 5
#define DIALOG_BANK_LIST 6
#define DIALOG_BANK_WITHDRAW 7
#define DIALOG_BANK_DEPOSIT 8
#define DIALOG_BANK_BALANCE 9
#define DIALOG_CIASAT 10
#define DIALOG_SUPASAVE 11
#define DIALOG_DRUGHOUSE 12
#define DIALOG_WEAPONS 13
#define DIALOG_OTTO 14
#define DIALOG_BOMBSHOP 15
#define DIALOG_TERRORIST 16
#define DIALOG_ROBSKILL 17
#define DIALOG_BURGERSHOT 18
#define DIALOG_CLUCKINBELL 19
#define DIALOG_AMMUNATION 20
#define DIALOG_GAYDAR 21
#define DIALOG_ZERO 22
#define DIALOG_MISTYS 23
#define DIALOG_GYM 24
#define DIALOG_SCHOOL 25
#define DIALOG_WANGCARS 26
#define DIALOG_TRAIN 27
#define DIALOG_BARBERS 28
#define DIALOG_HOSPITAL 29
#define DIALOG_JIZZYS 30
#define DIALOG_PIZZA 31
#define DIALOG_ZIP 32
#define DIALOG_VICTIM 33
#define DIALOG_BINCO 34
#define DIALOG_CITYHALL 35
#define DIALOG_INVENTORY 36
#define DIALOG_CREDITS 37
#define DIALOG_RULES 38
#define DIALOG_PC 39
#define DIALOG_CHANGEPASS 40
#define DIALOG_CHANGENAME 41


#define MAX_ROADBLOCKS 35
#define MAX_SPAM 5

#define SPEC_TYPE_NONE 0
#define SPEC_TYPE_PLAYER 1
#define SPEC_TYPE_VEHICLE 2

//Checkpoint defines
#define CP_SFPDEnt 0
#define CP_SFPDExit 1
#define CP_DropOff 2
#define CP_BankEnt 3
#define CP_BankExit 4
#define CP_BankMain 5
#define CP_CIAEnt 6
#define CP_CIAExit 7
#define CP_CIAExit2 8
#define CP_CIASat 9
#define CP_FBIEnt 10
#define CP_FBIExit 11
#define CP_SupaSaveEnt 12
#define CP_SupaSaveExit 13
#define CP_SupaSaveMain 14
#define CP_DrugHouseCaltonHeights 15
#define CP_DrugHouseOceanFlats 16
#define CP_DrugHouseParadiso 17
#define CP_DrugHouseJuniperHollow 18
#define CP_ShipYard 19
#define CP_OttoCP 20
#define CP_BombShop 21
#define CP_CIASatBlow 22
#define CP_CIABridge 23
#define CP_BurgerShotMain 24
#define CP_CluckinBellMain 25
#define CP_Ammunation 26
#define CP_GayDarMain 27
#define CP_ZeroMain 28
#define CP_MistysMain 29
#define CP_GYM 30
#define CP_School 31
#define CP_WangCars 32
#define CP_Train 33
#define CP_Barbers 34
#define CP_CityHallEnt 35
#define CP_Hospital 36
#define CP_Jizzys 37
#define CP_PizzaMain 38
#define CP_ZipMain 39
#define CP_VictimMain 40
#define CP_BincoMain 41
#define CP_CityHallExit 42
#define CP_CityHallMain 43

#define MAX_POINTS 44

#define MAX_PLAYERS_ 35

//Case sensitive
#define DrugHouseOwnerName "Stevo127"
#define OttoOwnerName "Stevo127"

//==============================================================================

//Variables
new Float:checkCoords[MAX_POINTS][4] = {
{-1623.6704,710.2758,-1595.5138,726.3750}, //SFPDEnt
{233.7716,107.9433,259.8581,122.0880}, //SFPDExit
{-1628.7830,672.2675,-1586.4739,691.8566}, //DropOff
{-1527.6946,868.8881,-1492.1344,955.5516}, //BankEnt
{2304.6948,-17.3057,2312.3196,-13.2586}, //BankExit
{2311.6550,-13.6536,2316.6047,-0.1508}, //BankMain
{-1245.9392,708.7461,-1219.4531,764.7156}, //CIAEnt
{272.2762,169.4900,301.7643,184.6361}, //CIAExit
{228.7007,140.0458,248.7588,153.6630}, //CIAExit2
{280.3638,178.2592,301.9283,192.3590}, //CIASat
{-1781.6199,949.1130,-1727.1202,964.0967}, //FBIEnt
{242.7642,62.7023,255.3901,72.0994}, //FBIExit
{-2486.7969,720.7235,-2399.2456,757.8288}, //SupaSaveEnt
{4.5919,-30.8944,9.4711,-24.1830}, //SupaSaveExit
{-8.3713,-31.1897,3.9439,-23.9503}, //SupaSaveMain
{-2130.8936,898.9030,-2085.2764,913.5282}, //DrugHouseCaltonHeights
{-2800.3831,-17.7937,-2757.5454,36.4089}, //DrugHouseOceanFlats
{-2614.3384,794.2173,-2548.7556,819.7993}, //DrugHouseParadiso
{-2466.9871,1251.7363,-2433.7473,1309.5492}, //DrugHouseJuniperHollow
{-1593.1047,100.3332,-1527.3502,148.0326}, //ShipYard
{-1677.6678,1202.5203,-1621.3718,1237.6665}, //OttoCP
{-1925.1906,276.9108,-1910.2406,309.3634}, //BombShop
{-1332.1198,764.7802,-1284.4316,799.4351}, //CIASatBlow
{-1548.1466,765.9007,-1483.7194,801.4399}, //CIABridge
{362.3203,-76.7831,382.6036,-64.5106}, //BurgerShotMain
{363.8834,-11.4192,380.8347,-6.0182}, //CluckenBellMain
{284.2406,-40.9833,299.4141,-30.4050}, //Ammunation
{478.1811,-24.5361,501.1296,-2.1605}, //GayDarMain
{-2240.0078,128.3076,-2223.8943,137.1232}, //ZeroMain
{487.6969,-76.0396,511.9043,-71.8035}, //MistysMain
{754.0794,-50.2732,777.8512,-16.4785}, //GYM
{-2035.6058,-119.3974,-2021.7870,-108.7207}, //School
{-1971.3776,253.6257,-1950.4263,308.1653}, //WangCars
{-1978.7638,116.7885,-1956.5165,155.2209}, //Train
{416.8030,-84.2422,422.2446,-74.0695}, //Barbers
{-2766.5471,360.1405,-2744.8018,392.1549}, //CityHall
{-2670.9158,614.7380,-2637.2957,640.1582}, //Hospital
{-2678.9795,1396.2579,-2634.2734,1426.7246}, //Jizzys
{367.0538,-133.4065,380.3084,-118.8081}, //PizzaMain
{145.4055,-96.1957,177.4023,-70.9268}, //ZipMain
{199.8335,-13.0003,227.0720,-3.5268}, //VictimMain
{200.5280,-111.0826,217.7478,-96.9589}, //BincoMain
{377.7993,170.0076,389.6078,177.6493}, //CityHallExit
{354.1745,158.6413,390.2875,188.8046} //CityHallMain
};

new Float:checkpoints[MAX_POINTS][4] = {
{-1605.5288,712.4097,13.8714,3.0}, //SFPDEnt
{246.4093,109.0884,1003.2188,3.0}, //SFPDExit
{-1606.3319,673.9650,-5.2422,3.0}, //DropOff
{-1493.4175,920.0615,7.1875,3.0}, //BankEnt
{2305.5889,-16.2092,26.7496,3.0}, //BankExit
{2315.8198,-7.2530,26.7422,3.0}, //BankMain
{-1222.6882,738.9059,6.6299,3.0}, //CIAEnt
{288.6720,170.1256,1007.1794,3.0}, //CIAExit
{238.6524,140.8584,1003.0234,3.0}, //CIAExit2
{297.5231,183.4510,1007.1719,3.0}, //CIASat
{-1754.1787,962.3545,24.8828,3.0}, //FBIEnt
{246.7218,63.4211,1003.6406,3.0}, //FBIExit
{-2442.7930,754.4579,35.1719,3.0}, //SupaSaveEnt
{6.2157,-30.8714,1003.5494,3.0}, //SupaSaveExit
{1.6692,-28.4267,1003.5494,3.0}, //SupaSaveMain
{-2099.6882,899.1699,76.7109,3.0}, //DrugHouseCaltonHeights
{-2779.9194,0.3026,10.0625,3.0}, //DrugHouseOceanFlats
{-2576.4824,818.9226,49.9844,3.0}, //DrugHouseParadiso
{-2433.7866,1281.6011,23.7422,3.0}, //DrugHouseJuniperHollow
{-1547.4066,123.6555,3.5547,5.0}, //ShipYard
{-1657.7573,1210.2754,7.2500,3.0}, //OttoCP
{-1923.3926,303.6380,41.0469,3.0}, //BombShop
{-1308.1965,796.5082,6.6299,3.0}, //CIASatBlow
{-1496.3555,796.4011,7.1875,3.0}, //CIABridge
{373.0567,-65.5078,1001.5078,3.0}, //BurgerShotMain
{370.7744,-6.5378,1001.8589,3.0}, //CluckinBellMain
{294.0775,-40.7211,1001.5156,3.0}, //Ammunation
{499.5635,-18.8676,1000.6719,3.0}, //GayDarMain
{-2235.2788,130.4634,1035.4141,3.0}, //ZeroMain
{495.6589,-75.4557,998.7578,3.0}, //MistysMain
{754.6652,-41.0422,1000.5859,3.0}, //GYM
{-2032.9712,-117.4418,1035.1719,3.0}, //School
{-1951.9911,300.2070,35.4688,3.0}, //WangCars
{-1972.4688,117.8655,27.6940,3.0}, //Train
{421.5031,-76.8336,1001.8047,3.0}, //Barbers
{-2765.7402,375.5952,6.3347,3.0}, //CityHall
{-2658.3201,639.5060,14.4531,3.0}, //Hospital
{-2656.2332,1416.1669,906.2734,3.0}, //Jizzys
{376.7648,-119.4542,1001.4995,3.0}, //PizzaMain
{162.8374,-83.6908,1001.8047,3.0}, //ZipMain
{205.6493,-10.6077,1001.2109,3.0}, //VictimMain
{206.2597,-100.7781,1005.2578,3.0}, //BincoMain
{389.2351,173.7753,1008.3828,3.0}, //CityHallExit
{362.0905,173.7759,1008.3828,3.0} //CityHallMain
};

new checkpointType[MAX_POINTS] = {
CP_SFPDEnt,
CP_SFPDExit,
CP_DropOff,
CP_BankEnt,
CP_BankExit,
CP_BankMain,
CP_CIAEnt,
CP_CIAExit,
CP_CIAExit2,
CP_CIASat,
CP_FBIEnt,
CP_FBIExit,
CP_SupaSaveEnt,
CP_SupaSaveExit,
CP_SupaSaveMain,
CP_DrugHouseCaltonHeights,
CP_DrugHouseOceanFlats,
CP_DrugHouseParadiso,
CP_DrugHouseJuniperHollow,
CP_ShipYard,
CP_OttoCP,
CP_BombShop,
CP_CIASatBlow,
CP_CIABridge,
CP_BurgerShotMain,
CP_CluckinBellMain,
CP_Ammunation,
CP_GayDarMain,
CP_ZeroMain,
CP_MistysMain,
CP_GYM,
CP_School,
CP_WangCars,
CP_Train,
CP_Barbers,
CP_CityHallEnt,
CP_Hospital,
CP_Jizzys,
CP_PizzaMain,
CP_ZipMain,
CP_VictimMain,
CP_BincoMain,
CP_CityHallExit,
CP_CityHallMain
};

// Random Jail Spawns
new Float:JailSpawnPoints[4][4] =
{
{215.5644,110.7332,999.0156,1.2767},
{219.4913,110.9124,999.0156,359.0834},
{223.4386,111.0879,999.0156,0.9634},
{227.4427,111.2414,999.0156,358.1433}
};

// Random Civilian Spawns
new Float:SpawnPoints[11][4] =
{
{-1496.3367,904.7078,7.1875,90.4882},
{-1749.9264,960.2077,24.8828,177.4444},
{-1980.9019,1120.1901,53.1256,273.1997},
{-2243.8044,943.8950,66.6484,88.6631},
{-2243.4663,753.3155,49.4393,86.9318},
{-2442.1355,746.6382,35.0156,176.9609},
{-2760.9460,375.2620,5.0312,267.6648},
{-2666.2195,-19.0636,6.1328,90.7135},
{-2345.2627,-139.9374,35.5547,359.7453},
{-2033.2048,-100.5898,35.1641,0.6258},
{-1984.5894,138.2576,27.6875,90.5403}
};

//Leaving types
new aDisconnectNames[][16] = {
	{"Timeout"}, // 0
	{"Leaving"}, // 1
	{"Kicked"} // 2
};

//Weapon names
new aWeaponNames[][32] = {
	{"Unarmed (Fist)"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Big White Vibrator"}, // 11
	{"Medium White Vibrator"}, // 12
	{"Small White Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Colt 45 (Silenced)"}, // 23
	{"Desert Eagle"}, // 24
	{"Normal Shotgun"}, // 25
	{"Sawnoff Shotgun"}, // 26
	{"Combat Shotgun"}, // 27
	{"Micro Uzi (Mac 10)"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"}, // 47
	{"Unknown"}, //48
	{"Vehicle"}, //49
	{"Helicopter Blades"}, //50
	{"Explosion"}, //51
	{"Unknown"}, //52
	{"Drowned"}, //53
	{"Explosion"} //54
};

enum vInfo
{
	bought,
	stolen,
	bombed
}
new VehicleInfo[MAX_VEHICLES][vInfo];

/////////////////////For xobjects
enum object_info//////xobjects
{
	xmodelid,
	Float:ox,
	Float:oy,
	Float:oz,
	Float:orx,
	Float:ory,
	Float:orz,
	Float:viewdist
}

new Objects[][object_info] = {
//SFPD
{2886,-1622.12353516,688.01043701,7.88793468,0.00000000,0.00000000,0.00000000,350.0}, //object(sec_keypad) (1)
{2886,-1618.29150391,689.65557861,7.76999092,0.00000000,0.00000000,269.63272095,350.0}, //object(sec_keypad) (2)

//Army base
{987,-1513.69616699,481.82632446,6.08127546,0.00000000,0.00000000,179.26562500,350.0}, //object(elecfence_bar) (1)
{3268,-1232.47753906,389.00982666,5.99461794,0.00000000,0.00000000,0.00000000,350.0}, //object(mil_hangar1_) (1)
{3268,-1251.71240234,333.13879395,6.10084248,0.00000000,0.00000000,269.63269043,350.0}, //object(mil_hangar1_) (2)
{3268,-1300.47680664,333.32141113,6.10084248,0.00000000,0.00000000,269.63275146,350.0}, //object(mil_hangar1_) (3)
{7371,-1221.26403809,329.22235107,5.62858820,0.00000000,0.00000000,180.22889709,350.0}, //object(vgsnelec_fence_02) (1)
{7371,-1207.69128418,316.60687256,5.46349335,0.00000000,0.00000000,269.63281250,350.0}, //object(vgsnelec_fence_02) (2)

//CIA base
{5296,-1383.45385742,793.59912109,11.37113190,0.00000000,0.00000000,352.46936035,350.0}, //object(laroads_26a_las01) (2)
{8150,-1249.84094238,702.46673584,8.73092747,0.00000000,0.00000000,172.62756348,350.0}, //object(vgsselecfence04) (1)
{8150,-1268.74279785,825.06512451,8.73092747,0.00000000,0.00000000,352.46936035,350.0}, //object(vgsselecfence04) (2)
{8150,-1180.46203613,753.77587891,8.73092747,0.00000000,0.00000000,262.10214233,350.0}, //object(vgsselecfence04) (3)
{8210,-1342.79138184,742.29718018,8.59358215,0.00000000,0.00000000,262.10214233,350.0}, //object(vgsselecfence12) (1)
{8210,-1319.66711426,711.43829346,8.73092651,0.00000000,0.00000000,352.52142334,350.0}, //object(vgsselecfence12) (2)
{8210,-1199.00512695,815.66241455,8.69980621,0.00000000,0.00000000,172.00897217,350.0}, //object(vgsselecfence12) (3)
{3881,-1336.21936035,773.73394775,7.48146248,0.00000000,0.00000000,172.86389160,350.0}, //object(airsecbooth_sfse) (1)
{8210,-1332.07885742,824.90759277,8.59358215,0.00000000,0.00000000,262.77856445,350.0}, //object(vgsselecfence12) (4)
{9833,-1335.65783691,778.59289551,8.96163368,0.00000000,0.00000000,0.00000000,350.0}, //object(fountain_sfw) (1)
{9833,-1333.67919922,795.21160889,8.95700550,0.00000000,0.00000000,0.00000000,350.0}, //object(fountain_sfw) (2)

//FBI base
{987,-1781.57653809,986.68835449,23.67817688,0.00000000,0.00000000,269.78674316,350.0}, //object(elecfence_bar) (1)
{987,-1781.53979492,992.69714355,23.67817688,0.00000000,0.00000000,269.78674316,350.0}, //object(elecfence_bar) (2)
{3515,-1784.37463379,990.54791260,24.26747131,0.00000000,0.00000000,0.00000000,350.0}, //object(vgsfountain) (1)
{3515,-1784.41992188,977.25000000,24.26747131,0.00000000,0.00000000,0.00000000,350.0}, //object(vgsfountain) (2)
{7091,-1781.84436035,970.20080566,37.21278381,0.00000000,0.00000000,179.57318115,350.0}, //object(vegasflag02) (1)
{7091,-1781.73266602,983.68243408,37.29210663,0.00000000,0.00000000,179.61553955,350.0}, //object(vegasflag02) (2)
{7091,-1781.93957520,997.38391113,37.27826691,0.00000000,0.00000000,178.54718018,350.0}, //object(vegasflag02) (3)
{7091,-1765.44677734,963.75579834,37.20131683,0.00000000,0.00000000,270.25720215,350.0}, //object(vegasflag02) (4)
{7091,-1742.81616211,963.73315430,37.20131683,0.00000000,0.00000000,269.61529541,350.0}, //object(vegasflag02) (5)
{9833,-1767.86267090,940.79766846,27.09316826,0.00000000,0.00000000,0.00000000,350.0}, //object(fountain_sfw) (1)
{9833,-1781.06030273,940.90979004,27.09316826,0.00000000,0.00000000,0.00000000,350.0}, //object(fountain_sfw) (2)
{9833,-1743.30383301,940.90661621,27.09316826,0.00000000,0.00000000,0.00000000,350.0}, //object(fountain_sfw) (3)
{9833,-1727.93933105,941.00140381,27.09316826,0.00000000,0.00000000,0.00000000,350.0}, //object(fountain_sfw) (4)
{2886,247.71240234,72.41156006,1003.91296387,0.00000000,0.00000000,0.00000000,350.0}, //object(fbiinsideshutteroutsidekeypad) (1)
{2886,244.84619141,73.62068939,1003.76916504,0.00000000,0.00000000,90.81121826,350.0}, //object(fbiinsideshutterinsidekeypad) (2)
{4727,-1754.17578125,988.74890137,97.29925537,0.00000000,0.00000000,0.00000000,350.0} //object(libtwrhelipda_lan2) (1)
};

enum player_info
{
	objid[sizeof(Objects)],
	bool:view[sizeof(Objects)]
}
new Player[MAX_PLAYERS][player_info];

bool:IsInReach(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2,Float:dist)
{
	x = (x > x2) ? x - x2 : x2 - x;
	if(x > dist) return false;
	y = (y > y2) ? y - y2 : y2 - y;
	if(y > dist) return false;
	z = (z > z2) ? z - z2 : z2 - z;
	if(z > dist) return false;
	return true;
}
new timer;

////Roadblocks////
enum rInfo
{
    sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};
new Roadblocks[MAX_ROADBLOCKS][rInfo];

enum pInfo
{
	pRoadblock,
};
new PlayerInfo[MAX_PLAYERS][pInfo];

// ZONES
enum zoneinfo {
	zone_name[27],
    Float:zone_minx,
    Float:zone_miny,
    Float:zone_minz,
    Float:zone_maxx,
    Float:zone_maxy,
    Float:zone_maxz
}
// Makabos zones script // ALWAYS ADD NEW ZONES TO THE END (YOULL MESS UP ALL ROBBERIES)
new Float:zones[][zoneinfo] = {
{ "Supa Save (Int)",             -11.0048,  -31.3442,  1003.5494,  8.3204,  -2.7050,  50.00},
{ "Army Base",                   -1546.4114,  260.0058, 7.1797, -1222.0865, 521.8784, 50.00},
{ "SFPD (Int)",                  214.0158,  107.4454, 999.0156, 278.4889,  127.9651,  50.00},
{ "FBI HQ (Int)",                217.2494, 62.7068,  1001.0391,  270.0461,  92.4821,  50.00},
{ "CIA HQ",                      -1336.4915, 705.7386, 6.6299, -1182.2593, 823.7599, 200.00},
{ "CIA HQ (Int)",                188.1787, 138.6903, 1003.0234, 301.7826, 197.7743,   50.00},
{ "The Big Ear",                -410.00,  1403.30,    -3.00,  -137.90,  1681.20,     200.00},
{ "Aldea Malvada",               -1372.10,  2498.50,     0.00, -1277.50,  2615.30,   200.00},
{ "Angel Pine",                  -2324.90, -2584.20,    -6.10, -1964.20, -2212.10,   200.00},
{ "Arco del Oeste",               -901.10,  2221.80,     0.00,  -592.00,  2571.90,   200.00},
{ "Avispa Country Club",         -2646.40,  -355.40,     0.00, -2270.00,  -222.50,   200.00},
{ "Avispa Country Club",         -2831.80,  -430.20,    -6.10, -2646.40,  -222.50,   200.00},
{ "Avispa Country Club",         -2361.50,  -417.10,     0.00, -2270.00,  -355.40,   200.00},
{ "Avispa Country Club",         -2667.80,  -302.10,   -28.80, -2646.40,  -262.30,    71.10},
{ "Avispa Country Club",         -2470.00,  -355.40,     0.00, -2270.00,  -318.40,    46.10},
{ "Avispa Country Club",         -2550.00,  -355.40,     0.00, -2470.00,  -318.40,    39.70},
{ "Back o Beyond",               -1166.90, -2641.10,     0.00,  -321.70, -1856.00,   200.00},
{ "Battery Point",               -2741.00,  1268.40,    -4.50, -2533.00,  1490.40,   200.00},
{ "Bayside",                     -2741.00,  2175.10,     0.00, -2353.10,  2722.70,   200.00},
{ "Bayside Marina",              -2353.10,  2275.70,     0.00, -2153.10,  2475.70,   200.00},
{ "Beacon Hill",                  -399.60, -1075.50,    -1.40,  -319.00,  -977.50,   198.50},
{ "Blackfield",                    964.30,  1203.20,   -89.00,  1197.30,  1403.20,   110.90},
{ "Blackfield",                    964.30,  1403.20,   -89.00,  1197.30,  1726.20,   110.90},
{ "Blackfield Chapel",            1375.60,   596.30,   -89.00,  1558.00,   823.20,   110.90},
{ "Blackfield Chapel",            1325.60,   596.30,   -89.00,  1375.60,   795.00,   110.90},
{ "Blackfield Intersection",      1197.30,  1044.60,   -89.00,  1277.00,  1163.30,   110.90},
{ "Blackfield Intersection",      1166.50,   795.00,   -89.00,  1375.60,  1044.60,   110.90},
{ "Blackfield Intersection",      1277.00,  1044.60,   -89.00,  1315.30,  1087.60,   110.90},
{ "Blackfield Intersection",      1375.60,   823.20,   -89.00,  1457.30,   919.40,   110.90},
{ "Blueberry",                     104.50,  -220.10,     2.30,   349.60,   152.20,   200.00},
{ "Blueberry",                      19.60,  -404.10,     3.80,   349.60,  -220.10,   200.00},
{ "Blueberry Acres",              -319.60,  -220.10,     0.00,   104.50,   293.30,   200.00},
{ "Calton Heights",              -2274.10,   744.10,    -6.10, -1982.30,  1358.90,   200.00},
{ "Chinatown",                   -2274.10,   578.30,    -7.60, -2078.60,   744.10,   200.00},
{ "Commerce",                     1323.90, -1842.20,   -89.00,  1701.90, -1722.20,   110.90},
{ "Commerce",                     1323.90, -1722.20,   -89.00,  1440.90, -1577.50,   110.90},
{ "Commerce",                     1370.80, -1577.50,   -89.00,  1463.90, -1384.90,   110.90},
{ "Commerce",                     1463.90, -1577.50,   -89.00,  1667.90, -1430.80,   110.90},
{ "Commerce",                     1583.50, -1722.20,   -89.00,  1758.90, -1577.50,   110.90},
{ "Commerce",                     1667.90, -1577.50,   -89.00,  1812.60, -1430.80,   110.90},
{ "Conference Center",            1046.10, -1804.20,   -89.00,  1323.90, -1722.20,   110.90},
{ "Conference Center",            1073.20, -1842.20,   -89.00,  1323.90, -1804.20,   110.90},
{ "Cranberry Station",           -2007.80,    56.30,     0.00, -1922.00,   224.70,   100.00},
{ "Class Selection",           942.5793,  0.2095,  1000.9295, 947.4127,  4.8616,  1000.9299},
{ "Creek",                        2749.90,  1937.20,   -89.00,  2921.60,  2669.70,   110.90},
{ "Dillimore",                     580.70,  -674.80,    -9.50,   861.00,  -404.70,   200.00},
{ "Doherty",                     -2270.00,  -324.10,    -0.00, -1794.90,  -222.50,   200.00},
{ "Doherty",                     -2173.00,  -222.50,    -0.00, -1794.90,   265.20,   200.00},
{ "Downtown",                    -1982.30,   744.10,    -6.10, -1871.70,  1274.20,   200.00},
{ "Downtown",                    -1871.70,  1176.40,    -4.50, -1620.30,  1274.20,   200.00},
{ "Downtown",                    -1700.00,   744.20,    -6.10, -1580.00,  1176.50,   200.00},
{ "Downtown",                    -1580.00,   744.20,    -6.10, -1499.80,  1025.90,   200.00},
{ "Downtown",                    -2078.60,   578.30,    -7.60, -1499.80,   744.20,   200.00},
{ "Downtown",                    -1993.20,   265.20,    -9.10, -1794.90,   578.30,   200.00},
{ "Downtown Los Santos",          1463.90, -1430.80,   -89.00,  1724.70, -1290.80,   110.90},
{ "Downtown Los Santos",          1724.70, -1430.80,   -89.00,  1812.60, -1250.90,   110.90},
{ "Downtown Los Santos",          1463.90, -1290.80,   -89.00,  1724.70, -1150.80,   110.90},
{ "Downtown Los Santos",          1370.80, -1384.90,   -89.00,  1463.90, -1170.80,   110.90},
{ "Downtown Los Santos",          1724.70, -1250.90,   -89.00,  1812.60, -1150.80,   110.90},
{ "Downtown Los Santos",          1370.80, -1170.80,   -89.00,  1463.90, -1130.80,   110.90},
{ "Downtown Los Santos",          1378.30, -1130.80,   -89.00,  1463.90, -1026.30,   110.90},
{ "Downtown Los Santos",          1391.00, -1026.30,   -89.00,  1463.90,  -926.90,   110.90},
{ "Downtown Los Santos",          1507.50, -1385.20,   110.90,  1582.50, -1325.30,   335.90},
{ "East Beach",                   2632.80, -1852.80,   -89.00,  2959.30, -1668.10,   110.90},
{ "East Beach",                   2632.80, -1668.10,   -89.00,  2747.70, -1393.40,   110.90},
{ "East Beach",                   2747.70, -1668.10,   -89.00,  2959.30, -1498.60,   110.90},
{ "East Beach",                   2747.70, -1498.60,   -89.00,  2959.30, -1120.00,   110.90},
{ "East Los Santos",              2421.00, -1628.50,   -89.00,  2632.80, -1454.30,   110.90},
{ "East Los Santos",              2222.50, -1628.50,   -89.00,  2421.00, -1494.00,   110.90},
{ "East Los Santos",              2266.20, -1494.00,   -89.00,  2381.60, -1372.00,   110.90},
{ "East Los Santos",              2381.60, -1494.00,   -89.00,  2421.00, -1454.30,   110.90},
{ "East Los Santos",              2281.40, -1372.00,   -89.00,  2381.60, -1135.00,   110.90},
{ "East Los Santos",              2381.60, -1454.30,   -89.00,  2462.10, -1135.00,   110.90},
{ "East Los Santos",              2462.10, -1454.30,   -89.00,  2581.70, -1135.00,   110.90},
{ "Easter Basin",                -1794.90,   249.90,    -9.10, -1242.90,   578.30,   200.00},
{ "Easter Basin",                -1794.90,   -50.00,    -0.00, -1499.80,   249.90,   200.00},
{ "Easter Bay Airport",          -1499.80,   -50.00,    -0.00, -1242.90,   249.90,   200.00},
{ "Easter Bay Airport",          -1794.90,  -730.10,    -3.00, -1213.90,   -50.00,   200.00},
{ "Easter Bay Airport",          -1213.90,  -730.10,     0.00, -1132.80,   -50.00,   200.00},
{ "Easter Bay Airport",          -1242.90,   -50.00,     0.00, -1213.90,   578.30,   200.00},
{ "Easter Bay Airport",          -1213.90,   -50.00,    -4.50,  -947.90,   578.30,   200.00},
{ "Easter Bay Airport",          -1315.40,  -405.30,    15.40, -1264.40,  -209.50,    25.40},
{ "Easter Bay Airport",          -1354.30,  -287.30,    15.40, -1315.40,  -209.50,    25.40},
{ "Easter Bay Airport",          -1490.30,  -209.50,    15.40, -1264.40,  -148.30,    25.40},
{ "Easter Bay Chemicals",        -1132.80,  -768.00,     0.00,  -956.40,  -578.10,   200.00},
{ "Easter Bay Chemicals",        -1132.80,  -787.30,     0.00,  -956.40,  -768.00,   200.00},
{ "El Castillo del Diablo",       -464.50,  2217.60,     0.00,  -208.50,  2580.30,   200.00},
{ "El Castillo del Diablo",       -208.50,  2123.00,    -7.60,   114.00,  2337.10,   200.00},
{ "El Castillo del Diablo",       -208.50,  2337.10,     0.00,     8.40,  2487.10,   200.00},
{ "El Corona",                    1812.60, -2179.20,   -89.00,  1970.60, -1852.80,   110.90},
{ "El Corona",                    1692.60, -2179.20,   -89.00,  1812.60, -1842.20,   110.90},
{ "El Quebrados",                -1645.20,  2498.50,     0.00, -1372.10,  2777.80,   200.00},
{ "Esplanade East",              -1620.30,  1176.50,    -4.50, -1580.00,  1274.20,   200.00},
{ "Esplanade East",              -1580.00,  1025.90,    -6.10, -1499.80,  1274.20,   200.00},
{ "Esplanade East",              -1499.80,   578.30,   -79.60, -1339.80,  1274.20,    20.30},
{ "Esplanade North",             -2533.00,  1358.90,    -4.50, -1996.60,  1501.20,   200.00},
{ "Esplanade North",             -1996.60,  1358.90,    -4.50, -1524.20,  1592.50,   200.00},
{ "Esplanade North",             -1982.30,  1274.20,    -4.50, -1524.20,  1358.90,   200.00},
{ "Fallen Tree",                  -792.20,  -698.50,    -5.30,  -452.40,  -380.00,   200.00},
{ "Fallow Bridge",                 434.30,   366.50,     0.00,   603.00,   555.60,   200.00},
{ "Fern Ridge",                    508.10,  -139.20,     0.00,  1306.60,   119.50,   200.00},
{ "Financial",                   -1871.70,   744.10,    -6.10, -1701.30,  1176.40,   300.00},
{ "Fisher's Lagoon",              1916.90,  -233.30,  -100.00,  2131.70,    13.80,   200.00},
{ "Flint Intersection",           -187.70, -1596.70,   -89.00,    17.00, -1276.60,   110.90},
{ "Flint Range",                  -594.10, -1648.50,     0.00,  -187.70, -1276.60,   200.00},
{ "Fort Carson",                  -376.20,   826.30,    -3.00,   123.70,  1220.40,   200.00},
{ "Foster Valley",               -2270.00,  -430.20,    -0.00, -2178.60,  -324.10,   200.00},
{ "Foster Valley",               -2178.60,  -599.80,    -0.00, -1794.90,  -324.10,   200.00},
{ "Foster Valley",               -2178.60, -1115.50,     0.00, -1794.90,  -599.80,   200.00},
{ "Foster Valley",               -2178.60, -1250.90,     0.00, -1794.90, -1115.50,   200.00},
{ "Frederick Bridge",             2759.20,   296.50,     0.00,  2774.20,   594.70,   200.00},
{ "Gant Bridge",                 -2741.40,  1659.60,    -6.10, -2616.40,  2175.10,   200.00},
{ "Gant Bridge",                 -2741.00,  1490.40,    -6.10, -2616.40,  1659.60,   200.00},
{ "Ganton",                       2222.50, -1852.80,   -89.00,  2632.80, -1722.30,   110.90},
{ "Ganton",                       2222.50, -1722.30,   -89.00,  2632.80, -1628.50,   110.90},
{ "Garcia",                      -2411.20,  -222.50,    -0.00, -2173.00,   265.20,   200.00},
{ "Garcia",                      -2395.10,  -222.50,    -5.30, -2354.00,  -204.70,   200.00},
{ "Garver Bridge",               -1339.80,   828.10,   -89.00, -1213.90,  1057.00,   110.90},
{ "Garver Bridge",               -1213.90,   950.00,   -89.00, -1087.90,  1178.90,   110.90},
{ "Garver Bridge",               -1499.80,   696.40,  -179.60, -1339.80,   925.30,    20.30},
{ "Glen Park",                    1812.60, -1449.60,   -89.00,  1996.90, -1350.70,   110.90},
{ "Glen Park",                    1812.60, -1100.80,   -89.00,  1994.30,  -973.30,   110.90},
{ "Glen Park",                    1812.60, -1350.70,   -89.00,  2056.80, -1100.80,   110.90},
{ "Green Palms",                   176.50,  1305.40,    -3.00,   338.60,  1520.70,   200.00},
{ "Greenglass College",            964.30,  1044.60,   -89.00,  1197.30,  1203.20,   110.90},
{ "Greenglass College",            964.30,   930.80,   -89.00,  1166.50,  1044.60,   110.90},
{ "Hampton Barns",                 603.00,   264.30,     0.00,   761.90,   366.50,   200.00},
{ "Hankypanky Point",             2576.90,    62.10,     0.00,  2759.20,   385.50,   200.00},
{ "Harry Gold Parkway",           1777.30,   863.20,   -89.00,  1817.30,  2342.80,   110.90},
{ "Hashbury",                    -2593.40,  -222.50,    -0.00, -2411.20,    54.70,   200.00},
{ "Hilltop Farm",                  967.30,  -450.30,    -3.00,  1176.70,  -217.90,   200.00},
{ "Hunter Quarry",                 337.20,   710.80,  -115.20,   860.50,  1031.70,   203.70},
{ "Idlewood",                     1812.60, -1852.80,   -89.00,  1971.60, -1742.30,   110.90},
{ "Idlewood",                     1812.60, -1742.30,   -89.00,  1951.60, -1602.30,   110.90},
{ "Idlewood",                     1951.60, -1742.30,   -89.00,  2124.60, -1602.30,   110.90},
{ "Idlewood",                     1812.60, -1602.30,   -89.00,  2124.60, -1449.60,   110.90},
{ "Idlewood",                     2124.60, -1742.30,   -89.00,  2222.50, -1494.00,   110.90},
{ "Idlewood",                     1971.60, -1852.80,   -89.00,  2222.50, -1742.30,   110.90},
{ "Jefferson",                    1996.90, -1449.60,   -89.00,  2056.80, -1350.70,   110.90},
{ "Jefferson",                    2124.60, -1494.00,   -89.00,  2266.20, -1449.60,   110.90},
{ "Jefferson",                    2056.80, -1372.00,   -89.00,  2281.40, -1210.70,   110.90},
{ "Jefferson",                    2056.80, -1210.70,   -89.00,  2185.30, -1126.30,   110.90},
{ "Jefferson",                    2185.30, -1210.70,   -89.00,  2281.40, -1154.50,   110.90},
{ "Jefferson",                    2056.80, -1449.60,   -89.00,  2266.20, -1372.00,   110.90},
{ "Julius Thruway East",          2623.10,   943.20,   -89.00,  2749.90,  1055.90,   110.90},
{ "Julius Thruway East",          2685.10,  1055.90,   -89.00,  2749.90,  2626.50,   110.90},
{ "Julius Thruway East",          2536.40,  2442.50,   -89.00,  2685.10,  2542.50,   110.90},
{ "Julius Thruway East",          2625.10,  2202.70,   -89.00,  2685.10,  2442.50,   110.90},
{ "Julius Thruway North",         2498.20,  2542.50,   -89.00,  2685.10,  2626.50,   110.90},
{ "Julius Thruway North",         2237.40,  2542.50,   -89.00,  2498.20,  2663.10,   110.90},
{ "Julius Thruway North",         2121.40,  2508.20,   -89.00,  2237.40,  2663.10,   110.90},
{ "Julius Thruway North",         1938.80,  2508.20,   -89.00,  2121.40,  2624.20,   110.90},
{ "Julius Thruway North",         1534.50,  2433.20,   -89.00,  1848.40,  2583.20,   110.90},
{ "Julius Thruway North",         1848.40,  2478.40,   -89.00,  1938.80,  2553.40,   110.90},
{ "Julius Thruway North",         1704.50,  2342.80,   -89.00,  1848.40,  2433.20,   110.90},
{ "Julius Thruway North",         1377.30,  2433.20,   -89.00,  1534.50,  2507.20,   110.90},
{ "Julius Thruway South",         1457.30,   823.20,   -89.00,  2377.30,   863.20,   110.90},
{ "Julius Thruway South",         2377.30,   788.80,   -89.00,  2537.30,   897.90,   110.90},
{ "Julius Thruway West",          1197.30,  1163.30,   -89.00,  1236.60,  2243.20,   110.90},
{ "Julius Thruway West",          1236.60,  2142.80,   -89.00,  1297.40,  2243.20,   110.90},
{ "Juniper Hill",                -2533.00,   578.30,    -7.60, -2274.10,   968.30,   200.00},
{ "Juniper Hollow",              -2533.00,   968.30,    -6.10, -2274.10,  1358.90,   200.00},
{ "K.A.C.C. Military Fuels",      2498.20,  2626.50,   -89.00,  2749.90,  2861.50,   110.90},
{ "Kincaid Bridge",              -1339.80,   599.20,   -89.00, -1213.90,   828.10,   110.90},
{ "Kincaid Bridge",              -1213.90,   721.10,   -89.00, -1087.90,   950.00,   110.90},
{ "Kincaid Bridge",              -1087.90,   855.30,   -89.00,  -961.90,   986.20,   110.90},
{ "King's",                      -2329.30,   458.40,    -7.60, -1993.20,   578.30,   200.00},
{ "King's",                      -2411.20,   265.20,    -9.10, -1993.20,   373.50,   200.00},
{ "King's",                      -2253.50,   373.50,    -9.10, -1993.20,   458.40,   200.00},
{ "LVA Freight Depot",            1457.30,   863.20,   -89.00,  1777.40,  1143.20,   110.90},
{ "LVA Freight Depot",            1375.60,   919.40,   -89.00,  1457.30,  1203.20,   110.90},
{ "LVA Freight Depot",            1277.00,  1087.60,   -89.00,  1375.60,  1203.20,   110.90},
{ "LVA Freight Depot",            1315.30,  1044.60,   -89.00,  1375.60,  1087.60,   110.90},
{ "LVA Freight Depot",            1236.60,  1163.40,   -89.00,  1277.00,  1203.20,   110.90},
{ "Las Barrancas",                -926.10,  1398.70,    -3.00,  -719.20,  1634.60,   200.00},
{ "Las Brujas",                   -365.10,  2123.00,    -3.00,  -208.50,  2217.60,   200.00},
{ "Las Colinas",                  1994.30, -1100.80,   -89.00,  2056.80,  -920.80,   110.90},
{ "Las Colinas",                  2056.80, -1126.30,   -89.00,  2126.80,  -920.80,   110.90},
{ "Las Colinas",                  2185.30, -1154.50,   -89.00,  2281.40,  -934.40,   110.90},
{ "Las Colinas",                  2126.80, -1126.30,   -89.00,  2185.30,  -934.40,   110.90},
{ "Las Colinas",                  2747.70, -1120.00,   -89.00,  2959.30,  -945.00,   110.90},
{ "Las Colinas",                  2632.70, -1135.00,   -89.00,  2747.70,  -945.00,   110.90},
{ "Las Colinas",                  2281.40, -1135.00,   -89.00,  2632.70,  -945.00,   110.90},
{ "Las Payasadas",                -354.30,  2580.30,     2.00,  -133.60,  2816.80,   200.00},
{ "Las Venturas Airport",         1236.60,  1203.20,   -89.00,  1457.30,  1883.10,   110.90},
{ "Las Venturas Airport",         1457.30,  1203.20,   -89.00,  1777.30,  1883.10,   110.90},
{ "Las Venturas Airport",         1457.30,  1143.20,   -89.00,  1777.40,  1203.20,   110.90},
{ "Las Venturas Airport",         1515.80,  1586.40,   -12.50,  1729.90,  1714.50,    87.50},
{ "Last Dime Motel",              1823.00,   596.30,   -89.00,  1997.20,   823.20,   110.90},
{ "Leafy Hollow",                -1166.90, -1856.00,     0.00,  -815.60, -1602.00,   200.00},
{ "Lil' Probe Inn",                -90.20,  1286.80,    -3.00,   153.80,  1554.10,   200.00},
{ "Linden Side",                  2749.90,   943.20,   -89.00,  2923.30,  1198.90,   110.90},
{ "Linden Station",               2749.90,  1198.90,   -89.00,  2923.30,  1548.90,   110.90},
{ "Linden Station",               2811.20,  1229.50,   -39.50,  2861.20,  1407.50,    60.40},
{ "Little Mexico",                1701.90, -1842.20,   -89.00,  1812.60, -1722.20,   110.90},
{ "Little Mexico",                1758.90, -1722.20,   -89.00,  1812.60, -1577.50,   110.90},
{ "Los Flores",                   2581.70, -1454.30,   -89.00,  2632.80, -1393.40,   110.90},
{ "Los Flores",                   2581.70, -1393.40,   -89.00,  2747.70, -1135.00,   110.90},
{ "Los Santos International",     1249.60, -2394.30,   -89.00,  1852.00, -2179.20,   110.90},
{ "Los Santos International",     1852.00, -2394.30,   -89.00,  2089.00, -2179.20,   110.90},
{ "Los Santos International",     1382.70, -2730.80,   -89.00,  2201.80, -2394.30,   110.90},
{ "Los Santos International",     1974.60, -2394.30,   -39.00,  2089.00, -2256.50,    60.90},
{ "Los Santos International",     1400.90, -2669.20,   -39.00,  2189.80, -2597.20,    60.90},
{ "Los Santos International",     2051.60, -2597.20,   -39.00,  2152.40, -2394.30,    60.90},
{ "Marina",                        647.70, -1804.20,   -89.00,   851.40, -1577.50,   110.90},
{ "Marina",                        647.70, -1577.50,   -89.00,   807.90, -1416.20,   110.90},
{ "Marina",                        807.90, -1577.50,   -89.00,   926.90, -1416.20,   110.90},
{ "Market",                        787.40, -1416.20,   -89.00,  1072.60, -1310.20,   110.90},
{ "Market",                        952.60, -1310.20,   -89.00,  1072.60, -1130.80,   110.90},
{ "Market",                       1072.60, -1416.20,   -89.00,  1370.80, -1130.80,   110.90},
{ "Market",                        926.90, -1577.50,   -89.00,  1370.80, -1416.20,   110.90},
{ "Market Station",                787.40, -1410.90,   -34.10,   866.00, -1310.20,    65.80},
{ "Martin Bridge",                -222.10,   293.30,     0.00,  -122.10,   476.40,   200.00},
{ "Missionary Hill",             -2994.40,  -811.20,     0.00, -2178.60,  -430.20,   200.00},
{ "Montgomery",                   1119.50,   119.50,    -3.00,  1451.40,   493.30,   200.00},
{ "Montgomery",                   1451.40,   347.40,    -6.10,  1582.40,   420.80,   200.00},
{ "Montgomery Intersection",      1546.60,   208.10,     0.00,  1745.80,   347.40,   200.00},
{ "Montgomery Intersection",      1582.40,   347.40,     0.00,  1664.60,   401.70,   200.00},
{ "Mulholland",                   1414.00,  -768.00,   -89.00,  1667.60,  -452.40,   110.90},
{ "Mulholland",                   1281.10,  -452.40,   -89.00,  1641.10,  -290.90,   110.90},
{ "Mulholland",                   1269.10,  -768.00,   -89.00,  1414.00,  -452.40,   110.90},
{ "Mulholland",                   1357.00,  -926.90,   -89.00,  1463.90,  -768.00,   110.90},
{ "Mulholland",                   1318.10,  -910.10,   -89.00,  1357.00,  -768.00,   110.90},
{ "Mulholland",                   1169.10,  -910.10,   -89.00,  1318.10,  -768.00,   110.90},
{ "Mulholland",                    768.60,  -954.60,   -89.00,   952.60,  -860.60,   110.90},
{ "Mulholland",                    687.80,  -860.60,   -89.00,   911.80,  -768.00,   110.90},
{ "Mulholland",                    737.50,  -768.00,   -89.00,  1142.20,  -674.80,   110.90},
{ "Mulholland",                   1096.40,  -910.10,   -89.00,  1169.10,  -768.00,   110.90},
{ "Mulholland",                    952.60,  -937.10,   -89.00,  1096.40,  -860.60,   110.90},
{ "Mulholland",                    911.80,  -860.60,   -89.00,  1096.40,  -768.00,   110.90},
{ "Mulholland",                    861.00,  -674.80,   -89.00,  1156.50,  -600.80,   110.90},
{ "Mulholland Intersection",      1463.90, -1150.80,   -89.00,  1812.60,  -768.00,   110.90},
{ "North Rock",                   2285.30,  -768.00,     0.00,  2770.50,  -269.70,   200.00},
{ "Ocean Docks",                  2373.70, -2697.00,   -89.00,  2809.20, -2330.40,   110.90},
{ "Ocean Docks",                  2201.80, -2418.30,   -89.00,  2324.00, -2095.00,   110.90},
{ "Ocean Docks",                  2324.00, -2302.30,   -89.00,  2703.50, -2145.10,   110.90},
{ "Ocean Docks",                  2089.00, -2394.30,   -89.00,  2201.80, -2235.80,   110.90},
{ "Ocean Docks",                  2201.80, -2730.80,   -89.00,  2324.00, -2418.30,   110.90},
{ "Ocean Docks",                  2703.50, -2302.30,   -89.00,  2959.30, -2126.90,   110.90},
{ "Ocean Docks",                  2324.00, -2145.10,   -89.00,  2703.50, -2059.20,   110.90},
{ "Ocean Flats",                 -2994.40,   277.40,    -9.10, -2867.80,   458.40,   200.00},
{ "Ocean Flats",                 -2994.40,  -222.50,    -0.00, -2593.40,   277.40,   200.00},
{ "Ocean Flats",                 -2994.40,  -430.20,    -0.00, -2831.80,  -222.50,   200.00},
{ "Octane Springs",                338.60,  1228.50,     0.00,   664.30,  1655.00,   200.00},
{ "Old Venturas Strip",           2162.30,  2012.10,   -89.00,  2685.10,  2202.70,   110.90},
{ "Palisades",                   -2994.40,   458.40,    -6.10, -2741.00,  1339.60,   200.00},
{ "Paradiso",                    -2741.00,   793.40,    -6.10, -2533.00,  1268.40,   200.00},
{ "Pershing Square",              1440.90, -1722.20,   -89.00,  1583.50, -1577.50,   110.90},
{ "Pilgrim",                      2437.30,  1383.20,   -89.00,  2624.40,  1783.20,   110.90},
{ "Pilgrim",                      2624.40,  1383.20,   -89.00,  2685.10,  1783.20,   110.90},
{ "Pilson Intersection",          1098.30,  2243.20,   -89.00,  1377.30,  2507.20,   110.90},
{ "Pirates in Men's Pants",       1817.30,  1469.20,   -89.00,  2027.40,  1703.20,   110.90},
{ "Playa del Seville",            2703.50, -2126.90,   -89.00,  2959.30, -1852.80,   110.90},
{ "Prickle Pine",                 1534.50,  2583.20,   -89.00,  1848.40,  2863.20,   110.90},
{ "Prickle Pine",                 1117.40,  2507.20,   -89.00,  1534.50,  2723.20,   110.90},
{ "Prickle Pine",                 1848.40,  2553.40,   -89.00,  1938.80,  2863.20,   110.90},
{ "Prickle Pine",                 1938.80,  2624.20,   -89.00,  2121.40,  2861.50,   110.90},
{ "Queens",                      -2533.00,   458.40,     0.00, -2329.30,   578.30,   200.00},
{ "Queens",                      -2593.40,    54.70,     0.00, -2411.20,   458.40,   200.00},
{ "Queens",                      -2411.20,   373.50,     0.00, -2253.50,   458.40,   200.00},
{ "Randolph Industrial Estate",   1558.00,   596.30,   -89.00,  1823.00,   823.20,   110.90},
{ "Redsands East",                1817.30,  2011.80,   -89.00,  2106.70,  2202.70,   110.90},
{ "Redsands East",                1817.30,  2202.70,   -89.00,  2011.90,  2342.80,   110.90},
{ "Redsands East",                1848.40,  2342.80,   -89.00,  2011.90,  2478.40,   110.90},
{ "Redsands West",                1236.60,  1883.10,   -89.00,  1777.30,  2142.80,   110.90},
{ "Redsands West",                1297.40,  2142.80,   -89.00,  1777.30,  2243.20,   110.90},
{ "Redsands West",                1377.30,  2243.20,   -89.00,  1704.50,  2433.20,   110.90},
{ "Redsands West",                1704.50,  2243.20,   -89.00,  1777.30,  2342.80,   110.90},
{ "Regular Tom",                  -405.70,  1712.80,    -3.00,  -276.70,  1892.70,   200.00},
{ "Richman",                       647.50, -1118.20,   -89.00,   787.40,  -954.60,   110.90},
{ "Richman",                       647.50,  -954.60,   -89.00,   768.60,  -860.60,   110.90},
{ "Richman",                       225.10, -1369.60,   -89.00,   334.50, -1292.00,   110.90},
{ "Richman",                       225.10, -1292.00,   -89.00,   466.20, -1235.00,   110.90},
{ "Richman",                        72.60, -1404.90,   -89.00,   225.10, -1235.00,   110.90},
{ "Richman",                        72.60, -1235.00,   -89.00,   321.30, -1008.10,   110.90},
{ "Richman",                       321.30, -1235.00,   -89.00,   647.50, -1044.00,   110.90},
{ "Richman",                       321.30, -1044.00,   -89.00,   647.50,  -860.60,   110.90},
{ "Richman",                       321.30,  -860.60,   -89.00,   687.80,  -768.00,   110.90},
{ "Richman",                       321.30,  -768.00,   -89.00,   700.70,  -674.80,   110.90},
{ "Robada Intersection",         -1119.00,  1178.90,   -89.00,  -862.00,  1351.40,   110.90},
{ "Roca Escalante",               2237.40,  2202.70,   -89.00,  2536.40,  2542.50,   110.90},
{ "Roca Escalante",               2536.40,  2202.70,   -89.00,  2625.10,  2442.50,   110.90},
{ "Rockshore East",               2537.30,   676.50,   -89.00,  2902.30,   943.20,   110.90},
{ "Rockshore West",               1997.20,   596.30,   -89.00,  2377.30,   823.20,   110.90},
{ "Rockshore West",               2377.30,   596.30,   -89.00,  2537.30,   788.80,   110.90},
{ "Rodeo",                          72.60, -1684.60,   -89.00,   225.10, -1544.10,   110.90},
{ "Rodeo",                          72.60, -1544.10,   -89.00,   225.10, -1404.90,   110.90},
{ "Rodeo",                         225.10, -1684.60,   -89.00,   312.80, -1501.90,   110.90},
{ "Rodeo",                         225.10, -1501.90,   -89.00,   334.50, -1369.60,   110.90},
{ "Rodeo",                         334.50, -1501.90,   -89.00,   422.60, -1406.00,   110.90},
{ "Rodeo",                         312.80, -1684.60,   -89.00,   422.60, -1501.90,   110.90},
{ "Rodeo",                         422.60, -1684.60,   -89.00,   558.00, -1570.20,   110.90},
{ "Rodeo",                         558.00, -1684.60,   -89.00,   647.50, -1384.90,   110.90},
{ "Rodeo",                         466.20, -1570.20,   -89.00,   558.00, -1385.00,   110.90},
{ "Rodeo",                         422.60, -1570.20,   -89.00,   466.20, -1406.00,   110.90},
{ "Rodeo",                         466.20, -1385.00,   -89.00,   647.50, -1235.00,   110.90},
{ "Rodeo",                         334.50, -1406.00,   -89.00,   466.20, -1292.00,   110.90},
{ "San Andreas Sound",            2450.30,   385.50,  -100.00,  2759.20,   562.30,   200.00},
{ "Santa Flora",                 -2741.00,   458.40,    -7.60, -2533.00,   793.40,   200.00},
{ "Santa Maria Beach",             342.60, -2173.20,   -89.00,   647.70, -1684.60,   110.90},
{ "Santa Maria Beach",              72.60, -2173.20,   -89.00,   342.60, -1684.60,   110.90},
{ "Shady Cabin",                 -1632.80, -2263.40,    -3.00, -1601.30, -2231.70,   200.00},
{ "Shady Creeks",                -1820.60, -2643.60,    -8.00, -1226.70, -1771.60,   200.00},
{ "Shady Creeks",                -2030.10, -2174.80,    -6.10, -1820.60, -1771.60,   200.00},
{ "Sobell Rail Yards",            2749.90,  1548.90,   -89.00,  2923.30,  1937.20,   110.90},
{ "Temple",                       1252.30, -1130.80,   -89.00,  1378.30, -1026.30,   110.90},
{ "Temple",                       1252.30, -1026.30,   -89.00,  1391.00,  -926.90,   110.90},
{ "Temple",                       1252.30,  -926.90,   -89.00,  1357.00,  -910.10,   110.90},
{ "Temple",                        952.60, -1130.80,   -89.00,  1096.40,  -937.10,   110.90},
{ "Temple",                       1096.40, -1130.80,   -89.00,  1252.30, -1026.30,   110.90},
{ "Temple",                       1096.40, -1026.30,   -89.00,  1252.30,  -910.10,   110.90},
{ "The Emerald Isle",             2011.90,  2202.70,   -89.00,  2237.40,  2508.20,   110.90},
{ "The Farm",                    -1209.60, -1317.10,   114.90,  -908.10,  -787.30,   251.90},
{ "The Mako Span",                1664.60,   401.70,     0.00,  1785.10,   567.20,   200.00},
{ "The Panopticon",               -947.90,  -304.30,    -1.10,  -319.60,   327.00,   200.00},
{ "The Sherman Dam",              -968.70,  1929.40,    -3.00,  -481.10,  2155.20,   200.00},
{ "The Visage",                   1817.30,  1863.20,   -89.00,  2106.70,  2011.80,   110.90},
{ "The Visage",                   1817.30,  1703.20,   -89.00,  2027.40,  1863.20,   110.90},
{ "Unity Station",                1692.60, -1971.80,   -20.40,  1812.60, -1932.80,    79.50},
{ "Valle Ocultado",               -936.60,  2611.40,     2.00,  -715.90,  2847.90,   200.00},
{ "Verdant Bluffs",                930.20, -2488.40,   -89.00,  1249.60, -2006.70,   110.90},
{ "Verdant Bluffs",               1073.20, -2006.70,   -89.00,  1249.60, -1842.20,   110.90},
{ "Verdant Bluffs",               1249.60, -2179.20,   -89.00,  1692.60, -1842.20,   110.90},
{ "Verdant Meadows",                37.00,  2337.10,    -3.00,   435.90,  2677.90,   200.00},
{ "Verona Beach",                  647.70, -2173.20,   -89.00,   930.20, -1804.20,   110.90},
{ "Verona Beach",                  930.20, -2006.70,   -89.00,  1073.20, -1804.20,   110.90},
{ "Verona Beach",                  851.40, -1804.20,   -89.00,  1046.10, -1577.50,   110.90},
{ "Verona Beach",                 1161.50, -1722.20,   -89.00,  1323.90, -1577.50,   110.90},
{ "Verona Beach",                 1046.10, -1722.20,   -89.00,  1161.50, -1577.50,   110.90},
{ "Vinewood",                      787.40, -1310.20,   -89.00,   952.60, -1130.80,   110.90},
{ "Vinewood",                      787.40, -1130.80,   -89.00,   952.60,  -954.60,   110.90},
{ "Vinewood",                      647.50, -1227.20,   -89.00,   787.40, -1118.20,   110.90},
{ "Vinewood",                      647.70, -1416.20,   -89.00,   787.40, -1227.20,   110.90},
{ "Whitewood Estates",             883.30,  1726.20,   -89.00,  1098.30,  2507.20,   110.90},
{ "Whitewood Estates",            1098.30,  1726.20,   -89.00,  1197.30,  2243.20,   110.90},
{ "Willowfield",                  1970.60, -2179.20,   -89.00,  2089.00, -1852.80,   110.90},
{ "Willowfield",                  2089.00, -2235.80,   -89.00,  2201.80, -1989.90,   110.90},
{ "Willowfield",                  2089.00, -1989.90,   -89.00,  2324.00, -1852.80,   110.90},
{ "Willowfield",                  2201.80, -2095.00,   -89.00,  2324.00, -1989.90,   110.90},
{ "Willowfield",                  2541.70, -1941.40,   -89.00,  2703.50, -1852.80,   110.90},
{ "Willowfield",                  2324.00, -2059.20,   -89.00,  2541.70, -1852.80,   110.90},
{ "Willowfield",                  2541.70, -2059.20,   -89.00,  2703.50, -1941.40,   110.90},
{ "Yellow Bell Station",          1377.40,  2600.40,   -21.90,  1492.40,  2687.30,    78.00},
{ "Los Santos",                     44.60, -2892.90,  -242.90,  2997.00,  -768.00,   900.00},
{ "Bone County",                  -480.50,   596.30,  -242.90,   869.40,  2993.80,   900.00},
{ "Tierra Robada",               -2997.40,  1659.60,  -242.90,  -480.50,  2993.80,   900.00},
{ "Tierra Robada",               -1213.90,   596.30,  -242.90,  -480.50,  1659.60,   900.00},
{ "Flint County",                -1213.90, -2892.90,  -242.90,    44.60,  -768.00,   900.00},
{ "Whetstone",                   -2997.40, -2892.90,  -242.90, -1213.90, -1115.50,   900.00}
};


new zoneupdates[MAX_PLAYERS_];
new player_zone[MAX_PLAYERS_];
new zoneupdate;
new Text:LocationTD[MAX_PLAYERS];
public update_zones()
{
 	new line1[10];
 	new line2[10];

	for(new i=0; i<MAX_PLAYERS_; i++)
	{
		if(IsPlayerConnected(i) && zoneupdates[i] == 1)
		{
   			if(IsPlayerInZone(i,player_zone[i]))
  			{
  			}
   			else {
			    new player_zone_before;
			    player_zone_before = player_zone[i];
			    player_zone[i] = -1;
				for(new j=0; j<sizeof(zones);j++)
				{
	     			if(IsPlayerInZone(i,j) && player_zone[i] == -1)
					{

						if(player_zone_before == -1) 
						{
						    new string[128];
					 		format(string,sizeof(string),"%s",zones[j][zone_name]);
						 	TextDrawSetString(LocationTD[i],string);
						}
	   	  				else
					 	{
					 		if(strcmp(zones[j][zone_name],zones[player_zone_before][zone_name],true) != 0)
					 		{
					 		    new string[128];
					 		    format(string,sizeof(string),"%s",zones[j][zone_name]);
						 		TextDrawSetString(LocationTD[i],string);
							}
						}
						player_zone[i] = j;
				      	format(line1,10,"p%dzone",i);
				      	format(line2,10,"%d",j);
				      	PropertySet(line1,line2);
					}
				}
    			if(player_zone[i] == -1) player_zone[i] = player_zone_before;
			}
   		}
	}
}

IsPlayerInZone(playerid, zoneid)
{
 	if(zoneid == -1) return 0;
 	new Float:x, Float:y, Float:z;
 	GetPlayerPos(playerid,x,y,z);
	if(x >= zones[zoneid][zone_minx] && x < zones[zoneid][zone_maxx]
	&& y >= zones[zoneid][zone_miny] && y < zones[zoneid][zone_maxy]
	&& z >= zones[zoneid][zone_minz] && z < zones[zoneid][zone_maxz]
	&& z < 1200.0000) return 1;
 	return 0;
}
//--------------------------------------

new gBotID[MAX_BOTS],gGroupID,gGroupAdminID;

new IsSpawned[MAX_PLAYERS];
new Banning[MAX_PLAYERS];
new Kicking[MAX_PLAYERS];
new IsMuted[MAX_PLAYERS];
new IsFrozen[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new CanChooseSkill[MAX_PLAYERS];
new PLAYERLIST_authed[MAX_PLAYERS];
new PasswordAttempts[MAX_PLAYERS];
new BankCash[MAX_PLAYERS];
new CanUseArmy[MAX_PLAYERS];
new CanUseCIA[MAX_PLAYERS];
new AdminLevel[MAX_PLAYERS];
new HasWeed[MAX_PLAYERS];
new HasHeroin[MAX_PLAYERS];
new HasRope[MAX_PLAYERS];
new HasScissors[MAX_PLAYERS];
new HasSausageRolls[MAX_PLAYERS];
new HasAntiSTI[MAX_PLAYERS];
new HasSecureWallet[MAX_PLAYERS];
new HasNeedleAndSyringe[MAX_PLAYERS];
new HasPackC4[MAX_PLAYERS];
new HasPackRope[MAX_PLAYERS];
new HasPackMoney[MAX_PLAYERS];
new IrcColor[MAX_PLAYERS];
new HasLawEnforcementRadio[MAX_PLAYERS];
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new IsCuffed[MAX_PLAYERS];
new AttemptedToCuffRecently[MAX_PLAYERS];
new AttemptedToRapeRecently[MAX_PLAYERS];
new HasUsedDeath[MAX_PLAYERS];
new IsRegularPlayer[MAX_PLAYERS];
new HasTicket[MAX_PLAYERS];
new TimeToPayTicket[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new JailTime[MAX_PLAYERS];
new TotalJailTime[MAX_PLAYERS];
new LastVehicle[MAX_PLAYERS];
new CuffTime[MAX_PLAYERS];
new IsDetained[MAX_PLAYERS];
new MessageTDTime[MAX_PLAYERS];
new HasBeenReportedRecently[MAX_PLAYERS];
new CIAPlayerBeingViewed[MAX_PLAYERS] =-1;
new CIAIsBeingWatched[MAX_PLAYERS];
new StoppedSatViewing[MAX_PLAYERS];
new PlayerWeapon[MAX_PLAYERS][13];
new PlayerAmmo[MAX_PLAYERS][13];
new IsTackled[MAX_PLAYERS];
new AttemptedToTackleRecently[MAX_PLAYERS];
new RobbingSupaSave[MAX_PLAYERS];
new RobbingDrugHouse[MAX_PLAYERS];
new SpamStrings[MAX_PLAYERS];
new Warns[MAX_PLAYERS];
new InAdminMode[MAX_PLAYERS];
new IsBeingSpectated[MAX_PLAYERS];
new SpectatingPlayer[MAX_PLAYERS];
new AdminKilled[MAX_PLAYERS];
new SkillPrice[MAX_PLAYERS] =2000;
new CalledForMedic[MAX_PLAYERS];
new CalledForMechanic[MAX_PLAYERS];
new CalledForTaxi[MAX_PLAYERS];
new CalledForDrugDealer[MAX_PLAYERS];
new CalledForWeaponDealer[MAX_PLAYERS];
new HasSTI[MAX_PLAYERS];
new PayingTaxi[MAX_PLAYERS];
new HasTaxiFare[MAX_PLAYERS] =-1;
new OnDuty[MAX_PLAYERS];
new TeamKillWarning[MAX_PLAYERS];
new NameBanned[MAX_PLAYERS];
new OldCash[MAX_PLAYERS];
new DiedFromSTI[MAX_PLAYERS];
new HasRapedRecently[MAX_PLAYERS];
new DrugHouseOwner[MAX_PLAYERS];
new OttoOwner[MAX_PLAYERS];
new GivenWeedRecently[MAX_PLAYERS];
new GivenHeroinRecently[MAX_PLAYERS];
new SmokingWeed[MAX_PLAYERS];
new InjectedHeroin[MAX_PLAYERS];
new GivenWeaponRecently[MAX_PLAYERS];
new PlacedHitRecently[MAX_PLAYERS];
new HasHit[MAX_PLAYERS];
new HitMoney[MAX_PLAYERS];
new IsKidnapped[MAX_PLAYERS];
new AttemptedToKidnapRecently[MAX_PLAYERS];
new HasKidnappedRecently[MAX_PLAYERS];
new AttemptedToRobRecently[MAX_PLAYERS];
new HasRobbedRecently[MAX_PLAYERS];
new RobbingOtto[MAX_PLAYERS];
new afktag[MAX_PLAYERS];
new Away[MAX_PLAYERS];
new HasC4[MAX_PLAYERS];
new HasBlownVehicleRecently[MAX_PLAYERS];
new TerroristSkill[MAX_PLAYERS];
new IsPlantingCIABuilding[MAX_PLAYERS];
new IsPlantingCIASat[MAX_PLAYERS];
new IsPlantingCIABridge[MAX_PLAYERS];
new RobSkill[MAX_PLAYERS];
new RobbingGarciaBurgerShot[MAX_PLAYERS];
new RobbingDownBurgerShot[MAX_PLAYERS];
new RobbingJHBurgerShot[MAX_PLAYERS];
new RobbingOceanCluckinBell[MAX_PLAYERS];
new RobbingDownCluckinBell[MAX_PLAYERS];
new RobbingAmmunation[MAX_PLAYERS];
new RobbingGayDar[MAX_PLAYERS];
new RobbingZero[MAX_PLAYERS];
new RobbingMistys[MAX_PLAYERS];
new RobbingGYM[MAX_PLAYERS];
new RobbingSchool[MAX_PLAYERS];
new RobbingWang[MAX_PLAYERS];
new RobbingTrain[MAX_PLAYERS];
new RobbingBarbers[MAX_PLAYERS];
new RobbingHospital[MAX_PLAYERS];
new RobbingJizzys[MAX_PLAYERS];
new RobbingEsplanadePizza[MAX_PLAYERS];
new RobbingFinancialPizza[MAX_PLAYERS];
new RobbingDownZip[MAX_PLAYERS];
new RobbingDownVictim[MAX_PLAYERS];
new RobbingJHBinco[MAX_PLAYERS];
new RobbingCityHall[MAX_PLAYERS];
new SavedJailTime[MAX_PLAYERS];
new SavedWantedLevel[MAX_PLAYERS];
new HasEatenSausageRecently[MAX_PLAYERS];

//Robberies
new SupaSaveRobbedRecently =0;
new DrugHouseRobbedRecently =0;
new OttoRobbedRecently =0;
new GarciaBurgerShotRobbedRecently =0;
new DownBurgerShotRobbedRecently =0;
new JHBurgerShotRobbedRecently =0;
new OceanCluckinBellRobbedRecently =0;
new DownCluckinBellRobbedRecently =0;
new AmmunationRobbedRecently =0;
new GayDarRobbedRecently =0;
new ZeroRobbedRecently =0;
new MistysRobbedRecently =0;
new GYMRobbedRecently =0;
new SchoolRobbedRecently =0;
new WangRobbedRecently =0;
new TrainRobbedRecently =0;
new BarbersRobbedRecently =0;
new HospitalRobbedRecently =0;
new JizzysRobbedRecently =0;
new EsplanadePizzaRobbedRecently =0;
new FinancialPizzaRobbedRecently =0;
new DownZipRobbedRecently =0;
new DownVictimRobbedRecently =0;
new JHBincoRobbedRecently =0;
new CityHallRobbedRecently =0;

//BlownRecently
new CIABuildingBlown =0;
new CIASatBlown =0;
new CIABridgeBlown =0;

//SFPD Gates
new SFPDRightGate;
new SFPDLeftGate;
new SFPDGateOpen =0;
new SFPDShutter;
new SFPDShutterOpen =0;

//Army Gate
new ArmyGate;
new ArmyGateOpen =0;

//CIA Gates
new CIARightGate;
new CIALeftGate;
new CIAGateOpen =0;

//FBI Gates
new FBIRightGate;
new FBILeftGate;
new FBIRightGateOpen =0;
new FBILeftGateOpen =0;
new FBIShutter;
new FBIShutterOpen =0;

//Buildings
new CIABuilding;

//CIA Bridge
new CIABridge;

//CIA Satelite
new CIASat;

//==============================================================================

new gametime =12;
new gameday =1;
new gameweek =1;

//==============================================================================

//MENUS
new Menu:SkillMenu;

//TextDraws
new Text:JailTimer[MAX_PLAYERS];
new Text:VersionTD;
new Text:WebsiteTD;
new Text:MessageTD[MAX_PLAYERS];

//Vehicles
new NPCTram;

new PoliceCar1;
new PoliceCar2;
new PoliceCar3;
new PoliceCar4;
new PoliceCar5;
new PoliceCar6;
new PoliceCar7;
new PoliceCar8;
new PoliceCar9;
new PoliceCar10;
new PoliceCar11;
new PoliceCar12;
new PoliceCar14;
new PoliceCar15;
new PoliceCar16;
new PoliceCar17;
new PoliceCar18;
new PoliceCar19;
new PoliceCar20;
new PoliceCar21;
new PoliceCar22;
new PoliceCar23;
new PoliceCar24;
new PoliceCar25;
new PoliceCar26;
new PoliceCar27;
new PoliceCar28;
new PoliceCar29;
new PoliceCar30;
new PoliceCar31;
new PoliceCar32;
new PoliceCar33;
new PoliceCar34;
new PoliceCar35;
new PoliceCar36;
new PoliceCar37;
new PoliceCar38;
new PoliceCar39;
new PoliceCar40;
new PoliceCar41;
new PoliceCar42;
new PoliceCar43;
new PoliceCar44;
new PoliceCar45;
new PoliceCar46;
new PoliceCar47;

new ArmyVehicle0;
new ArmyVehicle1;
new ArmyVehicle2;
new ArmyVehicle3;
new ArmyVehicle4;
new ArmyVehicle5;
new ArmyVehicle6;
new ArmyVehicle7;
new ArmyVehicle8;
new ArmyVehicle9;
new ArmyVehicle10;
new ArmyVehicle11;
new ArmyVehicle12;
new ArmyVehicle13;
new ArmyVehicle14;
new ArmyVehicle15;
new ArmyVehicle16;
new ArmyVehicle17;
new ArmyVehicle18;
new ArmyVehicle19;
new ArmyVehicle20;
new ArmyVehicle21;
new ArmyVehicle22;

new CIAVehicle1;
new CIAVehicle2;
new CIAVehicle3;
new CIAVehicle4;
new CIAVehicle5;
new CIAVehicle6;
new CIAVehicle7;
new CIAVehicle8;
new CIAVehicle9;
new CIAVehicle10;
new CIAVehicle11;
new CIAVehicle12;
new CIAVehicle13;
new CIAVehicle14;
new CIAVehicle15;
new CIAVehicle16;
new CIAVehicle17;
new CIAVehicle18;
new CIAVehicle19;

new FBIVehicle1;
new FBIVehicle2;
new FBIVehicle3;
new FBIVehicle4;
new FBIVehicle5;
new FBIVehicle6;
new FBIVehicle7;
new FBIVehicle8;
new FBIVehicle9;
new FBIVehicle10;
new FBIVehicle11;
new FBIVehicle12;
new FBIVehicle13;
new FBIVehicle14;
new FBIVehicle15;
new FBIVehicle16;
new FBIVehicle17;

new MedicVehicle1;
new MedicVehicle2;
new MedicVehicle3;
new MedicVehicle4;
new MedicVehicle5;
new MedicVehicle6;
new MedicVehicle7;
new MedicVehicle8;
new MedicVehicle9;
new MedicVehicle10;

new TaxiVehicle1;
new TaxiVehicle2;
new TaxiVehicle3;
new TaxiVehicle4;
new TaxiVehicle5;
new TaxiVehicle6;
new TaxiVehicle7;
new TaxiVehicle8;
new TaxiVehicle9;
new TaxiVehicle10;
new TaxiVehicle11;
new TaxiVehicle12;
new TaxiVehicle13;
new TaxiVehicle14;

//==============================================================================

//Pickups
new FBIInsidePickup;
new FBIRoofPickup;
new FBIGaragePickup;

//==============================================================================

//Gang Zones
new ArmyZone;
new CIAZone;
new FBIZone;
new SFPDZone;
new TaxiZone;

//==============================================================================

//Forwards
forward ResetVariables(playerid);
forward Say(channel[],msg[]);
forward LSay(channel[],msg[]);
forward KickPlayer();
forward BanPlayer();
forward CheckPasswordAttempts(playerid);
forward SetPlayerToTeamColour(playerid);
forward PlayerOneSecondVariables();
forward ServerOneSecondVariables();
forward SendClientMessageToAllAdmins(msg[]);
forward SendClientMessageToAllRegulars(msg[]);
forward SendClientMessageToAllCops(msg[]);
forward SendClientMessageToAllMedics(msg[]);
forward SendClientMessageToAllMechanics(msg[]);
forward SendClientMessageToAllDrivers(msg[]);
forward SendClientMessageToAllDDealers(msg[]);
forward SendClientMessageToAllGDealers(msg[]);
forward SendClientMessageToAllHitmen(msg[]);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward RemoveRoadblock(playerid);
forward SafeSetPlayerPos(playerid, Float:x, Float:y, Float:z);
forward RemoveRoadblock(playerid);
forward IncreaseWantedLevel(playerid,Value);
forward IncreasePlayerScore(playerid,Value);
forward DecreasePlayerScore(playerid,Value);
forward getCheckpointType(playerID);
forward checkpointUpdate();
forward isPlayerInArea(playerID, Float:data[4]);
forward Timer();////////////For xObjects
forward SetPlayerPosWithObjects(playerid,Float:x,Float:y,Float:z);
forward update_zones();
forward SFPDGatesOpen();
forward SFPDGatesClose();
forward ArmyGatesOpen();
forward ArmyGatesClose();
forward CIAGatesOpen();
forward CIAGatesClose();
forward FBIRightGatesOpen();
forward FBIRightGatesClose();
forward FBILeftGatesOpen();
forward FBILeftGatesClose();
forward IsAPlane(carid);
forward IsACycleBike(carid);
forward TaxiPay();
forward TimeWorld();
forward HasIlegalWeapon(playerid);
forward HasSTITimer();
forward SendClientMessageToDHOwner(msg[]);
forward RandomMessage();
forward TextDrawColorChange();
forward GameModeText();
//
forward PlantingOneCIABuilding();
forward PlantingTwoCIABuilding();
forward PlantingThreeCIABuilding();
forward FinalPlantCIABuilding();
forward CIABuildingExplosionOne();
forward CIABuildingExplosionTwo();
forward CIABuildingExplosionThree();
forward CIABuildingExplosionFour();
forward CIABuildingExplosionFive();
forward CIABuildingExplosionSix();
forward CIABuildingExplosionSeven();
forward CIABuildingExplosionEight();
forward RestoreCIABuilding();
//
forward PlantingOneCIASat();
forward PlantingTwoCIASat();
forward PlantingThreeCIASat();
forward PlantingFourCIASat();
forward FinalPlantCIASat();
forward CIASatExplosionOne();
forward CIASatExplosionTwo();
forward CIASatExplosionThree();
forward CIASatExplosionFour();
forward CIASatExplosionFive();
forward RestoreCIASat();
//
forward PlantingOneCIABridge();
forward PlantingTwoCIABridge();
forward PlantingThreeCIABridge();
forward FinalPlantCIABridge();
forward CIABridgeExplosionOne();
forward CIABridgeExplosionTwo();
forward CIABridgeExplosionThree();
forward CIABridgeExplosionFour();
forward CIABridgeExplosionFive();
forward RestoreCIABridge();
//


//==============================================================================

main()
{
	print("\n----------------------------------");
	printf("{%s} %s",sabbv,svname);
	print("----------------------------------\n");
}

//==============================================================================

public OnGameModeInit()
{
	new string[128];
	format(string,sizeof(string),"hostname {%s} %s v%s",sabbv,svname,sversion);
	SendRconCommand(string);
	
	SetGameModeText("Cops-Robbers-RPG");
	SetTeamCount(1);
	AllowInteriorWeapons(1);
	//UsePlayerPedAnims();
	SetWorldTime(12);
	SetWeather(10);
	ManualVehicleEngineAndLights();
	AllowAdminTeleport(1);
	ConnectNPC("Billy","SFTram");

	#if USE_IRC == true
	//IRC Connect
	SetTimerEx("IRC_ConnectDelay", 5000, 0, "d", 1);
	SetTimerEx("IRC_ConnectDelay", 10000, 0, "d", 2);
	SetTimerEx("IRC_ConnectDelay", 15000, 0, "d", 3);
	gGroupID = IRC_CreateGroup();
	gGroupAdminID = IRC_CreateGroup();
	#endif
	
	//Timers
	SetTimer("PlayerOneSecondVariables",1000,1);
	SetTimer("ServerOneSecondVariables",1000,1);
	SetTimer("checkpointUpdate",1100,1);
	SetTimer("SFPDGatesOpen",1000,1);
	SetTimer("ArmyGatesOpen",1000,1);
	SetTimer("CIAGatesOpen",1000,1);
	SetTimer("FBIRightGatesOpen",1000,1);
	SetTimer("FBILeftGatesOpen",1000,1);
	SetTimer("TaxiPay",60000,1);
	SetTimer("TimeWorld",60000,1);
	SetTimer("HasSTITimer",10000,1);
	SetTimer("RandomMessage",120000,1);
	SetTimer("TextDrawColorChange",120000,1);
	SetTimer("GameModeText",120000,1);
    timer = SetTimer("Timer",500,1);
    if(!zoneupdate) zoneupdate = SetTimer("update_zones",1000,4);
    
    //Gang Zones (Area Colour)
	ArmyZone = GangZoneCreate(-1546.4114,260.0058,-1222.0865,521.8784);
	FBIZone = GangZoneCreate(-1780.9791,939.1539,-1683.4225,1063.1093);
	CIAZone = GangZoneCreate(-1336.4915,705.7386,-1182.2593,823.7599);
	SFPDZone = GangZoneCreate(-1701.5393,647.1263,-1571.7961,718.8061);
	TaxiZone = GangZoneCreate(-1681.0787,1278.7904,-1632.4701,1331.4086);
	
	// Player Classes
	AddPlayerClass(266,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); // citycop
	AddPlayerClass(211,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); // female citycop
	AddPlayerClass(265,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); // citycop
	AddPlayerClass(267,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); // citycop
	AddPlayerClass(283,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); //  police
	AddPlayerClass(284,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); //  police
	AddPlayerClass(285,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); //  police
	AddPlayerClass(286,-1722.3170,1018.0255,17.5859,88.8758,3,1,22,50,29,500); // fbi
    AddPlayerClass(287,2941.0012,468.3174,21.6395,49.3062,24,50,30,500,34,20); // army
    AddPlayerClass(164,-1590.5083,716.0220,-5.2422,269.2736,23,100,25,50,0,0); // CIA spawn
    AddPlayerClass(122,-1590.5083,716.0220,-5.2422,269.2736,3,1,22,50,29,500); // plain clothes
    AddPlayerClass(71,-1261.6409,38.9104,14.1387,226.4688,3,1,22,50,29,500); // air cops
    AddPlayerClass(71,-1552.3872,1275.2610,7.1845,177.3413,3,1,22,50,29,500); // marine unit new
    AddPlayerClass(276,1624.2527,1821.0498,10.8203,5.6779,22,50,0,0,0,0); // medic 2
	AddPlayerClass(50,2006.1929,2295.9451,10.8203,177.4306,22,50,0,0,0,0); // mechanic spawn
    AddPlayerClass(133,1151.7200,1399.4144,5.8203,0.9030,22,50,0,0,0,0); // driver spawn male
    AddPlayerClass(151,1151.7200,1399.4144,5.8203,0.9030,22,50,0,0,0,0); // driver spawn female
    AddPlayerClass(12,2090.1008,2078.2600,10.8203,263.0699,0,0,0,0,0,0);// civil skin
    AddPlayerClass(23,2090.1008,2078.2600,10.8203,263.0699,0,0,0,0,0,0);// civil skin
    AddPlayerClass(29,2815.0498,2254.1252,10.8203,158.6954,0,0,0,0,0,0); // hoody skin civi
    AddPlayerClass(294,2814.0542,2253.4043,10.8203,315.9051,0,0,0,0,0,0); // woozie skin
    AddPlayerClass(214,2812.1963,2247.7256,10.8203,352.8735,0,0,0,0,0,0); // civi
    AddPlayerClass(1,2634.0793,1072.6293,10.8203,88.4012,0,0,0,0,0,0);// civil skin
    AddPlayerClass(15,2634.0793,1072.6293,10.8203,88.4012,0,0,0,0,0,0);// civil skin
    AddPlayerClass(34,2634.0793,1072.6293,10.8203,88.4012,0,0,0,0,0,0);// civil skin
    AddPlayerClass(2,2193.6528,2007.7402,12.2894,1.8574,0,0,0,0,0,0);// civil skin
    AddPlayerClass(9,2193.6528,2007.7402,12.2894,1.8574,0,0,0,0,0,0); // civil skin
    AddPlayerClass(19,2193.6528,2007.7402,12.2894,1.8574,0,0,0,0,0,0);// civil skin
    AddPlayerClass(22,2193.6528,2007.7402,12.2894,1.8574,0,0,0,0,0,0);// civil skin
    AddPlayerClass(26,2082.0784,2480.8333,10.8203,182.0390,0,0,0,0,0,0);// civil skin
    AddPlayerClass(31,2082.0784,2480.8333,10.8203,182.0390,0,0,0,0,0,0);// civil skin
    AddPlayerClass(45,2082.0784,2480.8333,10.8203,182.0390,0,0,0,0,0,0);// civil skin
    AddPlayerClass(46,2082.0784,2480.8333,10.8203,182.0390,0,0,0,0,0,0);// civil skin
	AddPlayerClass(9,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); // civil skin
	AddPlayerClass(13,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(14,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(24,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(33,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(36,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(38,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(160,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(82,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(107,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(59,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(127,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(128,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(138,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(28,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(147,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(299,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(123,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
 	AddPlayerClass(204,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(249,2193.7366,2007.4865,12.2894,358.2378,15,1,15,500,28,500); //Pimp skin
	AddPlayerClass(264,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(269,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(270,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(293,2193.5884,2007.4149,12.2894,355.9373,0,0,0,0,0,0); // OG Loc
	AddPlayerClass(271,2193.7366,2007.4865,12.2894,358.2378,0,0,0,0,0,0); //civil skin
	AddPlayerClass(298,2193.5884,2007.4149,12.2894,355.9373,0,0,0,0,0,0); // gloris skin///141
	AddPlayerClass(137,2193.5884,2007.4149,12.2894,355.9373,0,0,0,0,0,0); // Box on head Hobo guy
	
	//Menu designs
	SkillMenu = CreateMenu("~b~Skill ~w~Selection",1,15,150,200);
    SetMenuColumnHeader(SkillMenu , 0, "~w~Please select your skill");
    AddMenuItem(SkillMenu,0,"Rapist");
    AddMenuItem(SkillMenu,0,"Drug Dealer");
    AddMenuItem(SkillMenu,0,"Weapon Dealer");
    AddMenuItem(SkillMenu,0,"Hitman");
    AddMenuItem(SkillMenu,0,"Car Jacker");
    AddMenuItem(SkillMenu,0,"Kidnapper");
    AddMenuItem(SkillMenu,0,"Thief");
    AddMenuItem(SkillMenu,0,"Terrorist");
    
    //Textdraws
	VersionTD = TextDrawCreate(3.000000, 433.000000, "Version: 0.1");
	TextDrawBackgroundColor(VersionTD, -1);
	TextDrawFont(VersionTD, 1);
	TextDrawLetterSize(VersionTD, 0.519999, 1.300000);
	TextDrawColor(VersionTD, 65535);
	TextDrawSetOutline(VersionTD, 1);
	TextDrawSetProportional(VersionTD, 1);
	TextDrawUseBox(VersionTD, 1);
	TextDrawBoxColor(VersionTD, 255);
	TextDrawTextSize(VersionTD, 637.000000, 0.000000);
	
	format(string,sizeof(string),"Website: %s",sweb);
	WebsiteTD = TextDrawCreate(394.000000, 433.000000, string);
	TextDrawBackgroundColor(WebsiteTD, -1);
	TextDrawFont(WebsiteTD, 1);
	TextDrawLetterSize(WebsiteTD, 0.529999, 1.300000);
	TextDrawColor(WebsiteTD, -16711681);
	TextDrawSetOutline(WebsiteTD, 1);
	TextDrawSetProportional(WebsiteTD, 1);
	
	//Pickups
	FBIInsidePickup = CreatePickup(1239,1,246.3956,87.5255,1003.6406,0);
	FBIRoofPickup = CreatePickup(1239,1,-1750.0658,980.9041,95.8510,0);
	FBIGaragePickup = CreatePickup(1239,1,-1716.3550,1018.1495,17.5859,0);
	
	//Solid Objects
	//SFPD Gates
	SFPDRightGate = CreateObject(971,-1627.33483887,688.32006836,9.80140114,0.00000000,0.00000000,0.00000000); //object(sfpdrightgate)(1)
	SFPDLeftGate = CreateObject(971,-1636.18347168,688.50933838,9.80140114,0.00000000,0.00000000,178.24902344); //object(sfpdleftgate)(2)
    SFPDShutter = CreateObject(2957,-1620.61669922,688.17712402,7.80728531,0.00000000,0.00000000,0.00000000); //object(sfpdshutter)(1)
    
    //Army base
    ArmyGate = CreateObject(971,-1530.15380859,482.34051514,8.83757210,0.00000000,0.00000000,179.26562500); //object(gate)(1)
	CreateObject(3997,-1301.21313477,377.17645264,6.10084248,0.00000000,0.00000000,0.00000000); //object(armyground)(1)
	CreateObject(4726,-1248.46887207,457.03024292,5.45363998,0.00000000,0.00000000,0.00000000); //object(hydra pad)(1)
	CreateObject(4726,-1297.24182129,457.55130005,5.34741545,0.00000000,0.00000000,0.00000000); //object(hunter pad)(2)

	//CIA Base
	CreateObject(3997,-1259.44140625,763.71417236,5.62989998,0.00000000,0.00000000,352.46936035); //object(ciaground)(1)
	CIALeftGate = CreateObject(971,-1336.73291016,791.96447754,9.24380112,0.00000000,0.00000000,83.33264160); //object(ciarightgate)(1)
	CIARightGate = CreateObject(971,-1337.82531738,783.17510986,9.24380112,0.00000000,0.00000000,262.99182129); //object(cialeftgate)(2)
	CreateObject(4726,-1278.66345215,799.98425293,4.47114134,0.00000000,0.00000000,262.30816650); //object(libtwrhelipd_lan2)(1)
	CreateObject(4726,-1240.11083984,793.05010986,4.47114134,0.00000000,0.00000000,262.99182129); //object(libtwrhelipd_lan2)(2)
	CIABuilding = CreateObject(4564,-1207.69787598,737.33392334,114.88327789,0.00000000,0.00000000,352.52142334); //object(laskyscrap2_lan)(1)
	CIASat = CreateObject(16613,-1316.09350586,813.32238770,5.31122589,0.00000000,0.00000000,81.75177002); //object(des_bigtelescope)(1)
	CIABridge = CreateObject(5296,-1484.06884766,806.24200439,11.40033340,0.00000000,0.00000000,173.24121094); //object(laroads_26a_las01)(1)

	//FBI Base
    FBIRightGate = CreateObject(980,-1781.65063477,971.39666748,26.50776672,0.00000000,0.00000000,90.21514893); //object(fbirightgate)(1)
	FBILeftGate = CreateObject(980,-1781.49548340,996.09625244,26.50776672,0.00000000,0.00000000,270.38476562); //object(fbileftgate)(2)
	FBIShutter = CreateObject(2957,246.42794800,72.70855713,1004.26043701,0.00000000,0.00000000,0.00000000); //object(fbiinsideshutter)(1)
	CreateObject(4726,-1754.17224121,988.74639893,96.76550293,0.00000000,0.00000000,0.00000000); //object(helipad)(1)

    //Vehicles
    //Tram
    NPCTram = AddStaticVehicle(449,-1539.1951,791.7335,7.4973,354.2815,1,74); // Tram
    //
    TaxiVehicle1 = AddStaticVehicleEx(431,-2186.94200000,-424.17260000,35.33594000,90.00000000,-1,-1,900); //Bus
	TaxiVehicle2 = AddStaticVehicleEx(438,-2190.34100000,-420.24990000,35.33594000,90.00000000,-1,-1,900); //Cabbie
	TaxiVehicle3 = AddStaticVehicleEx(437,-2194.94200000,-416.31260000,35.33594000,90.00000000,-1,-1,900); //Coach
	TaxiVehicle4 = AddStaticVehicleEx(420,-2198.94200000,-412.17260000,35.33594000,90.00000000,-1,-1,900); //Taxi
	TaxiVehicle5 = AddStaticVehicleEx(420,-2202.94200000,-408.17260000,35.33594000,90.00000000,-1,-1,900); //Taxi
	TaxiVehicle6 = AddStaticVehicleEx(420,-1655.72880000,1314.76550000,6.81950000,134.29910000,-1,-1,900); //Taxi
	TaxiVehicle7 = AddStaticVehicleEx(420,-1652.23010000,1311.20630000,6.81430000,133.75430000,-1,-1,900); //Taxi
	TaxiVehicle8 = AddStaticVehicleEx(420,-1648.69790000,1307.64610000,6.81050000,134.12380000,-1,-1,900); //Taxi
	TaxiVehicle9 = AddStaticVehicleEx(437,-1649.94650000,1288.67440000,7.17250000,44.77090000,-1,-1,900); //Coach
	TaxiVehicle10 = AddStaticVehicleEx(409,-1641.98410000,1280.11850000,6.84110000,43.81840000,0,0,900); //Stretch
	TaxiVehicle11 = AddStaticVehicleEx(421,-1645.03660000,1304.07730000,6.91130000,136.09790000,0,0,900); //Washington
	TaxiVehicle12 = AddStaticVehicleEx(421,-1641.48900000,1300.60730000,6.91320000,134.81700000,0,0,900); //Washington
	TaxiVehicle13 = AddStaticVehicleEx(438,-1638.11510000,1296.90410000,7.04110000,135.12630000,-1,-1,900); //Cabbie
	TaxiVehicle14 = AddStaticVehicleEx(438,-1634.54420000,1293.14150000,7.04110000,134.73150000,-1,-1,900); //Cabbie
	//Mechanic Vehicles
	AddStaticVehicle(525,-2034.4927,170.3560,28.7153,270.3337,-1,-1); // MechanicTow1
	AddStaticVehicle(525,-2034.0262,178.9766,28.7156,271.2464,-1,-1); // MechanicTow2
	//Air Support Vehicles
	PoliceCar34 = AddStaticVehicleEx(597,-1244.37841797,47.57975769,14.00286388,224.82952881,1,125,900); //Police Car (SFPD)
	PoliceCar35 = AddStaticVehicleEx(597,-1241.58044434,50.30725861,14.00373554,224.44482422,1,125,900); //Police Car (SFPD)
	PoliceCar36 = AddStaticVehicleEx(597,-1238.91381836,52.91276169,14.00285053,223.67553711,1,125,900); //Police Car (SFPD)
	PoliceCar37 = AddStaticVehicleEx(497,-1181.57177734,31.35196304,14.41343784,44.87145996,125,1,900); //Police Maverick
	PoliceCar38 = AddStaticVehicleEx(497,-1191.69812012,21.01650429,14.41343784,44.87145996,125,1,900); //Police Maverick
	PoliceCar39 = AddStaticVehicleEx(497,-1218.57116699,-6.05413723,14.41343784,43.80310059,125,1,900); //Police Maverick
	PoliceCar40 = AddStaticVehicleEx(497,-1228.72521973,-16.13720322,14.41343784,45.93981934,125,1,900); //Police Maverick
	//Marine Support Vehicles
	PoliceCar41 = AddStaticVehicleEx(430,-1571.58044434,1262.94531250,0.00000000,269.01733398,1,0,900); //Predator
	PoliceCar42 = AddStaticVehicleEx(430,-1571.60034180,1257.47705078,0.00000000,268.16223145,1,0,900); //Predator
	PoliceCar43 = AddStaticVehicleEx(430,-1571.65551758,1251.78454590,0.00000000,269.70104980,1,0,900); //Predator
	PoliceCar44 = AddStaticVehicleEx(430,-1571.54797363,1245.67199707,0.00000000,270.76940918,1,0,900); //Predator
	PoliceCar45 = AddStaticVehicleEx(430,-1571.42468262,1240.08776855,0.00000000,270.85510254,1,0,900); //Predator
	PoliceCar46 = AddStaticVehicleEx(493,-1517.96838379,1236.94616699,0.00000000,269.31628418,1,0,900); //Jetmax
	PoliceCar47 = AddStaticVehicleEx(493,-1518.60620117,1266.46984863,0.00000000,270.38464355,1,0,900); //Jetmax
	//FBI Vehicles
	FBIVehicle1 = AddStaticVehicleEx(490,-1746.71911621,954.51037598,24.84986496,270.55615234,0,0,900); //FBI Rancher
	FBIVehicle2 = AddStaticVehicleEx(528,-1753.96679688,954.57086182,24.82096291,270.25720215,0,0,900); //FBI Truck
	FBIVehicle3 = AddStaticVehicleEx(490,-1761.50646973,954.47650146,24.84986496,270.17144775,0,0,900); //FBI Rancher
	FBIVehicle4 = AddStaticVehicleEx(405,-1735.76171875,1008.07470703,17.58593750,269.78674316,0,0,900); //Sentinel
	FBIVehicle5 = AddStaticVehicleEx(405,-1735.97216797,1012.12286377,17.58593750,270.47039795,0,0,900); //Sentinel
	FBIVehicle6 = AddStaticVehicleEx(490,-1720.33654785,999.72052002,17.69361496,90.21325684,0,0,900); //FBI Rancher
	FBIVehicle7 = AddStaticVehicleEx(490,-1720.40466309,1003.82769775,17.69361496,90.21325684,0,0,900); //FBI Rancher
	FBIVehicle8 = AddStaticVehicleEx(490,-1720.42102051,1007.84558105,17.69361496,90.59790039,0,0,900); //FBI Rancher
	FBIVehicle9 = AddStaticVehicleEx(402,-1736.18139648,1020.30407715,17.52593803,270.08569336,0,0,900); //Buffalo
	FBIVehicle10 = AddStaticVehicleEx(402,-1736.24182129,1024.31530762,17.52593803,270.47039795,0,0,900); //Buffalo
	FBIVehicle11 = AddStaticVehicleEx(402,-1736.38269043,1028.55749512,17.52593803,269.31628418,0,0,900); //Buffalo
	FBIVehicle12 = AddStaticVehicleEx(402,-1736.28369141,1032.67749023,17.52593803,269.23059082,0,0,900); //Buffalo
	FBIVehicle13 = AddStaticVehicleEx(528,-1720.45556641,1024.25341797,17.77093697,89.14489746,0,0,900); //FBI Truck
	FBIVehicle14 = AddStaticVehicleEx(528,-1720.41564941,1028.50671387,17.77093697,89.91430664,0,0,900); //FBI Truck
	FBIVehicle15 = AddStaticVehicleEx(560,-1703.04736328,999.73370361,17.39091301,270.08569336,0,0,900); //Sultan
	FBIVehicle16 = AddStaticVehicleEx(560,-1703.00793457,1003.78149414,17.39091301,270.08569336,0,0,900); //Sultan
	FBIVehicle17 = AddStaticVehicleEx(497,-1754.50793457,991.25335693,99.37017059,0.00000000,0,1,900); //Police Maverick
	//CIA Vehicles
	CIAVehicle1 = AddStaticVehicleEx(447,-1275.70361328,798.33709717,6.91991186,171.23968506,0,0,900); //Seasparrow
	CIAVehicle2 = AddStaticVehicleEx(447,-1236.98254395,791.46008301,6.91987276,172.90612793,0,0,900); //Seasparrow
	CIAVehicle3 = AddStaticVehicleEx(507,-1245.34179688,708.35351562,6.57989979,352.52142334,0,0,900); //Elegant
	CIAVehicle4 = AddStaticVehicleEx(507,-1249.13366699,708.83435059,6.57989979,351.45300293,0,0,900); //Elegant
	CIAVehicle5 = AddStaticVehicleEx(507,-1253.14514160,709.45367432,6.57989979,350.38464355,0,0,900); //Elegant
	CIAVehicle6 = AddStaticVehicleEx(402,-1258.4403,710.3248,6.4615,351.7213,0,0,900); // CIABuffalo
	CIAVehicle7 = AddStaticVehicleEx(402,-1262.5505,710.9274,6.4617,354.2975,0,0,900); // CIABuffalo2
	CIAVehicle8 = AddStaticVehicleEx(402,-1267.1667,711.5325,6.4615,353.8128,0,0,900); // CIABuffalo3
	CIAVehicle9 = AddStaticVehicleEx(411,-1272.1901,712.1153,6.3570,353.5891,0,0,900); // CIAInfernus
	CIAVehicle10 = AddStaticVehicleEx(411,-1277.4155,712.9612,6.3570,351.9374,0,0,900); // CIAInfernus2
	CIAVehicle11 = AddStaticVehicleEx(411,-1282.5824,713.2658,6.3566,353.9931,0,0,900); // CIAInfernus3
	CIAVehicle12 = AddStaticVehicleEx(494,-1243.06090000,724.79330000,6.52520000,352.01720000,0,0,900); //Hotring
	CIAVehicle13 = AddStaticVehicleEx(494,-1246.54260000,725.36190000,6.52510000,351.45560000,0,0,900); //Hotring
	CIAVehicle14 = AddStaticVehicleEx(494,-1250.68790000,725.89330000,6.52500000,352.21850000,0,0,900); //Hotring
	CIAVehicle15 = AddStaticVehicleEx(560,-1275.40320000,728.93510000,6.36140000,350.76840000,0,0,900); //Sultan
	CIAVehicle16 = AddStaticVehicleEx(560,-1280.06910000,729.50690000,6.33490000,352.61060000,0,0,900); //Sultan
	CIAVehicle17 = AddStaticVehicleEx(560,-1285.37340000,729.98310000,6.33580000,352.80520000,0,0,900); //Sultan
	CIAVehicle18 = AddStaticVehicleEx(497,-1307.64400000,723.77000000,6.79250000,353.22730000,0,0,900); //Police Maverick
	CIAVehicle19 = AddStaticVehicleEx(497,-1326.22790000,727.34100000,6.79280000,352.78880000,0,0,900); //Police Maverick
	//Police Vehicles
	PoliceCar1 = AddStaticVehicleEx(497,-1680.36800000,705.29660000,30.60156000,180.00000000,125,1,900); //Police Maverick
	PoliceCar2 = AddStaticVehicleEx(528,-1587.91400000,747.54220000,-5.24218800,180.00000000,1,125,900); //FBI Truck
	PoliceCar3 = AddStaticVehicleEx(597,-1574.24600000,734.89500000,-5.24218800,90.00000000,1,125,900); //Police Car (SFPD)
	PoliceCar4 = AddStaticVehicleEx(601,-1573.34600000,712.00550000,-5.24218800,90.00000000,1,125,900); //S.W.A.T. Van
	PoliceCar5 = AddStaticVehicleEx(523,-1608.33700000,692.92430000,-5.24218800,180.00000000,1,125,900); //HPV1000
	PoliceCar6 = AddStaticVehicleEx(523,-1612.31500000,691.94350000,-5.24218800,180.00000000,1,125,900); //HPV1000
	PoliceCar7 = AddStaticVehicleEx(411,-1622.75300000,654.27040000,-5.24218800,90.00000000,0,0,900); //Infernus
	PoliceCar8 = AddStaticVehicleEx(601,-1600.62800000,673.48800000,7.18750000,180.00000000,1,125,900); //S.W.A.T. Van
	PoliceCar9 = AddStaticVehicleEx(523,-1582.73800000,672.90630000,7.18750000,360.00000000,1,125,900); //HPV1000
	PoliceCar10 = AddStaticVehicleEx(597,-1656.49700000,739.33300000,17.00200000,90.00000000,1,125,900); //Police Car (SFPD)
	PoliceCar11 = AddStaticVehicleEx(597,-2679.95750000,582.79290000,14.22190000,270.26030000,1,125,900); //Police Car (SFPD)
	PoliceCar12 = AddStaticVehicleEx(597,-2757.30220000,378.95640000,4.10410000,179.72990000,1,125,900); //Police Car (SFPD)
	PoliceCar14 = AddStaticVehicleEx(523,-1616.36740000,733.05110000,-5.67050000,359.48540000,1,125,900); //HPV1000
	PoliceCar15 = AddStaticVehicleEx(523,-1573.88160000,742.57570000,-5.67540000,88.42480000,1,125,900); //HPV1000
	PoliceCar16 = AddStaticVehicleEx(523,-1589.07730000,706.53970000,-5.67280000,84.62820000,1,125,900); //HPV1000
	PoliceCar17 = AddStaticVehicleEx(523,-1588.79370000,709.66140000,-5.67240000,86.68150000,1,125,900); //HPV1000
	PoliceCar18 = AddStaticVehicleEx(597,-1612.58700000,748.70380000,-5.47310000,179.25390000,1,125,900); //Police Car (SFPD)
	PoliceCar19 = AddStaticVehicleEx(597,-1596.33850000,749.64670000,-5.47350000,0.13120000,1,125,900); //Police Car (SFPD)
	PoliceCar20 = AddStaticVehicleEx(597,-1573.17250000,742.74710000,-5.47400000,269.25220000,1,125,900); //Police Car (SFPD)
	PoliceCar21 = AddStaticVehicleEx(597,-1574.97250000,710.01510000,-5.47340000,89.22360000,1,125,900); //Police Car (SFPD)
	PoliceCar22 = AddStaticVehicleEx(597,-1596.00980000,675.27550000,-5.47280000,178.82880000,1,125,900); //Police Car (SFPD)
	PoliceCar23 = AddStaticVehicleEx(597,-1637.83080000,686.17180000,-5.47510000,90.24000000,1,125,900); //Police Car (SFPD)
	PoliceCar24 = AddStaticVehicleEx(427,-1637.64980000,653.70210000,-5.11040000,90.11330000,1,125,900); //Enforcer
	PoliceCar25 = AddStaticVehicleEx(427,-1623.72850000,653.70540000,-5.11050000,88.68700000,1,125,900); //Enforcer
	PoliceCar26 = AddStaticVehicleEx(427,-1628.77210000,692.92200000,-5.11020000,358.64450000,1,125,900); //Enforcer
	PoliceCar27 = AddStaticVehicleEx(597,-1606.14110000,673.42140000,6.95600000,0.86760000,1,125,900); //Police Car (SFPD)
	PoliceCar28 = AddStaticVehicleEx(597,-1599.07100000,652.27180000,6.95690000,0.73160000,1,125,900); //Police Car (SFPD)
	PoliceCar29 = AddStaticVehicleEx(597,-1588.22300000,673.72410000,6.95650000,0.29930000,1,125,900); //Police Car (SFPD)
	PoliceCar30 = AddStaticVehicleEx(597,-1595.14400000,723.12180000,9.79420000,269.93010000,1,125,900); //Police Car (SFPD)
	PoliceCar31 = AddStaticVehicleEx(597,-1602.02260000,723.01300000,11.03630000,269.78750000,1,125,900); //Police Car (SFPD)
	PoliceCar32 = AddStaticVehicleEx(523,-1616.83700000,652.24770000,6.75730000,181.22630000,1,125,900); //HPV1000
	PoliceCar33 = AddStaticVehicleEx(523,-1633.99850000,651.28960000,6.75930000,359.27840000,1,125,900); //HPV1000
	//Civilian Vehicles
	AddStaticVehicleEx(413,-2572.82810000,817.25430000,50.07340000,179.82530000,-1,-1,900); //Pony
	AddStaticVehicleEx(413,-2764.22290000,4.87720000,7.06760000,5.00160000,-1,-1,900); //Pony
	AddStaticVehicleEx(413,-2105.39330000,901.40830000,76.59570000,1.53260000,-1,-1,900); //Pony
	AddStaticVehicleEx(489,-1676.39150000,437.36540000,7.32290000,224.89370000,-1,-1,900); //Rancher
	AddStaticVehicleEx(589,-1676.45250000,437.16620000,6.83770000,227.33390000,-1,-1,900); //Club
	AddStaticVehicleEx(477,-1674.49130000,439.58490000,6.93490000,226.75390000,-1,-1,900); //ZR-350
	AddStaticVehicleEx(411,-2089.83280000,-83.09030000,34.90500000,0.16610000,-1,-1,900); //Infernus
	AddStaticVehicleEx(404,-1669.44010000,406.41520000,6.91370000,316.86990000,-1,-1,900); //Perrenial
	AddStaticVehicleEx(561,-1674.79500000,438.31980000,6.99320000,229.25410000,-1,-1,900); //Stratum
	AddStaticVehicleEx(493,-1769.10440000,-191.40140000,-0.09240000,182.87860000,-1,-1,900); //Jetmax
	AddStaticVehicleEx(470,-1543.86910000,477.67210000,7.17530000,83.15120000,-1,-1,900); //Patriot
	AddStaticVehicleEx(452,-1753.03990000,-191.30690000,-0.49320000,178.53570000,-1,-1,900); //Speeder
	AddStaticVehicleEx(562,-1922.97960000,281.38710000,40.70920000,183.55140000,-1,-1,900); //Elegy
	AddStaticVehicleEx(486,-2109.52490000,144.55770000,35.30330000,92.87470000,-1,-1,900); //Dozer
	AddStaticVehicleEx(571,-2211.55710000,114.47790000,34.60410000,90.24370000,-1,-1,900); //Kart
	AddStaticVehicleEx(558,-2265.55350000,200.41640000,34.79490000,271.54760000,-1,-1,900); //Uranus
	AddStaticVehicleEx(527,-2265.87520000,128.80040000,34.88910000,270.35960000,-1,-1,900); //Cadrona
	AddStaticVehicleEx(426,-2265.17600000,141.08560000,34.90020000,268.78800000,-1,-1,900); //Premier
	AddStaticVehicleEx(402,-2773.85620000,-311.68830000,6.87060000,181.31560000,-1,-1,900); //Buffalo
	AddStaticVehicleEx(534,-2765.94070000,-311.59730000,6.76380000,182.97190000,-1,-1,900); //Remington
	AddStaticVehicleEx(480,-1800.66250000,967.60600000,24.50590000,179.86120000,-1,-1,900); //Comet
	AddStaticVehicleEx(551,-1800.61170000,947.20010000,24.53660000,179.55430000,-1,-1,900); //Merit
	AddStaticVehicleEx(477,-1930.44300000,910.69400000,37.96110000,269.79150000,-1,-1,900); //ZR-350
	AddStaticVehicleEx(492,-1907.27100000,876.67620000,34.87310000,179.65690000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(589,-1996.18800000,805.17630000,45.03460000,359.61890000,-1,-1,900); //Club
	AddStaticVehicleEx(404,-1891.36020000,749.56350000,45.10240000,1.06050000,-1,-1,900); //Perrenial
	AddStaticVehicleEx(400,-1931.58870000,723.32990000,45.45950000,269.96630000,-1,-1,900); //Landstalker
	AddStaticVehicleEx(567,-1978.06590000,723.27500000,45.23970000,270.28630000,-1,-1,900); //Savanna
	AddStaticVehicleEx(575,-2124.51810000,655.25420000,51.96990000,89.71740000,-1,-1,900); //Broadway
	AddStaticVehicleEx(466,-2151.93530000,518.23850000,34.83230000,180.40020000,-1,-1,900); //Glendale
	AddStaticVehicleEx(412,-2274.41530000,700.62220000,49.20580000,181.25760000,-1,-1,900); //Voodoo
	AddStaticVehicleEx(418,-2197.04790000,644.90340000,49.53190000,93.09500000,-1,-1,900); //Moonbeam
	AddStaticVehicleEx(419,-2308.25170000,573.83860000,33.09040000,90.20650000,-1,-1,900); //Esperanto
	AddStaticVehicleEx(401,-2380.39530000,606.43660000,29.32300000,359.60890000,-1,-1,900); //Bravura
	AddStaticVehicleEx(410,-2394.61350000,649.70150000,34.74570000,179.78720000,-1,-1,900); //Manana
	AddStaticVehicleEx(415,-2578.16310000,713.88790000,27.65570000,88.84100000,-1,-1,900); //Cheetah
	AddStaticVehicleEx(491,-2645.34060000,725.19040000,27.71720000,179.80090000,-1,-1,900); //Virgo
	AddStaticVehicleEx(496,-2756.51050000,708.20290000,40.91270000,180.99490000,-1,-1,900); //Blista Compact
	AddStaticVehicleEx(500,-2756.40990000,631.31150000,27.92580000,178.08960000,-1,-1,900); //Mesa
	AddStaticVehicleEx(429,-2469.16040000,902.71390000,62.67690000,269.02420000,-1,-1,900); //Banshee
	AddStaticVehicleEx(526,-2451.43360000,741.12570000,34.78230000,180.81120000,-1,-1,900); //Fortune
	AddStaticVehicleEx(536,-2833.76170000,681.45920000,20.12360000,201.18450000,-1,-1,900); //Blade
	AddStaticVehicleEx(540,-2802.67020000,861.90860000,43.84030000,0.28020000,-1,-1,900); //Vincent
	AddStaticVehicleEx(527,-2828.83590000,607.58310000,5.88330000,177.27280000,-1,-1,900); //Cadrona
	AddStaticVehicleEx(560,-2881.80790000,506.10120000,4.61830000,181.26110000,-1,-1,900); //Sultan
	AddStaticVehicleEx(551,-2927.46140000,499.03380000,4.71090000,270.81710000,-1,-1,900); //Merit
	AddStaticVehicleEx(554,-2911.28640000,506.27330000,4.99710000,181.35670000,-1,-1,900); //Yosemite
	AddStaticVehicleEx(492,-2898.24760000,419.99080000,4.69590000,358.53070000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(496,-2927.33230000,445.14500000,4.63040000,271.58690000,-1,-1,900); //Blista Compact
	AddStaticVehicleEx(461,-2980.29270000,484.73860000,4.49720000,180.80410000,-1,-1,900); //PCJ-600
	AddStaticVehicleEx(493,-2970.25200000,492.43340000,-0.68790000,0.94290000,-1,-1,900); //Jetmax
	AddStaticVehicleEx(493,-2982.74730000,492.45550000,-0.38380000,0.07140000,-1,-1,900); //Jetmax
	AddStaticVehicleEx(500,-2970.88550000,458.01810000,5.02260000,358.88880000,-1,-1,900); //Mesa
	AddStaticVehicleEx(573,-2553.48600000,2272.38800000,5.68900000,334.54000000,-1,-1,900); //Duneride
	AddStaticVehicleEx(573,-2392.98800000,2219.30200000,4.54900000,88.60000000,-1,-1,900); //Duneride
	AddStaticVehicleEx(532,-46.32000000,-10.04500000,2.69000000,77.20000000,-1,-1,900); //Combine
	AddStaticVehicleEx(532,-365.94200000,-1440.50900000,25.29800000,83.87000000,-1,-1,900); //Combine
	AddStaticVehicleEx(531,-377.87300000,-1050.07900000,58.65100000,257.42000000,-1,-1,900); //Tractor
	AddStaticVehicleEx(478,-369.62800000,-1061.14500000,58.78500000,7.09000000,-1,-1,900); //Walton
	AddStaticVehicleEx(531,-90.73500000,-36.59500000,1.70000000,337.51000000,-1,-1,900); //Tractor
	AddStaticVehicleEx(493,-1509.84700000,1386.38500000,0.26100000,91.60000000,-1,-1,900); //Jetmax
	AddStaticVehicleEx(409,-1940.19520000,1192.82790000,45.32050000,359.64750000,-1,-1,900); //Stretch
	AddStaticVehicleEx(409,-2634.60860000,1396.18630000,6.97620000,283.61830000,-1,-1,900); //Stretch
	AddStaticVehicleEx(482,-2645.28910000,1369.92810000,7.04360000,269.27580000,-1,-1,900); //Burrito
	AddStaticVehicleEx(421,-2645.22560000,1356.08760000,7.04330000,272.09000000,-1,-1,900); //Washington
	AddStaticVehicleEx(462,-2416.79740000,332.25730000,34.60000000,148.23670000,-1,-1,900); //Faggio
	//Medic Vehicles
	MedicVehicle1 = AddStaticVehicleEx(416,-2543.89330000,598.77650000,14.60240000,90.01300000,-1,-1,900); //Ambulance
	MedicVehicle2 = AddStaticVehicleEx(416,-2546.53860000,658.33760000,14.60820000,88.78520000,-1,-1,900); //Ambulance
	MedicVehicle3 = AddStaticVehicleEx(416,-2588.87820000,648.13110000,14.60310000,88.12190000,-1,-1,900); //Ambulance
	MedicVehicle4 = AddStaticVehicleEx(416,-2571.54590000,632.81340000,14.60820000,270.28390000,-1,-1,900); //Ambulance
	MedicVehicle5 = AddStaticVehicleEx(416,-2546.25780000,627.39260000,14.60280000,267.93780000,-1,-1,900); //Ambulance
	MedicVehicle6 = AddStaticVehicleEx(416,-2657.56670000,633.10820000,14.60230000,89.63460000,-1,-1,900); //Ambulance
	MedicVehicle7 = AddStaticVehicleEx(416,-2592.34420000,665.95810000,27.44300000,90.85530000,-1,-1,900); //Ambulance
	MedicVehicle8 = AddStaticVehicleEx(416,-2592.38210000,660.95790000,27.44270000,88.83300000,-1,-1,900); //Ambulance
	MedicVehicle9 = AddStaticVehicleEx(416,-2591.84130000,640.03890000,27.44260000,90.08000000,-1,-1,900); //Ambulance
	MedicVehicle10 = AddStaticVehicleEx(416,-2591.92500000,634.83520000,27.44190000,90.11720000,-1,-1,900); //Ambulance
	///////////////////
	AddStaticVehicleEx(448,-2693.10280000,230.39680000,3.96710000,269.96410000,-1,-1,900); //Pizzaboy
	AddStaticVehicleEx(448,-2693.18210000,234.01520000,3.96590000,270.75220000,-1,-1,900); //Pizzaboy
	AddStaticVehicleEx(448,-2693.02050000,237.80530000,3.96700000,270.69440000,-1,-1,900); //Pizzaboy
	AddStaticVehicleEx(457,-2381.16650000,-213.80440000,42.47260000,197.10280000,-1,-1,900); //Caddy
	AddStaticVehicleEx(457,-2375.05830000,-210.64540000,42.46970000,196.89650000,-1,-1,900); //Caddy
	AddStaticVehicleEx(457,-2367.47270000,-208.92190000,42.46430000,182.96580000,-1,-1,900); //Caddy
	AddStaticVehicleEx(530,-2182.76170000,-264.75460000,36.51560000,284.06560000,-1,-1,900); //Forklift
	AddStaticVehicleEx(400,-2175.92580000,293.32520000,35.10970000,0.71800000,-1,-1,900); //Landstalker
	AddStaticVehicleEx(589,-2223.00050000,306.08810000,35.10960000,0.35770000,-1,-1,900); //Club
	AddStaticVehicleEx(444,-2235.39990000,305.97950000,35.10950000,0.36010000,-1,-1,900); //Monster
	AddStaticVehicleEx(562,-2235.32590000,293.68930000,35.10980000,0.35560000,-1,-1,900); //Elegy
	AddStaticVehicleEx(434,-2171.53420000,305.85670000,35.10930000,0.68020000,-1,-1,900); //Hotknife
	AddStaticVehicleEx(577,-1269.78050000,-367.43380000,14.02310000,275.83430000,-1,-1,900); //AT-400
	AddStaticVehicleEx(583,-1276.03530000,-294.72700000,14.02340000,279.82700000,-1,-1,900); //Tug
	AddStaticVehicleEx(608,-1286.26110000,-296.49810000,14.02350000,279.82710000,-1,-1,900); //Stair Trailer
	AddStaticVehicleEx(487,-1383.27800000,-229.13620000,14.70740000,319.77220000,-1,-1,900); //Maverick
	AddStaticVehicleEx(487,-1343.33870000,-281.76910000,14.71560000,326.25200000,-1,-1,900); //Maverick
	AddStaticVehicleEx(553,-1606.87850000,-300.61390000,14.70140000,55.50230000,-1,-1,900); //Nevada
	AddStaticVehicleEx(553,-1571.18550000,-271.27550000,14.70350000,28.13140000,-1,-1,900); //Nevada
	AddStaticVehicleEx(567,-2172.29600000,-209.41900000,34.89100000,269.49000000,-1,-1,900); //Savanna
	AddStaticVehicleEx(535,-2152.58600000,-167.04600000,34.89100000,262.63000000,-1,-1,900); //Slamvan
	AddStaticVehicleEx(413,-2115.12600000,-136.26700000,34.89000000,94.01000000,-1,-1,900); //Pony
	AddStaticVehicleEx(516,-2425.28780000,741.18580000,34.84930000,0.49550000,-1,-1,900); //Nebula
	AddStaticVehicleEx(517,-2438.35010000,741.58330000,34.87050000,180.18000000,-1,-1,900); //Majestic
	AddStaticVehicleEx(518,-2473.14700000,741.27200000,34.68650000,180.46420000,-1,-1,900); //Buccaneer
	AddStaticVehicleEx(400,-2532.31910000,729.65740000,28.95850000,179.91550000,-1,-1,900); //Landstalker
	AddStaticVehicleEx(551,-2573.67310000,626.30830000,27.60670000,180.28700000,-1,-1,900); //Merit
	AddStaticVehicleEx(543,-2670.36230000,632.61800000,14.27090000,89.82080000,-1,-1,900); //Sadler
	AddStaticVehicleEx(422,-2732.13350000,511.21440000,9.06370000,221.93800000,-1,-1,900); //Bobcat
	AddStaticVehicleEx(445,-2859.63260000,409.81330000,4.33720000,179.27780000,-1,-1,900); //Admiral
	AddStaticVehicleEx(410,-2681.64010000,268.23090000,3.99060000,359.56140000,-1,-1,900); //Manana
	AddStaticVehicleEx(559,-2688.42380000,268.22390000,3.99230000,179.74880000,-1,-1,900); //Jester
	AddStaticVehicleEx(445,-2641.31030000,232.57020000,4.12540000,181.24050000,-1,-1,900); //Admiral
	AddStaticVehicleEx(551,-2654.20070000,209.54250000,4.12800000,270.00210000,-1,-1,900); //Merit
	AddStaticVehicleEx(409,-2757.23140000,371.10860000,4.14790000,180.80930000,-1,-1,900); //Stretch
	AddStaticVehicleEx(492,-2655.61650000,350.38100000,4.16450000,180.49030000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(412,-2723.50050000,76.12780000,4.17400000,269.90830000,-1,-1,900); //Voodoo
	AddStaticVehicleEx(410,-2654.86890000,61.99260000,3.79520000,181.17380000,-1,-1,900); //Manana
	AddStaticVehicleEx(521,-2673.04640000,-34.24880000,3.90580000,359.83470000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(419,-2689.64580000,-22.60490000,4.13340000,181.15830000,-1,-1,900); //Esperanto
	AddStaticVehicleEx(492,-2713.08010000,-130.97660000,4.11000000,179.56490000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(466,-2598.34470000,-183.90280000,4.07000000,0.27700000,-1,-1,900); //Glendale
	AddStaticVehicleEx(571,-2645.73580000,-289.21200000,6.78740000,313.23190000,-1,-1,900); //Kart
	AddStaticVehicleEx(571,-2660.48930000,-290.17650000,6.72170000,135.09810000,-1,-1,900); //Kart
	AddStaticVehicleEx(571,-2464.91820000,-256.24290000,38.85980000,317.28490000,-1,-1,900); //Kart
	AddStaticVehicleEx(471,-2648.96170000,-286.21980000,6.98910000,133.11770000,-1,-1,900); //Quad
	AddStaticVehicleEx(471,-2573.02320000,-290.44230000,22.88980000,190.34240000,-1,-1,900); //Quad
	AddStaticVehicleEx(550,-1495.65700000,907.59300000,6.76600000,89.58000000,-1,-1,900); //Sunrise
	AddStaticVehicleEx(445,-2315.11890000,-125.83960000,35.18730000,359.69690000,-1,-1,900); //Admiral
	AddStaticVehicleEx(498,-2318.91240000,-160.03480000,35.49760000,178.45160000,-1,-1,900); //Boxville
	AddStaticVehicleEx(419,-2348.48510000,-126.04350000,35.10990000,359.76930000,-1,-1,900); //Esperanto
	AddStaticVehicleEx(556,-2161.18990000,-444.02060000,35.71830000,315.48250000,-1,-1,900); //Monster A
	AddStaticVehicleEx(557,-2161.36940000,-409.96300000,35.71080000,43.34120000,-1,-1,900); //Monster B
	AddStaticVehicleEx(504,-2185.71240000,-375.16930000,35.19030000,88.74770000,-1,-1,900); //Bloodring Banger
	AddStaticVehicleEx(519,-1363.49410000,-487.18310000,15.09390000,204.02290000,-1,-1,900); //Shamal
	AddStaticVehicleEx(476,-1434.92570000,-507.10260000,14.89080000,206.28880000,-1,-1,900); //Rustler
	AddStaticVehicleEx(476,-1446.33640000,-512.62400000,14.89960000,207.49700000,-1,-1,900); //Rustler
	AddStaticVehicleEx(476,-1458.59270000,-518.55440000,14.89860000,207.11310000,-1,-1,900); //Rustler
	AddStaticVehicleEx(519,-1337.70040000,-277.54500000,15.06930000,293.88900000,-1,-1,900); //Shamal
	AddStaticVehicleEx(511,-1353.29960000,-257.57260000,15.52090000,314.48990000,-1,-1,900); //Beagle
	AddStaticVehicleEx(513,-1398.39670000,-220.96720000,14.69170000,156.41050000,-1,-1,900); //Stunt
	AddStaticVehicleEx(511,-1622.95800000,-130.68640000,15.52550000,314.27040000,-1,-1,900); //Beagle
	AddStaticVehicleEx(498,-1720.55790000,-122.27010000,3.61770000,44.83850000,-1,-1,900); //Boxville
	AddStaticVehicleEx(413,-1548.31450000,120.05450000,3.62340000,314.67560000,-1,-1,900); //Pony
	AddStaticVehicleEx(487,-1563.68350000,62.82170000,17.49760000,316.50230000,-1,-1,900); //Maverick
	AddStaticVehicleEx(430,-1632.17800000,161.89040000,-0.12420000,136.08660000,-1,-1,900); //Predator
	AddStaticVehicleEx(413,-1739.41500000,170.60100000,3.63790000,180.24080000,-1,-1,900); //Pony
	AddStaticVehicleEx(403,-1825.20460000,87.98320000,15.72280000,179.61180000,-1,-1,900); //Linerunner
	AddStaticVehicleEx(533,-1834.06910000,-110.97710000,5.27610000,270.10460000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(451,-2081.27830000,-85.30580000,34.87050000,359.45920000,-1,-1,900); //Turismo
	AddStaticVehicleEx(533,-2068.34790000,-85.04530000,34.87310000,180.26020000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(445,-2025.76530000,-92.81020000,35.11330000,268.96770000,-1,-1,900); //Admiral
	AddStaticVehicleEx(407,-2020.63560000,84.19910000,28.18370000,272.09260000,-1,-1,900); //Firetruck
	AddStaticVehicleEx(407,-2021.78340000,75.99190000,28.30280000,273.10790000,-1,-1,900); //Firetruck
	AddStaticVehicleEx(400,-1985.94260000,126.79920000,27.65150000,359.30650000,-1,-1,900); //Landstalker
	AddStaticVehicleEx(475,-2036.03700000,135.70780000,28.64030000,91.21670000,-1,-1,900); //Sabre
	AddStaticVehicleEx(533,-1947.18360000,272.30940000,40.75920000,310.91550000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(562,-1955.82910000,281.82760000,40.70600000,359.39090000,-1,-1,900); //Elegy
	AddStaticVehicleEx(409,-1948.41040000,263.12270000,40.84840000,50.06140000,-1,-1,900); //Stretch
	AddStaticVehicleEx(559,-1953.39890000,258.41840000,40.70310000,90.84030000,-1,-1,900); //Jester
	AddStaticVehicleEx(475,-1946.10710000,274.75040000,35.27650000,106.36760000,-1,-1,900); //Sabre
	AddStaticVehicleEx(451,-1945.69090000,267.33740000,35.18100000,329.58460000,-1,-1,900); //Turismo
	AddStaticVehicleEx(507,-1947.52610000,256.29910000,35.29330000,270.36770000,-1,-1,900); //Elegant
	AddStaticVehicleEx(524,-2053.64970000,218.61990000,36.49490000,151.83920000,-1,-1,900); //Cement Truck
	AddStaticVehicleEx(521,-1989.05880000,271.38490000,34.72460000,90.23400000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(445,-2014.33180000,440.79680000,35.04690000,0.41950000,-1,-1,900); //Admiral
	AddStaticVehicleEx(521,-1961.55800000,465.19340000,34.73830000,268.23050000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(420,-2025.55130000,573.67570000,34.86510000,89.14130000,-1,-1,900); //Taxi
	AddStaticVehicleEx(562,-1950.31410000,584.55370000,34.79310000,0.13500000,-1,-1,900); //Elegy
	AddStaticVehicleEx(492,-1941.40410000,585.49680000,34.89690000,359.56070000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(475,-1806.31910000,597.64500000,34.83620000,270.25410000,-1,-1,900); //Sabre
	AddStaticVehicleEx(475,-1869.90200000,832.67490000,34.88790000,88.99750000,-1,-1,900); //Sabre
	AddStaticVehicleEx(445,-1886.01940000,961.92650000,35.04690000,349.98270000,-1,-1,900); //Admiral
	AddStaticVehicleEx(551,-2066.23050000,962.71440000,60.18170000,58.33220000,-1,-1,900); //Merit
	AddStaticVehicleEx(466,-2243.83740000,937.13820000,66.39050000,0.02710000,-1,-1,900); //Glendale
	AddStaticVehicleEx(400,-2196.79710000,1009.09720000,80.09220000,182.84830000,-1,-1,900); //Landstalker
	AddStaticVehicleEx(438,-1403.40800000,-316.38400000,14.06980000,31.47310000,-1,-1,900); //Cabbie
	AddStaticVehicleEx(420,-1408.39990000,-309.49260000,13.84530000,41.78010000,-1,-1,900); //Taxi
	AddStaticVehicleEx(420,-1413.30800000,-303.87770000,13.84330000,41.42400000,-1,-1,900); //Taxi
	AddStaticVehicleEx(420,-1871.83980000,-780.99980000,31.80260000,269.49490000,-1,-1,900); //Taxi
	AddStaticVehicleEx(418,-1897.66890000,-827.21720000,32.11640000,269.25790000,-1,-1,900); //Moonbeam
	AddStaticVehicleEx(458,-1897.09610000,-890.63680000,31.90180000,269.87340000,-1,-1,900); //Solair
	AddStaticVehicleEx(533,-1981.74800000,-784.92050000,31.80910000,0.33740000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(487,-2110.42550000,-826.77530000,32.34940000,0.88890000,-1,-1,900); //Maverick
	AddStaticVehicleEx(556,-2164.97610000,-440.16640000,35.71820000,314.79610000,-1,-1,900); //Monster A
	AddStaticVehicleEx(556,-2168.59300000,-436.70950000,35.71460000,312.36880000,-1,-1,900); //Monster A
	AddStaticVehicleEx(504,-2175.42260000,-375.25470000,35.15920000,87.57550000,-1,-1,900); //Bloodring Banger
	AddStaticVehicleEx(458,-2105.86620000,-377.42380000,35.20520000,269.43740000,-1,-1,900); //Solair
	AddStaticVehicleEx(413,-2245.92110000,-104.67250000,35.39590000,359.88770000,-1,-1,900); //Pony
	AddStaticVehicleEx(522,-2327.88310000,-42.76190000,34.87900000,90.29290000,-1,-1,900); //NRG-500
	AddStaticVehicleEx(533,-2495.25390000,-118.37230000,25.32690000,179.16520000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(475,-2551.07910000,-124.55440000,12.81790000,90.12590000,-1,-1,900); //Sabre
	AddStaticVehicleEx(475,-2613.59960000,202.59970000,4.53020000,0.19480000,-1,-1,900); //Sabre
	AddStaticVehicleEx(438,-2559.89530000,234.43640000,10.54210000,314.53800000,-1,-1,900); //Cabbie
	AddStaticVehicleEx(521,-2538.55740000,217.60430000,10.66250000,322.20070000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(420,-2509.60380000,386.15620000,27.54590000,155.06370000,-1,-1,900); //Taxi
	AddStaticVehicleEx(418,-2487.18260000,421.29640000,27.87390000,315.36180000,-1,-1,900); //Moonbeam
	AddStaticVehicleEx(445,-2486.21530000,398.55340000,27.65350000,141.86500000,-1,-1,900); //Admiral
	AddStaticVehicleEx(507,-2555.94210000,415.68990000,18.85990000,91.90900000,-1,-1,900); //Elegant
	AddStaticVehicleEx(411,-2671.31010000,819.40340000,49.71140000,88.53130000,-1,-1,900); //Infernus
	AddStaticVehicleEx(533,-2718.20040000,789.28320000,50.00720000,176.78140000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(529,-2865.43770000,816.54030000,38.68210000,237.69260000,-1,-1,900); //Willard
	AddStaticVehicleEx(562,-2856.91090000,683.98630000,22.62640000,294.62240000,-1,-1,900); //Elegy
	AddStaticVehicleEx(559,-2837.80050000,924.20700000,43.71280000,274.43980000,-1,-1,900); //Jester
	AddStaticVehicleEx(507,-2894.79100000,1033.00040000,35.75770000,110.26320000,-1,-1,900); //Elegant
	AddStaticVehicleEx(445,-2899.20190000,1101.26680000,27.09000000,91.95380000,-1,-1,900); //Admiral
	AddStaticVehicleEx(400,-2897.46880000,1165.10000000,13.16700000,93.23320000,-1,-1,900); //Landstalker
	AddStaticVehicleEx(409,-2625.29470000,1380.07310000,6.95710000,268.70990000,-1,-1,900); //Stretch
	AddStaticVehicleEx(420,-2646.72660000,1375.19480000,6.95060000,181.75060000,-1,-1,900); //Taxi
	AddStaticVehicleEx(420,-2646.37920000,1364.11550000,6.94700000,181.84210000,-1,-1,900); //Taxi
	AddStaticVehicleEx(420,-2645.97950000,1351.96850000,6.94730000,181.92810000,-1,-1,900); //Taxi
	AddStaticVehicleEx(420,-2645.54250000,1339.27870000,6.94350000,181.98730000,-1,-1,900); //Taxi
	AddStaticVehicleEx(559,-2623.29640000,1336.63920000,6.85160000,316.82710000,-1,-1,900); //Jester
	AddStaticVehicleEx(418,-2437.58080000,1284.77360000,23.45570000,268.68820000,-1,-1,900); //Moonbeam
	AddStaticVehicleEx(551,-2471.76000000,1246.36340000,33.56810000,178.79070000,-1,-1,900); //Merit
	AddStaticVehicleEx(551,-2538.48190000,1228.52030000,37.22260000,32.00350000,-1,-1,900); //Merit
	AddStaticVehicleEx(521,-2529.35990000,1228.30270000,36.99840000,34.53320000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(420,-2517.00710000,1217.82320000,37.20500000,271.12570000,-1,-1,900); //Taxi
	AddStaticVehicleEx(411,-2510.20120000,1138.86280000,55.45360000,355.80260000,-1,-1,900); //Infernus
	AddStaticVehicleEx(533,-2489.77610000,1139.08070000,55.43560000,359.24880000,-1,-1,900); //Feltzer
	AddStaticVehicleEx(510,-2424.85820000,1135.88040000,55.33230000,346.33450000,-1,-1,900); //Mountain Bike
	AddStaticVehicleEx(507,-2414.42090000,1013.55380000,50.21530000,180.18120000,-1,-1,900); //Elegant
	AddStaticVehicleEx(420,-2417.40630000,962.99570000,45.07580000,180.18530000,-1,-1,900); //Taxi
	AddStaticVehicleEx(429,-2340.26980000,1023.34860000,50.37500000,270.64750000,-1,-1,900); //Banshee
	AddStaticVehicleEx(426,-2133.52610000,832.57630000,69.22070000,357.82030000,-1,-1,900); //Premier
	AddStaticVehicleEx(426,-1706.02370000,895.59030000,24.55640000,359.62680000,-1,-1,900); //Premier
	AddStaticVehicleEx(409,-1505.65430000,919.45070000,6.98750000,358.39970000,-1,-1,900); //Stretch
	AddStaticVehicleEx(429,-1677.96010000,1208.72220000,13.35140000,41.59060000,-1,-1,900); //Banshee
	AddStaticVehicleEx(507,-1664.27060000,1222.69490000,20.97970000,14.84890000,-1,-1,900); //Elegant
	AddStaticVehicleEx(562,-1677.51030000,1208.14770000,20.81780000,244.68790000,-1,-1,900); //Elegy
	AddStaticVehicleEx(426,-1665.07530000,1206.08570000,20.89940000,271.16510000,-1,-1,900); //Premier
	AddStaticVehicleEx(560,-1650.65300000,1207.57060000,13.37730000,44.23610000,-1,-1,900); //Sultan
	AddStaticVehicleEx(409,-1659.31840000,1218.82020000,13.47230000,225.90870000,-1,-1,900); //Stretch
	AddStaticVehicleEx(405,-1661.00790000,1211.20340000,13.55140000,261.33960000,-1,-1,900); //Sentinel
	AddStaticVehicleEx(475,-1663.56650000,1214.72190000,7.05550000,64.13920000,-1,-1,900); //Sabre
	AddStaticVehicleEx(521,-1661.71260000,1216.39070000,6.81570000,254.38860000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(560,-1791.03440000,1310.51570000,31.55610000,357.84560000,-1,-1,900); //Sultan
	AddStaticVehicleEx(405,-1798.58010000,1294.15300000,31.72660000,176.57860000,-1,-1,900); //Sentinel
	AddStaticVehicleEx(426,-1792.97830000,1293.13370000,40.89170000,178.16410000,-1,-1,900); //Premier
	AddStaticVehicleEx(562,-1821.89670000,1309.87830000,40.80700000,3.22690000,-1,-1,900); //Elegy
	AddStaticVehicleEx(411,-1810.66530000,1311.58330000,50.17230000,10.23040000,-1,-1,900); //Infernus
	AddStaticVehicleEx(551,-1811.57430000,1292.91280000,59.53490000,187.51520000,-1,-1,900); //Merit
	AddStaticVehicleEx(521,-1799.06730000,1293.46580000,59.30370000,358.59360000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(445,-1686.71780000,1311.84690000,7.05490000,226.82430000,-1,-1,900); //Admiral
	AddStaticVehicleEx(442,-1981.70150000,1131.55910000,53.03340000,180.43190000,-1,-1,900); //Romero
	AddStaticVehicleEx(475,-1816.94910000,1093.42290000,45.24510000,270.09720000,-1,-1,900); //Sabre
	AddStaticVehicleEx(429,-2095.17380000,703.78520000,69.22500000,180.28890000,-1,-1,900); //Banshee
	AddStaticVehicleEx(422,-2133.56150000,767.00170000,69.46950000,359.38070000,-1,-1,900); //Bobcat
	AddStaticVehicleEx(458,-2152.37260000,627.03050000,52.19360000,179.77250000,-1,-1,900); //Solair
	AddStaticVehicleEx(405,-2232.28610000,526.65420000,34.96390000,180.07820000,-1,-1,900); //Sentinel
	AddStaticVehicleEx(560,-2248.24100000,763.70070000,49.07350000,0.84750000,-1,-1,900); //Sultan
	AddStaticVehicleEx(480,-2265.28220000,212.34500000,34.93560000,270.46010000,-1,-1,900); //Comet
	AddStaticVehicleEx(429,-2265.93680000,192.53640000,34.84380000,270.21420000,-1,-1,900); //Banshee
	AddStaticVehicleEx(426,-2266.71680000,141.07110000,34.90250000,269.76980000,-1,-1,900); //Premier
	AddStaticVehicleEx(498,-2235.19260000,160.81960000,35.39120000,268.76390000,-1,-1,900); //Boxville
	AddStaticVehicleEx(521,-2176.32840000,102.38090000,34.87420000,270.43830000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(466,-2140.81670000,171.35510000,34.98600000,359.81760000,-1,-1,900); //Glendale
	AddStaticVehicleEx(445,-2072.54590000,-84.77220000,35.03890000,0.40480000,-1,-1,900); //Admiral
	AddStaticVehicleEx(426,-2039.82970000,-84.04520000,35.06330000,0.70110000,-1,-1,900); //Premier
	AddStaticVehicleEx(538,-1942.92140000,166.26760000,27.00060000,356.79740000,-1,-1,900); //Streak
	AddStaticVehicleEx(521,-2050.70090000,904.58590000,53.70160000,257.87560000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(426,-2060.34500000,1114.24770000,53.03210000,181.10470000,-1,-1,900); //Premier
	AddStaticVehicleEx(466,-2126.72020000,1220.40830000,47.01530000,92.67580000,-1,-1,900); //Glendale
	AddStaticVehicleEx(492,-2003.07210000,1278.75560000,6.93160000,270.68950000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(438,-2461.05620000,479.63980000,29.92990000,117.59650000,-1,-1,900); //Cabbie
	AddStaticVehicleEx(562,-2481.90310000,429.10770000,29.19940000,228.62890000,-1,-1,900); //Elegy
	AddStaticVehicleEx(421,-2430.69380000,416.18820000,35.00910000,316.14200000,-1,-1,900); //Washington
	AddStaticVehicleEx(551,-2411.10130000,349.98530000,34.97150000,94.37200000,-1,-1,900); //Merit
	AddStaticVehicleEx(421,-2429.01760000,305.64060000,35.05740000,3.01450000,-1,-1,900); //Washington
	AddStaticVehicleEx(409,-2405.98830000,338.70390000,34.77200000,326.82050000,-1,-1,900); //Stretch
	AddStaticVehicleEx(409,-2411.90310000,329.66040000,34.76870000,326.80940000,-1,-1,900); //Stretch
	AddStaticVehicleEx(521,-2199.14750000,368.17040000,34.89150000,270.61120000,-1,-1,900); //FCR-900
	//Army Vehicles
	ArmyVehicle0 = AddStaticVehicleEx(470,-1336.29930000,479.83900000,7.17660000,268.88080000,-1,-1,900); //Patriot
	ArmyVehicle1 = AddStaticVehicleEx(425,-1304.67020000,494.84250000,18.80550000,90.36650000,-1,-1,900); //Hunter
	ArmyVehicle2 = AddStaticVehicleEx(520,-1457.47640000,495.84160000,19.00100000,269.04800000,-1,-1,900); //Hydra
	ArmyVehicle3 = AddStaticVehicleEx(520,-1457.39120000,507.02200000,18.99060000,271.12150000,-1,-1,900); //Hydra
	ArmyVehicle4 = AddStaticVehicleEx(520,-1416.58900000,515.90760000,18.96030000,241.83840000,-1,-1,900); //Hydra
	ArmyVehicle5 = AddStaticVehicleEx(425,-1408.15800000,494.36940000,18.89370000,268.56920000,-1,-1,900); //Hunter
	ArmyVehicle6 = AddStaticVehicleEx(470,-1536.95310000,479.70070000,7.18350000,270.05480000,-1,-1,900); //Patriot
	ArmyVehicle7 = AddStaticVehicleEx(595,-1443.30460000,504.11950000,0.27790000,90.77600000,16,65,900); //Launch
	ArmyVehicle8 = AddStaticVehicleEx(595,-1652.99829102,254.30502319,0.00000000,271.13885498,16,65,900); //Launch
	ArmyVehicle9 = AddStaticVehicleEx(595,-1416.33020020,286.39666748,0.00000000,271.13885498,16,65,900); //Launch
	ArmyVehicle10 = AddStaticVehicleEx(595,-1447.01000977,426.60415649,0.00000000,269.63275146,16,65,900); //Launch
	ArmyVehicle11 = AddStaticVehicleEx(430,-1447.56372070,390.68203735,0.00000000,269.63275146,16,65,900); //Predator
	ArmyVehicle12 = AddStaticVehicleEx(430,-1446.35119629,354.91290283,0.00000000,269.63275146,16,65,900); //Predator
	ArmyVehicle13 = AddStaticVehicleEx(520,-1249.76623535,460.23059082,8.71617889,90.36724854,16,16,900); //Hydra
	ArmyVehicle14 = AddStaticVehicleEx(425,-1298.23291016,460.71105957,8.54009628,88.86114502,-1,-1,900); //Hunter
	ArmyVehicle15 = AddStaticVehicleEx(433,-1235.21545410,392.99462891,7.67084217,88.86114502,16,16,900); //Barracks
	ArmyVehicle16 = AddStaticVehicleEx(433,-1235.25720215,384.80035400,7.67084217,87.35504150,-1,-1,900); //Barracks
	ArmyVehicle17 = AddStaticVehicleEx(432,-1248.25329590,337.82229614,7.20017958,0.00000000,-1,-1,900); //Rhino
	ArmyVehicle18 = AddStaticVehicleEx(432,-1255.71887207,337.80114746,7.20017958,0.00000000,-1,-1,900); //Rhino
	ArmyVehicle19 = AddStaticVehicleEx(470,-1294.64562988,337.34295654,7.21085405,0.00000000,16,16,900); //Patriot
	ArmyVehicle20 = AddStaticVehicleEx(470,-1300.10278320,337.40713501,7.21085405,0.00000000,-1,-1,900); //Patriot
	ArmyVehicle21 = AddStaticVehicleEx(470,-1305.53698730,337.32635498,7.21085405,0.00000000,-1,-1,900); //Patriot
	ArmyVehicle22 = AddStaticVehicleEx(430,-1445.12770000,509.64810000,-0.3229000,92.7766000,16,65,900); //Predator
	//Civilian Vehicles
	AddStaticVehicleEx(487,-2328.65970000,-1687.14490000,483.78230000,182.88290000,-1,-1,900); //Maverick
	AddStaticVehicleEx(411,-2343.97050000,-1590.90530000,483.30360000,246.26910000,-1,-1,900); //Infernus
	AddStaticVehicleEx(411,-2345.27420000,-1593.73670000,483.31560000,247.08620000,-1,-1,900); //Infernus
	AddStaticVehicleEx(411,-2346.57010000,-1596.76660000,483.32930000,247.10880000,-1,-1,900); //Infernus
	AddStaticVehicleEx(411,-2347.90800000,-1599.82190000,483.34280000,246.34930000,-1,-1,900); //Infernus
	AddStaticVehicleEx(541,-2354.40630000,-1625.23790000,483.29550000,215.63970000,-1,-1,900); //Bullet
	AddStaticVehicleEx(541,-2353.42940000,-1620.62810000,483.28220000,213.58310000,-1,-1,900); //Bullet
	AddStaticVehicleEx(541,-2352.90040000,-1616.48990000,483.27000000,212.19710000,-1,-1,900); //Bullet
	AddStaticVehicleEx(541,-2352.04390000,-1612.03630000,483.25690000,216.23230000,-1,-1,900); //Bullet
	AddStaticVehicleEx(541,-2351.29270000,-1607.80470000,483.24450000,215.81030000,-1,-1,900); //Bullet
	AddStaticVehicleEx(560,-2348.44410000,-1579.50020000,485.42420000,215.52740000,-1,-1,900); //Sultan
	AddStaticVehicleEx(560,-2350.34110000,-1584.34250000,485.37290000,267.62470000,-1,-1,900); //Sultan
	AddStaticVehicleEx(573,-2336.83450000,-1578.21880000,484.18810000,201.73290000,-1,-1,900); //Duneride
	AddStaticVehicleEx(573,-2339.17600000,-1582.26070000,484.19790000,204.23130000,-1,-1,900); //Duneride
	AddStaticVehicleEx(541,-1772.08620000,1204.71530000,24.75000000,119.11640000,-1,-1,900); //Bullet
	AddStaticVehicleEx(492,-1755.22890000,1177.52150000,24.90660000,270.57240000,-1,-1,900); //Greenwood
	AddStaticVehicleEx(411,-1715.13660000,1204.21190000,24.84730000,133.26810000,-1,-1,900); //Infernus
	AddStaticVehicleEx(551,-1722.26790000,1160.40650000,29.47130000,180.42220000,-1,-1,900); //Merit
	AddStaticVehicleEx(451,-1749.84810000,1112.17420000,45.15230000,89.38800000,-1,-1,900); //Turismo
	AddStaticVehicleEx(521,-1684.38160000,1103.85710000,54.27360000,356.43700000,-1,-1,900); //FCR-900
	AddStaticVehicleEx(560,-1679.37720000,1072.42300000,54.40840000,359.25950000,-1,-1,900); //Sultan
	AddStaticVehicleEx(429,-2072.35720000,964.27710000,60.71990000,1.87590000,-1,-1,900); //Banshee
	AddStaticVehicleEx(511,-1558.42030000,-250.52810000,15.52050000,31.02750000,-1,-1,900); //Beagle
	AddStaticVehicleEx(511,-1576.59050000,-264.84320000,15.52280000,41.86860000,-1,-1,900); //Beagle
	AddStaticVehicleEx(511,-1591.97730000,-280.63100000,15.52370000,45.32940000,-1,-1,900); //Beagle
	AddStaticVehicleEx(476,-1612.56800000,-315.43550000,14.87030000,70.26530000,-1,-1,900); //Rustler
	AddStaticVehicleEx(476,-1617.04440000,-329.69200000,14.85770000,71.20480000,-1,-1,900); //Rustler
	AddStaticVehicleEx(476,-1209.27340000,190.22600000,14.86300000,135.13470000,-1,-1,900); //Rustler
	AddStaticVehicleEx(476,-1217.53640000,198.89320000,14.84120000,132.28790000,-1,-1,900); //Rustler
	AddStaticVehicleEx(445,-1398.11950000,-324.46550000,13.75960000,30.90510000,-1,-1,900); //Admiral
	
	for(new v=0; v<MAX_VEHICLES; v++)
	{
	    VehicleInfo[v][bought] =999;
	    VehicleInfo[v][stolen] =0;
	    VehicleInfo[v][bombed] =0;
	}
	return 1;
}

//==============================================================================

public OnGameModeExit()
{
    //////xobject
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		for(new o = 0; o < sizeof(Objects); o++)
		{
			if(Player[i][view][o])
			{
				Player[i][view][o] = false;
				DestroyPlayerObject(i,Player[i][objid][o]);
			}
		}
	}
	KillTimer(timer);
    // Disconnect the first bot
	IRC_Quit(gBotID[0], "Gamemode exiting");
	// Disconnect the second bot
	IRC_Quit(gBotID[1], "Gamemode exiting");
	// Disconnect the admin bot
	IRC_Quit(gBotID[2], "Gamemode exiting");
	// Destroy the group
	IRC_DestroyGroup(gGroupID);
	IRC_DestroyGroup(gGroupAdminID);
	return 1;
}

//==============================================================================

public OnPlayerRequestClass(playerid, classid)
{
    if(IsPlayerNPC(playerid)) return 1;

	//Set up the class selection
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,-1753.6743,885.2703,295.8750);
    SetPlayerCameraPos(playerid,-1753.6849,892.0016,295.8750);
	SetPlayerCameraLookAt(playerid,-1753.6743,885.2703,295.8750);
	SetPlayerFacingAngle(playerid,0.6323);
	
	//Do things to the player
    SetPlayerColor(playerid,COLOR_DEADCONNECT);
    SetPlayerTeamFromClass(playerid,classid);
    
    switch (classid)
	{
		case 0,1,2,3,4,5:
 		{
			GameTextForPlayer(playerid, "~b~POLICE OFFICER~n~~w~CITY OFFICER", 3000, 5);
		}
		case 6:
  		{
	        GameTextForPlayer(playerid, "~b~POLICE OFFICER~n~~w~SWAT", 3000, 5);
		}
		case 7:
		{
			GameTextForPlayer(playerid, "~b~POLICE OFFICER~n~~w~FBI", 3000, 5);
		}
		case 8:
		{
			GameTextForPlayer(playerid, "~p~SF ARMY OFFICER~n~~w~DEADLY FORCE SQUAD", 3000, 5);
		}
		case 9:
		{
			GameTextForPlayer(playerid, "~y~CIA~n~~w~CENTRAL INTELLIGENCE AGENCY", 3000, 5);
		}
		case 10:
		{
			GameTextForPlayer(playerid, "~b~POLICE OFFICER~n~~w~CASUAL OFFICER", 3000, 5);
		}
		case 11:
		{
			GameTextForPlayer(playerid, "~b~POLICE OFFICER~n~~w~AIR SUPPORT", 3000, 5);
		}
		case 12:
		{
			GameTextForPlayer(playerid, "~b~POLICE OFFICER~n~~w~MARINE SUPPORT", 3000, 5);
		}
		case 13:
		{
			GameTextForPlayer(playerid, "~g~MEDIC~n~~w~CITY SERVICE", 3000, 5);
		}
		case 14:
		{
			GameTextForPlayer(playerid, "~w~CAR MECHANIC", 3000, 5);
		}
		case 15,16:
		{
			GameTextForPlayer(playerid, "~g~TAXI DRIVER", 3000, 5);
		}
		case 17,18,19,20,21,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,48,49,50,51,52,53,54,55,56,57,58,59,60:
		{
			GameTextForPlayer(playerid, "~w~CIVILIAN~n~~r~CHOOSE A JOB WHEN YOU SPAWN", 3000, 5);
		}
	}
	return 1;
}

SetPlayerTeamFromClass(playerid, classid)
{
 	if(classid == 0 || classid == 1 || classid == 2 || classid == 3 || classid == 4 || classid == 5 || classid == 6 || classid == 7 || classid == 10 || classid == 11 || classid == 12)
	{
		gTeam[playerid] = TEAM_COP;
	}
	else if(classid == 8)
	{
		gTeam[playerid] = TEAM_ARMY;
	}
	else if(classid == 9)
	{
	    gTeam[playerid] = TEAM_CIA;
	}
	else if(classid == 13)
	{
	    gTeam[playerid] = TEAM_MEDIC;
 	}
 	else if(classid == 14)
 	{
	    gTeam[playerid] = TEAM_CARFIX;
	}
	else if(classid == 15 || classid == 16)
	{
	    gTeam[playerid] = TEAM_DRIVER;
 	}
	else if(classid >= 17)
	{
	    gTeam[playerid] = TEAM_CIVIL;
	}
}

//==============================================================================

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;

	new string[128];
    new pname[24];
    
    //Variables
    zoneupdates[playerid] =1;

	//Connect Messages
	format(string,sizeof(string),"Welcome to %s v%s!",svname,sversion);
	SendClientMessage(playerid,COLOR_WHITE,string);
	format(string,sizeof(string),"We have many fun things for you to do here in %s",sabbv);
	SendClientMessage(playerid,COLOR_ROYALBLUE,string);
	SendClientMessage(playerid,COLOR_LIME,"Please remember to abide by our server /rules at all times");
	SendClientMessage(playerid,COLOR_GREEN,"If you have any problems feel free to /report them to the Administrators online");
	
	//Player Join message
	GetPlayerName(playerid,pname,sizeof(pname));
	format(string,sizeof(string),"%s(%d) Has joined %s v%s!",pname,playerid,svname,sversion);
	SendClientMessageToAll(COLOR_VIOLETBLUE,string);
	format(string,sizeof(string),"6%s(%d) Has joined %s v%s!",pname,playerid,svname,sversion);
	IRC_Say(gGroupID,IRC_CHANNEL,string);
	SetPlayerColor(playerid,COLOR_DEADCONNECT);

	//Do things to the player
	JailTimer[playerid] = TextDrawCreate(505.000000, 411.000000, "Jailtime: 180");
	TextDrawBackgroundColor(JailTimer[playerid], -1);
	TextDrawFont(JailTimer[playerid], 3);
	TextDrawLetterSize(JailTimer[playerid], 0.529999, 1.299999);
	TextDrawColor(JailTimer[playerid], 65535);
	TextDrawSetOutline(JailTimer[playerid], 1);
	TextDrawSetProportional(JailTimer[playerid], 1);
	TextDrawUseBox(JailTimer[playerid], 1);
	TextDrawBoxColor(JailTimer[playerid], 255);
	TextDrawTextSize(JailTimer[playerid], 633.000000, 0.000000);
	
	MessageTD[playerid] = TextDrawCreate(241.000000, 410.000000, "TICKET RECIEVED");
	TextDrawBackgroundColor(MessageTD[playerid], 255);
	TextDrawFont(MessageTD[playerid], 1);
	TextDrawLetterSize(MessageTD[playerid], 0.549999, 1.500000);
	TextDrawColor(MessageTD[playerid], -1);
	TextDrawSetOutline(MessageTD[playerid], 0);
	TextDrawSetProportional(MessageTD[playerid], 1);
	TextDrawSetShadow(MessageTD[playerid], 1);
	TextDrawUseBox(MessageTD[playerid], 1);
	TextDrawBoxColor(MessageTD[playerid], 255);
	TextDrawTextSize(MessageTD[playerid], 384.000000, 0.000000);
	
	LocationTD[playerid] = TextDrawCreate(43.000000, 327.000000, "Downtown");
	TextDrawBackgroundColor(LocationTD[playerid], 255);
	TextDrawFont(LocationTD[playerid], 1);
	TextDrawLetterSize(LocationTD[playerid], 0.500000, 1.000000);
	TextDrawColor(LocationTD[playerid], -1);
	TextDrawSetOutline(LocationTD[playerid], 0);
	TextDrawSetProportional(LocationTD[playerid], 1);
	TextDrawSetShadow(LocationTD[playerid], 1);
	
	format(string,sizeof(string),"Version: %s",sversion);
	TextDrawSetString(VersionTD,string);
	TextDrawShowForPlayer(playerid,VersionTD);
	TextDrawShowForPlayer(playerid,WebsiteTD);
	TogglePlayerClock(playerid,1);
	
	SetPlayerMapIcon(playerid,1,-2626.1843,211.5102,4.6097,6,0); //Ammunation
	SetPlayerMapIcon(playerid,2,-2099.6882,899.1699,76.7109,24,0); //CaltonHeightsDH
	SetPlayerMapIcon(playerid,3,-2779.9194,0.3026,10.0625,24,0); //OceanFlatsDH
	SetPlayerMapIcon(playerid,4,-2576.4824,818.9226,49.9844,24,0); //ParadisoDH
	SetPlayerMapIcon(playerid,5,-2433.7866,1281.6011,23.7422,24,0); //JuniperHollowDH
	SetPlayerMapIcon(playerid,6,-1547.4066,123.6555,3.5547,9,0); //ShipYard
	SetPlayerMapIcon(playerid,7,-1657.7573,1210.2754,7.2500,55,0); //Otto'sCars
	SetPlayerMapIcon(playerid,8,-1923.3926,303.6380,41.0469,8,0); //BombShop
	SetPlayerMapIcon(playerid,9,-2331.8582,-164.2207,35.5547,10,0); //BurgerShotGarcia
	SetPlayerMapIcon(playerid,10,-2671.5444,260.9214,4.6328,10,0); //BurgerShotOcean
	SetPlayerMapIcon(playerid,11,370.7744,-6.5378,1001.8589,14,0); //CluckinBellOcean
	SetPlayerMapIcon(playerid,12,-2553.8923,193.2280,6.1560,49,0); //GayDarStation
	SetPlayerMapIcon(playerid,13,-2241.8118,131.9901,35.3203,47,0); //Zero's
	SetPlayerMapIcon(playerid,14,-2242.2817,-85.7698,35.3203,49,0); //Misty's
	SetPlayerMapIcon(playerid,15,-1951.9911,300.2070,35.4688,55,0); //WangCars
	SetPlayerMapIcon(playerid,16,-2658.3201,639.5060,14.4531,22,0); //Hospital
	SetPlayerMapIcon(playerid,17,-2568.8982,243.9241,10.2489,7,0); //Barbers
	SetPlayerMapIcon(playerid,18,-2270.1182,-152.8132,35.3203,54,0); //GYM
	SetPlayerMapIcon(playerid,19,-2029.2903,-102.0118,35.1641,36,0); //DrivingSchool
	SetPlayerMapIcon(playerid,20,-1979.9883,138.0498,27.6875,42,0); //TrainStation
	SetPlayerMapIcon(playerid,21,-1911.2001,829.2663,35.1719,10,0); //BurgerShotDowntown
	SetPlayerMapIcon(playerid,22,-1886.2000,862.4730,35.1719,45,0); //DowntownZip
	SetPlayerMapIcon(playerid,23,-1806.8252,947.8553,24.8906,29,0); //FinancialPizza
	SetPlayerMapIcon(playerid,24,-1748.4784,963.3699,24.8828,30,0); //FBI
	SetPlayerMapIcon(playerid,25,-1692.5487,949.6002,24.8906,45,0); //DowntownVictim
	SetPlayerMapIcon(playerid,26,-1496.8027,919.8218,7.1875,52,0); //Bank
	SetPlayerMapIcon(playerid,27,-1609.2813,712.9857,13.7334,30,0); //SFPD
	SetPlayerMapIcon(playerid,28,-1719.8079,1356.6371,7.1875,29,0); //EsplanadePizza
	SetPlayerMapIcon(playerid,29,-2622.5164,1412.6412,7.0938,49,0); //Jizzy's
	SetPlayerMapIcon(playerid,30,-2356.0327,1004.7512,50.8984,10,0); //BurgerShotJuniperHollow
	SetPlayerMapIcon(playerid,31,-2374.1877,908.1357,45.4371,45,0); //JuniperHillBinco
	SetPlayerMapIcon(playerid,32,-2446.3350,752.2393,35.1719,62,0); //SupaSave
	SetPlayerMapIcon(playerid,33,-1814.2487,617.8710,35.1719,14,0); //DowntownCluckin
	
	//Check to see if they are registered or logged in
	if(udb_Exists(PlayerName(playerid)))
	{
		SendClientMessage(playerid,COLOR_ERROR,"This player name has already been registered. Please login before you spawn.");
		ShowLoginScreen(playerid);
	}
	else
	if(!udb_Exists(PlayerName(playerid)))
	{
		SendClientMessage(playerid,COLOR_ERROR,"This player name has not been registered. You must register before playing.");
		ShowRegisterScreen(playerid);
	}

	for(new i = 0; i < sizeof(Objects); i++) Player[playerid][view][i] = false; /////////xobj
	
	return 1;
}

//==============================================================================

public OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerNPC(playerid))
	{
	    IsSpawned[playerid] =0;
	    return 1;
	}
    if(afktag[playerid] == 1)
	{
		new pname[16];
		GetPlayerName(playerid,pname,16);
		strdel(pname, strlen(pname)-5, strlen(pname));
		afktag[playerid] =0;
		SetPlayerName(playerid,pname);
	}
    new string[128];
	new pname[24];
	GetPlayerName(playerid,pname,sizeof(pname));
	
	//Save Wanted Level && Jailtime
	SavedWantedLevel[playerid] =GetPlayerWantedLevel(playerid);
	SavedJailTime[playerid] =JailTime[playerid];
	
	if(PLAYERLIST_authed[playerid] == 1)
	{
		dUserSetINT(PlayerName(playerid)).("Bankcash",BankCash[playerid]);
		dUserSetINT(PlayerName(playerid)).("Cash",GetPlayerMoney(playerid));
		dUserSetINT(PlayerName(playerid)).("Score",GetPlayerScore(playerid));
	 	dUserSetINT(PlayerName(playerid)).("Adminlevel",AdminLevel[playerid]);
		dUserSetINT(PlayerName(playerid)).("Army",CanUseArmy[playerid]);
		dUserSetINT(PlayerName(playerid)).("CIA",CanUseCIA[playerid]);
		dUserSetINT(PlayerName(playerid)).("RegularPlayer",IsRegularPlayer[playerid]);
		dUserSetINT(PlayerName(playerid)).("DrugHouseOwner",DrugHouseOwner[playerid]);
		dUserSetINT(PlayerName(playerid)).("OttoOwner",OttoOwner[playerid]);
		dUserSetINT(PlayerName(playerid)).("TSkill",TerroristSkill[playerid]);
		dUserSetINT(PlayerName(playerid)).("RobSkill",RobSkill[playerid]);
		dUserSetINT(PlayerName(playerid)).("HasPackC4",HasPackC4[playerid]);
		dUserSetINT(PlayerName(playerid)).("HasPackRope",HasPackRope[playerid]);
		dUserSetINT(PlayerName(playerid)).("HasPackMoney",HasPackMoney[playerid]);
		dUserSetINT(PlayerName(playerid)).("SavedWantedLevel",SavedWantedLevel[playerid]);
		dUserSetINT(PlayerName(playerid)).("SavedJailTime",SavedJailTime[playerid]);
	}
	
	//Do things to the playerid
	ResetVariables(playerid);
	TextDrawHideForPlayer(playerid,VersionTD);
	TextDrawHideForPlayer(playerid,WebsiteTD);
	TextDrawDestroy(MessageTD[playerid]);
	TextDrawDestroy(JailTimer[playerid]);
	TextDrawDestroy(LocationTD[playerid]);
	
	if (PlayerInfo[playerid][pRoadblock] != 0)
	{
		RemoveRoadblock(playerid);
	}
	for(new i = 0; i < sizeof(Objects); i++) ////Xobj
	{
		if(Player[playerid][view][i])
		{
			Player[playerid][view][i] = false;
			DestroyPlayerObject(playerid,Player[playerid][objid][i]);
		}
	}
	format(string,sizeof(string),"%s Has just left the server! (%s)",pname,aDisconnectNames[reason]);
	SendClientMessageToAll(COLOR_VIOLETBLUE,string);
	format(string,sizeof(string),"1%s Has just left the server! (%s)",pname,aDisconnectNames[reason]);
	IRC_Say(gGroupID,IRC_CHANNEL,string);
	return 1;
}

//==============================================================================

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
	{
		if(strcmp(PlayerName(playerid), "Billy") == 0)
		{
		    PutPlayerInVehicle(playerid,NPCTram,0);
		    SetPlayerColor(playerid,COLOR_DARKOLIVEGREEN);
		    SetPlayerSkin(playerid,255);
		    IsSpawned[playerid] =1;
		    print("[NPC SPAWN] Billy has been placed in his tram.");
		}
		return 1;
	}
	new string[128];
	new pname[128];
	
	GetPlayerName(playerid,pname,sizeof(pname));
	//Namebanned
	if(NameBanned[playerid] == 1)
	{
	    format(string,sizeof(string),"[AUTO BAN] %s(%d) has been auto banned for ban evading. (Nickname is banned).",pname,playerid);
	    SendClientMessageToAll(COLOR_ADMIN,string);
	    
	    format(string,sizeof(string),"9[AUTO BAN] %s(%d) has been auto banned for ban evading. (Nickname is banned).",pname,playerid);
	    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		Banning[playerid] =1;
		SetTimer("BanPlayer",700,0);
		return 1;
	}
	
	SetPlayerWantedLevel(playerid,0);
	SetPlayerToTeamColour(playerid);
	//////xobject
    PlayerObjectUpdate(playerid);
    TextDrawShowForPlayer(playerid,LocationTD[playerid]);
    
    GangZoneShowForPlayer(playerid, FBIZone, COLOR_BLUE);
    GangZoneShowForPlayer(playerid, SFPDZone, COLOR_BLUE);
    GangZoneShowForPlayer(playerid, ArmyZone, COLOR_FORESTGREEN);
    GangZoneShowForPlayer(playerid, CIAZone, COLOR_ORANGERED);
    GangZoneShowForPlayer(playerid, TaxiZone, COLOR_DARKOLIVEGREEN);
    SetPlayerTime(playerid,gametime,0);

	
	//Spawn Message
    format(string, sizeof(string), "7[SPAWN] %s(%d)",pname,playerid);
	IRC_GroupSay(gGroupID, IRC_CHANNEL,string);

	//Set their job/skill
	if(gTeam[playerid] == TEAM_COP && GetPlayerSkin(playerid) != 286)
	{
		ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{0000FF}POLICE OFFICER INFORMATION:","{FFFFFF}Commands: Type /commands for a list of police commands.\n{FFFFFF}Job: Your job is to deal with crime in San Fierro.\n{FFFFFF}Player Colours: For a list of what the player colors mean, type /pc.\n{FFFFFF}Don't forget to read the /rules of San Fierro CRRPG!","Ok","Cancel");
		GivePlayerWeapon(playerid,31,500);
        GivePlayerWeapon(playerid,29,300);
        GivePlayerWeapon(playerid,3,1);
		SetCameraBehindPlayer(playerid);
		HasLawEnforcementRadio[playerid] =1;
 	}
 	if(gTeam[playerid] == TEAM_COP && GetPlayerSkin(playerid) == 286)
	{
		ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{0000FF}FBI INFORMATION:","{FFFFFF}Commands: Type /commands for a list of police commands.\n{FFFFFF}Job: Your job is to deal with crime in San Fierro.\n{FFFFFF}Player Colours: For a list of what the player colors mean, type /pc.\n{FFFFFF}Don't forget to read the /rules of San Fierro CRRPG!","Ok","Cancel");
		GivePlayerWeapon(playerid,31,500);
        GivePlayerWeapon(playerid,29,300);
        GivePlayerWeapon(playerid,24,20);
        GivePlayerWeapon(playerid,3,1);
		SetCameraBehindPlayer(playerid);
		HasLawEnforcementRadio[playerid] =1;
 	}
 	else if(gTeam[playerid] == TEAM_ARMY)
 	{
 	    /*SendClientMessage(playerid,COLOR_VIOLETBLUE,"ARMY OFFICIAL INFORMATION:");
 	    SendClientMessage(playerid,COLOR_VIOLETBLUE,"Commands: Type /commands for a list of Army commands.");
 	    SendClientMessage(playerid,COLOR_VIOLETBLUE,"Job: Your main job is to take down red (Most Wanted) criminals.");
 	    SendClientMessage(playerid,COLOR_VIOLETBLUE,"Please do not use the Army vehicles for any other purpose than your job.");
        SendClientMessage(playerid,COLOR_VIOLETBLUE,"Although you are a Regular Player, don't forget to abide by the server /rules.");*/
        ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{8A2BE2}ARMY OFFICIAL INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Army commands.\n{FFFFFF}Job: Your main job is to take down red (Most Wanted) criminals.\n{FFFFFF}Please do not use the Army vehicles for any other purpose than your job.\n{FFFFFF}Although you are a Regular Player, don't forget to abide by the server /rules.","Ok","Cancel");
		GivePlayerWeapon(playerid,31,500);
        GivePlayerWeapon(playerid,34,60);
        GivePlayerWeapon(playerid,24,80);
        SetPlayerPos(playerid,-1380.7788,508.4977,18.2344);
        SetPlayerFacingAngle(playerid,88.3392);
		SetCameraBehindPlayer(playerid);
		HasLawEnforcementRadio[playerid] =1;
	}
	else if(gTeam[playerid] == TEAM_CIA)
	{
        /*SendClientMessage(playerid,COLOR_VIOLETBLUE,"CIA INFORMATION:");
 	    SendClientMessage(playerid,COLOR_VIOLETBLUE,"Commands: Type /commands for a list of CIA commands.");
 	    SendClientMessage(playerid,COLOR_VIOLETBLUE,"Job: Your main job is to arrest red (Most Wanted) criminals.");
        SendClientMessage(playerid,COLOR_VIOLETBLUE,"Although you are a Regular Player, don't forget to abide by the server /rules.");*/
        ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{FFFF00}CIA INFORMATION:","{FFFFFF}Commands: Type /commands for a list of CIA commands.\n{FFFFFF}Job: Your main job is to arrest red (Most Wanted) criminals.\n{FFFFFF}Although you are a Regular Player, don't forget to abide by the server /rules.","Ok","Cancel");
		GivePlayerWeapon(playerid,31,500);
        GivePlayerWeapon(playerid,29,300);
        GivePlayerWeapon(playerid,24,80);
        SetPlayerPos(playerid,-1232.2139,739.2380,6.6299);
        SetPlayerFacingAngle(playerid,81.8141);
		SetCameraBehindPlayer(playerid);
        HasLawEnforcementRadio[playerid] =1;
	}
	else if(gTeam[playerid] == TEAM_MEDIC)
	{
	    /*SendClientMessage(playerid,COLOR_FORESTGREEN,"MEDIC INFORMATION:");
	    SendClientMessage(playerid,COLOR_FORESTGREEN,"Commands: Type /commands for a list of Medic commands.");
	    SendClientMessage(playerid,COLOR_FORESTGREEN,"Job: Your job is to heal and cure unhealthy people in San Fierro.");
	    SendClientMessage(playerid,COLOR_FORESTGREEN,"Respond to people when they use the command /medic to call for you.");
        SendClientMessage(playerid,COLOR_FORESTGREEN,"Please remember to abide by the server /rules, or you may be banned.");*/
        ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{228B22}MEDIC INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Medic commands.\n{FFFFFF}Job: Your job is to heal and cure unhealthy people in San Fierro.\n{FFFFFF}Respond to people when they use the command /medic to call for you.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
		GivePlayerWeapon(playerid,22,60);
		GivePlayerWeapon(playerid,4,1);
		SetPlayerPos(playerid,-2558.2654,661.3560,14.45314);
        SetPlayerFacingAngle(playerid,182.7825);
		SetCameraBehindPlayer(playerid);
	}
	else if(gTeam[playerid] == TEAM_CARFIX)
	{
	    /*SendClientMessage(playerid,COLOR_WHITE,"MECHANIC INFORMATION:");
        SendClientMessage(playerid,COLOR_WHITE,"Commands: Type /commands for a list of Mechanic commands.");
        SendClientMessage(playerid,COLOR_WHITE,"Job: Your job is to fix players vehicles whenever they get damaged.");
        SendClientMessage(playerid,COLOR_WHITE,"Respond to people when they use the command /mechanic to call you.");
        SendClientMessage(playerid,COLOR_WHITE,"Please remember to abide by the server /rules, or you may be banned.");*/
        ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}MECHANIC INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Mechanic commands.\n{FFFFFF}Job: Your job is to repair players vehicles in San Fierro.\n{FFFFFF}Respond to people when they use the command /mechanic to call for you.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
		GivePlayerWeapon(playerid,22,60);
		GivePlayerWeapon(playerid,4,1);
		SetPlayerPos(playerid,-2032.1998,148.3631,28.8359);
        SetPlayerFacingAngle(playerid,271.3353);
		SetCameraBehindPlayer(playerid);
	}
	else if(gTeam[playerid] == TEAM_DRIVER)
	{
	    /*SendClientMessage(playerid,COLOR_DARKOLIVEGREEN,"DRIVER INFORMATION:");
        SendClientMessage(playerid,COLOR_DARKOLIVEGREEN,"Commands: Type /commands for a list of Driver commands.");
        SendClientMessage(playerid,COLOR_DARKOLIVEGREEN,"Job: Your job is to collect players at take them to their destination.");
        SendClientMessage(playerid,COLOR_DARKOLIVEGREEN,"Respond to people when they use the command /driver to call you.");
        SendClientMessage(playerid,COLOR_DARKOLIVEGREEN,"Please remember to abide by the server /rules, or you may be banned.");*/
        ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{556B2F}DRIVER INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Driver commands.\n{FFFFFF}Job: Your job is to collect players at take them to their destination.\n{FFFFFF}Respond to people when they use the command /driver to call for you.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
		GivePlayerWeapon(playerid,22,60);
		GivePlayerWeapon(playerid,4,1);
		GivePlayerWeapon(playerid,5,1);
		SetPlayerPos(playerid,-1674.9299,1334.6108,7.1875);
        SetPlayerFacingAngle(playerid,221.6657);
		SetCameraBehindPlayer(playerid);
	}
	else if(gTeam[playerid] >= 9)
	{
	    SendClientMessage(playerid,COLOR_WHITE,"CIVILIAN INFORMATION:");
	    SendClientMessage(playerid,COLOR_WHITE,"Please choose a skill from the menu below.");
        CanChooseSkill[playerid] =1;
        ShowMenuForPlayer(SkillMenu,playerid);
        TogglePlayerControllable(playerid,0);
        new rnd = random(sizeof(SpawnPoints));
        SetPlayerPos(playerid,SpawnPoints[rnd][0],SpawnPoints[rnd][1],SpawnPoints[rnd][2]);
        SetPlayerFacingAngle(playerid,SpawnPoints[rnd][3]);
		SetCameraBehindPlayer(playerid);
	}
	
	//Saved Stats
	if(SavedWantedLevel[playerid] != 0)
	{
	    SetPlayerWantedLevel(playerid,SavedWantedLevel[playerid]);
	    SavedWantedLevel[playerid] =0;
	    SendClientMessage(playerid,COLOR_RED,"You have left the server while wanted. Wanted level restored.");
	}
	if(SavedJailTime[playerid] != 0)
	{
	    TextDrawShowForPlayer(playerid,JailTimer[playerid]);
	    
	    ResetPlayerWeapons(playerid);
	
        new rnd = random(sizeof(JailSpawnPoints));
		JailTime[playerid] =SavedJailTime[playerid];
		IsCuffed[playerid] =0;
		CuffTime[playerid] =0;
		TotalJailTime[playerid] =SavedJailTime[playerid];
		SetPlayerInterior(playerid,10);
		SetPlayerPos(playerid,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		SetPlayerFacingAngle(playerid,JailSpawnPoints[rnd][3]);
		TogglePlayerControllable(playerid,1);
		StopLoopingAnim(playerid);
		SetPlayerWantedLevel(playerid,0);
		SetPlayerToTeamColour(playerid);
	    SavedJailTime[playerid] =0;
	    SendClientMessage(playerid,COLOR_RED,"You have left the server while in jail. You must finish your sentence.");

		format(string,sizeof(string),"[AUTO JAIL] %s(%d) has been auto jailed for leaving the server while in jail. He will finish his sentence.",PlayerName(playerid),playerid);
		SendClientMessageToAll(COLOR_ADMIN,string);
		
		format(string,sizeof(string),"9[AUTO JAIL] %s(%d) has been auto jailed for leaving the server while in jail. He will finish his sentence.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	}
	
	//Set Variables
	IsSpawned[playerid] =1;
	return 1;
}

public SetPlayerToTeamColour(playerid)
{
	if(gTeam[playerid] == TEAM_COP)
	{
	    SetPlayerColor(playerid,COLOR_BLUE);
	}
	if(gTeam[playerid] == TEAM_ARMY)
	{
	    SetPlayerColor(playerid,COLOR_FORESTGREEN);
	}
	if(gTeam[playerid] == TEAM_CIA)
	{
	    SetPlayerColor(playerid,COLOR_ORANGERED);
	}
	if(gTeam[playerid] == TEAM_MEDIC)
	{
	    SetPlayerColor(playerid,COLOR_FORESTGREEN);
	}
	if(gTeam[playerid] == TEAM_CARFIX)
	{
	    SetPlayerColor(playerid,COLOR_WHITE);
	}
	if(gTeam[playerid] == TEAM_DRIVER)
	{
	    SetPlayerColor(playerid,COLOR_DARKOLIVEGREEN);
	}
	if(gTeam[playerid] >= 9)
	{
	    SetPlayerColor(playerid,COLOR_WHITE);
	}
	return 1;
}

//==============================================================================

public OnPlayerDeath(playerid, killerid, reason)
{
    new pname[24];
	new killername[24];
	new string[128];
	
	//Get the names
	GetPlayerName(playerid,pname,sizeof(pname));
	GetPlayerName(killerid,killername,sizeof(killername));

	//Reset Death Variables
	IsSpawned[playerid] =0;
	IsFrozen[playerid] =0;
	CanChooseSkill[playerid] =0;
	HasWeed[playerid] =0;
	HasLawEnforcementRadio[playerid] =0;
	gPlayerUsingLoopingAnim[playerid] =0;
	IsCuffed[playerid] =0;
	JailTime[playerid] =0;
	AttemptedToCuffRecently[playerid] =0;
	HasTicket[playerid] =0;
	TimeToPayTicket[playerid] =0;
	playerCheckpoint[playerid] =0;
	TotalJailTime[playerid] =0;
	LastVehicle[playerid] =0;
	CuffTime[playerid] =0;
	IsDetained[playerid] =0;
	MessageTDTime[playerid] =0;
	HasBeenReportedRecently[playerid] =0;
	StoppedSatViewing[playerid] =0;
	IsTackled[playerid] =0;
	HasRope[playerid] =0;
	HasScissors[playerid] =0;
	HasSausageRolls[playerid] =0;
	HasAntiSTI[playerid] =0;
	HasSecureWallet[playerid] =0;
	HasNeedleAndSyringe[playerid] =0;
	InAdminMode[playerid] =0;
	CalledForMedic[playerid] =0;
	CalledForMechanic[playerid] =0;
	CalledForDrugDealer[playerid] =0;
	CalledForTaxi[playerid] =0;
	CalledForWeaponDealer[playerid] =0;
	HasSTI[playerid] =0;
	PayingTaxi[playerid] =0;
	HasTaxiFare[playerid] =-1;
	OnDuty[playerid] =0;
	HasRapedRecently[playerid] =0;
	SmokingWeed[playerid] =0;
	InjectedHeroin[playerid] =0;
	RobbingDrugHouse[playerid] =0;
	RobbingSupaSave[playerid] =0;
	GivenWeaponRecently[playerid] =0;
	IsKidnapped[playerid] =0;
	AttemptedToKidnapRecently[playerid] =0;
	HasKidnappedRecently[playerid] =0;
	AttemptedToRobRecently[playerid] =0;
	HasRobbedRecently[playerid] =0;
	RobbingOtto[playerid] =0;
	HasC4[playerid] =0;
	HasBlownVehicleRecently[playerid] =0;
	IsPlantingCIABuilding[playerid] =0;
	IsPlantingCIASat[playerid] =0;
	IsPlantingCIABridge[playerid] =0;
	RobbingGarciaBurgerShot[playerid] =0;
	RobbingDownBurgerShot[playerid] =0;
	RobbingJHBurgerShot[playerid] =0;
	RobbingOceanCluckinBell[playerid] =0;
	RobbingDownCluckinBell[playerid] =0;
	RobbingAmmunation[playerid] =0;
	RobbingGayDar[playerid] =0;
	RobbingZero[playerid] =0;
	RobbingMistys[playerid] =0;
	RobbingGYM[playerid] =0;
	RobbingSchool[playerid] =0;
	RobbingWang[playerid] =0;
	RobbingTrain[playerid] =0;
	RobbingBarbers[playerid] =0;
	RobbingHospital[playerid] =0;
	RobbingJizzys[playerid] =0;
	RobbingEsplanadePizza[playerid] =0;
	RobbingFinancialPizza[playerid] =0;
	RobbingDownZip[playerid] =0;
	RobbingDownVictim[playerid] =0;
	RobbingJHBinco[playerid] =0;
	RobbingCityHall[playerid] =0;
	
	//Do extra things to the player.
	TextDrawHideForPlayer(playerid,LocationTD[playerid]);
	new mrand =random(20000);
	format(string,sizeof(string),"The hospital has charged you $%d for their medical services.",mrand);
	SendClientMessage(playerid,COLOR_PINK,string);
	GivePlayerMoney(playerid,-mrand);
	SetPlayerDrunkLevel(playerid,0);
	TextDrawHideForPlayer(playerid,JailTimer[playerid]);
	
	//Remove things.
	if (PlayerInfo[playerid][pRoadblock] != 0)
	{
		RemoveRoadblock(playerid);
	}
	
	//Message the server (Death reasons: Must always be at the end of OnPlayerDeath)
	if(HasHit[playerid] >= 1)
	{
	    format(string,sizeof(string),"[DEATH] %s(%d) has been killed by %s(%d) for a hit contract.",PlayerName(playerid),playerid,PlayerName(killerid),killerid);
	    SendClientMessageToAll(COLOR_PINK,string);
	    format(string,sizeof(string),"13[DEATH] %s(%d) has been killed by %s(%d) for a hit contract.",PlayerName(playerid),playerid,PlayerName(killerid),killerid);
	    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	    
	    GivePlayerMoney(killerid,HitMoney[playerid]);
	    SendClientMessage(killerid,COLOR_DEADCONNECT,"[[_Contract Kill_]]");
	    format(string,sizeof(string),"You have killed %s(%d) for a hit contract and recieved $%d for the kill.",PlayerName(playerid),playerid,HitMoney[playerid]);
	    SendClientMessage(killerid,COLOR_RED,string);
		IncreaseWantedLevel(killerid,20);
		
		format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has murdered %s(%d) and has been caught on CCTV. Arrest the suspect ASAP.",killername,killerid,pname,playerid);
  		SendClientMessageToAllCops(string);
  		
  		HasHit[playerid] =0;
  		HitMoney[playerid] =0;
  		SetPlayerColor(playerid,COLOR_DEADCONNECT);
		SetPlayerWantedLevel(playerid,0);
		SendDeathMessage(killerid,playerid,reason);
  		return 1;
	}
	if(DiedFromSTI[playerid] == 1)
	{
	    DiedFromSTI[playerid] =0;
	    SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
		SetPlayerColor(playerid,COLOR_DEADCONNECT);
		SetPlayerWantedLevel(playerid,0);
	    return 1;
	}
	if(HasUsedDeath[playerid] == 1)
	{
	    format(string,sizeof(string),"[DEATH] %s(%d) Has taken an overdose on pills and killed themself .. Poor guy",pname,playerid);
		SendClientMessageToAll(COLOR_PINK,string);
		format(string,sizeof(string),"13[DEATH] %s(%d) Has taken an overdose on pills and killed themself .. Poor guy",pname,playerid);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		HasUsedDeath[playerid] =0;
		DecreasePlayerScore(playerid,2);
		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
		SetPlayerColor(playerid,COLOR_DEADCONNECT);
		SetPlayerWantedLevel(playerid,0);
	    return 1;
	}
	if(AdminKilled[playerid] == 1)
	{
	    AdminKilled[playerid] =0;
	    SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	    SetPlayerColor(playerid,COLOR_DEADCONNECT);
		SetPlayerWantedLevel(playerid,0);
	    return 1;
	}
	if(InAdminMode[killerid] == 1)
	{
	    format(string,sizeof(string),"[ADMIN KILL] Administrator %s(%d) has killed %s(%d) while in admin mode.",killername,killerid,pname,playerid);
	    SendClientMessageToAll(COLOR_ADMIN,string);
	    SetPlayerColor(playerid,COLOR_DEADCONNECT);
		SetPlayerWantedLevel(playerid,0);
		SendDeathMessage(killerid,playerid,reason);
		return 1;
	}
	if(IsPlayerConnected(killerid))
	{
	    if(gTeam[killerid] >= 6)
	    {
	        if(JailTime[killerid] == 0)
	        {
	            SendClientMessage(killerid,COLOR_DEADCONNECT,"[[_Murder_]]");
	            format(string,sizeof(string),"You have murdered %s(%d) and have been caught on CCTV. The police have been informed.",pname,playerid);
	            SendClientMessage(killerid,COLOR_RED,string);
	            IncreaseWantedLevel(killerid,20);
	            SetPlayerWantedLevel(playerid,0);
	            SendDeathMessage(killerid,playerid,reason);
	            
	            format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has murdered %s(%d) and has been caught on CCTV. Arrest the suspect ASAP.",killername,killerid,pname,playerid);
	            SendClientMessageToAllCops(string);
	            return 1;
			}
			if(JailTime[killerid] >= 1)
			{
			    SendClientMessage(killerid,COLOR_DEADCONNECT,"[[_Jail Fight_]]");
			    SendClientMessage(killerid,COLOR_RED,"You have been caught by the security guards in a jail fight. You have recieved an extra jail sentence.");
				JailTime[killerid] +=180;
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);
				return 1;
			}
		}
		if(gTeam[killerid] == TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
		{
		    if(GetPlayerWantedLevel(playerid) < 4)
		    {
		        SendClientMessage(killerid,COLOR_RED,"[INNOCENT KILL] Do not kill innocent players .. (White/Yellow) Only shoot at Oranges and reds.");
		        SendClientMessage(killerid,COLOR_RED,"This is not a DM server. Please read our /rules and our /pc for a list of player colours.");
                SetPlayerWantedLevel(playerid,0);
                SendDeathMessage(killerid,playerid,reason);
                return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 4 && GetPlayerWantedLevel(playerid) < 20)
			{
				format(string,sizeof(string),"[POLICE ACTION] Police Officer %s(%d) has taken down Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);
				
				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $10000 for taking down the wanted suspect.");
				GivePlayerMoney(killerid,10000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 4 && GetPlayerWantedLevel(playerid) < 30)
			{
				format(string,sizeof(string),"[POLICE ACTION] Police Officer %s(%d) has taken down Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $10000 for taking down the wanted suspect.");
				GivePlayerMoney(killerid,10000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 30 && GetPlayerWantedLevel(playerid) < 40)
			{
				format(string,sizeof(string),"[POLICE ACTION] Police Officer %s(%d) has taken down the Most Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $30000 for taking down the most wanted suspect.");
				GivePlayerMoney(killerid,30000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 40)
			{
				format(string,sizeof(string),"[POLICE ACTION] Police Officer %s(%d) has taken down the Maniac %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $50000 for taking down the Maniac by force.");
				GivePlayerMoney(killerid,50000);
				return 1;
			}
		}
		if(gTeam[killerid] == TEAM_ARMY && gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_CIA)
		{
		    if(GetPlayerWantedLevel(playerid) < 4)
		    {
		        SendClientMessage(killerid,COLOR_RED,"[INNOCENT KILL] Do not kill innocent players .. (White/Yellow) Only shoot at Oranges and reds.");
		        SendClientMessage(killerid,COLOR_RED,"This is not a DM server. Please read our /rules and our /pc for a list of player colours.");
                SetPlayerWantedLevel(playerid,0);
                SendDeathMessage(killerid,playerid,reason);
                return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 4 && GetPlayerWantedLevel(playerid) < 20)
			{
				format(string,sizeof(string),"[POLICE ACTION] Army Officer %s(%d) has taken down Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $10000 for taking down the wanted suspect.");
				GivePlayerMoney(killerid,10000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 4 && GetPlayerWantedLevel(playerid) < 30)
			{
				format(string,sizeof(string),"[POLICE ACTION] Army Officer %s(%d) has taken down Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $10000 for taking down the wanted suspect.");
				GivePlayerMoney(killerid,10000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 30 && GetPlayerWantedLevel(playerid) < 40)
			{
				format(string,sizeof(string),"[POLICE ACTION] Army Officer %s(%d) has taken down the Most Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $30000 for taking down the most wanted suspect.");
				GivePlayerMoney(killerid,30000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 40)
			{
				format(string,sizeof(string),"[POLICE ACTION] Army Officer %s(%d) has taken down the Maniac %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $50000 for taking down the Maniac by force.");
				GivePlayerMoney(killerid,50000);
				return 1;
			}
		}
		if(gTeam[killerid] == TEAM_CIA && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_COP)
		{
		    if(GetPlayerWantedLevel(playerid) < 4)
		    {
		        SendClientMessage(killerid,COLOR_RED,"[INNOCENT KILL] Do not kill innocent players .. (White/Yellow) Only shoot at Oranges and reds.");
		        SendClientMessage(killerid,COLOR_RED,"This is not a DM server. Please read our /rules and our /pc for a list of player colours.");
                SetPlayerWantedLevel(playerid,0);
                SendDeathMessage(killerid,playerid,reason);
                return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 4 && GetPlayerWantedLevel(playerid) < 20)
			{
				format(string,sizeof(string),"[POLICE ACTION] CIA Agent %s(%d) has taken down Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $10000 for taking down the wanted suspect.");
				GivePlayerMoney(killerid,10000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 4 && GetPlayerWantedLevel(playerid) < 30)
			{
				format(string,sizeof(string),"[POLICE ACTION] CIA Agent %s(%d) has taken down Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $10000 for taking down the wanted suspect.");
				GivePlayerMoney(killerid,10000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 30 && GetPlayerWantedLevel(playerid) < 40)
			{
				format(string,sizeof(string),"[POLICE ACTION] CIA Agent %s(%d) has taken down the Most Wanted suspect %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $30000 for taking down the most wanted suspect.");
				GivePlayerMoney(killerid,30000);
				return 1;
			}
			if(GetPlayerWantedLevel(playerid) >= 40)
			{
				format(string,sizeof(string),"[POLICE ACTION] CIA Agent %s(%d) has taken down the Maniac %s(%d) by a %s",killername,killerid,pname,playerid,aWeaponNames[reason]);
				SendClientMessageToAll(COLOR_DODGERBLUE,string);
				
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);

				SendClientMessage(killerid,COLOR_LIGHTBLUE,"You have recieved $50000 for taking down the Maniac by force.");
				GivePlayerMoney(killerid,50000);
				return 1;
			}
		}
		if(gTeam[killerid] == TEAM_COP || gTeam[killerid] == TEAM_ARMY || gTeam[killerid] == TEAM_CIA)
		{
		    if(TeamKillWarning[killerid] < 2)
		    {
			    SendClientMessage(killerid,COLOR_RED,"DO NOT TEAMKILL IN THIS SERVER. IT IS NOT ALLOWED.");
			    SendClientMessage(killerid,COLOR_RED,"You cannot teamkill. Please read /rules and /pc for a list of rules and player colours in this server.");

                format(string,sizeof(string),"13[DEATH] %d%s(%d) Has been killed by %d%s(%d) by a %s",IrcColor[playerid],pname,playerid,IrcColor[killerid],killername,killerid,aWeaponNames[reason]);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				TeamKillWarning[killerid] ++;
				SetPlayerColor(playerid,COLOR_DEADCONNECT);
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);
			    return 1;
			}
			if(TeamKillWarning[killerid] == 2)
			{
			    format(string,sizeof(string),"[AUTO KICK] %s(%d) too many warnings for teamkilling other players. [3/3]",killername,killerid);
			    SendClientMessageToAll(COLOR_ADMIN,string);
			    
			    format(string,sizeof(string),"9[AUTO KICK] %s(%d) too many warnings for teamkilling other players. [3/3]",killername,killerid);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				
				format(string,sizeof(string),"13[DEATH] %d%s(%d) Has been killed by %d%s(%d) by a %s",IrcColor[playerid],pname,playerid,IrcColor[killerid],killername,killerid,aWeaponNames[reason]);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				TeamKillWarning[killerid] =0;
				Kicking[killerid] =1;
				SetTimer("KickPlayer",700,0);
				SetPlayerColor(playerid,COLOR_DEADCONNECT);
				SetPlayerWantedLevel(playerid,0);
				SendDeathMessage(killerid,playerid,reason);
				return 1;
			}
		}
		if(gTeam[killerid] != TEAM_COP && gTeam[killerid] != TEAM_ARMY && gTeam[killerid] != TEAM_CIA)
		{
			format(string,sizeof(string),"[DEATH] %s(%d) Has been killed by %s(%d) by a %s",pname,playerid,killername,killerid,aWeaponNames[reason]);
			SendClientMessageToAll(COLOR_PINK,string);
			SetPlayerWantedLevel(playerid,0);
		}
		format(string,sizeof(string),"13[DEATH] %d%s(%d) Has been killed by %d%s(%d) by a %s",IrcColor[playerid],pname,playerid,IrcColor[killerid],killername,killerid,aWeaponNames[reason]);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		SendDeathMessage(killerid,playerid,reason);
		SetPlayerWantedLevel(playerid,0);
	}
	if(!IsPlayerConnected(killerid))
	{
	    format(string,sizeof(string),"[DEATH] %s(%d) Has killed themselves .. (For some odd reason)",pname,playerid);
	    SendClientMessageToAll(COLOR_PINK,string);
	    format(string,sizeof(string),"13[DEATH] %s(%d) Has killed themselves .. (For some odd reason)",pname,playerid);
	    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	    SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	    SetPlayerWantedLevel(playerid,0);
	}
	SetPlayerColor(playerid,COLOR_DEADCONNECT);
	SetPlayerWantedLevel(playerid,0);
	return 1;
}

//==============================================================================

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

//==============================================================================

public OnVehicleDeath(vehicleid, killerid)
{
	if(VehicleInfo[vehicleid][bought] != 999)
	{
	    SendClientMessage(VehicleInfo[vehicleid][bought],COLOR_ERROR,"The car your purchased from Otto's Cars has been destroyed.");
		DestroyVehicle(vehicleid);
	}
	VehicleInfo[vehicleid][bought] =999;
	VehicleInfo[vehicleid][stolen] =0;
	VehicleInfo[vehicleid][bombed] =0;
	return 1;
}

//==============================================================================

public OnPlayerText(playerid, text[])
{
	new pname[24];
	new string[128];
	GetPlayerName(playerid,pname,sizeof(pname));
	
	//SPAM
	SpamStrings[playerid] +=2;
	
	//If Muted
	if(IsMuted[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are muted by a Server Administrator. You cannot speak.");
	    return 0;
	}
	//If Spamming
	if(SpamStrings[playerid] >= MAX_SPAM)
	{
	    format(string,sizeof(string),"Please do not spam in %s. Please wait before typing again.",sabbv);
	    SendClientMessage(playerid, COLOR_ERROR, string);
	    return 0;
    }
	
	if (text[0] == '@')
    {
        if(HasLawEnforcementRadio[playerid] != 1)
        {
            SendClientMessage(playerid,COLOR_ERROR,"You need to have a Law Enforcement radio in order to send a message down the police radio.");
            return 0;
		}
		format(string,sizeof(string),"[POLICE RADIO] %s(%d): %s, over.",pname,playerid,text[1]);
		SendClientMessageToAllCops(string);
		format(string,sizeof(string),"12[POLICE RADIO] %s(%d): %s, over.",pname,playerid,text[1]);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		return 0;
	}
	
	//IRC Message
	format(string,sizeof(string),"3[CHAT] %d %s(%d):1 %s",IrcColor[playerid],pname,playerid,text);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

//==============================================================================

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[128];
	SpamStrings[playerid] +=2;
    if(SpamStrings[playerid] >= MAX_SPAM)
	{
	    format(string,sizeof(string),"Please do not spam in %s. Please wait before typing again.",sabbv);
	    SendClientMessage(playerid, COLOR_ERROR, string);
	    return 1;
    }

	//dcmd//
	//Civilian commands//
	dcmd(gcommands,9,cmdtext); //General Commands
	dcmd(commands,8,cmdtext);
	dcmd(rules,5,cmdtext);
	dcmd(pc,2,cmdtext); // Player Colours
	dcmd(transfer,8,cmdtext);
	dcmd(death,5,cmdtext);
	dcmd(911,3,cmdtext);
	dcmd(payticket,9,cmdtext);
	dcmd(engineon,8,cmdtext);
	dcmd(engineoff,9,cmdtext);
	dcmd(lightson,8,cmdtext);
	dcmd(lightsoff,9,cmdtext);
	dcmd(bootup,6,cmdtext);
	dcmd(bootdown,8,cmdtext);
	dcmd(bonnetup,8,cmdtext);
	dcmd(bonnetdown,10,cmdtext);
	dcmd(me,2,cmdtext);
	dcmd(w,1,cmdtext);
	dcmd(whisper,7,cmdtext);
	dcmd(cw,2,cmdtext);
	dcmd(carwhisper,10,cmdtext);
	dcmd(pm,2,cmdtext);
	dcmd(ircpm,5,cmdtext);
	dcmd(report,6,cmdtext);
	dcmd(medic,5,cmdtext);
	dcmd(mechanic,8,cmdtext);
	dcmd(drugdealer,10,cmdtext);
	dcmd(weapondealer,12,cmdtext);
	dcmd(taxi,4,cmdtext);
	dcmd(bo,2,cmdtext);
	dcmd(bizowners,9,cmdtext);
	dcmd(smokeweed,9,cmdtext);
	dcmd(injectheroin,12,cmdtext);
	dcmd(placehit,8,cmdtext);
	dcmd(untie,5,cmdtext);
	dcmd(cutrope,7,cmdtext);
	dcmd(robskill,8,cmdtext);
	dcmd(robstore,8,cmdtext);
	dcmd(inventory,9,cmdtext);
	dcmd(credits,7,cmdtext);
	dcmd(sausage,7,cmdtext);
	dcmd(givecash,8,cmdtext);
	dcmd(givegun,7,cmdtext);
	dcmd(changepass,10,cmdtext);
	dcmd(changename,10,cmdtext);
	
	//Regular Player Commands//
	dcmd(crb,3,cmdtext);
	dcmd(rub,3,cmdtext);
	dcmd(rrball,6,cmdtext);
	dcmd(afk,3,cmdtext);
	dcmd(back,4,cmdtext);
	dcmd(rc,2,cmdtext);
	
	//Terrorist Commands//
	dcmd(blowcar,7,cmdtext);
	dcmd(blowup,6,cmdtext);
	dcmd(tlevel,6,cmdtext);
	
	//Car Jacker Commands//
	dcmd(sellcar,7,cmdtext);

	//Thief Commands//
	dcmd(rob,3,cmdtext);

	//Kidnapper Commands//
	dcmd(kidnap,6,cmdtext);

	//Hitman Commands//
	dcmd(hitlist,7,cmdtext);
	
	//Weapon Dealer Commands//
	dcmd(showweapons,11,cmdtext);
	dcmd(sellweapon,10,cmdtext);
	
	//Drug Dealer Commands//
	dcmd(giveweed,8,cmdtext);
	dcmd(giveheroin,10,cmdtext);
	
	//Rapist commands//
	dcmd(rape,4,cmdtext); //Also for non-rapeists.
	
	//Range of Classes Commands//
	dcmd(setprice,8,cmdtext);
	
	//Medic Commands//
	dcmd(heal,4,cmdtext);
	dcmd(cure,4,cmdtext);
	dcmd(healme,6,cmdtext);
	dcmd(cureme,6,cmdtext);
	
	//Mechanic Commands//
	dcmd(repair,6,cmdtext);
	dcmd(repairme,8,cmdtext);
	
	//Police Commands//
	dcmd(pu,2,cmdtext);
	dcmd(ticket,6,cmdtext);
	dcmd(suspect,7,cmdtext);
	dcmd(search,6,cmdtext);
	dcmd(m,1,cmdtext);
	dcmd(arrest,6,cmdtext);
	dcmd(cuff,4,cmdtext);
	dcmd(uncuff,6,cmdtext);
	dcmd(detain,6,cmdtext);
	dcmd(dropoff,7,cmdtext);
	
	//CIA Commands//
	dcmd(stopsat,7,cmdtext);
	dcmd(tackle,6,cmdtext);
	
	//FBI Commands//
	dcmd(liftup,6,cmdtext);
	dcmd(liftdown,8,cmdtext);
	
	//Administrator Commands//
	if(AdminLevel[playerid] >= 1)
	{
		dcmd(adcmds,6,cmdtext);
		dcmd(admute,6,cmdtext);
		dcmd(adunmute,8,cmdtext);
		dcmd(adwarn,6,cmdtext);
		dcmd(admsg,5,cmdtext);
		if(AdminLevel[playerid] >= 2)
		{
		    dcmd(adfreeze,8,cmdtext);
			dcmd(adunfreeze,10,cmdtext);
		}
		if(AdminLevel[playerid] >= 3)
		{
			dcmd(adjail,6,cmdtext);
			dcmd(adan,4,cmdtext);
			dcmd(adannounce,10,cmdtext);
			dcmd(adkick,6,cmdtext);
		}
		if(AdminLevel[playerid] >= 4)
		{
		    dcmd(adblow,6,cmdtext);
		    dcmd(adban,5,cmdtext);
		    dcmd(spectate,8,cmdtext);
		    dcmd(specoff,7,cmdtext);
		    dcmd(adkill,6,cmdtext);
		    dcmd(adgivecash,10,cmdtext);
		    dcmd(adgc,4,cmdtext);
		}
		if(AdminLevel[playerid] >= 5)
		{
		    dcmd(adon,4,cmdtext);
			dcmd(adoff,5,cmdtext);
			dcmd(goto,4,cmdtext);
			dcmd(bring,5,cmdtext);
			dcmd(adreg,5,cmdtext);
			dcmd(adunreg,7,cmdtext);
			dcmd(adarmy,6,cmdtext);
			dcmd(adunarmy,8,cmdtext);
			dcmd(adcia,5,cmdtext);
			dcmd(aduncia,7,cmdtext);
			dcmd(adgiveweapon,12,cmdtext);
			dcmd(adjetpack,9,cmdtext);
		}
		if(AdminLevel[playerid] == 1337)
		{
		    dcmd(adsetlevel,10,cmdtext);
		}
	}
	
	return SendClientMessage(playerid,COLOR_RED,"Wrong command. This command is not found. Type /commands for a list of commands.");
}

dcmd_commands(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
    if(gTeam[playerid] == TEAM_COP && GetPlayerSkin(playerid) != 286)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}POLICE COMMANDS","{FFFFFF}/cuff - Cuffs a player.\n/uncuff - Uncuffs a player.\n/pu - Asks a suspect to pull over.\n/ticket - Issues a ticket to a player.\n/suspect - Gives a player a wanted level.\n/search - Searches a player.\n/m - Megaphone.\n/arrest - Arrests a player.\n/detain - Detains a player.\n/dropoff - Arrests a detained player.\n@ (message) - Sends a message through the police radio.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_ARMY)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}ARMY COMMANDS","{FFFFFF}/cuff - Cuffs a player.\n/uncuff - Uncuffs a player.\n/pu - Asks a suspect to pull over.\n/ticket - Issues a ticket to a player.\n/suspect - Gives a player a wanted level.\n/search - Searches a player.\n/m - Megaphone.\n/arrest - Arrests a player.\n/detain - Detains a player.\n/dropoff - Arrests a detained player.\n@ (message) - Sends a message through the police radio.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_CIA)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}CIA COMMANDS","{FFFFFF}/cuff - Cuffs a player.\n/uncuff - Uncuffs a player.\n/pu - Asks a suspect to pull over.\n/ticket - Issues a ticket to a player.\n/suspect - Gives a player a wanted level.\n/search - Searches a player.\n/m - Megaphone.\n/arrest - Arrests a player.\n/detain - Detains a player.\n/dropoff - Arrests a detained player.\n/tackle\n@ (message) - Sends a message through the police radio.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_COP && GetPlayerSkin(playerid) == 286)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}FBI COMMANDS","{FFFFFF}/cuff - Cuffs a player.\n/uncuff - Uncuffs a player.\n/pu - Asks a suspect to pull over.\n/ticket - Issues a ticket to a player.\n/suspect - Gives a player a wanted level.\n/search - Searches a player.\n/m - Megaphone.\n/arrest - Arrests a player.\n/detain - Detains a player.\n/dropoff - Arrests a detained player.\n@ (message) - Sends a message through the police radio.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_CARFIX)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}MECHANIC COMMANDS","{FFFFFF}/repair - Repairs someone elses vehicle.\n/repairme - Repairs your own vehicle.\n/setprice - Sets your price.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_MEDIC)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}MEDIC COMMANDS","{FFFFFF}/heal - Heals a player.\n/healme - Heals yourself.\n/cure - Cures a player.\n/cureme - Cures yourself.\n/setprice - Sets your price.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_RAPIST)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}RAPIST COMMANDS","{FFFFFF}/rape - Rapes a player and infects them.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_DRGDEL)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}DRUG DEALER COMMANDS","{FFFFFF}/giveweed - Gives a player weed.\n/giveheroin - Gives a player heroin.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_GUNDEL)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}WEAPON DEALER COMMANDS","{FFFFFF}/showweapons - Shows a player your weapon list.\n/sellweapon - Sells a player a weapon.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_HITMAN)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}HITMAN COMMANDS","{FFFFFF}/hitlist - Shows the list of hits.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_KIDNAP)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}KIDNAPPER COMMANDS","{FFFFFF}/kidnap - Kidnaps a player.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_THIEF)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}THIEF COMMANDS","{FFFFFF}/rob - Robs a player.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_CARJACK)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}CAR JACKER COMMANDS","{FFFFFF}/sellcar - Sells a stolen car to the Shipyard.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_TERRO)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}TERRORIST COMMANDS","{FFFFFF}/blowcar - Blows up your car.\n/blowup - Blows up a building.\n/tlevel - Shows your Terrorism Level.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	if(gTeam[playerid] == TEAM_DRIVER)
    {
		ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"{0000FF}DRIVER COMMANDS","{FFFFFF}/setprice - Set the price of your services.\nYou have no other specific commands. Get in a taxi vehicle to go on duty.\nYou can also see a list of General Commands with /gcommands.","Ok","Cancel");
		format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /commands.",PlayerName(playerid),playerid);
		SendClientMessageToAllAdmins(string);
	}
	return 1;
}

dcmd_gcommands(playerid,params[])
{
	#pragma unused params
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	ShowPlayerDialog(playerid,DIALOG_COMMANDS,DIALOG_STYLE_MSGBOX,"General Commands","{FFFFFF}/death /911 /engineon /engineoff /lightson /lightsoff /bootup /bootdown /bonnetup /bonnetdown /me /w\n/cw /pm /ircpm /report /medic /mechanic /weapondealer /drugdealer /taxi /bizowners /smokeweed /injectheroin\n/placehit /untie /cutrope /robskill /robstore /inventory /credits /sausage /givecash /givegun\n{FF0000}/rules and /pc","Ok","Cancel");
	return 1;
}

dcmd_death(playerid,params[])
{
	#pragma unused params
	if(IsCuffed[playerid] == 1)
 	{
		SendClientMessage(playerid,COLOR_ERROR,"You cannot kill yourself while handcuffed. How could that be possible?");
		return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsSpawned[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are already dead, why on earth would you want to kill yourself twice?");
		return 1;
	}
	if(GetPlayerWantedLevel(playerid) >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use /death to kill yourself while you have a wanted level. That is arrest evade.");
	    return 1;
	}
	if(JailTime[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use /death to kill yourself while you are in jail. That is jail evade.");
	    return 1;
	}
    HasUsedDeath[playerid] =1;
	SetPlayerHealth(playerid,0);
	return 1;
}

dcmd_911(playerid,params[])
{
	new string[128];
    SpamStrings[playerid] +=2;
    if(SpamStrings[playerid] >= MAX_SPAM)
	{
	    format(string,sizeof(string),"Please do not spam in %s. Please wait before typing again.",sabbv);
	    SendClientMessage(playerid, COLOR_ERROR, string);
	    return 1;
    }
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /911 (Message)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Law enforcement cannot call 911. Please use '@Message' to use your police radio.");
	    return 1;
	}
	new current_zone;
	current_zone = player_zone[playerid];
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_911 Call_]]");
	format(string,sizeof(string),"You have sent the message: %s",params);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"Location: %s",zones[current_zone][zone_name]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	SendClientMessage(playerid,COLOR_DEADCONNECT,"Your message has been recieved and emergency services are on the way. Stay in the area.");

	format(string,sizeof(string),"[POLICE RADIO] 911 Call From: %s(%d). Message: %s. Location: %s.",PlayerName(playerid),playerid,params,zones[current_zone][zone_name]);
	SendClientMessageToAllCops(string);

	format(string,sizeof(string),"[MEDIC RADIO] 911 Call From: %s(%d). Message: %s. Location: %s.",PlayerName(playerid),playerid,params,zones[current_zone][zone_name]);
	SendClientMessageToAllMedics(string);
	return 1;
}

dcmd_payticket(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(HasTicket[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have a ticket to pay.");
		return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Ticket Paid_]]");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have paid your ticket of $2000 and your wanted level has been removed.");
	SetPlayerWantedLevel(playerid,0);
	GivePlayerMoney(playerid,-2000);
	HasTicket[playerid] =0;
	TimeToPayTicket[playerid] =0;

	format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has paid their ticket of $2000 and their wanted level has been removed.",PlayerName(playerid),playerid);
	SendClientMessageToAllCops(string);
	return 1;
}

dcmd_pu(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /pu (Player Name/ID)");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can ask suspects to pull over.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot ask them to pull over.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(!IsPlayerInAnyVehicle(ID))
	{
	    format(string,sizeof(string),"%s(%d) is not in a vehicle. You cannot ask them to pull over.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 20)
	{
		format(string,sizeof(string),"%s(%d) is too far away. You cannot ask them to pull over. Try using your megaphone. (/m)",PlayerName(ID),ID);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has asked you to pull over. Pull over to the side.",PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_DODGERBLUE,string);
	TextDrawSetString(MessageTD[ID],"PULL OVER");
	TextDrawShowForPlayer(ID,MessageTD[ID]);
	MessageTDTime[ID] =5;

	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Pull Over_]]");
	format(string,sizeof(string),"You have asked %s(%d) to pull over. If they fail to respond, use /suspect to report them.",PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_DODGERBLUE,string);
	return 1;
}

dcmd_ticket(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
		SendClientMessage(playerid,COLOR_ERROR,"USAGE: /ticket (Player Name/ID)");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
 		SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can issue tickets to suspects.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot issue them a ticket.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerWantedLevel(ID) >= 4)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give this player a ticket, you must /cuff this player and then /arrest them.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 8)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot issue them a ticket. Get closer.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Fined_]]");
	format(string,sizeof(string),"Law Enforcement Officer %s(%d) has issued you a ticket of $2000 for your criminal actions.",PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_DODGERBLUE,string);
	SendClientMessage(ID,COLOR_DODGERBLUE,"You have 2 minutes to pay this ticket with /payticket or your wanted level will increase.");
	HasTicket[ID] =1;
	TimeToPayTicket[ID] =120;
	TextDrawSetString(MessageTD[ID],"TICKET RECIEVED");
	TextDrawShowForPlayer(ID,MessageTD[ID]);
	MessageTDTime[ID] =5;
	IncreasePlayerScore(playerid,1);

	format(string,sizeof(string),"[POLICE RADIO] Law Enforcement Officer %s(%d) has issued a ticket of $2000 to %s(%d).",PlayerName(playerid),playerid,PlayerName(ID),ID);
	SendClientMessageToAllCops(string);
	return 1;
}

dcmd_suspect(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[128];
	if(sscanf(params, "us[100]", ID, cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /suspect (Player Name/ID) (Reason)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can report criminals on the police radio.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot report them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_COP || gTeam[ID] == TEAM_ARMY || gTeam[ID] == TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot report other law enforcement on the police radio. Im sure they done nothing wrong.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot report yourself down the police radio. Why would you even want to do that.");
	    return 1;
	}
	if(HasBeenReportedRecently[ID] >= 1)
	{
	    format(string,sizeof(string),"%s(%d) has been reported for criminal activity lately. You cannot report them",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	new message =strval(cmdreason);
	format(string,sizeof(string),"[POLICE RADIO] Law Enforcement Officer %s(%d) has reported %s(%d) for criminal activity. Reason: %s",PlayerName(playerid),playerid,PlayerName(ID),ID,message);
	SendClientMessageToAllCops(string);
	format(string,sizeof(string),"12[POLICE RADIO] Law Enforcement Officer %s(%d) has reported %s(%d) for criminal activity. Reason: %s",PlayerName(playerid),playerid,PlayerName(ID),ID,message);
	IRC_GroupSay(gGroupAdminID,IRC_CHANNEL,string);

	format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has reported you. Reason: %s",PlayerName(playerid),playerid,message);
	SendClientMessage(ID,COLOR_DODGERBLUE,string);
	TextDrawSetString(MessageTD[ID],"TICKET RECIEVED");
	TextDrawShowForPlayer(ID,MessageTD[ID]);
	MessageTDTime[ID] =5;
	IncreaseWantedLevel(ID,2);
	HasBeenReportedRecently[ID] =60;
	IncreasePlayerScore(playerid,1);
	return 1;
}

dcmd_search(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /search (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can search suspects.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot search them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to search him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsCuffed[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not cuffed. You must cuff the player before trying to search them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot search a suspect while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot search a suspect while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot search yourself, i think you already know what you are carrying.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot search dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot search them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_SEARCHED_]]");
	format(string,sizeof(string),"Law Enforcement Officer %s(%d) has started to search you, better hope you are not carrying anything ilegal!",PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_DODGERBLUE,string);
	if(HasWeed[ID] >= 1 || HasHeroin[ID] >= 1)
	{
	    if(HasWeed[ID] >= 1)
	    {
		    format(string,sizeof(string),"[POLICE ACTION] Officer %s(%d) has searched %s(%d) and found %d grams of weed on them.",PlayerName(playerid),playerid,PlayerName(ID),ID,HasWeed[ID]);
		    SendClientMessageToAll(COLOR_LIGHTBLUE,string);
			IncreaseWantedLevel(ID,4);
		}
		if(HasHeroin[ID] >= 1)
	    {
		    format(string,sizeof(string),"[POLICE ACTION] Officer %s(%d) has searched %s(%d) and found %d injections of heroin on them.",PlayerName(playerid),playerid,PlayerName(ID),ID,HasWeed[ID]);
		    SendClientMessageToAll(COLOR_LIGHTBLUE,string);
			IncreaseWantedLevel(ID,4);
		}
		return 1;
	}
	format(string,sizeof(string),"[SEARCH] You have performed a search on %s(%d) but have found nothing ilegal.",PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_DODGERBLUE,string);
	return 1;
}

dcmd_crb(playerid,params[])
{
	new rb;
    if(IsPlayerConnected(playerid) && gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || AdminLevel[playerid] == 1337)
	{
	    if(sscanf(params, "i", rb))
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "USAGE: /crb (Roadblock ID)");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "[Available Roadblocks]");
			SendClientMessage(playerid, COLOR_GREY, "| 1: Small Roadblock | 2: Medium Roadblock |");
			SendClientMessage(playerid, COLOR_GREY, "| 3: Big Roadblock | 4: Cone | 5: Detour Sign |");
			SendClientMessage(playerid, COLOR_GREY, "| 6: Will Be Sign | 7: Line Closed Sign |");
			return 1;
		}
		if(IsKidnapped[playerid] == 1)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
		    return 1;
		}
		if(IsRegularPlayer[playerid] != 1337)
		{
			SendClientMessage(playerid,COLOR_ERROR,"You must be a regular player to place roadblocks.");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			SendClientMessage(playerid,COLOR_ERROR,"You cannot place a roadblock while in a vehicle. What are you? Superman?");
			return 1;
		}
        if (rb == 1)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(1459,plocx,plocy,plocz,ploca);
	        GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
			return 1;
		}
		else if (rb == 2)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(978,plocx,plocy,plocz+0.6,ploca);
	        GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
			return 1;
		}
		else if (rb == 3)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(981,plocx,plocy,plocz+0.9,ploca+180);
	        GameTextForPlayer(playerid,"~w~Roadblock ~g~Placed!",3000,1);
	        SafeSetPlayerPos(playerid, plocx, plocy+5, plocz);
			return 1;
		}
		else if (rb == 4)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(1238,plocx,plocy,plocz+0.2,ploca);
	        GameTextForPlayer(playerid,"~w~Cone ~g~Placed!",3000,1);
			return 1;
		}
		else if (rb == 5)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(1425,plocx,plocy,plocz+0.6,ploca);
	        GameTextForPlayer(playerid,"~w~Sign ~g~Placed!",3000,1);
			return 1;
		}
		else if (rb == 6)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(3265,plocx,plocy,plocz-0.5,ploca);
	        GameTextForPlayer(playerid,"~w~Sign ~g~Placed!",3000,1);
			return 1;
		}
		else if (rb == 7)
		{
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateRoadblock(3091,plocx,plocy,plocz+0.5,ploca+180);
	        GameTextForPlayer(playerid,"~w~Sign ~g~Placed!",3000,1);
			return 1;
		}
	}
	return 1;
}

dcmd_rub(playerid,params[])
{
	#pragma unused params
    if(IsRegularPlayer[playerid] != 1337)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You must be a regular player to remove roadblocks.");
		return 1;
	}
	if(IsPlayerConnected(playerid) && gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || AdminLevel[playerid] == 1337)
	{
       	DeleteClosestRoadblock(playerid);
        GameTextForPlayer(playerid,"~w~Roadblock ~r~Removed!",3000,1);
	}
    return 1;
}

dcmd_rrball(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsRegularPlayer[playerid] != 1337)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You must be a regular player to remove roadblocks.");
		return 1;
	}
    if(IsPlayerConnected(playerid) && gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || AdminLevel[playerid] == 1337)
   	{
    	DeleteAllRoadblocks(playerid);
    	format(string,sizeof(string),"[POLICE RADIO] Law Enforcement Officer %s(%d) has removed all Roadblocks in his area, over.",PlayerName(playerid),playerid);
    	SendClientMessageToAllCops(string);
    	GameTextForPlayer(playerid,"~b~All ~w~Roadblocks ~r~Removed!",3000,1);
	}
	return 1;
}

dcmd_w(playerid,params[])
{
	new string[128];
    if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /w(whisper) (msg)");
	    return 1;
    }
    format(string, sizeof(string), "[WHISPER] %s(%d): %s",PlayerName(playerid),playerid,params);
    printf("%s", string);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
    for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i) && GetDistanceBetweenPlayers(playerid,i) < 10)
		{
		    format(string, sizeof(string), "[WHISPER] %s(%d): %s",PlayerName(playerid),playerid,params);
		    SendClientMessage(i,COLOR_YELLOW,string);
	    }
    }
    return 1;
}

dcmd_whisper(playerid,params[])	return dcmd_w(playerid,params);

dcmd_cw(playerid,params[])
{
	new string[128];
	if(!IsPlayerInAnyVehicle(playerid))
	{
	    SendClientMessage(playerid, COLOR_ERROR, "You not in any vehicle. You cannot use this command");
	    return 1;
    }
    if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /c(ar)w(hisper) (Message)");
	    return 1;
    }
    new cwid = GetPlayerVehicleID(playerid);
    format(string, sizeof(string), "[CAR WHISPER] %s(%d): %s",PlayerName(playerid),playerid,params);
    printf("%s", string);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
    for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) == cwid)
			{
			    format(string, sizeof(string), "[CAR WHISPER] %s(%d): %s",PlayerName(playerid),playerid,params);
			    SendClientMessage(i,COLOR_YELLOW,string);
		    }
    	}
	}
    return 1;
}

dcmd_carwhisper(playerid,params[]) return dcmd_cw(playerid,params);

dcmd_pm(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params, "us[100]", ID, cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /pm (Player Name/ID) (Message)");
	    return 1;
	}
    if(IsMuted[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are Muted. You Cannot Use This Command");
	    return 1;
    }
    if(udb_Exists(PlayerName(playerid)) && !PLAYERLIST_authed[playerid])
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must login before you can talk");
	    return 1;
    }
    if(!IsPlayerConnected(ID))
	{
	    format(string, sizeof(string), "The Player ID (%d) is not connected to the server.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
    }
	format(string, sizeof(string), "PM Sent to: %s(%d): %s",PlayerName(ID),ID,cmdreason);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	
	format(string, sizeof(string), "PM From: %s(%d) %s",PlayerName(playerid),playerid,cmdreason);
	SendClientMessage(ID,COLOR_YELLOW,string);
	
	format(string, sizeof(string), "3[PM] From %s(%d) to %s(%d): %s",PlayerName(playerid),playerid,PlayerName(ID),ID,cmdreason); // [0] <jacob> hi
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	
	SpamStrings[playerid] ++;
    PlayerPlaySound(ID,1085,0.0,0.0,0.0);
	return 1;
}

dcmd_ircpm(playerid,params[])
{
	new string[128];
    SpamStrings[playerid] +=2;
    if(SpamStrings[playerid] >= MAX_SPAM)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Please do not spam. Please wait before typing again.");
	    return 1;
    }
	if(IsMuted[playerid] == 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You are muted, you can't use this command.");
		return 1;
	}
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /ircpm (Message)");
	    return 1;
	}
    format(string, sizeof(string), "10[IRC PM] %s(%d): %s",PlayerName(playerid),playerid,params);
    IRC_GroupSay(gGroupID, IRC_CHANNEL,string);
    
    if(AdminLevel[playerid] != 1337)
    {
	    format(string, sizeof(string), "[IRC PM] %s(%d): %s",PlayerName(playerid),playerid,params);
	    SendClientMessage(playerid,COLOR_PINK,string);
    }
    for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(AdminLevel[i] == 1337)
		{
		    format(string, sizeof(string), "[IRC PM] %s(%d): %s",PlayerName(playerid),playerid,params);
		    SendClientMessage(i,COLOR_PINK,string);
    	}
    }
    return 1;
}

dcmd_report(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /report (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connect to the server.",ID);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	format(string,sizeof(string),"[REPORT] You have successfully reported %s(%d) to the online Server Administrators.",PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_ADMIN,string);
	
	format(string,sizeof(string),"9[REPORT] Reporter: %s(%d) Reported: %s(%d) Reason: %s",PlayerName(playerid),playerid,PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	
	format(string,sizeof(string),"[REPORT] Reporter: %s(%d) has reported %s(%d).",PlayerName(playerid),playerid,PlayerName(ID),ID);
	SendClientMessageToAllAdmins(string);
	format(string,sizeof(string),"[REPORT] Reason: %s.",cmdreason);
	SendClientMessageToAllAdmins(string);
	return 1;
}

dcmd_me(playerid,params[])
{
	new string[128];
	SpamStrings[playerid] +=2;
    if(SpamStrings[playerid] >= MAX_SPAM)
	{
	    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before typing again.");
	    return 1;
    }
    if(!strlen(params))
    {
        SendClientMessage(playerid,COLOR_ERROR, "USAGE: /me (Message)");
        return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsMuted[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are muted by a Server Administrator, you cannot use this command.");
	    return 1;
	}
	format(string,sizeof(string),"[ME] %s(%d) %s",PlayerName(playerid),playerid,params);
	new pcol = GetPlayerColor(playerid);
	SendClientMessageToAll(pcol,string);
	
	format(string,sizeof(string),"10[ME] %d %s(%d) 1%s",IrcColor[playerid],PlayerName(playerid),playerid,params);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_m(playerid,params[])
{
	new string[128];
	SpamStrings[playerid] +=2;
    if(SpamStrings[playerid] >= MAX_SPAM)
	{
	    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before typing again.");
	    return 1;
    }
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /m (Message)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can use the megaphone.");
	    return 1;
	}
	for(new i=0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(GetDistanceBetweenPlayers(playerid,i) <= 50)
			{
				format(string,sizeof(string),"[POLICE MEGAPHONE] %s(%d): %s",PlayerName(playerid),playerid,params);
				SendClientMessage(i,COLOR_RED,string);
			}
		}
	}
	format(string,sizeof(string),"4[POLICE MEGAPHONE] %s(%d): %s",PlayerName(playerid),playerid,params);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	return 1;
}

dcmd_arrest(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /arrest (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can arrest wanted suspects.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot arrest them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to arrest him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsCuffed[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not cuffed. You have to place the suspect in cuffs before attempted to arrest them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot arrest a suspect while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot arrest a suspect they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot arrest yourself, why would you do that anyway?");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You arrest dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot arrest them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerWantedLevel(ID) < 4)
	{
	    format(string,sizeof(string),"%s(%d)'s wanted level is too low. You cannot jail them. Use /ticket (Player ID).",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4)
	{
		SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Arrested_]]");
		format(string,sizeof(string),"You have been sent to San Fierro Prison by Law Enforcement Officer %s(%d)",PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_LIGHTBLUE,string);

		//Give the Police Officer Reward
		IncreasePlayerScore(playerid,2);

		//Show the jail TextDraw for suspect
		TextDrawShowForPlayer(ID,JailTimer[ID]);
		
		//Others
		ResetPlayerWeapons(ID);

		//Send the suspect to jail
		if(GetPlayerWantedLevel(ID) >= 4 && GetPlayerWantedLevel(ID) <= 10)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the low wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the low wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

			//Give the police officer reward
		    format(string,sizeof(string),"You have recieved $10000 for sending the low wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,10000);

			new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =180;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =180;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 11 && GetPlayerWantedLevel(ID) <= 19)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $15000 for sending the wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,15000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =250;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =250;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 20 && GetPlayerWantedLevel(ID) <= 29)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $15000 for sending the wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,15000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =340;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =340;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 30 && GetPlayerWantedLevel(ID) <= 39)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the most wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the most wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $25000 for sending the most wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,25000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =400;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =400;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 40)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the maniac %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the maniac %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $40000 for sending the maniac %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,40000);

		    new rnd = random(sizeof(JailSpawnPoints));
			JailTime[ID] =500;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =500;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		return 1;
	}
	return 1;
}

dcmd_cuff(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /cuff (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can place cuffs on suspects.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot cuff them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to place cuffs on him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_COP || gTeam[ID] == TEAM_ARMY || gTeam[ID] == TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot place other Law Enforcement officer in cuffs. You might lose your job for that ..");
	    return 1;
	}
	if(IsCuffed[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is already cuffed. You don't want to waste a second pair of cuffs on them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot place a suspect in cuffs while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot place a suspect in cuffs while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot put cuffs on yourself, it wouldn't be a good idea with rapists around.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot place cuffs on dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot place cuffs them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(AttemptedToCuffRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You're handcuffs are stuck in the lock from your last attempt. Please wait until they get unstuck first.");
		return 1;
	}
	new crand = random(100);
	if(crand <= 30)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Cuff attempt failed. The suspect's arm slipped out of your hands.");
		AttemptedToCuffRecently[playerid] =25;
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4 && crand > 30)
	{
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Suspect Cuffed_]]");
	    format(string,sizeof(string),"You have placed cuffs on %s(%d)! They can no longer move.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Placed in handcuffs_]]");
	    format(string,sizeof(string),"Law enforcement officer %s(%d) has placed you in handcuffs! You cannot move! You will be auto uncuffed in 30 seconds.",PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		TogglePlayerControllable(ID,0);
	    LoopingAnim(ID, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Taking Cover
	    IsCuffed[ID] =1;
	    CuffTime[ID] =30;
	    return 1;
	}
	return 1;
}

dcmd_uncuff(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /uncuff (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can remove cuffs from suspects.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot uncuff them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to remove cuffs from him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsCuffed[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not cuffed. You cannot uncuff them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot remove a suspect's cuffs while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot remove a suspect's cuffs while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot remove cuffs from yourself.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot remove cuffs from dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot remove cuffs from them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4)
	{
	    format(string,sizeof(string),"You have removed %s(%d)'s cuffs. They can now move again.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    format(string,sizeof(string),"Law enforcement officer %s(%d) has removed your cuffs! You can now move again!",PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_ERROR,string);
		TogglePlayerControllable(ID,1);
	    IsCuffed[ID] =0;
	    StopLoopingAnim(ID);
	    CuffTime[ID] =0;
	    return 1;
	}
	return 1;
}

dcmd_detain(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /detain (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can take suspects into their vehicle.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot detain them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to detain him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsCuffed[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not cuffed. You cannot detain them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot detain a suspect while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot detain a suspect while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot detain yourself.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot detain dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot detain them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(LastVehicle[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must enter a vehicle before trying to detain a suspect.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4)
	{
	    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has placed the suspect %s(%d) in his vehicle.",PlayerName(playerid),playerid,PlayerName(ID),ID);
	    SendClientMessageToAll(COLOR_DODGERBLUE,string);
	    format(string,sizeof(string),"12[POLICE ACTION] Law Enforcement Officer %s(%d) has placed the suspect %s(%d) in his vehicle.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		IRC_Say(gGroupID,IRC_CHANNEL,string);

		SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Detained_]]");
		format(string,sizeof(string),"Law Enforcement Officer %s(%d) has placed you in his vehicle. Your auto uncuff timer has been increased.",PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_DODGERBLUE,string);

		SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Detained_]]");
		format(string,sizeof(string),"You have detained %s(%d) into the last vehicle you were in.",PlayerName(ID),ID);
		SendClientMessage(playerid,COLOR_DODGERBLUE,string);
		SendClientMessage(playerid,COLOR_DODGERBLUE,"You have recieved $5000 for detaining the suspect.");
		GivePlayerMoney(playerid,5000);

		//Put the suspect in the vehicle and increase cuff timer
		PutPlayerInVehicle(ID,LastVehicle[playerid],1);
		CuffTime[ID] =300;
		IsDetained[ID] =1;
		return 1;
	}
	return 1;
}

dcmd_dropoff(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
		SendClientMessage(playerid,COLOR_ERROR,"USAGE: /dropoff (Player Name/ID)");
		return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only law enforcement can drop suspects off to prison.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot jail them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 6)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to jail him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsDetained[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not detained. You cannot jail them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot jail yourself.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot jail dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot jail them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerWantedLevel(ID) < 4)
	{
	    format(string,sizeof(string),"%s(%d)'s wanted level is too low. You cannot jail them. Use /ticket (Player ID).",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(getCheckpointType(playerid) != CP_DropOff)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be in the Checkpoint at the SFPD garage to drop off suspects.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 6)
	{
	    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Arrested_]]");
		format(string,sizeof(string),"You have been sent to San Fierro Prison by Law Enforcement Officer %s(%d)",PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		IsDetained[ID] =0;

		//Give the Police Officer Reward
		IncreasePlayerScore(playerid,4);

		//Show the jail TextDraw for suspect
		TextDrawShowForPlayer(ID,JailTimer[ID]);
		
		//Others
		ResetPlayerWeapons(ID);

		//Send the suspect to jail
		if(GetPlayerWantedLevel(ID) >= 4 && GetPlayerWantedLevel(ID) <= 10)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the low wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the low wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $10000 for sending the low wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,10000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =180;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =180;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 11 && GetPlayerWantedLevel(ID) <= 19)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $15000 for sending the wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,15000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =250;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =250;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 20 && GetPlayerWantedLevel(ID) <= 29)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $15000 for sending the wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,15000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =340;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =340;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 30 && GetPlayerWantedLevel(ID) <= 39)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the most wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the most wanted suspect %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $25000 for sending the most wanted suspect %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,25000);

		    new rnd = random(sizeof(JailSpawnPoints));
		    JailTime[ID] =400;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =400;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		if(GetPlayerWantedLevel(ID) >= 40)
		{
		    format(string,sizeof(string),"[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the maniac %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ORANGE,string);
		    format(string,sizeof(string),"7[POLICE ACTION] Law Enforcement Officer %s(%d) has sent the maniac %s(%d) to San Fierro Prison.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

		    //Give the police officer reward
		    format(string,sizeof(string),"You have recieved $40000 for sending the maniac %s(%d) to prison.",PlayerName(ID),ID);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			GivePlayerMoney(playerid,40000);

		    new rnd = random(sizeof(JailSpawnPoints));
			JailTime[ID] =500;
		    IsCuffed[ID] =0;
		    CuffTime[ID] =0;
		    TotalJailTime[ID] =500;
		    SetPlayerInterior(ID,10);
		    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
		    TogglePlayerControllable(ID,1);
		    StopLoopingAnim(ID);
		    SetPlayerWantedLevel(ID,0);
		    SetPlayerToTeamColour(ID);
		    return 1;
		}
		return 1;
	}
	return 1;
}

dcmd_adcmds(playerid,params[])
{
	#pragma unused params
	if(AdminLevel[playerid] == 1)
	{
    	ShowPlayerDialog(playerid,DIALOG_ADCMDS,DIALOG_STYLE_MSGBOX,"{10F441}ADMINISTRATOR Level 2 COMMANDS:","{FFFFFF}/admsg /adwarn /ad(un)mute","Ok","Cancel");
	}
	if(AdminLevel[playerid] == 2)
	{
    	ShowPlayerDialog(playerid,DIALOG_ADCMDS,DIALOG_STYLE_MSGBOX,"{10F441}ADMINISTRATOR Level 2 COMMANDS:","{FFFFFF}/ad(un)freeze /admsg /adwarn /ad(un)mute","Ok","Cancel");
	}
	if(AdminLevel[playerid] == 3)
	{
    	ShowPlayerDialog(playerid,DIALOG_ADCMDS,DIALOG_STYLE_MSGBOX,"{10F441}ADMINISTRATOR Level 3 COMMANDS:","{FFFFFF}/adkick /adan(nounce)\n/adjail /ad(un)freeze /admsg /adwarn /ad(un)mute","Ok","Cancel");
	}
	if(AdminLevel[playerid] == 4)
	{
    	ShowPlayerDialog(playerid,DIALOG_ADCMDS,DIALOG_STYLE_MSGBOX,"{10F441}ADMINISTRATOR Level 4 COMMANDS:","{FFFFFF}/adg(ive)c(ash) /adkill /spectate /specoff /adban /adblow /adkick /adan(nounce)\n/adjail /ad(un)freeze /admsg /adwarn /ad(un)mute","Ok","Cancel");
	}
	if(AdminLevel[playerid] == 5)
	{
    	ShowPlayerDialog(playerid,DIALOG_ADCMDS,DIALOG_STYLE_MSGBOX,"{10F441}ADMINISTRATOR Level 5 COMMANDS:","{FFFFFF}/adjetpack /adgiveweapon /ad(un)cia /ad(un)army /ad(un)reg /bring /goto /adoff /adon\n/adg(ive)c(ash) /adkill /spectate /specoff /adban /adblow /adkick /adan(nounce)\n/adjail /ad(un)freeze /admsg /adwarn /ad(un)mute","Ok","Cancel");
	}
	if(AdminLevel[playerid] == 1337)
	{
    	ShowPlayerDialog(playerid,DIALOG_ADCMDS,DIALOG_STYLE_MSGBOX,"{10F441}ADMINISTRATOR Level 1337 COMMANDS:","{FFFFFF}/adsetlevel /adjetpack /adgiveweapon /ad(un)cia /ad(un)army /ad(un)reg /bring /goto /adoff /adon\n/adg(ive)c(ash) /adkill /spectate /specoff /adban /adblow /adkick /adan(nounce)\n/adjail /ad(un)freeze /admsg /adwarn /ad(un)mute","Ok","Cancel");
	}
	return 1;
}

dcmd_adjetpack(playerid,params[])
{
	#pragma unused params
    SetPlayerSpecialAction(playerid,2);
    return 1;
}

dcmd_adgiveweapon(playerid,params[])
{
	new string[128];
	new ID;
	new Ammo;
	new Wepid;
	if(sscanf(params,"uii",ID,Wepid,Ammo))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adgiveweapon (Player Name/ID) (Weapon ID) (Ammo)");
	    return 1;
	}
	if(IsSpawned[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is must be alive and spawned in order to give them a weapon.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The Player ID (%d) is not connected to the server.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	GivePlayerWeapon(ID,Wepid,Ammo);
	format(string,sizeof(string),"[ADMIN WEAPON] Administrator has given you a weapon. Weapon: %s. Ammo: %d.",aWeaponNames[Wepid],Ammo);
	SendClientMessage(ID,COLOR_ADMIN,string);
	
	format(string,sizeof(string),"[ADMIN WEAPON] You have given %s(%d) a weapon. Weapon: %s. Ammo: %d.",PlayerName(ID),ID,aWeaponNames[Wepid],Ammo);
	SendClientMessage(playerid,COLOR_ADMIN,string);
	
	format(string,sizeof(string),"9[ADMIN WEAPON] Administrator %s(%d) has given %s(%d) a weapon. Weapon: %s. Ammo: %d.",PlayerName(playerid),playerid,PlayerName(ID),ID,aWeaponNames[Wepid],Ammo);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	return 1;
}

dcmd_adgivecash(playerid,params[])
{
	new ID;
	new Cash;
	new string[128];
    if(sscanf(params,"ui",ID,Cash))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adg(ive)c(ash) (Player Name/ID) (Amount)");
	    return 1;
	}
	if(IsSpawned[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is must be alive and spawned in order to give them cash.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The Player ID (%d) is not connected to the server.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	GivePlayerMoney(ID,Cash);
	format(string,sizeof(string),"[ADMIN CASH] Administrator has given you Cash. Amount: %d.",Cash);
	SendClientMessage(ID,COLOR_ADMIN,string);

	format(string,sizeof(string),"[ADMIN CASH] You have given %s(%d) Cash. Amount: %d.",PlayerName(ID),ID,Cash);
	SendClientMessage(playerid,COLOR_ADMIN,string);

	format(string,sizeof(string),"9[ADMIN CASH] Administrator %s(%d) has given %s(%d) Cash. Amount: %d.",PlayerName(playerid),playerid,PlayerName(ID),ID,Cash);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	return 1;
}

dcmd_adgc(playerid,params[]) return dcmd_adgivecash(playerid,params);

dcmd_adjail(playerid,params[])
{
	new string[128];
	new ID;
	new cmdtime;
	if(sscanf(params, "ui", ID, cmdtime))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adjail (Player Name/ID) (Seconds)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot jail them.");
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot jail them.");
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN] Administrator has jailed %s(%d) to San Fierro Prison for %d seconds.",PlayerName(ID),ID,cmdtime);
	SendClientMessageToAll(COLOR_ADMIN,string);
  	format(string,sizeof(string),"9[ADMIN] Administrator has jailed %s(%d) to San Fierro Prison for %d seconds.",PlayerName(ID),ID,cmdtime);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

	//TextDraw
	TextDrawShowForPlayer(ID,JailTimer[ID]);
	
	//Others
	ResetPlayerWeapons(ID);

    new rnd = random(sizeof(JailSpawnPoints));
    JailTime[ID] =cmdtime;
    IsCuffed[ID] =0;
    CuffTime[ID] =0;
    TotalJailTime[ID] =cmdtime;
    SetPlayerInterior(ID,10);
    SetPlayerPos(ID,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
    SetPlayerFacingAngle(ID,JailSpawnPoints[rnd][3]);
    TogglePlayerControllable(ID,1);
    SetPlayerWantedLevel(ID,0);
    SetPlayerToTeamColour(ID);
    return 1;
}

dcmd_admute(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /admute (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot mute them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsMuted[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is already muted by a Server Administrator. You cannot mute them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	IsMuted[ID] =1;
	format(string,sizeof(string),"[ADMIN] Administrator has muted %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);

	format(string,sizeof(string),"9[ADMIN] Administrator has muted %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adunmute(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"uS[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adunmute (Player Name/ID) (Reason - Optional)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot unmute them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsMuted[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not muted by a Server Administrator. You cannot unmute them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	IsMuted[ID] =0;
	format(string,sizeof(string),"[ADMIN] Administrator has unmuted %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);

	format(string,sizeof(string),"9[ADMIN] Administrator has unmuted %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adfreeze(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adfreeze (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot freeze them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is already frozen by a Server Administrator. You cannot freeze them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	IsFrozen[ID] =1;
	format(string,sizeof(string),"[ADMIN] Administrator has frozen %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);
	TogglePlayerControllable(ID,0);

	format(string,sizeof(string),"9[ADMIN] Administrator has frozen %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adunfreeze(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"uS[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adunfreeze (Player Name/ID) (Reason - Optional)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot unfreeze them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) is not frozen by a Server Administrator. You cannot unfreeze them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	IsFrozen[ID] =0;
	format(string,sizeof(string),"[ADMIN] Administrator has unfrozen %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);
	TogglePlayerControllable(ID,1);

	format(string,sizeof(string),"9[ADMIN] Administrator has unfrozen %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adwarn(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adwarn (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot warn them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(Warns[ID] >= 0 && Warns[ID] < 2)
	{
		Warns[ID] ++;
		format(string,sizeof(string),"[ADMIN] Administrator has warned %s(%d) [%d/3] for reason: %s.",PlayerName(ID),ID,Warns[ID],cmdreason);
		SendClientMessageToAll(COLOR_ADMIN,string);

		format(string,sizeof(string),"9[ADMIN] Administrator has warned %s(%d) [%d/3] for reason: %s.",PlayerName(ID),ID,Warns[ID],cmdreason);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		return 1;
	}
	if(Warns[ID] == 2)
	{
	    Warns[ID] =0;
	    format(string,sizeof(string),"[ADMIN] Administrator has warned %s(%d) [3/3] for reason: %s.",PlayerName(ID),ID,Warns[ID],cmdreason);
		SendClientMessageToAll(COLOR_ADMIN,string);
		format(string,sizeof(string),"[AUTO KICK] %s(%d) has been auto kicked by our auto admin for too many admin warnings. [3/3]",PlayerName(ID),ID);
		SendClientMessageToAll(COLOR_ADMIN,string);

		format(string,sizeof(string),"9[ADMIN] Administrator has warned %s(%d) [3/3] for reason: %s.",PlayerName(ID),ID,Warns[ID],cmdreason);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		format(string,sizeof(string),"9[AUTO KICK] %s(%d) has been auto kicked by our auto admin for too many admin warnings. [3/3]",PlayerName(ID),ID);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		Kicking[ID] =1;
		SetTimer("KickPlayer",700,0);
		return 1;
	}
	return 1;
}

dcmd_adkick(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adkick (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot kick them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	Kicking[ID] =1;
	format(string,sizeof(string),"[ADMIN] Administrator has kicked %s(%d) from the server. Reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);
	
	format(string,sizeof(string),"9[ADMIN] Administrator has kicked %s(%d) from the server. Reason: %s.",PlayerName(ID),ID,cmdreason);
    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	SetTimer("KickPlayer",700,0);
	return 1;
}

dcmd_adban(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adban (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot ban them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	Banning[ID] =1;
	format(string,sizeof(string),"[ADMIN] Administrator has banned %s(%d) from the server. Reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);

	format(string,sizeof(string),"9[ADMIN] Administrator has banned %s(%d) from the server. Reason: %s.",PlayerName(ID),ID,cmdreason);
    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
    if(PLAYERLIST_authed[ID] == 1)
    {
    	dUserSetINT(PlayerName(ID)).("Nameban",1);
	}
	SetTimer("BanPlayer",700,0);
	return 1;
}

dcmd_adan(playerid,params[])
{
	new string[128];
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adan(nounce) (Message)");
	    return 1;
	}
	format(string,sizeof(string),"%s",params);
	GameTextForAll(string,5000,0);
	return 1;
}

dcmd_adannounce(playerid,params[]) return dcmd_adan(playerid,params);

dcmd_adblow(playerid,params[])
{
	new string[128];
    new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adblow (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot blow them up.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsSpawned[ID] == 0)
	{
		format(string,sizeof(string),"%s(%d) is not spawned. You cannot blow them up.",PlayerName(ID),ID);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
    new Float:x, Float:y, Float:z;
	GetPlayerPos(ID, x, y, z);
	CreateExplosion(x,y,z, 6, 10.0);
	
	format(string, sizeof(string), "[ADMIN] Administrator has blown up %s(%d). Reason: %s.",PlayerName(ID),ID,cmdreason);
    SendClientMessageToAll(COLOR_ADMIN, string);
    
    format(string, sizeof(string), "9[ADMIN] Administrator has blown up %s(%d). Reason: %s.",PlayerName(ID),ID,cmdreason);
    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
    return 1;
}

dcmd_adon(playerid,params[])
{
	#pragma unused params
	if(InAdminMode[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are already in admin mode.");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to go into admin mode.");
	    return 1;
	}
	for(new w=0; w<13; w++)
	{
		GetPlayerWeaponData(playerid,w,PlayerWeapon[playerid][w],PlayerAmmo[playerid][w]);
	}
	SendClientMessage(playerid,COLOR_ADMIN,"You are now in admin mode. You have unlimited minigun, health and armour.");
	ResetPlayerWeapons(playerid);
	InAdminMode[playerid] =1;
	
	GivePlayerWeapon(playerid,38,999999);
	SetPlayerHealth(playerid,999999);
	SetPlayerArmour(playerid,999999);
	return 1;
}
	
dcmd_adoff(playerid,params[])
{
	#pragma unused params
	if(InAdminMode[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not in admin mode.");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to go out from admin mode.");
	    return 1;
	}
	ResetPlayerWeapons(playerid);
	for(new w=0; w<13; w++)
	{
		GivePlayerWeapon(playerid,PlayerWeapon[playerid][w],PlayerAmmo[playerid][w]);
	}
	SendClientMessage(playerid,COLOR_ADMIN,"You are now no longer in admin mode. Your weapons, health and armour have been restored.");
	InAdminMode[playerid] =0;
	SetPlayerHealth(playerid,100);
	SetPlayerArmour(playerid,0);
	return 1;
}

dcmd_adsetlevel(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason;
	if(sscanf(params,"ui",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adsetlevel (Player Name/ID) (Level)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot set their administrator level.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you set their administrator level.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(AdminLevel[ID] == cmdreason)
	{
	    format(string,sizeof(string),"%s(%d) is already at the Administrator level: %d",PlayerName(ID),ID,cmdreason);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot set your own Administrator level. You are already the highest level.");
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN LEVEL CHANGE] Owner %s(%d) has given %s(%d) the administrator level %d.",PlayerName(playerid),playerid,PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);
	
	SendClientMessage(ID,COLOR_ADMIN,"Your admin level has been changed by the Server Owner. To see your new commands type /adcmds.");
	AdminLevel[ID] =cmdreason;
	
	format(string,sizeof(string),"9[ADMIN LEVEL CHANGE] Owner %s(%d) has given %s(%d) the administrator level %d.",PlayerName(playerid),playerid,PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_spectate(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params,"u",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /spectate (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot spectate them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot spectate yourself, how could that even be possible?");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot place spectate dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsPlayerInAnyVehicle(ID))
	{
		new vehid = GetPlayerVehicleID(ID);
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectateVehicle(playerid, vehid);
		SetPlayerInterior(playerid,GetPlayerInterior(ID));
		SpectatingPlayer[playerid] =ID;
		IsBeingSpectated[ID] =1;
		return 1;
	}
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectatePlayer(playerid, ID);
	SetPlayerInterior(playerid,GetPlayerInterior(ID));
	SpectatingPlayer[playerid] =ID;
	IsBeingSpectated[ID] =1;
	return 1;
}

dcmd_specoff(playerid,params[])
{
	#pragma unused params
    if(SpectatingPlayer[playerid] == -1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not spectating a player. How can you spectating them?");
	    return 1;
	}
	TogglePlayerSpectating(playerid,0);

	IsBeingSpectated[SpectatingPlayer[playerid]] =0;
	SpectatingPlayer[playerid] =-1;
	return 1;
}

dcmd_admsg(playerid,params[])
{
	new string[128];
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /admsg (Message)");
	    return 1;
	}
	if(IsSpawned[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	format(string,sizeof(string),"4[ADMIN CHAT] %s(%d): %s",PlayerName(playerid),playerid,params);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(AdminLevel[i] >= 1)
	    {
	        format(string,sizeof(string),"[ADMIN CHAT] %s(%d): %s",PlayerName(playerid),playerid,params);
	        SendClientMessage(i,COLOR_ADMIN,string);
		}
	}
	return 1;
}

dcmd_adkill(playerid,params[])
{
	new string[128];
	new ID;
	new cmdreason[100];
	if(sscanf(params,"us[100]",ID,cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adkill (Player Name/ID) (Reason)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot kill them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	AdminKilled[ID] =1;
	format(string,sizeof(string),"[ADMIN] Administrator has killed %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	SendClientMessageToAll(COLOR_ADMIN,string);

	format(string,sizeof(string),"9[ADMIN] Administrator has killed %s(%d) for reason: %s.",PlayerName(ID),ID,cmdreason);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	SetPlayerHealth(ID,0);
	return 1;
}

dcmd_goto(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params,"u",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /goto (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot goto them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot goto dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	new Float:x,Float:y,Float:z;
	GetPlayerPos(ID,x,y,z);
	
	SetPlayerPos(playerid,x+1,y,z);
	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(ID));
	SetPlayerInterior(playerid,GetPlayerInterior(ID));
	format(string,sizeof(string),"You have teleported to %s(%d).",PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_ADMIN,string);
	return 1;
}

dcmd_bring(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params,"u",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /bring (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot bring them.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot bring dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);

	SetPlayerPos(ID,x+1,y,z);
	SetPlayerVirtualWorld(ID,GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(ID,GetPlayerInterior(playerid));
	format(string,sizeof(string),"You have been teleported to %s(%d).",PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_ADMIN,string);
	format(string,sizeof(string),"You have teleported %s(%d) to you.",PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_ADMIN,string);
	return 1;
}

dcmd_adreg(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params,"ui",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adreg (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them Regular Player status.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you give them Regular Player status.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsRegularPlayer[ID] == 1337)
	{
	    format(string,sizeof(string),"%s(%d) is already a Regular Player.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN REGULAR] Administrator has given %s(%d) Regular Player status.",PlayerName(ID),ID);
	SendClientMessageToAll(COLOR_ADMIN,string);

	SendClientMessage(ID,COLOR_ADMIN,"You have been given Regular Player status by a Server Administrator. Congratulations.");
	IsRegularPlayer[ID] =1337;

	format(string,sizeof(string),"9[ADMIN REGULAR] Administrator has given %s(%d) Regular Player status.",PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adunreg(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params,"ui",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adunreg (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot take their Regular Player status.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you take their Regular Player status.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsRegularPlayer[ID] != 1337)
	{
	    format(string,sizeof(string),"%s(%d) is not a Regular Player.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN UNREGULAR] Administrator has taken %s(%d)'s Regular Player status.",PlayerName(ID),ID);
	SendClientMessageToAll(COLOR_ADMIN,string);

	SendClientMessage(ID,COLOR_ADMIN,"Your Regular Player status has been taken away from you by a Server Administrator. Unlucky.");
	IsRegularPlayer[ID] =0;

	format(string,sizeof(string),"9[ADMIN UNREGULAR] Administrator has taken %s(%d)'s Regular Player status.",PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adarmy(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params,"ui",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adarmy (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them Army status.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you give them Army status.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CanUseArmy[ID] == 1337)
	{
	    format(string,sizeof(string),"%s(%d) is already an Army member.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN ARMY] Administrator has given %s(%d) Army status.",PlayerName(ID),ID);
	SendClientMessageToAll(COLOR_ADMIN,string);

	SendClientMessage(ID,COLOR_ADMIN,"You have been given Army status by a Server Administrator. Congratulations.");
	CanUseArmy[ID] =1337;

	format(string,sizeof(string),"9[ADMIN ARMY] Administrator has given %s(%d) Army status.",PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adunarmy(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params,"ui",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adunarmy (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot take their Army status.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you take their Army status.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CanUseArmy[ID] != 1337)
	{
	    format(string,sizeof(string),"%s(%d) is not an Army member.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN UNARMY] Administrator has taken %s(%d)'s Army status.",PlayerName(ID),ID);
	SendClientMessageToAll(COLOR_ADMIN,string);

	SendClientMessage(ID,COLOR_ADMIN,"Your Army status has been taken away from you by a Server Administrator. Unlucky.");
	CanUseArmy[ID] =0;

	format(string,sizeof(string),"9[ADMIN UNARMY] Administrator has taken %s(%d)'s Army status.",PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_adcia(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params,"ui",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adcia (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them CIA status.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you give them CIA status.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CanUseCIA[ID] == 1337)
	{
	    format(string,sizeof(string),"%s(%d) is already a CIA member.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN CIA] Administrator has given %s(%d) CIA status.",PlayerName(ID),ID);
	SendClientMessageToAll(COLOR_ADMIN,string);

	SendClientMessage(ID,COLOR_ADMIN,"You have been given CIA status by a Server Administrator. Congratulations.");
	CanUseCIA[ID] =1337;

	format(string,sizeof(string),"9[ADMIN CIA] Administrator has given %s(%d) CIA status.",PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_aduncia(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params,"ui",ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /aduncia (Player Name/ID)");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot take their CIA status.",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(PLAYERLIST_authed[ID] != 1)
	{
        format(string,sizeof(string),"%s(%d) is not logged into to the server. You must wait till they login before you take their CIA status.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CanUseCIA[ID] != 1337)
	{
	    format(string,sizeof(string),"%s(%d) is not a CIA member.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	format(string,sizeof(string),"[ADMIN UNCIA] Administrator has taken %s(%d)'s CIA status.",PlayerName(ID),ID);
	SendClientMessageToAll(COLOR_ADMIN,string);

	SendClientMessage(ID,COLOR_ADMIN,"Your CIA status has been taken away from you by a Server Administrator. Unlucky.");
	CanUseCIA[ID] =0;

	format(string,sizeof(string),"9[ADMIN UNCIA] Administrator has taken %s(%d)'s CIA status.",PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_stopsat(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(CIAPlayerBeingViewed[playerid] == -1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not using the CIA satelite. How can you stop using it?");
	    return 1;
	}
	TogglePlayerSpectating(playerid,0);
	
	StoppedSatViewing[playerid] =3;
	
	format(string,sizeof(string),"You have stopped viewing %s(%d) through the CIA Satelite Imagery.",PlayerName(CIAPlayerBeingViewed[playerid]),CIAPlayerBeingViewed[playerid]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	CIAIsBeingWatched[CIAPlayerBeingViewed[playerid]] =0;
	CIAPlayerBeingViewed[playerid] =-1;
	return 1;
}

dcmd_tackle(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /tackle (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only CIA Personnel can tackle players.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot tackle them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to tackle him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_COP || gTeam[ID] == TEAM_ARMY || gTeam[ID] == TEAM_CIA)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot tackle other Law Enforcement officers. You might lose your job for that ..");
	    return 1;
	}
	if(IsTackled[ID] >= 1)
	{
	    format(string,sizeof(string),"%s(%d) is already tackled. You should place handcuffs on them with /cuff (Player Name/ID).",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot place a tackle a suspect while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot tackle a suspect while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot tackle yourself, how could that even be possible?");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot place tackle dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot tackle them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(AttemptedToTackleRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You are tired out from your last attempt. Please wait until you get your energy back first.");
		return 1;
	}
	new crand = random(100);
	if(crand <= 30)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Tackle attempt failed. The suspect slipped out of your grasp.");
		AttemptedToTackleRecently[playerid] =25;
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4 && crand > 30)
	{
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Suspect Tackled_]]");
	    format(string,sizeof(string),"You have tackles %s(%d) to the ground! They can not move for 5 seconds.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Tackled to the ground_]]");
	    format(string,sizeof(string),"CIA Officer %s(%d) has tackled you to the ground! You cannot move!",PlayerName(playerid),playerid);

        ApplyAnimation(playerid,"PED","EV_dive",4.0,0,0,0,0,0);

		TogglePlayerControllable(ID,0);
	    ApplyAnimation(ID, "ped", "BIKE_fall_off", 3.0, 0, 0, 0, 0, 0); // Fallen off bike
	    IsTackled[ID] =7;
	    return 1;
	}
	return 1;
}

dcmd_liftup(playerid,params[])
{
	#pragma unused params
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(!PlayerToPoint(1.0,playerid,246.3956,87.5255,1003.6406) && !PlayerToPoint(1.0,playerid,-1750.0658,980.9041,95.8510) && !PlayerToPoint(1.0,playerid,-1716.3550,1018.1495,17.5859))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be near the FBI Elevators to use them.");
	    return 1;
	}
	if(GetPlayerSkin(playerid) != 286)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only FBI Personnel can use the FBI Elevators. Please use the front door.");
	    return 1;
	}
	if(PlayerToPoint(1.0,playerid,246.3956,87.5255,1003.6406)) //Inside Pickup
	{
	    SetPlayerPos(playerid,-1750.0658,980.9041,95.8510);
	    SetPlayerInterior(playerid,0);
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have used the elevator to go to the FBI roof.");
	    return 1;
	}
	if(PlayerToPoint(1.0,playerid,-1716.3550,1018.1495,17.5859)) //Garage Pickup
	{
	    SetPlayerPos(playerid,246.3956,87.5255,1003.6406);
	    SetPlayerInterior(playerid,6);
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have used the elevator to go to the FBI interior.");
	    return 1;
	}
	if(PlayerToPoint(1.0,playerid,-1750.0658,980.9041,95.8510)) //Roof Pickup
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use the elevator to go up, there is nowhere to go to.");
	    return 1;
	}
	return 1;
}

dcmd_liftdown(playerid,params[])
{
	#pragma unused params
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(!PlayerToPoint(1.0,playerid,246.3956,87.5255,1003.6406) && !PlayerToPoint(1.0,playerid,-1750.0658,980.9041,95.8510) && !PlayerToPoint(1.0,playerid,-1716.3550,1018.1495,17.5859))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be near the FBI Elevators to use them.");
	    return 1;
	}
	if(GetPlayerSkin(playerid) != 286)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only FBI Personnel can use the FBI Elevators. Please use the front door.");
	    return 1;
	}
	if(PlayerToPoint(1.0,playerid,246.3956,87.5255,1003.6406)) //Inside Pickup
	{
	    SetPlayerPos(playerid,-1716.3550,1018.1495,17.5859);
	    SetPlayerInterior(playerid,0);
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have used the elevator to go to the FBI garage.");
	    return 1;
	}
	if(PlayerToPoint(1.0,playerid,-1716.3550,1018.1495,17.5859)) //Garage Pickup
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use the elevator to go down, there is nowhere to go to.");
	    return 1;
	}
	if(PlayerToPoint(1.0,playerid,-1750.0658,980.9041,95.8510)) //Roof Pickup
	{
	    SetPlayerPos(playerid,246.3956,87.5255,1003.6406);
	    SetPlayerInterior(playerid,6);
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have used the elevator to go to the FBI interior.");
	    return 1;
	}
	return 1;
}

dcmd_engineon(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(engine == VEHICLE_PARAMS_ON)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The engine is already running.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) spins the vehicle's engine key and turns on the engine.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_engineoff(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(engine == VEHICLE_PARAMS_OFF)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The engine is already off.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) spins the vehicle's engine key and turns off the engine.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_lightson(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(lights == VEHICLE_PARAMS_ON)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The lights are already on.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) twists a lever behind the steering wheel and turns on the lights.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_lightsoff(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(lights == VEHICLE_PARAMS_OFF)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The lights are already off.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) twists a lever behind the steering wheel and turns off the lights.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_bonnetup(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(bonnet == VEHICLE_PARAMS_ON)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The bonnet is already up.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) pushes a button behind the steering wheel and pops up the bonnet.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_bonnetdown(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(bonnet == VEHICLE_PARAMS_OFF)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The bonnet is already down.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) pushes a button behind the steering wheel and puts down the bonnet.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_bootup(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(boot == VEHICLE_PARAMS_ON)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The bonnet is already up.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) pushes a button behind the steering wheel and pops up the boot.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_bootdown(playerid,params[])
{
	#pragma unused params
	new string[128];
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new vid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    if(boot == VEHICLE_PARAMS_OFF)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The bonnet is already down.");
	        return 1;
		}
	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(GetDistanceBetweenPlayers(playerid,i) < 10)
		    {
		        format(string,sizeof(string),"%s(%d) pushes a button behind the steering wheel and puts down the boot.",PlayerName(playerid),playerid);
				SendClientMessage(i,COLOR_LIGHTBLUE,string);
			}
		}
	}
    return 1;
}

dcmd_repair(playerid,params[])
{
	new string[128];
	new ID;
	new Float:vhealth;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /repair (Player Name/ID)");
	    return 1;
	}
	new pveh = GetPlayerVehicleID(ID);
	GetVehicleHealth(pveh,vhealth);
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_CARFIX)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are unable to repair vehicles. Only Mechanics can do this.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connected to the server. You cannot repair their vehicle.",ID);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(ID == playerid)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot repair your own vehicle with this command. Try /repairme");
	    return 1;
	}
	if(CalledForMechanic[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) has not called for a mechanic. Tell them to type /mechanic first.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 6)
	{
	    format(string,sizeof(string),"%s(%d) is not close enough. Get closer to them before trying to repair their vehicle.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(vhealth == 1000)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Their vehicles health is already full. You don't need to repair it.");
	    return 1;
	}
	if(GetPlayerMoney(ID) < SkillPrice[playerid])
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player does not have enough money on them to pay your price.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Vehicle Repaired_]]");
	format(string,sizeof(string),"You have repaired %s(%d)'s vehicle for a price of $%d. Make sure they are happy.",PlayerName(ID),ID,SkillPrice[playerid]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	GivePlayerMoney(playerid,SkillPrice[playerid]);

	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Vehicle Repaired_]]");
	format(string,sizeof(string),"Your vehicle has been repaired by %s(%d) for a price of $%d.",PlayerName(playerid),playerid,SkillPrice[playerid]);
	SendClientMessage(ID,COLOR_LIGHTBLUE,string);
	GivePlayerMoney(ID,-SkillPrice[playerid]);
	SetVehicleHealth(pveh,1000);
	RepairVehicle(pveh);
	CalledForMechanic[ID] =0;

	format(string,sizeof(string),"3[MECHANIC ACTION] %s(%d) has repaired %s(%d)'s vehicle by using /repair.",PlayerName(playerid),playerid,PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_repairme(playerid,params[])
{
	#pragma unused params
	new string[128];
	new Float:vhealth;
	new pveh = GetPlayerVehicleID(playerid);
	GetVehicleHealth(pveh,vhealth);
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_CARFIX)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are unable to repair vehicles. Only Mechanics can do this.");
	    return 1;
	}
	if(vhealth == 1000)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Your vehicles health is already full. You don't need to repair it.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Vehicle Repaired_]]");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have repaired your vehicle and it's health is now restored.");
	SetVehicleHealth(pveh,1000);
	RepairVehicle(pveh);

	format(string,sizeof(string),"3[MECHANIC ACTION] %s(%d) has repaired his vehicle by using /repairme.",PlayerName(playerid),playerid);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_heal(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /heal (Player Name/ID)");
	    return 1;
	}
	new Float:phealth;
	GetPlayerHealth(ID,phealth);
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_MEDIC)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are unable to heal people. Only medics can do this.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connected to the server. You cannot heal them.",ID);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(ID == playerid)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot heal yourself with this command. Try /healme");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 6)
	{
	    format(string,sizeof(string),"%s(%d) is not close enough. Get closer to them before trying to heal them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CalledForMedic[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) has not called for a medic. Tell them to type /medic first.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(phealth == 100)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Their health is already full. You don't need to heal them.");
	    return 1;
	}
	if(GetPlayerMoney(ID) < SkillPrice[playerid])
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player does not have enough money on them to pay your price.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Healed_]]");
	format(string,sizeof(string),"You have healed %s(%d) for a price of $%d. Make sure they are happy.",PlayerName(ID),ID,SkillPrice[playerid]);
	SendClientMessage(playerid,COLOR_FORESTGREEN,string);
	GivePlayerMoney(playerid,SkillPrice[playerid]);
	
	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Healed_]]");
	format(string,sizeof(string),"You have been healed by %s(%d) for a price of $%d.",PlayerName(playerid),playerid,SkillPrice[playerid]);
	SendClientMessage(ID,COLOR_FORESTGREEN,string);
	GivePlayerMoney(ID,-SkillPrice[playerid]);
	SetPlayerHealth(ID,100);
	CalledForMedic[ID] =0;
	
	format(string,sizeof(string),"3[MEDIC ACTION] %s(%d) has restored %s(%d)'s health by using /heal.",PlayerName(playerid),playerid,PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_healme(playerid,params[])
{
	#pragma unused params
	new string[128];
	new Float:phealth;
	GetPlayerHealth(playerid,phealth);
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_MEDIC)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are unable to heal yourself. Only medics can do this.");
	    return 1;
	}
	if(phealth == 100)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Your health is already full. You don't need to heal yourself.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Healed_]]");
	SendClientMessage(playerid,COLOR_FORESTGREEN,"You have healed yourself for free. Your health is now restored.");
	SetPlayerHealth(playerid,100);

	format(string,sizeof(string),"3[MEDIC ACTION] %s(%d) has restored their own health by using /healme.",PlayerName(playerid),playerid);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_cure(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /cure (Player Name/ID)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_MEDIC)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are unable to cure people. Only medics can do this.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connected to the server. You cannot cure them.",ID);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(ID == playerid)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot cure yourself with this command. Try /cureme");
	    return 1;
	}
    if(GetDistanceBetweenPlayers(playerid,ID) > 6)
	{
	    format(string,sizeof(string),"%s(%d) is not close enough. Get closer to them before trying to cure them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CalledForMedic[ID] == 0)
	{
	    format(string,sizeof(string),"%s(%d) has not called for a medic. Tell them to type /medic first.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(HasSTI[ID] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"They are not infected. You don't need to cure them.");
	    return 1;
	}
	if(GetPlayerMoney(ID) < SkillPrice[playerid])
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player does not have enough money on them to pay your price.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Cured_]]");
	format(string,sizeof(string),"You have cured %s(%d) for a price of $%d. Make sure they are happy.",PlayerName(ID),ID,SkillPrice[playerid]);
	SendClientMessage(playerid,COLOR_FORESTGREEN,string);
	GivePlayerMoney(playerid,SkillPrice[playerid]);

	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Cured_]]");
	format(string,sizeof(string),"You have been cured by %s(%d) for a price of $%d.",PlayerName(playerid),playerid,SkillPrice[playerid]);
	SendClientMessage(ID,COLOR_FORESTGREEN,string);
	GivePlayerMoney(ID,-SkillPrice[playerid]);
	HasSTI[ID] =0;
	CalledForMedic[ID] =0;

	format(string,sizeof(string),"3[MEDIC ACTION] %s(%d) has cured %s(%d)'s health by using /cure.",PlayerName(playerid),playerid,PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_cureme(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_MEDIC)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are unable to cure yourself. Only medics can do this.");
	    return 1;
	}
	if(HasSTI[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not infected. You don't need to cure yourself.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Cured_]]");
	SendClientMessage(playerid,COLOR_FORESTGREEN,"You have cured yourself and your infections are no longer effected you.");
	HasSTI[playerid] =0;

	format(string,sizeof(string),"3[MEDIC ACTION] %s(%d) has cured themselves by using /cureme.",PlayerName(playerid),playerid);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_medic(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_MEDIC)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are a medic. Use your medic commands to help yourself.");
	    return 1;
	}
	if(CalledForMedic[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have already called for a medic. They are on their way.");
	    return 1;
	}
	if(!GetPlayersInTeam(TEAM_MEDIC))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"There are no medics on duty. You'll have to go to the hospital yourself.");
	    return 1;
	}
	new current_zone = player_zone[playerid];
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Medic Called_]]");
	SendClientMessage(playerid,COLOR_FORESTGREEN,"You have called for a medic. They are on their way.");
	CalledForMedic[playerid] =180;
	
	format(string,sizeof(string),"[MEDIC CALL] %s(%d) has called for a medic. Location: %s.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
	SendClientMessageToAllMedics(string);
	return 1;
}

dcmd_mechanic(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_CARFIX)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are a mechanic. Use your mechanic commands to help yourself.");
	    return 1;
	}
	if(CalledForMechanic[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have already called for a mechanic. They are on their way.");
	    return 1;
	}
	if(!GetPlayersInTeam(TEAM_CARFIX))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"There are no mechanics on duty. You'll have to go to the Pay'n'Spray.");
	    return 1;
	}
	new current_zone = player_zone[playerid];
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Mechanic Called_]]");
	SendClientMessage(playerid,COLOR_FORESTGREEN,"You have called for a mechanic. They are on their way.");
	CalledForMechanic[playerid] =180;

	format(string,sizeof(string),"[MECHANIC CALL] %s(%d) has called for a mechanic. Location: %s.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
	SendClientMessageToAllMechanics(string);
	return 1;
}

dcmd_drugdealer(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_DRGDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are a Drug Dealer. Use a Drug House to help yourself.");
	    return 1;
	}
	if(CalledForDrugDealer[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have already called for a Drug Dealer. They are on their way.");
	    return 1;
	}
	if(gTeam[playerid] < 9)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command with your class/skill.");
	    return 1;
	}
	if(!GetPlayersInTeam(TEAM_DRGDEL))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"There are no Drug Dealers on duty. You'll have to go to a Drug House.");
	    return 1;
	}
	new current_zone = player_zone[playerid];
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Drug Dealer Called_]]");
	SendClientMessage(playerid,COLOR_RED,"You have called for a Drug Dealer. They are on their way.");
	CalledForDrugDealer[playerid] =180;

	format(string,sizeof(string),"[DRUG DEALER CALL] %s(%d) has called for a Drug Dealer. Location: %s.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
	SendClientMessageToAllDDealers(string);
	return 1;
}

dcmd_weapondealer(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_GUNDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are a Weapon Dealer. Use Ammunation to help yourself.");
	    return 1;
	}
	if(CalledForWeaponDealer[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have already called for a Weapon Dealer. They are on their way.");
	    return 1;
	}
	if(!GetPlayersInTeam(TEAM_GUNDEL))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"There are no Weapon Dealers on duty. You'll have to go to Ammunation.");
	    return 1;
	}
	new current_zone = player_zone[playerid];
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon Dealer Called_]]");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have called for a Weapon Dealer. They are on their way.");
	CalledForWeaponDealer[playerid] =180;

	format(string,sizeof(string),"[WEAPON DEALER CALL] %s(%d) has called for a Weapon Dealer. Location: %s.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
	SendClientMessageToAllGDealers(string);
	return 1;
}

dcmd_taxi(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_DRIVER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are a driver. Use your taxi vehicles to help yourself.");
	    return 1;
	}
	if(CalledForTaxi[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have already called for a taxi. They are on their way.");
	    return 1;
	}
	if(!GetPlayersInTeam(TEAM_DRIVER))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"There are no taxi's on duty. You'll have to go to find your own mode of travel.");
	    return 1;
	}
	new current_zone = player_zone[playerid];
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Taxi Called_]]");
	SendClientMessage(playerid,COLOR_FORESTGREEN,"You have called for a taxi. They are on their way.");
	CalledForTaxi[playerid] =180;

	format(string,sizeof(string),"[TAXI CALL] %s(%d) has called for a taxi. Location: %s.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
	SendClientMessageToAllDrivers(string);
	return 1;
}

dcmd_setprice(playerid,params[])
{
	new string[128];
	new price;
	if(sscanf(params, "i", price))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /setprice (Amount)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(gTeam[playerid] != TEAM_MEDIC && gTeam[playerid] != TEAM_CARFIX && gTeam[playerid] != TEAM_DRIVER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command with your class/skill.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(price > 50000 || price < 2000)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Please enter an amount between $2000 and $50000.");
	    return 1;
	}
	SkillPrice[playerid] =price;
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Service Price Set_]]");
	format(string,sizeof(string),"You have set your services price to $%d.",SkillPrice[playerid]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return 1;
}

dcmd_rape(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /rape (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] < 9)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command with your class/skill.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot rape them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to rape him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot rape someone while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot rape someone while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot rape yourself, how can you even manage that?");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot rape dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot rape them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(AttemptedToRapeRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"Your cock is sore from the last time you tried to rape someone. Please wait before trying to rape again.");
		return 1;
	}
	if(HasRapedRecently[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Your cock is still tired from the last rape. Please wait before raping again.");
	    return 1;
	}
	new crand = random(100);
	if(crand <= 30)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Rape attempt failed. The player slipped out of your grasp.");
		AttemptedToRapeRecently[playerid] =25;
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4 && crand > 30)
	{
	    if(gTeam[playerid] == TEAM_RAPIST && gTeam[ID] != TEAM_COP && gTeam[ID] != TEAM_ARMY && gTeam[ID] != TEAM_CIA)
	    {
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Player Raped_]]");
		    format(string,sizeof(string),"You have grabbed %s(%d) and raped them! They have been infected with an STI.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    IncreasePlayerScore(playerid,2);
		    HasRapedRecently[playerid] =120;
		    
		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Raped_]]");
		    format(string,sizeof(string),"%s(%d) has grabbed you and raped you! You have been infected with an STI.",PlayerName(playerid),playerid);
			SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    HasSTI[ID] =1;
		    IncreaseWantedLevel(playerid,4);
		    
		    format(string,sizeof(string),"[RAPE] %s(%d) has grabbed %s(%d) and raped them. They are now infected with an STI.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ROYALBLUE,string);
		    
		    format(string,sizeof(string),"11[RAPE] %s(%d) has grabbed %s(%d) and raped them. They are now infected with an STI.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		    return 1;
		}
		if(gTeam[playerid] == TEAM_RAPIST)
	    {
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Player Raped_]]");
		    format(string,sizeof(string),"You have grabbed law enforcement officer %s(%d) and raped them! They have been infected with an STI.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    IncreasePlayerScore(playerid,2);
		    HasRapedRecently[playerid] =120;
		    
		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Raped_]]");
		    format(string,sizeof(string),"%s(%d) has grabbed you and raped you! You have been infected with an STI.",PlayerName(playerid),playerid);
			SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    HasSTI[ID] =1;
		    IncreaseWantedLevel(playerid,10);

		    format(string,sizeof(string),"[RAPE] %s(%d) has grabbed law enforcement officer %s(%d) and raped them. They are now infected with an STI.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ROYALBLUE,string);

		    format(string,sizeof(string),"11[RAPE] %s(%d) has grabbed law enforcement officer %s(%d) and raped them. They are now infected with an STI.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		    return 1;
		}
		if(gTeam[playerid] != TEAM_RAPIST && gTeam[ID] != TEAM_COP && gTeam[ID] != TEAM_ARMY && gTeam[ID] != TEAM_CIA)
	    {
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Player Raped_]]");
		    format(string,sizeof(string),"You have grabbed %s(%d) and raped them!",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    HasRapedRecently[playerid] =120;
		    
		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Raped_]]");
		    format(string,sizeof(string),"%s(%d) has grabbed you and raped you!",PlayerName(playerid),playerid);
			SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    IncreaseWantedLevel(playerid,4);

		    format(string,sizeof(string),"[RAPE] %s(%d) has grabbed %s(%d) and raped them.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ROYALBLUE,string);

		    format(string,sizeof(string),"11[RAPE] %s(%d) has grabbed %s(%d) and raped them.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		    return 1;
		}
		if(gTeam[playerid] != TEAM_RAPIST)
	    {
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Player Raped_]]");
		    format(string,sizeof(string),"You have grabbed law enforcement officer %s(%d) and raped them!",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    HasRapedRecently[playerid] =120;
		    
		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Raped_]]");
		    format(string,sizeof(string),"%s(%d) has grabbed you and raped you!",PlayerName(playerid),playerid);
			SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    IncreaseWantedLevel(playerid,10);

		    format(string,sizeof(string),"[RAPE] %s(%d) has grabbed law enforcement officer %s(%d) and raped them.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    SendClientMessageToAll(COLOR_ROYALBLUE,string);

		    format(string,sizeof(string),"11[RAPE] %s(%d) has grabbed law enforcement officer %s(%d) and raped them.",PlayerName(playerid),playerid,PlayerName(ID),ID);
		    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		    return 1;
		}
		return 1;
	}
	return 1;
}

dcmd_bizowners(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(IsSpawned[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alived and spawned in order to use this command.");
	    return 1;
	}
	new DrugHouseOwnerOnlineName[24];
	new DrugHouseOwnerOnline =0;
	new OttoOwnerOnlineName[24];
	new OttoOwnerOnline =0;
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Business Owners_]]");
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
		{
			if(DrugHouseOwner[i] == 1337)
			{
				DrugHouseOwnerOnline ++;
				GetPlayerName(i,DrugHouseOwnerOnlineName,24);
			}
			if(OttoOwner[i] == 1337)
			{
				OttoOwnerOnline ++;
				GetPlayerName(i,OttoOwnerOnlineName,24);
			}
		}
	}
	if(DrugHouseOwnerOnline == 1)
	{
    	format(string,sizeof(string),"[DRUG HOUSE] Owner: %s",DrugHouseOwnerOnlineName);
		SendClientMessage(playerid,COLOR_LIME,string);
	}
	else
	if(DrugHouseOwnerOnline == 0)
	{
		SendClientMessage(playerid,COLOR_LIME,"[DRUG HOUSE] Owner: Offline.");
	}
	if(OttoOwnerOnline == 1)
	{
    	format(string,sizeof(string),"[OTTO's CARS] Owner: %s",OttoOwnerOnlineName);
		SendClientMessage(playerid,COLOR_LIME,string);
	}
	else
	if(OttoOwnerOnline == 0)
	{
		SendClientMessage(playerid,COLOR_LIME,"[OTTO's CARS] Owner: Offline.");
	}
	return 1;
}

dcmd_bo(playerid,params[]) return dcmd_bizowners(playerid,params);

dcmd_giveweed(playerid,params[])
{
	new string[128];
	new ID;
	new grams;
	if(sscanf(params, "ui", ID, grams))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /giveweed (Player Name/ID) (Grams)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_DRGDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only Drug Dealers can give people weed.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them weed",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to give him weed.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_DRGDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give other Drug Dealers weed .. Im sure they have plenty.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give yourself weed. Go to a Drug House to get some.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot give dead people drugs ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(HasWeed[playerid] < grams)
	{
		format(string,sizeof(string),"You do not have %d grams of weed to give.",grams);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(grams < 20)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must give atleast 20 grams in order for them to be able to roll a joint.");
	    return 1;
	}
	if(grams > 5000)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give them more than 5000 grams or they will be noticed by the police.");
	    return 1;
	}
	if(CalledForDrugDealer[ID] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"They have not called for a drug dealer. You cannot give them weed.");
	    return 1;
	}
	if(GivenWeedRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You have given weed recently. Please wait before giving anymore to people.");
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4)
	{
	    new current_zone;
	    current_zone = player_zone[playerid];
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Given Weed_]]");
	    format(string,sizeof(string),"You have given %d grams of weed to %s(%d). Make sure they are happy.",grams,PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_RED,string);
		HasWeed[playerid] -=grams;
		IncreaseWantedLevel(playerid,4);
		GivenWeedRecently[playerid] =60;
		IncreasePlayerScore(playerid,2);
	    
	    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Weed Received_]]");
	    format(string,sizeof(string),"You have been given %d grams of weed from %s(%d).",grams,PlayerName(playerid),playerid);
	    SendClientMessage(ID,COLOR_RED,string);
	    HasWeed[ID] +=grams;
	    
	    format(string,sizeof(string),"[POLICE RADIO] Suspected drug dealing taking place. Location: %s.",zones[current_zone][zone_name]);
	    SendClientMessageToAllCops(string);
	    return 1;
	}
	return 1;
}

dcmd_giveheroin(playerid,params[])
{
	new string[128];
	new ID;
	new grams;
	if(sscanf(params, "ui", ID, grams))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /giveheroin (Player Name/ID) (Injections)");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_DRGDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only Drug Dealers can give people heroin.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them heroin",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to give him heroin.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_DRGDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give other Drug Dealers heroin .. Im sure they have plenty.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give yourself heroin. Go to a Drug House to get some.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot give dead people drugs ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(HasHeroin[playerid] < grams)
	{
		format(string,sizeof(string),"You do not have %d injections of heroin to give.",grams);
		SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(CalledForDrugDealer[ID] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"They have not called for a drug dealer. You cannot give them heroin.");
	    return 1;
	}
	if(grams == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must give atleast 1 injection of heroin.");
	    return 1;
	}
	if(GivenHeroinRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You have given heroin recently. Please wait before giving anymore to people.");
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4)
	{
	    new current_zone;
	    current_zone = player_zone[playerid];
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Given Heroin_]]");
	    format(string,sizeof(string),"You have given %d injections of heroin to %s(%d). Make sure they are happy.",grams,PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_RED,string);
		HasHeroin[playerid] -=grams;
		IncreaseWantedLevel(playerid,4);
		GivenHeroinRecently[playerid] =60;
		IncreasePlayerScore(playerid,2);

	    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Heroin Received_]]");
	    format(string,sizeof(string),"You have been given %d injections of heroin from %s(%d).",grams,PlayerName(playerid),playerid);
	    SendClientMessage(ID,COLOR_RED,string);
	    HasHeroin[ID] +=grams;

	    format(string,sizeof(string),"[POLICE RADIO] Suspected drug dealing taking place. Location: %s.",zones[current_zone][zone_name]);
	    SendClientMessageToAllCops(string);
	    return 1;
	}
	return 1;
}

dcmd_smokeweed(playerid,params[])
{
	new string[128];
	new grams;
	if(sscanf(params, "i", grams))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /smokeweed (Grams)");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(gTeam[playerid] < 9)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command with your class/skill.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(HasWeed[playerid] < grams)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have this amount of grams to smoke.");
	    return 1;
	}
	if(grams < 20 && HasWeed[playerid] >= grams)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must smoke atleast 20 grams of weed in order to be able to roll a joint.");
	    return 1;
	}
	if(grams > 50)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot smoke anymore than 50 grams at a time. It won't fit into a joint.");
	    return 1;
	}
	if(SmokingWeed[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are already smoking some weed. Finish your joint first.");
	    return 1;
	}
	SmokingWeed[playerid] =grams;
	HasWeed[playerid] -=grams;
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Smoking Weed_]]");
	format(string,sizeof(string),"You have begun to smoke %d grams of weed. You can feel yourself feeling slightly happier.",grams);
	SendClientMessage(playerid,COLOR_RED,string);
	SetPlayerDrunkLevel(playerid,5000);
	return 1;
}

dcmd_injectheroin(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] < 9)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command with your class/skill.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(HasHeroin[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have any injections of heroin to inject.");
	    return 1;
	}
	if(HasNeedleAndSyringe[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must buy a needle and a syringe from Supa Save before injecting heroin.");
	    return 1;
	}
	if(InjectedHeroin[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are already under the effects on your last injection. Please wait until the effects have worn off.");
	    return 1;
	}
	InjectedHeroin[playerid] =160;
	HasHeroin[playerid] --;
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Injected Heroin_]]");
	format(string,sizeof(string),"You have injected some heroin into your arm. You can feel yourself feeling much happier.");
	SendClientMessage(playerid,COLOR_RED,string);
	IncreasePlayerScore(playerid,1);
	SetPlayerDrunkLevel(playerid,50000);
	return 1;
}

dcmd_showweapons(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /showweapons (Player Name/ID)");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_GUNDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only Weapon Dealers can show people their weapons for sale.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them weapons",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to show him weapons.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_GUNDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give other Weapon Dealers weapons .. Im sure they have plenty.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give yourself weapons. Go to Ammunation to get some.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot give dead people weapons ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(CalledForWeaponDealer[ID] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"They have not called for a weapon dealer. You cannot give them weapons.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4)
	{
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon list shown_]]");
		format(string,sizeof(string),"You have shown your list of weapons for sale to %s(%d). Use /sellweapon to sell them a weapon.",PlayerName(ID),ID);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		
		format(string,sizeof(string),"%s(%d) has shown you their list of weapons for sale. Tell them which number you want to buy from them.",PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		ShowPlayerDialog(ID,DIALOG_WEAPONS,DIALOG_STYLE_MSGBOX,"{33CCFF}Weapon Dealer List","{FFFFFF}{10F441}1: {FFFFFF}M4 (500 Ammo - $5000)\n{10F441}2: {FFFFFF}Tec-9 (300 Ammo - $5000)\n{10F441}3: {FFFFFF}Sniper (40 Ammo - $5000)\n{10F441}4: {FFFFFF}Combat Shotgun (100 Ammo - $7000)\n{10F441}5: {FFFFFF}Deagle (40 Ammo - $5000)\n{10F441}6: {FFFFFF}Armour (100 - $6000)","Ok","Cancel");
		return 1;
	}
	return 1;
}

dcmd_sellweapon(playerid,params[])
{
	new string[128];
	new ID;
	new number;
	if(sscanf(params, "ui", ID, number))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /sellweapon (Player Name/ID) (Number)");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_GUNDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only Weapon Dealers can give people weapons.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot give them weapons",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to give him weapons.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[ID] == TEAM_GUNDEL)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give other Weapon Dealers weapons .. Im sure they have plenty.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give yourself weapons. Go to Ammunation to get some.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot give dead people weapons ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(number == 0 || number > 6)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Please enter a number between 1-6.");
	    return 1;
	}
	if(CalledForWeaponDealer[ID] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"They have not called for a weapon dealer. You cannot give them weapons.");
	    return 1;
	}
	if(GivenWeaponRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You have given weapons recently. Please wait before giving anymore to people.");
		return 1;
	}
	if(number == 1)
	{
	    if(GetPlayerMoney(ID) < 5000)
	    {
	        format(string,sizeof(string),"%s(%d) does not have $5000 to buy an M4 from you.",PlayerName(ID),ID);
	        SendClientMessage(playerid,COLOR_ERROR,string);
	        return 1;
		}
		else
		{
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon Sold_]]");
		    format(string,sizeof(string),"You have sold 500 Ammo of an M4 to %s(%d) for $5000.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(playerid,5000);
		    IncreasePlayerScore(playerid,1);
		    GivenWeaponRecently[playerid] =20;
		    format(string,sizeof(string),"4[WEAPON SALE] %s(%d)'s money has increased from a weapon sale.",PlayerName(playerid),playerid);
		    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
		    
		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Weapon Bought_]]");
		    format(string,sizeof(string),"You have bought 500 Ammo of an M4 from %s(%d) for $5000.",PlayerName(playerid),playerid);
		    SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(ID,-5000);
		    GivePlayerWeapon(ID,31,500);
		    return 1;
		}
	}
	if(number == 2)
	{
	    if(GetPlayerMoney(ID) < 5000)
	    {
	        format(string,sizeof(string),"%s(%d) does not have $5000 to buy a Tec-9 from you.",PlayerName(ID),ID);
	        SendClientMessage(playerid,COLOR_ERROR,string);
	        return 1;
		}
		else
		{
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon Sold_]]");
		    format(string,sizeof(string),"You have sold 300 Ammo of a Tec-9 to %s(%d) for $5000.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(playerid,5000);
		    IncreasePlayerScore(playerid,1);
		    GivenWeaponRecently[playerid] =20;
		    format(string,sizeof(string),"4[WEAPON SALE] %s(%d)'s money has increased from a weapon sale.",PlayerName(playerid),playerid);
		    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);

		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Weapon Bought_]]");
		    format(string,sizeof(string),"You have bought 300 Ammo of a Tec-9 from %s(%d) for $5000.",PlayerName(playerid),playerid);
		    SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(ID,-5000);
		    GivePlayerWeapon(ID,32,300);
		    return 1;
		}
	}
	if(number == 3)
	{
	    if(GetPlayerMoney(ID) < 5000)
	    {
	        format(string,sizeof(string),"%s(%d) does not have $5000 to buy a Sniper from you.",PlayerName(ID),ID);
	        SendClientMessage(playerid,COLOR_ERROR,string);
	        return 1;
		}
		else
		{
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon Sold_]]");
		    format(string,sizeof(string),"You have sold 40 Ammo of a Sniper to %s(%d) for $5000.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(playerid,5000);
		    IncreasePlayerScore(playerid,1);
		    GivenWeaponRecently[playerid] =20;
		    format(string,sizeof(string),"4[WEAPON SALE] %s(%d)'s money has increased from a weapon sale.",PlayerName(playerid),playerid);
		    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);

		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Weapon Bought_]]");
		    format(string,sizeof(string),"You have bought 40 Ammo of a Sniper from %s(%d) for $5000.",PlayerName(playerid),playerid);
		    SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(ID,-5000);
		    GivePlayerWeapon(ID,34,40);
		    return 1;
		}
	}
	if(number == 4)
	{
	    if(GetPlayerMoney(ID) < 7000)
	    {
	        format(string,sizeof(string),"%s(%d) does not have $7000 to buy a Combat Shotgun from you.",PlayerName(ID),ID);
	        SendClientMessage(playerid,COLOR_ERROR,string);
	        return 1;
		}
		else
		{
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon Sold_]]");
		    format(string,sizeof(string),"You have sold 100 Ammo of a Combat Shotgun to %s(%d) for $7000.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(playerid,7000);
		    IncreasePlayerScore(playerid,1);
		    GivenWeaponRecently[playerid] =20;
		    format(string,sizeof(string),"4[WEAPON SALE] %s(%d)'s money has increased from a weapon sale.",PlayerName(playerid),playerid);
		    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);

		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Weapon Bought_]]");
		    format(string,sizeof(string),"You have bought 100 Ammo of a Combat Shotgun from %s(%d) for $7000.",PlayerName(playerid),playerid);
		    SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(ID,-7000);
		    GivePlayerWeapon(ID,27,100);
		    return 1;
		}
	}
	if(number == 5)
	{
	    if(GetPlayerMoney(ID) < 5000)
	    {
	        format(string,sizeof(string),"%s(%d) does not have $5000 to buy a Deagle from you.",PlayerName(ID),ID);
	        SendClientMessage(playerid,COLOR_ERROR,string);
	        return 1;
		}
		else
		{
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Weapon Sold_]]");
		    format(string,sizeof(string),"You have sold 40 Ammo of a Deagle to %s(%d) for $5000.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(playerid,5000);
		    IncreasePlayerScore(playerid,1);
		    GivenWeaponRecently[playerid] =20;
		    format(string,sizeof(string),"4[WEAPON SALE] %s(%d)'s money has increased from a weapon sale.",PlayerName(playerid),playerid);
		    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);

		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Weapon Bought_]]");
		    format(string,sizeof(string),"You have bought 40 Ammo of a Deagle from %s(%d) for $5000.",PlayerName(playerid),playerid);
		    SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(ID,-5000);
		    GivePlayerWeapon(ID,24,40);
		    return 1;
		}
	}
	if(number == 6)
	{
	    if(GetPlayerMoney(ID) < 6000)
	    {
	        format(string,sizeof(string),"%s(%d) does not have $6000 to buy Armour from you.",PlayerName(ID),ID);
	        SendClientMessage(playerid,COLOR_ERROR,string);
	        return 1;
		}
		else
		{
		    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Armour Sold_]]");
		    format(string,sizeof(string),"You have sold Armour to %s(%d) for $6000.",PlayerName(ID),ID);
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(playerid,6000);
		    IncreasePlayerScore(playerid,1);
		    GivenWeaponRecently[playerid] =20;
		    format(string,sizeof(string),"4[WEAPON SALE] %s(%d)'s money has increased from a weapon sale.",PlayerName(playerid),playerid);
		    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);

		    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Armour Bought_]]");
		    format(string,sizeof(string),"You have bought Armour from %s(%d) for $6000.",PlayerName(playerid),playerid);
		    SendClientMessage(ID,COLOR_LIGHTBLUE,string);
		    GivePlayerMoney(ID,-6000);
		    SetPlayerArmour(ID,100);
		    return 1;
		}
	}
	return 1;
}

dcmd_placehit(playerid,params[])
{
	new string[128];
	new ID;
	new number;
	if(sscanf(params, "ui", ID, number))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /placehit (Player Name/ID) (Amount)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot place a hit on them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(gTeam[playerid] == TEAM_HITMAN)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot place hits while you are a hitman .. That would be paying yourself to kill someone.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot place hits on yourself.");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot place hits on dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(number < 20000)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Please enter an amount over $20000.");
	    return 1;
	}
	if(PlacedHitRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You have placed a hit recently. Please wait before placing anymore on people.");
		return 1;
	}
	if(HasHit[ID] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player already has a hit. You cannot place a second on him.");
	    return 1;
	}
	if(GetPlayerMoney(playerid) < number)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not carrying that amount of money to place a hit on someone.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Hit Placed_]]");
	format(string,sizeof(string),"You have placed a hit on %s(%d) for the sum of $%d. Your money has been takin from you for payment purposes.",PlayerName(ID),ID,number);
	SendClientMessage(playerid,COLOR_RED,string);
	PlacedHitRecently[playerid] =900;
	GivePlayerMoney(playerid,-number);
	
	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Hit Placed On You_]]");
	format(string,sizeof(string),"You have had a hit placed on you by %s(%d) for the sum of $%d. If you think this is invalid, /report them.",PlayerName(playerid),playerid,number);
	SendClientMessage(ID,COLOR_RED,string);
	TextDrawSetString(MessageTD[ID],"HIT PLACED");
	TextDrawShowForPlayer(ID,MessageTD[ID]);
	MessageTDTime[ID] =5;
	HasHit[ID] =1800;
	HitMoney[ID] =number;
	
	format(string,sizeof(string),"[HIT PLACED] %s(%d) has placed a hit on %s(%d) for a sum of $%d.",PlayerName(playerid),playerid,PlayerName(ID),ID,number);
	SendClientMessageToAllHitmen(string);
	
	format(string,sizeof(string),"[HIT PLACED] %s(%d) has placed a hit on %s(%d) for a sum of $%d.",PlayerName(playerid),playerid,PlayerName(ID),ID,number);
	SendClientMessageToAllAdmins(string);
	format(string,sizeof(string),"4[HIT PLACED] %s(%d) has placed a hit on %s(%d) for a sum of $%d.",PlayerName(playerid),playerid,PlayerName(ID),ID,number);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	return 1;
}

dcmd_hitlist(playerid,params[])
{
	#pragma unused params
	new string[138];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsCuffed[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are cuffed. You cannot use this command.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Hit List_]]");
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(HasHit[i] >= 1)
	    {
	        format(string,sizeof(string),"%s(%d) - $%d - %d seconds left.",PlayerName(i),i,HitMoney[i],HasHit[i]);
	        SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		}
	}
	return 1;
}

dcmd_kidnap(playerid,params[])
{
    new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /kidnap (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(LastVehicle[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must enter a vehicle before attempting to kidnap a player.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsKidnapped[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"They are kidnapped. You cannot kidnap them twice.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_KIDNAP)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only kidnappers can use this command to kidnap players.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot kidnap them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to kidnap him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot kidnap someone while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot kidnap someone while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot kidnap yourself, how can you even manage that?");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot kidnap dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot kidnap them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(AttemptedToKidnapRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You are tired from your last kidnap attempt. Please wait before trying to kidnap again.");
		return 1;
	}
	if(HasKidnappedRecently[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are tired from your last kidnap. Please wait before kidnapping someone again.");
	    return 1;
	}
	if(HasRope[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must have rope in order to use this command. Buy one from Supa Save.");
	    return 1;
	}
	new crand = random(100);
	if(crand <= 30)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Kidnap attempt failed. The player slipped out of your grasp.");
		AttemptedToKidnapRecently[playerid] =60;
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4 && crand > 30)
	{
	    new current_zone = player_zone[playerid];
	
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Kidnapped Player_]]");
	    format(string,sizeof(string),"You have grabbed %s(%d), tied them up with your rope and thrown them into your vehicle.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_RED,string);
	    IncreaseWantedLevel(playerid,8);
	    HasKidnappedRecently[playerid] =300;
		HasRope[playerid] --;
		IncreasePlayerScore(playerid,3);
	    
	    SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Kidnapped_]]");
	    format(string,sizeof(string),"%s(%d) has tied you up and thrown you into their vehicle!. If you have scissors you can /cutrope.",PlayerName(playerid),playerid);
	    SendClientMessage(ID,COLOR_RED,string);
	    PutPlayerInVehicle(ID,LastVehicle[playerid],1);
	    TogglePlayerControllable(ID,0);
	    IsKidnapped[ID] =120;
	    
	    format(string,sizeof(string),"[KIDNAP] %s(%d) has tied %s(%d) up and thrown them into their vehicle!",PlayerName(playerid),playerid,PlayerName(ID),ID);
	    SendClientMessageToAll(COLOR_RED,string);
	    
	    format(string,sizeof(string),"[POLICE RADIO] %s(%d) has tied %s(%d) up with rope and thrown them into their vehicle! Location: %s",PlayerName(playerid),playerid,PlayerName(ID),ID,zones[current_zone][zone_name]);
	    SendClientMessageToAllCops(string);
	    return 1;
	}
	return 1;
}

dcmd_untie(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /untie (Player Name/ID)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(IsCuffed[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command while cuffed by law enforcement.");
	    return 1;
	}
	if(IsKidnapped[ID] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"This player is not kidnapped. You have no reason to untie them.");
	    return 1;
	}
	format(string,sizeof(string),"You have untied %s(%d) from their rope and they are now free to go.",PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_ERROR,string);
	
	format(string,sizeof(string),"You have been untied by %s(%d) from your rope and you are now free to go.",PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_ERROR,string);
	TogglePlayerControllable(ID,1);
	IsKidnapped[ID] =0;
	return 1;
}

dcmd_cutrope(playerid,params[])
{
	new string[128];
	#pragma unused params
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not kidnapped. You cannot use this command.");
	    return 1;
	}
	if(HasScissors[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must have a pair of scissors to be able to do this. Buy some from Supa Save.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Rope Cut_]]");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have cut the rope with the scissors you bought and are now free to go!");
	IsKidnapped[playerid] =0;
	TogglePlayerControllable(playerid,1);
	TextDrawSetString(MessageTD[playerid],"ESCAPED");
	TextDrawShowForPlayer(playerid,MessageTD[playerid]);
	MessageTDTime[playerid] =5;
	HasScissors[playerid] --;
	
	format(string,sizeof(string),"[KIDNAP ESCAPE] %s(%d) has used the scissors he bought to escape from his kidnapper.",PlayerName(playerid),playerid);
	SendClientMessageToAll(COLOR_LIGHTBLUE,string);
	return 1;
}

dcmd_rob(playerid,params[])
{
	new string[128];
	new ID;
	if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /rob (Player Name/ID)");
	    return 1;
	}
    if(IsSpawned[playerid] != 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(InAdminMode[ID] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command on this player because they are in Administrator mode.");
	    return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_THIEF)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only thieves can rob players of their money.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
	    format(string,sizeof(string),"The player ID (%d) is not connected to the server. You cannot rob them",ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) > 4)
	{
	    format(string,sizeof(string),"%s(%d) is too far away. You cannot reach him to rob him.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob someone while in a vehicle. Exit the vehicle first.");
	    return 1;
	}
	if(GetPlayerState(ID) == PLAYER_STATE_DRIVER || GetPlayerState(ID) == PLAYER_STATE_PASSENGER)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob someone while they are in a vehicle. Get them to exit the vehicle first.");
	    return 1;
	}
	if(playerid == ID)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob yourself, how can you even manage that?");
	    return 1;
	}
	if(IsSpawned[ID] != 1)
	{
	    format(string,sizeof(string),"%s(%d) is not spawned. You cannot rob dead people ..",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(IsFrozen[ID] == 1)
	{
	    format(string,sizeof(string),"%s(%d) is frozen by a Server Administrator. You cannot rob them.",PlayerName(ID),ID);
	    SendClientMessage(playerid,COLOR_ERROR,string);
	    return 1;
	}
	if(AttemptedToRobRecently[playerid] >= 1)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You are too tired from your last rob attempt. Please wait before robbing again.");
		return 1;
	}
	if(HasRobbedRecently[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are too tired from the last person you robbed. Please wait before robbing again.");
	    return 1;
	}
	if(GetPlayerMoney(ID) <= 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player has no money in their pockets. What would be the point in robbing them?");
	    return 1;
	}
	new crand = random(100);
	if(crand <= 30)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Rob attempt failed. The player slipped out of your grasp.");
		AttemptedToRobRecently[playerid] =35;
		return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) <= 4 && crand > 30)
	{
	    new current_zone = player_zone[playerid];
	    new mrand =random(GetPlayerMoney(ID));
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Player Robbed_]]");
	    format(string,sizeof(string),"You have robbed $%d from %s(%d). Careful they dont come after you!",mrand,PlayerName(ID),ID);
		SendClientMessage(playerid,COLOR_RED,string);
		GivePlayerMoney(playerid,mrand);
		IncreaseWantedLevel(playerid,8);
		HasRobbedRecently[playerid] =180;
		IncreasePlayerScore(playerid,3);
		
		SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Robbed_]]");
	    format(string,sizeof(string),"You have had $%d robbed from you by %s(%d). Kill them for your money back or run!",mrand,PlayerName(playerid),playerid);
		SendClientMessage(ID,COLOR_RED,string);
		GivePlayerMoney(ID,-mrand);
		
		format(string,sizeof(string),"[POLICE RADIO] Robbery: %s(%d) has robbed $%d from %s(%d). Location: %s.",PlayerName(playerid),playerid,mrand,PlayerName(ID),ID,zones[current_zone][zone_name]);
		SendClientMessageToAllCops(string);
		return 1;
	}
	return 1;
}

dcmd_sellcar(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_CARJACK)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only Car Jackers can sell vehicles to the Shipyard.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(getCheckpointType(playerid) != CP_ShipYard)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be in the Shipyard checkpoint in order to sell stolen cars.");
	    return 1;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be in a vehicle if you wany to sell one.");
	    return 1;
	}
	new pveh =GetPlayerVehicleID(playerid);
	if(VehicleInfo[pveh][stolen] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"This vehicle has not been stolen, you cannot sell it to us.");
	    return 1;
	}
	new mrand =random(250000);
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Stolen Vehicle Sold_]]");
	format(string,sizeof(string),"You have sold the vehicle that you have stolen to the shipyard for $%d.",mrand);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	GivePlayerMoney(playerid,mrand);
	
	format(string,sizeof(string),"[STOLEN CAR SALE] Car Jacker %s(%d) has sold a stolen vehicle to the Shipyard for $%d.",PlayerName(playerid),playerid,mrand);
	SendClientMessageToAll(COLOR_ORANGE,string);

    format(string,sizeof(string),"7[STOLEN CAR SALE] Car Jacker %s(%d) has sold a stolen vehicle to the Shipyard for $%d.",PlayerName(playerid),playerid,mrand);
    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
    
    VehicleInfo[pveh][stolen] =0;
    VehicleInfo[pveh][bought] =999;
    DestroyVehicle(pveh);
    return 1;
}

dcmd_afk(playerid,params[])
{
    #pragma unused params
	new name[24];
	new string[128];
	if(IsRegularPlayer[playerid] != 1337)
	{
		SendClientMessage(playerid, COLOR_ERROR, "You must be a Regular Player to use this command.");
		return 1;
	}
	if(Away[playerid] == 1)
	{
		SendClientMessage(playerid, COLOR_ERROR, "You are already set to Away.");
		return 1;
	}
    Away[playerid] =1;
    TogglePlayerControllable(playerid,0);
    SetCameraBehindPlayer(playerid);
    GetPlayerName(playerid,name,128);
    format(string, sizeof(string), "[AWAY] %s(%d) is now AFK! (Away from keyboard)",name,playerid);
    SendClientMessageToAll(COLOR_LIME, string);
    
    new setname[16];
    format(setname, sizeof(setname), "%s[AFK]",name);
    if(!strlen(name[11]))
	{
	    afktag[playerid] =1;
	    SetPlayerName(playerid,setname);
    }
    format(string, sizeof(string), "8[AWAY] %s(%d) is now AFK! (Away from keyboard)",name,playerid);
    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
    SendClientMessage(playerid, COLOR_LIME, "Type /back when you are back on the computer.");
    return 1; //return value
}

dcmd_back(playerid,params[])
{
	#pragma unused params
    new name[24];
	new string[128];
    if(IsRegularPlayer[playerid] != 1337)
	{
		SendClientMessage(playerid, COLOR_ERROR, "You must be a Regular Player to use this command.");
		return 1;
	}
	if(Away[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_ERROR, "You are not set to Away.");
		return 1;
	}
    Away[playerid] =0;
    TogglePlayerControllable(playerid,1);
    SetCameraBehindPlayer(playerid);
    GetPlayerName(playerid,name,16);
    new pname[16];
    GetPlayerName(playerid,pname,16);
    strdel(pname, strlen(pname)-5, strlen(pname));
    if(afktag[playerid] == 1)
    {
	    afktag[playerid] =0;
	    SetPlayerName(playerid,pname);
    }
    new name2[16];
    GetPlayerName(playerid,name2,16);
    format(string, sizeof(string), "[BACK] %s(%d) is now back infront of the computer.",name2,playerid);
    SendClientMessageToAll(COLOR_LIME, string);
    format(string, sizeof(string), "8[BACK] %s(%d) is now back infront of the computer.",name2,playerid);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
 	SendClientMessage(playerid, COLOR_LIME, "Type /afk to go AFK again.");
   	return 1;
}

dcmd_rc(playerid,params[])
{
	new string[128];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsRegularPlayer[playerid] != 1337)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Only Regular Players can use the Regular Player chat to talk.");
	    return 1;
	}
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /rc (Message)");
	    return 1;
	}
	format(string,sizeof(string),"[REGULAR CHAT] %s(%d): %s",PlayerName(playerid),playerid,params);
	SendClientMessageToAllRegulars(string);
    format(string,sizeof(string),"11[REGULAR CHAT] %s(%d): %s",PlayerName(playerid),playerid,params);
    IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
    return 1;
}

dcmd_blowcar(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_TERRO)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be a terrorist in order to blow up vehicles.");
	    return 1;
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not in any vehicle. How are you supposed to blow one up?");
	    return 1;
	}
	if(HasC4[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You need C4 in order to blow things up .. Try going to the bomb shop. (Behind Wang Cars)");
	    return 1;
	}
	if(HasBlownVehicleRecently[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are still recovering from your last explosion. Please wait before blowing stuff up again.");
	    return 1;
	}
	new pveh =GetPlayerVehicleID(playerid);
	new current_zone = player_zone[playerid];
	format(string,sizeof(string),"[TERRORIST ACTION] %s(%d) has planted a bomb in the vehicle they are travelling in! Careful of the explosion!",PlayerName(playerid),playerid);
	SendClientMessageToAll(COLOR_RED,string);
	
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Bomb Planted_]]");
	SendClientMessage(playerid,COLOR_RED,"You have planted a bomb in this vehicle, get out before it explodes ..");
	HasBlownVehicleRecently[playerid] =120;
	IncreaseWantedLevel(playerid,10);
	IncreasePlayerScore(playerid,2);
	
	if(TerroristSkill[playerid] < 20)
	{
	    TerroristSkill[playerid] ++;
	    SendClientMessage(playerid,COLOR_LIGHTBLUE,"Your terrorist level has increased. Check out /tlevel to see your level and what you can blow up next.");
	}

	format(string,sizeof(string),"[POLICE RADIO] Terrorism: %s(%d) has planted a bomb in the vehicle they are travelling in. Location: %s.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
	SendClientMessageToAllCops(string);

	VehicleInfo[pveh][bombed] =10;
	return 1;
}

dcmd_blowup(playerid,params[])
{
	#pragma unused params
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(gTeam[playerid] != TEAM_TERRO)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be a terrorist in order to blow up buildings/structures.");
	    return 1;
	}
	if(!IsPlayerInCheckpoint(playerid))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be in the checkpoint of a building/structure that you can blow up.");
	    return 1;
	}
	if(getCheckpointType(playerid) != CP_CIAEnt && getCheckpointType(playerid) != CP_CIASatBlow && getCheckpointType(playerid) != CP_CIABridge)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be in the checkpoint of a building/structure that you can blow up.");
	    return 1;
	}
	if(HasC4[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You need C4 in order to blow things up .. Try going to the bomb shop. (Behind Wang Cars)");
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_CIAEnt)
	{
	    if(TerroristSkill[playerid] < 20)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must have a Terrorism Level of 20 before you can blow up the CIA Headquarters.");
	        return 1;
		}
		if(CIABuildingBlown >= 1)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"The CIA Building has already been blown up. You must wait for it to be re-built before you can blow it up.");
		    return 1;
		}
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Planting Explosives_]]");
	    SendClientMessage(playerid,COLOR_RED,"You have begun to plant explosives on the building.");
	    
	    IsPlantingCIABuilding[playerid] =1;
	    TogglePlayerControllable(playerid,0);
	    HasC4[playerid] --;
	    SetTimer("PlantingOneCIABuilding",2000,0);
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_CIASatBlow)
	{
	    if(TerroristSkill[playerid] < 20)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must have a Terrorism Level of 20 before you can blow up the CIA Satelite.");
	        return 1;
		}
		if(CIASatBlown >= 1)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"The CIA Satelite has already been blown up. You must wait for it to be re-built before you can blow it up.");
		    return 1;
		}
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Planting Explosives_]]");
	    SendClientMessage(playerid,COLOR_RED,"You have begun to plant explosives on the satelite.");

	    IsPlantingCIASat[playerid] =1;
	    TogglePlayerControllable(playerid,0);
	    HasC4[playerid] --;
	    SetTimer("PlantingOneCIASat",2000,0);
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_CIABridge)
	{
	    if(TerroristSkill[playerid] < 30)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must have a Terrorism Level of 20 before you can blow up the CIA Bridge.");
	        return 1;
		}
		if(CIABridgeBlown >= 1)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"The CIA Bridge has already been blown up. You must wait for it to be re-built before you can blow it up.");
		    return 1;
		}
	    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Planting Explosives_]]");
	    SendClientMessage(playerid,COLOR_RED,"You have begun to plant explosives on the bridge.");

	    IsPlantingCIABridge[playerid] =1;
	    TogglePlayerControllable(playerid,0);
	    HasC4[playerid] --;
	    SetTimer("PlantingOneCIABridge",2000,0);
	    return 1;
	}
	return 1;
}

dcmd_tlevel(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(gTeam[playerid] != TEAM_TERRO)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be a terrorist in order to see your Terrorism Level.");
	    return 1;
	}
	if(TerroristSkill[playerid] >= 0 && TerroristSkill[playerid] < 20)
	{
	    format(string,sizeof(string),"Your terrorism level is %d.\nYou can blow up your vehicles with /blowcar.\nWhen you reach level 20 you will be able to blow up the CIA Building and Satelite.",TerroristSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_TERRORIST,DIALOG_STYLE_MSGBOX,"{FF0000}Terrorism Level",string,"Ok","Cancel");
		return 1;
	}
	if(TerroristSkill[playerid] >= 20 && TerroristSkill[playerid] < 30)
	{
	    format(string,sizeof(string),"Your terrorism level is %d.\nYou can blow up your vehicles with /blowcar and the CIA Building and Satelite.\nWhen you reach level 30 you will be able to blow up the CIA Bridge.",TerroristSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_TERRORIST,DIALOG_STYLE_MSGBOX,"{FF0000}Terrorism Level",string,"Ok","Cancel");
		return 1;
	}
	if(TerroristSkill[playerid] >= 30)
	{
	    format(string,sizeof(string),"Your terrorism level is %d.\nYou can blow up the CIA Bridge.\nYour are as good as you can be.",TerroristSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_TERRORIST,DIALOG_STYLE_MSGBOX,"{FF0000}Terrorism Level",string,"Ok","Cancel");
		return 1;
	}
	return 1;
}

dcmd_robskill(playerid,params[])
{
	#pragma unused params
	new string[128];
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(gTeam[playerid] < 9)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this command with your class/skill.");
	    return 1;
	}
	if(RobSkill[playerid] >= 0 && RobSkill[playerid] < 10)
	{
	    format(string,sizeof(string),"Your robbing skill level is %d.\nYou can rob players and Supa Save.\nWhen you reach level 10 you will be able to rob\nthe four Drug Houses.",RobSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_ROBSKILL,DIALOG_STYLE_MSGBOX,"{FF0000}Robbing Skill Level",string,"Ok","Cancel");
		return 1;
	}
	if(RobSkill[playerid] >= 10 && RobSkill[playerid] < 20)
	{
	    format(string,sizeof(string),"Your robbing skill level is %d.\nYou can rob players, Supa Save and the four Drug\nHouses.\nWhen you reach level 20 you will be able to\nrob Otto's Cars.",RobSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_ROBSKILL,DIALOG_STYLE_MSGBOX,"{FF0000}Robbing Skill Level",string,"Ok","Cancel");
		return 1;
	}
	if(RobSkill[playerid] >= 20 && RobSkill[playerid] < 30)
	{
	    format(string,sizeof(string),"Your robbing skill level is %d.\nYou can rob places such as Ammunation.",RobSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_ROBSKILL,DIALOG_STYLE_MSGBOX,"{FF0000}Robbing Skill Level",string,"Ok","Cancel");
		return 1;
	}
	if(RobSkill[playerid] >= 30)
	{
	    format(string,sizeof(string),"Your robbing skill level is %d.\nYou can rob anywhere you want.\nYou are the best you can be.",RobSkill[playerid]);
		ShowPlayerDialog(playerid,DIALOG_ROBSKILL,DIALOG_STYLE_MSGBOX,"{FF0000}Robbing Skill Level",string,"Ok","Cancel");
		return 1;
	}
	return 1;
}

dcmd_robstore(playerid,params[])
{
	new string[128];
	#pragma unused params
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(!IsPlayerInCheckpoint(playerid))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not in the checkpoint of anywhere you can rob.");
	    return 1;
	}
	if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || gTeam[playerid] == TEAM_MEDIC)
	{
 		SendClientMessage(playerid,COLOR_ERROR,"You cannot rob things with your class/skill.");
		return 1;
	}
	if(getCheckpointType(playerid) != CP_BurgerShotMain && getCheckpointType(playerid) != CP_CluckinBellMain &&
	getCheckpointType(playerid) != CP_Ammunation && getCheckpointType(playerid) != CP_GayDarMain &&
	getCheckpointType(playerid) != CP_ZeroMain && getCheckpointType(playerid) != CP_MistysMain &&
	getCheckpointType(playerid) != CP_GYM && getCheckpointType(playerid) != CP_School &&
	getCheckpointType(playerid) != CP_WangCars && getCheckpointType(playerid) != CP_Train &&
	getCheckpointType(playerid) != CP_Barbers && getCheckpointType(playerid) != CP_PizzaMain &&
	getCheckpointType(playerid) != CP_ZipMain && getCheckpointType(playerid) != CP_VictimMain &&
	getCheckpointType(playerid) != CP_BincoMain && getCheckpointType(playerid) != CP_CityHallMain)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are not in the checkpoint of anywhere you can rob.");
	    return 1;
	}
	new current_zone = player_zone[playerid];
	new rrand =random(100);
	if(getCheckpointType(playerid) == CP_BurgerShotMain)
	{
	    if(zones[current_zone][zone_name] == zones[116][zone_name] || zones[current_zone][zone_name] == zones[117][zone_name])
	    {
		    if(GarciaBurgerShotRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Garcia Burger Shot has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Garcia Burger Shot robbery failed.");
			    GarciaBurgerShotRobbedRecently =320;
			    return 1;
			}
			GarciaBurgerShotRobbedRecently =320;
			RobbingGarciaBurgerShot[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Burger Shot.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingGarciaBurgerShot[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Garcia Burger Shot! Get To Burger Shot and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Burger Shot ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Burger Shot ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		if(zones[current_zone][zone_name] == zones[162][zone_name])
	    {
		    if(JHBurgerShotRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Juniper Hollow Burger Shot has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Juniper Hollow Burger Shot robbery failed.");
			    JHBurgerShotRobbedRecently =320;
			    return 1;
			}
			JHBurgerShotRobbedRecently =320;
			RobbingJHBurgerShot[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Burger Shot.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingJHBurgerShot[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Juniper Hollow Burger Shot! Get To Burger Shot and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Burger Shot ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Burger Shot ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		if(zones[current_zone][zone_name] == zones[49][zone_name] || zones[current_zone][zone_name] == zones[50][zone_name] ||
		zones[current_zone][zone_name] == zones[51][zone_name] || zones[current_zone][zone_name] == zones[52][zone_name] ||
		zones[current_zone][zone_name] == zones[53][zone_name] || zones[current_zone][zone_name] == zones[54][zone_name])
	    {
		    if(DownBurgerShotRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Downtown Burger Shot has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Downtown Burger Shot robbery failed.");
			    DownBurgerShotRobbedRecently =320;
			    return 1;
			}
			DownBurgerShotRobbedRecently =320;
			RobbingDownBurgerShot[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Burger Shot.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownBurgerShot[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Downtown Burger Shot! Get To Burger Shot and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Burger Shot ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Burger Shot ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_ZipMain)
	{
		if(zones[current_zone][zone_name] == zones[49][zone_name] || zones[current_zone][zone_name] == zones[50][zone_name] ||
		zones[current_zone][zone_name] == zones[51][zone_name] || zones[current_zone][zone_name] == zones[52][zone_name] ||
		zones[current_zone][zone_name] == zones[53][zone_name] || zones[current_zone][zone_name] == zones[54][zone_name])
	    {
		    if(DownZipRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Downtown Zip has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Downtown Zip robbery failed.");
			    DownZipRobbedRecently =320;
			    return 1;
			}
			DownZipRobbedRecently =320;
			RobbingDownZip[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Zip.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownZip[playerid]);
			ShowPlayerDialog(playerid,DIALOG_ZIP,DIALOG_STYLE_MSGBOX,"{FF0000}Zip Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Downtown Zip! Get To Zip and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Zip ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Zip ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_BincoMain)
	{
		if(zones[current_zone][zone_name] == zones[161][zone_name])
	    {
		    if(JHBincoRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Juniper Hill Binco has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Juniper Hill Binco robbery failed.");
			    JHBincoRobbedRecently =320;
			    return 1;
			}
			JHBincoRobbedRecently =320;
			RobbingJHBinco[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Binco.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingJHBinco[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BINCO,DIALOG_STYLE_MSGBOX,"{FF0000}Binco Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Juniper Hill Binco! Get To Binco and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Binco ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Binco ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_VictimMain)
	{
		if(zones[current_zone][zone_name] == zones[49][zone_name] || zones[current_zone][zone_name] == zones[50][zone_name] ||
		zones[current_zone][zone_name] == zones[51][zone_name] || zones[current_zone][zone_name] == zones[52][zone_name] ||
		zones[current_zone][zone_name] == zones[53][zone_name] || zones[current_zone][zone_name] == zones[54][zone_name])
	    {
		    if(DownVictimRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Downtown Victim has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Downtown Victim robbery failed.");
			    DownVictimRobbedRecently =320;
			    return 1;
			}
			DownVictimRobbedRecently =320;
			RobbingDownVictim[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Victim.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownVictim[playerid]);
			ShowPlayerDialog(playerid,DIALOG_VICTIM,DIALOG_STYLE_MSGBOX,"{FF0000}Victim Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Downtown Victim! Get To Victim and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Victim ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Victim ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_PizzaMain)
	{
	    if(zones[current_zone][zone_name] == zones[96][zone_name] || zones[current_zone][zone_name] == zones[97][zone_name] ||
		zones[current_zone][zone_name] == zones[98][zone_name])
	    {
		    if(EsplanadePizzaRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Esplanade Well Stacked Pizza has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Esplanade Well Stacked Pizza robbery failed.");
			    EsplanadePizzaRobbedRecently =320;
			    return 1;
			}
			EsplanadePizzaRobbedRecently =320;
			RobbingEsplanadePizza[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Well Stacked Pizza.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingEsplanadePizza[playerid]);
			ShowPlayerDialog(playerid,DIALOG_PIZZA,DIALOG_STYLE_MSGBOX,"{FF0000}Well Stacked Pizza Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Esplanade Well Stacked Pizza! Go and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Well Stacked Pizza ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Well Stacked Pizza ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		if(zones[current_zone][zone_name] == zones[102][zone_name])
	    {
		    if(FinancialPizzaRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Financial Well Stacked Pizza has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Financial Well Stacked Pizza robbery failed.");
			    FinancialPizzaRobbedRecently =320;
			    return 1;
			}
			FinancialPizzaRobbedRecently =320;
			RobbingFinancialPizza[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Well Stacked Pizza.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingFinancialPizza[playerid]);
			ShowPlayerDialog(playerid,DIALOG_PIZZA,DIALOG_STYLE_MSGBOX,"{FF0000}Well Stacked Pizza Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Financial Well Stacked Pizza! Go and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Well Stacked Pizza ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Well Stacked Pizza ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Ammunation)
	{
	    if(zones[current_zone][zone_name] == zones[241][zone_name] || zones[current_zone][zone_name] == zones[242][zone_name] ||
		zones[current_zone][zone_name] == zones[243][zone_name])
	    {
		    if(AmmunationRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Ammunation has been robbed recently.");
		        return 1;
			}
			if(RobSkill[playerid] < 20)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"You must have a robbing skill level of 20 to rob Ammunation. Check /robskill to see what you can rob.");
			    return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Ammunation robbery failed.");
			    AmmunationRobbedRecently =320;
			    return 1;
			}
			AmmunationRobbedRecently =320;
			RobbingAmmunation[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Ammunation.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingAmmunation[playerid]);
			ShowPlayerDialog(playerid,DIALOG_AMMUNATION,DIALOG_STYLE_MSGBOX,"{FF0000}Ammunation Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Ammunation! Get To Ammunation and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Ammunation ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Ammunation ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Jizzys)
	{
	    if(JizzysRobbedRecently >= 1)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"Jizzy's has been robbed recently.");
	        return 1;
		}
		if(RobSkill[playerid] < 20)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"You must have a robbing skill level of 20 to rob Jizzy's. Check /robskill to see what you can rob.");
		    return 1;
		}
		if(rrand <= 30)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"Jizzy's robbery failed.");
		    JizzysRobbedRecently =320;
		    return 1;
		}
		JizzysRobbedRecently =320;
		RobbingJizzys[playerid] =25;
		IncreaseWantedLevel(playerid,4);
		IncreasePlayerScore(playerid,1);
		format(string,sizeof(string),"Robbing Jizzy's.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingJizzys[playerid]);
		ShowPlayerDialog(playerid,DIALOG_JIZZYS,DIALOG_STYLE_MSGBOX,"{FF0000}Jizzy's Robbery",string,"Ok","Cancel");

		format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob Jizzy's! Get To Jizzy's and arrest the suspect.",PlayerName(playerid),playerid);
		SendClientMessageToAllCops(string);

		format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Jizzy's ..",PlayerName(playerid),playerid);
		SendClientMessageToAll(COLOR_RED,string);

		format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Jizzy's ..",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		return 1;
	}
	if(getCheckpointType(playerid) == CP_CityHallMain)
	{
	    if(CityHallRobbedRecently >= 1)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"The City Hall has been robbed recently.");
	        return 1;
		}
		if(RobSkill[playerid] < 20)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"You must have a robbing skill level of 20 to rob the City Hall. Check /robskill to see what you can rob.");
		    return 1;
		}
		if(rrand <= 30)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"City Hall robbery failed.");
		    CityHallRobbedRecently =320;
		    return 1;
		}
		CityHallRobbedRecently =320;
		RobbingCityHall[playerid] =25;
		IncreaseWantedLevel(playerid,4);
		IncreasePlayerScore(playerid,1);
		format(string,sizeof(string),"Robbing City Hall.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingCityHall[playerid]);
		ShowPlayerDialog(playerid,DIALOG_CITYHALL,DIALOG_STYLE_MSGBOX,"{FF0000}City Hall Robbery",string,"Ok","Cancel");

		format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the City Hall! Get To the City Hall and arrest the suspect.",PlayerName(playerid),playerid);
		SendClientMessageToAllCops(string);

		format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the City Hall ..",PlayerName(playerid),playerid);
		SendClientMessageToAll(COLOR_RED,string);

		format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the City Hall ..",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Barbers)
	{
	    if(zones[current_zone][zone_name] == zones[258][zone_name] || zones[current_zone][zone_name] == zones[259][zone_name] ||
		zones[current_zone][zone_name] == zones[260][zone_name])
	    {
		    if(BarbersRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Barbers has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Barbers robbery failed.");
			    BarbersRobbedRecently =320;
			    return 1;
			}
			BarbersRobbedRecently =320;
			RobbingBarbers[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Barbers.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingBarbers[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BARBERS,DIALOG_STYLE_MSGBOX,"{FF0000}Barbers Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Barbers! Get To the Barbers and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the Barbers ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the Barbers ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Train)
	{
	    if(zones[current_zone][zone_name] == zones[47][zone_name] || zones[current_zone][zone_name] == zones[48][zone_name])
	    {
		    if(TrainRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Train Station has been robbed recently.");
		        return 1;
			}
			if(RobSkill[playerid] < 20)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"You must have a robbing skill level of 20 to rob the Train Station. Check /robskill to see what you can rob.");
			    return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Train Station robbery failed.");
			    TrainRobbedRecently =320;
			    return 1;
			}
			TrainRobbedRecently =320;
			RobbingTrain[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Train Station.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingTrain[playerid]);
			ShowPlayerDialog(playerid,DIALOG_TRAIN,DIALOG_STYLE_MSGBOX,"{FF0000}Train Station Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Train Station! Get To the Train Station and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the Train Station ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the Train Station ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_WangCars)
	{
	    if(zones[current_zone][zone_name] == zones[47][zone_name] || zones[current_zone][zone_name] == zones[48][zone_name])
	    {
		    if(WangRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Wang Cars has been robbed recently.");
		        return 1;
			}
			if(RobSkill[playerid] < 20)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"You must have a robbing skill level of 20 to rob Wang Cars. Check /robskill to see what you can rob.");
			    return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Wang Cars robbery failed.");
			    WangRobbedRecently =320;
			    return 1;
			}
			WangRobbedRecently =320;
			RobbingWang[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Wang Cars.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingWang[playerid]);
			ShowPlayerDialog(playerid,DIALOG_WANGCARS,DIALOG_STYLE_MSGBOX,"{FF0000}Wang Cars Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Wang Cars! Get To Wang Cars and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Wang Cars ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Wang Cars ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_GYM)
	{
	    if(zones[current_zone][zone_name] == zones[116][zone_name] || zones[current_zone][zone_name] == zones[117][zone_name])
	    {
		    if(GYMRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The GYM has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"GYM robbery failed.");
			    GYMRobbedRecently =320;
			    return 1;
			}
			GYMRobbedRecently =320;
			RobbingGYM[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing GYM.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingGYM[playerid]);
			ShowPlayerDialog(playerid,DIALOG_GYM,DIALOG_STYLE_MSGBOX,"{FF0000}GYM Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the GYM! Get to the GYM and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the GYM ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the GYM ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_School)
	{
	    if(zones[current_zone][zone_name] == zones[47][zone_name] || zones[current_zone][zone_name] == zones[48][zone_name])
	    {
		    if(SchoolRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Driving School has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Driving School robbery failed.");
			    SchoolRobbedRecently =320;
			    return 1;
			}
			SchoolRobbedRecently =320;
			RobbingSchool[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Driving School.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingSchool[playerid]);
			ShowPlayerDialog(playerid,DIALOG_SCHOOL,DIALOG_STYLE_MSGBOX,"{FF0000}Driving School Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Driving School! Get to the Driving School and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the Driving School ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the Driving School ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_GayDarMain)
	{
	    if(zones[current_zone][zone_name] == zones[258][zone_name] || zones[current_zone][zone_name] == zones[259][zone_name] ||
		zones[current_zone][zone_name] == zones[260][zone_name])
	    {
		    if(GayDarRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"Gay Dar Station has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Gay Dar Station robbery failed.");
			    GayDarRobbedRecently =320;
			    return 1;
			}
			GayDarRobbedRecently =320;
			RobbingGayDar[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Gay Dar Station.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingGayDar[playerid]);
			ShowPlayerDialog(playerid,DIALOG_GAYDAR,DIALOG_STYLE_MSGBOX,"{FF0000}Gay Dar Station Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob Gay Dar Station! Get To Gay Dar Station and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Gay Dar Station ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Gay Dar Station ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_ZeroMain)
	{
	    if(zones[current_zone][zone_name] == zones[116][zone_name] || zones[current_zone][zone_name] == zones[117][zone_name])
	    {
		    if(ZeroRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"Zero's has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Zero's robbery failed.");
			    ZeroRobbedRecently =320;
			    return 1;
			}
			ZeroRobbedRecently =320;
			RobbingZero[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Zero's.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingZero[playerid]);
			ShowPlayerDialog(playerid,DIALOG_ZERO,DIALOG_STYLE_MSGBOX,"{FF0000}Zero's Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob Zero's! Get To Zero's and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Zero's ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Zero's ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_MistysMain)
	{
	    if(zones[current_zone][zone_name] == zones[116][zone_name] || zones[current_zone][zone_name] == zones[117][zone_name])
	    {
		    if(MistysRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"Misty's has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Misty's robbery failed.");
			    MistysRobbedRecently =320;
			    return 1;
			}
			MistysRobbedRecently =320;
			RobbingMistys[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Misty's.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingMistys[playerid]);
			ShowPlayerDialog(playerid,DIALOG_MISTYS,DIALOG_STYLE_MSGBOX,"{FF0000}Misty's Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob Misty's! Get To Misty's and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Misty's ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Misty's ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_CluckinBellMain)
	{
	    if(zones[current_zone][zone_name] == zones[241][zone_name] || zones[current_zone][zone_name] == zones[242][zone_name] ||
		zones[current_zone][zone_name] == zones[243][zone_name])
	    {
		    if(OceanCluckinBellRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Ocean Flats Cluckin Bell has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Ocean Flats Cluckin Bell robbery failed.");
			    OceanCluckinBellRobbedRecently =320;
			    return 1;
			}
			OceanCluckinBellRobbedRecently =320;
			RobbingOceanCluckinBell[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Cluckin Bell.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingOceanCluckinBell[playerid]);
			ShowPlayerDialog(playerid,DIALOG_CLUCKINBELL,DIALOG_STYLE_MSGBOX,"{FF0000}Cluckin Bell Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Ocean Flats Cluckin Bell! Get To Cluckin Bell and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Cluckin Bell ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Cluckin Bell ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		if(zones[current_zone][zone_name] == zones[49][zone_name] || zones[current_zone][zone_name] == zones[50][zone_name] ||
		zones[current_zone][zone_name] == zones[51][zone_name] || zones[current_zone][zone_name] == zones[52][zone_name] ||
		zones[current_zone][zone_name] == zones[53][zone_name] || zones[current_zone][zone_name] == zones[54][zone_name])
	    {
		    if(DownCluckinBellRobbedRecently >= 1)
		    {
		        SendClientMessage(playerid,COLOR_ERROR,"The Downtown Cluckin Bell has been robbed recently.");
		        return 1;
			}
			if(rrand <= 30)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Downtown Cluckin Bell robbery failed.");
			    DownCluckinBellRobbedRecently =320;
			    return 1;
			}
			DownCluckinBellRobbedRecently =320;
			RobbingDownCluckinBell[playerid] =25;
			IncreaseWantedLevel(playerid,4);
			IncreasePlayerScore(playerid,1);
			format(string,sizeof(string),"Robbing Cluckin Bell.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingOceanCluckinBell[playerid]);
			ShowPlayerDialog(playerid,DIALOG_CLUCKINBELL,DIALOG_STYLE_MSGBOX,"{FF0000}Cluckin Bell Robbery",string,"Ok","Cancel");

			format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Downtown Cluckin Bell! Get To Cluckin Bell and arrest the suspect.",PlayerName(playerid),playerid);
			SendClientMessageToAllCops(string);

			format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Cluckin Bell ..",PlayerName(playerid),playerid);
			SendClientMessageToAll(COLOR_RED,string);

			format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Cluckin Bell ..",PlayerName(playerid),playerid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		return 1;
	}
	return 1;
}

dcmd_inventory(playerid,params[])
{
	#pragma unused params
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	ShowPlayerDialog(playerid,DIALOG_INVENTORY,DIALOG_STYLE_LIST,"Inventory Options","{FFFFFF}Add C4\nAdd Rope\nAdd All Money\nRemove C4\nRemove Rope\nRemove Money\n{FF0000}Inventory Information","Ok","Cancel");
	return 1;
}

dcmd_credits(playerid,params[])
{
	#pragma unused params
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	ShowPlayerDialog(playerid,DIALOG_CREDITS,DIALOG_STYLE_MSGBOX,"Credits","{FFFFFF}CRRPG {Site: www.crrpg.co.uk}\nFor enspiring me to make some of the skills/classes in this script.\nY-Less for sscanf.\nDracoblue for dudb && dcmd.\nCuerv0 for the roadblocks script.\nCreator of xObjects.\nBM[UK] for the checkpoint streamer.\nStevo127 for creating the Gamemode v1.0 and v1.1","Ok","Cancel");
	return 1;
}

dcmd_sausage(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(HasSausageRolls[playerid] == 0)
	{
		SendClientMessage(playerid,COLOR_ERROR,"You do not have any sausage rolls that you can eat. Buy some at Supa Save.");
		return 1;
	}
	new Float:phealth;
	GetPlayerHealth(playerid,phealth);
	if(phealth == 100)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Your health is already full. Why do you need to eat any sausage rolls?");
	    return 1;
	}
	if(HasEatenSausageRecently[playerid] >= 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have eaten a sausage roll recently. Please wait before eating again as your full up.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Sausage Roll Eaten_]]");
	SendClientMessage(playerid,COLOR_FORESTGREEN,"You have eaten a sausage roll and it has healed you slightly. You feel abit better.");
	SetPlayerHealth(playerid,phealth+25);
	HasSausageRolls[playerid] --;
	HasEatenSausageRecently[playerid] =60;
	
	format(string,sizeof(string),"3[FOOD EATEN] %s(%d)'s health has increased slightly from eating a sausage roll.",PlayerName(playerid),playerid);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_givecash(playerid,params[])
{
	new string[128];
	new ID, amount;
    if(sscanf(params, "ui", ID, amount))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /givecash (Player Name/ID) (Amount)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connected to the server. You cannot give money to them.",ID);
        SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(ID == playerid)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give money to yourself. Why would you waste your time?");
	    return 1;
	}
	if(GetPlayerMoney(playerid) < amount)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have that amount of money in order to give it to someone.");
	    return 1;
	}
	if(amount > 200000 || amount < 1000)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"Please enter an amount between $1000 and $200000.");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) < 6)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player is not close enough in order to give them money.");
	    return 1;
	}
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Money Given_]]");
	format(string,sizeof(string),"You have given $%d of your own money to %s(%d).",amount,PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	GivePlayerMoney(playerid,-amount);
	
	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Money Received_]]");
	format(string,sizeof(string),"You have been given $%d by %s(%d). Make sure you thank them.",amount,PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_YELLOW,string);
	GivePlayerMoney(ID,amount);
	
	format(string,sizeof(string),"2[CASH GIVEN] %s(%d) has given $%d to %s(%d).",PlayerName(playerid),playerid,amount,PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_givegun(playerid,params[])
{
	new string[128];
	new ID;
    if(sscanf(params, "u", ID))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /givegun (Player Name/ID)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connected to the server. You cannot give a gun to them.",ID);
        SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(ID == playerid)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot give a gun to yourself. Why would you waste your time?");
	    return 1;
	}
	if(GetDistanceBetweenPlayers(playerid,ID) < 6)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"That player is not close enough in order to give them a gun.");
	    return 1;
	}
	new wname[24];
	GetWeaponName(GetPlayerWeapon(playerid),wname,sizeof(wname));
	
	SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Gun Given_]]");
	format(string,sizeof(string),"You have given your %s to %s(%d).",wname,PlayerName(ID),ID);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	GivePlayerWeapon(playerid,GetPlayerWeapon(playerid),-GetPlayerAmmo(playerid));

	SendClientMessage(ID,COLOR_DEADCONNECT,"[[_Gun Received_]]");
	format(string,sizeof(string),"You have been given an %s by %s(%d). Make sure you thank them.",wname,PlayerName(playerid),playerid);
	SendClientMessage(ID,COLOR_YELLOW,string);
	GivePlayerWeapon(ID,GetPlayerWeapon(playerid),GetPlayerAmmo(playerid));

	format(string,sizeof(string),"2[GUN GIVEN] %s(%d) has given an %s to %s(%d).",PlayerName(playerid),playerid,wname,PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

dcmd_changepass(playerid,params[])
{
	#pragma unused params
	
	ShowChangePassScreen(playerid);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Enter your desired password into the box below and click ok.");
	return 1;
}

dcmd_changename(playerid,params[])
{
	#pragma unused params

	ShowChangeNameScreen(playerid);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Enter your desired name into the box below and click ok.");
	return 1;
}

dcmd_rules(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	ShowPlayerDialog(playerid,DIALOG_RULES,DIALOG_STYLE_MSGBOX,"{FF0000}Server Rules","{FFFFFF}1) No Deathmatching - Killing a player without a valid reason.\n2) No Hacking or Ilegal modding.\n3) No Flaming/Bitching - E.g. 'FUCK YOU BITCH'.\n4) No impersonating Administrators/Players.\n5) No Advertising or mentioning of other servers in this way.\n6) Respect all Administrators and Players no matter what.\n7) Do not shout about rule breakers, simply /report.","Ok","Cancel");
	
	format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /rules.",PlayerName(playerid),playerid);
	SendClientMessageToAllAdmins(string);
	
	format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /rules.",PlayerName(playerid),playerid);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	return 1;
}

dcmd_pc(playerid,params[])
{
	#pragma unused params
	new string[128];
    if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	ShowPlayerDialog(playerid,DIALOG_PC,DIALOG_STYLE_MSGBOX,"{FF0000}Player Colours","{228B22}This green is for Army Personnel and Medics.\n{0000FF}This blue is for police.\n{FF4500}This orange is for CIA.\n{556B2F}This green is for Drivers.\n{FFA500}This orange is for medium wanted players.\n{FFFF00}This yellow is for low wanted players.\n{FF0000}This red is for most wanted players.\n{FFFFFF}This white is for civilians. Police must not shoot these players.","Ok","Cancel");

	format(string,sizeof(string),"[ADMIN SPY] %s(%d) has typed /pc.",PlayerName(playerid),playerid);
	SendClientMessageToAllAdmins(string);

	format(string,sizeof(string),"4[ADMIN SPY] %s(%d) has typed /pc.",PlayerName(playerid),playerid);
	IRC_GroupSay(gGroupAdminID,IRC_ADMINCHANNEL,string);
	return 1;
}

dcmd_transfer(playerid,params[])
{
	new string[128];
	new ID, cmdreason;
	if(sscanf(params, "ui", ID, cmdreason))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"USAGE: /transfer (Player Name/ID) (Amount)");
	    return 1;
	}
	if(IsSpawned[playerid] != 1)
    {
        SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned in order to be able to use this command.");
        return 1;
	}
	if(IsKidnapped[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You are kidnapped. You cannot use this command.");
	    return 1;
	}
	if(IsFrozen[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have been frozen by a Server Administrator. You cannot use this command.");
	    return 1;
	}
	if(getCheckpointType(playerid) != CP_BankMain)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You must be in the bank checkpoint in order to transfer money to someone's account.");
	    return 1;
	}
	if(!IsPlayerConnected(ID))
	{
		format(string,sizeof(string),"The Player ID (%d) is not connected to the server. You cannot tranfer money to them.",ID);
        SendClientMessage(playerid,COLOR_ERROR,string);
		return 1;
	}
	if(ID == playerid)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot transfer funds to your own bank account. Why would you waste my time?");
	    return 1;
	}
	if(BankCash[playerid] < cmdreason)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have the sufficient funds in your bank account to transfer this amount.");
	    return 1;
	}
	BankCash[ID] +=cmdreason;
	format(string,sizeof(string),"[BANK ACTION] %s(%d) has transfered $%d to your bank account. Your new balance is $%d.",PlayerName(playerid),playerid,cmdreason,BankCash[ID]);
	SendClientMessage(ID,COLOR_LIGHTBLUE,string);

	BankCash[playerid] -=cmdreason;
	format(string,sizeof(string),"Account Holder: %s(%d).\nBranch Location: San Fierro.\nFunds Transfered: $%d.\nTransfered to: %s(%d).\nNew Balance: $%s.",PlayerName(playerid),playerid,cmdreason,PlayerName(ID),ID,BankCash[playerid]);
	ShowPlayerDialog(playerid,DIALOG_BANK_BALANCE,DIALOG_STYLE_MSGBOX,"Bank Balance",string,"Ok","Cancel");

	format(string,sizeof(string),"2[BANK ACTION] %s(%d) has transfered $%d to %s(%d)'s bank account.",PlayerName(playerid),playerid,cmdreason,PlayerName(ID),ID);
	IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	return 1;
}

//==============================================================================

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

//==============================================================================

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

//==============================================================================

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new pname[24];
	new string[128];
	GetPlayerName(playerid,pname,sizeof(pname));

	//Save Last Vehicle ID (Detain)
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    new engine,lights,alarm,doors,bonnet,boot,objective;
		new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine != VEHICLE_PARAMS_ON && !IsAPlane(vid) && !IsACycleBike(vid))
		{
		    SendClientMessage(playerid,COLOR_DODGERBLUE,"To turn on the vehicle engine type /engineon or press 2.");
		}
		if(engine != VEHICLE_PARAMS_ON && IsAPlane(vid) && !IsACycleBike(vid))
		{
		    SendClientMessage(playerid,COLOR_DODGERBLUE,"To turn on a plane engine type /engineon.");
		}
		if(engine != VEHICLE_PARAMS_ON && IsACycleBike(vid))
		{
		    SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		}
	    LastVehicle[playerid] =GetPlayerVehicleID(playerid);
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new pveh =GetPlayerVehicleID(playerid);
		if(VehicleInfo[pveh][bought] >= 0 && VehicleInfo[pveh][bought] <= MAX_PLAYERS_)
		{
		    if(playerid == VehicleInfo[pveh][bought])
		    {
		        SendClientMessage(playerid,COLOR_LIME,"Welcome to your bought vehicle from Otto's Cars.");
		        return 1;
			}
			if(playerid != VehicleInfo[pveh][bought] && gTeam[playerid] != TEAM_CARJACK)
			{
			    format(string,sizeof(string),"This vehicle is owned by %s(%d). You cannot drive it as you don't own it.",PlayerName(VehicleInfo[pveh][bought]),VehicleInfo[pveh][bought]);
			    SendClientMessage(playerid,COLOR_ERROR,string);
			    RemovePlayerFromVehicle(playerid);
			    return 1;
			}
			if(playerid != VehicleInfo[pveh][bought] && gTeam[playerid] == TEAM_CARJACK)
			{
			    SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Vehicle Stolen_]]");
			    format(string,sizeof(string),"You have stolen %s(%d)'s purchased vehicle from Otto's Cars!",PlayerName(VehicleInfo[pveh][bought]),VehicleInfo[pveh][bought]);
			    SendClientMessage(playerid,COLOR_ERROR,string);
			    IncreaseWantedLevel(playerid,6);
			    IncreasePlayerScore(playerid,2);

				format(string,sizeof(string),"Car Jacker %s(%d) has stolen your purchased vehicle from Otto's Cars!",PlayerName(playerid),playerid);
				SendClientMessage(VehicleInfo[pveh][bought],COLOR_RED,string);
				
				format(string,sizeof(string),"[VEHICLE THEFT] Car Jacker %s(%d) has stolen %s(%d)'s purchased vehicle from Otto's Cars!",PlayerName(playerid),playerid,PlayerName(VehicleInfo[pveh][bought]),VehicleInfo[pveh][bought]);
				SendClientMessageToAll(COLOR_RED,string);
				
				format(string,sizeof(string),"[POLICE RADIO] Theft: Car Jacker %s(%d) has stolen %s(%d)'s purchased vehicle from Otto's Cars!",PlayerName(playerid),playerid,PlayerName(VehicleInfo[pveh][bought]),VehicleInfo[pveh][bought]);
			    SendClientMessageToAllCops(string);
			    
			    VehicleInfo[pveh][bought] =playerid;
			    VehicleInfo[pveh][stolen] =1;
			    return 1;
			}
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT)
	{
	    if(CIAIsBeingWatched[playerid] == 1)
	    {
	        for(new i=0; i<MAX_PLAYERS; i++)
	        {
	            if(CIAPlayerBeingViewed[i] == playerid)
	            {
	                new pveh =GetPlayerVehicleID(playerid);
	            	PlayerSpectateVehicle(i,pveh);
				}
			}
		}
		if(IsBeingSpectated[playerid] == 1)
		{
		    for(new i=0; i<MAX_PLAYERS; i++)
	        {
	            if(SpectatingPlayer[i] == playerid)
	            {
	                new pveh =GetPlayerVehicleID(playerid);
	            	PlayerSpectateVehicle(i,pveh);
				}
			}
		}
	}
	
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
	    if(CIAIsBeingWatched[playerid] == 1)
	    {
	        for(new i=0; i<MAX_PLAYERS; i++)
	        {
	            if(CIAPlayerBeingViewed[i] == playerid)
	            {
	            	PlayerSpectatePlayer(i,playerid);
				}
			}
		}
		if(IsBeingSpectated[playerid] == 1)
	    {
	        for(new i=0; i<MAX_PLAYERS; i++)
	        {
	            if(SpectatingPlayer[i] == playerid)
	            {
	            	PlayerSpectatePlayer(i,playerid);
				}
			}
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(GetPlayerVehicleID(playerid) == TaxiVehicle1 || GetPlayerVehicleID(playerid) == TaxiVehicle2 ||
	    GetPlayerVehicleID(playerid) == TaxiVehicle3 || GetPlayerVehicleID(playerid) == TaxiVehicle4 ||
	    GetPlayerVehicleID(playerid) == TaxiVehicle5 || GetPlayerVehicleID(playerid) == TaxiVehicle6 ||
	    GetPlayerVehicleID(playerid) == TaxiVehicle7 || GetPlayerVehicleID(playerid) == TaxiVehicle8 ||
	    GetPlayerVehicleID(playerid) == TaxiVehicle9 || GetPlayerVehicleID(playerid) == TaxiVehicle10 ||
        GetPlayerVehicleID(playerid) == TaxiVehicle11 || GetPlayerVehicleID(playerid) == TaxiVehicle12 ||
        GetPlayerVehicleID(playerid) == TaxiVehicle13 || GetPlayerVehicleID(playerid) == TaxiVehicle14)
        {
	        if(gTeam[playerid] == TEAM_DRIVER && GetPlayerWantedLevel(playerid) == 0)
	        {
	            SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Taxi Vehicle_]]");
	            SendClientMessage(playerid,COLOR_LIGHTBLUE,"Welcome to your Taxi Company vehicle.");
	            OnDuty[playerid] =1;

	            format(string,sizeof(string),"[TAXI DUTY] %s(%d) is now on taxi duty. Call them with /taxi to get picked up at your location.",PlayerName(playerid),playerid);
	            SendClientMessageToAll(COLOR_DARKOLIVEGREEN,string);

	            format(string,sizeof(string),"3[TAXI DUTY] %s(%d) is now on taxi duty. Call them with /taxi to get picked up at your location.",PlayerName(playerid),playerid);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				return 1;
			}
		}
	}
	
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
	    if(OnDuty[playerid] == 1)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You are now off duty. Enter a taxi vehicle again to go on duty.");
			OnDuty[playerid] =0;
			return 1;
		}
	}
	
	if(newstate == PLAYER_STATE_PASSENGER)
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
		    new pveh =GetPlayerVehicleID(playerid);
		    if(OnDuty[i] == 1)
		    {
		        if(GetPlayerVehicleID(i) == pveh)
		        {
		            if(HasTaxiFare[i] == 1)
			        {
			            SendClientMessage(playerid,COLOR_ERROR,"This taxi already has a fare, please find your own taxi.");
						RemovePlayerFromVehicle(playerid);
						return 1;
					}
					if(GetPlayerMoney(playerid) < SkillPrice[i])
					{
					    SendClientMessage(playerid,COLOR_ERROR,"You cannot afford to pay the fare of this taxi.");
						RemovePlayerFromVehicle(playerid);
						return 1;
					}
		            SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Entered Taxi_]]");
		            format(string,sizeof(string),"You are now paying %s(%d) $%d a minute to take you to your destination.",PlayerName(i),i,SkillPrice[i]);
		            SendClientMessage(playerid,COLOR_DARKOLIVEGREEN,string);
		            PayingTaxi[playerid] =1;
		            HasTaxiFare[i] =playerid;
		            
		            SendClientMessage(i,COLOR_DEADCONNECT,"[[_Fare Picked Up_]]");
					format(string,sizeof(string),"You have picked up %s(%d) and are charging them $%d a minute to take them to their destination.",PlayerName(playerid),playerid,SkillPrice[i]);
					SendClientMessage(i,COLOR_DARKOLIVEGREEN,string);
					return 1;
				}
			}
		}
	}
	
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    if(PayingTaxi[playerid] == 1)
	    {
	        PayingTaxi[playerid] =0;
	        SendClientMessage(playerid,COLOR_ERROR,"You have left your taxi and have stopped paying the fare.");
	        for(new i=0; i<MAX_PLAYERS; i++)
	        {
	            if(HasTaxiFare[i] == playerid)
	            {
	                HasTaxiFare[i] =-1;
	                SendClientMessage(i,COLOR_ERROR,"Your taxi fare has left your vehicle and has stopped paying your fare.");
	                return 1;
				}
			}
			return 1;
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(GetPlayerVehicleID(playerid) == PoliceCar1 || GetPlayerVehicleID(playerid) == PoliceCar2 ||
	    GetPlayerVehicleID(playerid) == PoliceCar3 || GetPlayerVehicleID(playerid) == PoliceCar4 ||
	    GetPlayerVehicleID(playerid) == PoliceCar5 || GetPlayerVehicleID(playerid) == PoliceCar6 ||
	    GetPlayerVehicleID(playerid) == PoliceCar7 || GetPlayerVehicleID(playerid) == PoliceCar8 ||
	    GetPlayerVehicleID(playerid) == PoliceCar9 || GetPlayerVehicleID(playerid) == PoliceCar10 ||
        GetPlayerVehicleID(playerid) == PoliceCar11 || GetPlayerVehicleID(playerid) == PoliceCar12 ||
        GetPlayerVehicleID(playerid) == PoliceCar14 ||
        GetPlayerVehicleID(playerid) == PoliceCar15 || GetPlayerVehicleID(playerid) == PoliceCar16 ||
        GetPlayerVehicleID(playerid) == PoliceCar17 || GetPlayerVehicleID(playerid) == PoliceCar18 ||
        GetPlayerVehicleID(playerid) == PoliceCar19 || GetPlayerVehicleID(playerid) == PoliceCar20 ||
        GetPlayerVehicleID(playerid) == PoliceCar21 || GetPlayerVehicleID(playerid) == PoliceCar22 ||
        GetPlayerVehicleID(playerid) == PoliceCar23 || GetPlayerVehicleID(playerid) == PoliceCar24 ||
        GetPlayerVehicleID(playerid) == PoliceCar25 || GetPlayerVehicleID(playerid) == PoliceCar26 ||
        GetPlayerVehicleID(playerid) == PoliceCar27 || GetPlayerVehicleID(playerid) == PoliceCar28 ||
        GetPlayerVehicleID(playerid) == PoliceCar29 || GetPlayerVehicleID(playerid) == PoliceCar30 ||
        GetPlayerVehicleID(playerid) == PoliceCar31 || GetPlayerVehicleID(playerid) == PoliceCar32 ||
        GetPlayerVehicleID(playerid) == PoliceCar33 || GetPlayerVehicleID(playerid) == PoliceCar34 ||
		GetPlayerVehicleID(playerid) == PoliceCar35 || GetPlayerVehicleID(playerid) == PoliceCar36 ||
		GetPlayerVehicleID(playerid) == PoliceCar37 || GetPlayerVehicleID(playerid) == PoliceCar38 ||
		GetPlayerVehicleID(playerid) == PoliceCar39 || GetPlayerVehicleID(playerid) == PoliceCar40 ||
		GetPlayerVehicleID(playerid) == PoliceCar41 || GetPlayerVehicleID(playerid) == PoliceCar42 ||
		GetPlayerVehicleID(playerid) == PoliceCar43 || GetPlayerVehicleID(playerid) == PoliceCar44 ||
		GetPlayerVehicleID(playerid) == PoliceCar45 || GetPlayerVehicleID(playerid) == PoliceCar46 ||
		GetPlayerVehicleID(playerid) == PoliceCar47)
        {
		    if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA && gTeam[playerid] != TEAM_MEDIC)
		    {
		        new current_zone;
		        current_zone = player_zone[playerid];
		        SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Law Enforcement Vehicle Theft_]]");
		        SendClientMessage(playerid,COLOR_RED,"You have stolen a Law Enforcement Vehicle. The police has been informed, watch out ..");
		        IncreaseWantedLevel(playerid,4);

		        format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has stolen a Law Enforcement Vehicle. Location: %s",pname,playerid,zones[current_zone][zone_name]);
		        SendClientMessageToAllCops(string);
		        return 1;
			}
			SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Police Vehicle_]]");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Welcome to your Police Personnel vehicle.");
			return 1;
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(GetPlayerVehicleID(playerid) == MedicVehicle1 || GetPlayerVehicleID(playerid) == MedicVehicle2 ||
	    GetPlayerVehicleID(playerid) == MedicVehicle3 || GetPlayerVehicleID(playerid) == MedicVehicle4 ||
	    GetPlayerVehicleID(playerid) == MedicVehicle5 || GetPlayerVehicleID(playerid) == MedicVehicle6 ||
	    GetPlayerVehicleID(playerid) == MedicVehicle7 || GetPlayerVehicleID(playerid) == MedicVehicle8 ||
	    GetPlayerVehicleID(playerid) == MedicVehicle9 || GetPlayerVehicleID(playerid) == MedicVehicle10)
        {
		    if(gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY && gTeam[playerid] != TEAM_CIA && gTeam[playerid] != TEAM_MEDIC)
		    {
		        new current_zone;
		        current_zone = player_zone[playerid];
		        SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Medic Vehicle Theft_]]");
		        SendClientMessage(playerid,COLOR_RED,"You have stolen a Medic Vehicle. The police has been informed, watch out ..");
		        IncreaseWantedLevel(playerid,4);

		        format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has stolen a Medic Vehicle. Location: %s",pname,playerid,zones[current_zone][zone_name]);
		        SendClientMessageToAllCops(string);
		        return 1;
			}
			SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Medic Vehicle_]]");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Welcome to your Medic Personnel vehicle.");
			return 1;
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(GetPlayerVehicleID(playerid) == ArmyVehicle0 || GetPlayerVehicleID(playerid) == ArmyVehicle1 ||
	    GetPlayerVehicleID(playerid) == ArmyVehicle2 || GetPlayerVehicleID(playerid) == ArmyVehicle3 ||
	    GetPlayerVehicleID(playerid) == ArmyVehicle4 || GetPlayerVehicleID(playerid) == ArmyVehicle5 ||
	    GetPlayerVehicleID(playerid) == ArmyVehicle6 || GetPlayerVehicleID(playerid) == ArmyVehicle7 ||
	    GetPlayerVehicleID(playerid) == ArmyVehicle8 || GetPlayerVehicleID(playerid) == ArmyVehicle9 ||
        GetPlayerVehicleID(playerid) == ArmyVehicle10 || GetPlayerVehicleID(playerid) == ArmyVehicle11 ||
        GetPlayerVehicleID(playerid) == ArmyVehicle12 || GetPlayerVehicleID(playerid) == ArmyVehicle13 ||
        GetPlayerVehicleID(playerid) == ArmyVehicle14 || GetPlayerVehicleID(playerid) == ArmyVehicle15 ||
        GetPlayerVehicleID(playerid) == ArmyVehicle16 || GetPlayerVehicleID(playerid) == ArmyVehicle17 ||
        GetPlayerVehicleID(playerid) == ArmyVehicle18 || GetPlayerVehicleID(playerid) == ArmyVehicle19 ||
        GetPlayerVehicleID(playerid) == ArmyVehicle20 || GetPlayerVehicleID(playerid) == ArmyVehicle21 ||
		GetPlayerVehicleID(playerid) == ArmyVehicle22)
        {
		    if(gTeam[playerid] != TEAM_ARMY)
		    {
				SendClientMessage(playerid,COLOR_ERROR,"Only Army Personnel can use the Army vehicles.");
				RemovePlayerFromVehicle(playerid);
		        return 1;
			}
			SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_Army Vehicle_]]");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Welcome to your Army Personnel vehicle.");
			return 1;
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(GetPlayerVehicleID(playerid) == CIAVehicle1 || GetPlayerVehicleID(playerid) == CIAVehicle2 ||
	    GetPlayerVehicleID(playerid) == CIAVehicle3 || GetPlayerVehicleID(playerid) == CIAVehicle4 ||
	    GetPlayerVehicleID(playerid) == CIAVehicle5 || GetPlayerVehicleID(playerid) == CIAVehicle6 ||
	    GetPlayerVehicleID(playerid) == CIAVehicle7 || GetPlayerVehicleID(playerid) == CIAVehicle8 ||
	    GetPlayerVehicleID(playerid) == CIAVehicle9 || GetPlayerVehicleID(playerid) == CIAVehicle10 ||
        GetPlayerVehicleID(playerid) == CIAVehicle11 || GetPlayerVehicleID(playerid) == CIAVehicle12 ||
		GetPlayerVehicleID(playerid) == CIAVehicle13 || GetPlayerVehicleID(playerid) == CIAVehicle14 ||
		GetPlayerVehicleID(playerid) == CIAVehicle15 || GetPlayerVehicleID(playerid) == CIAVehicle16 ||
		GetPlayerVehicleID(playerid) == CIAVehicle17 || GetPlayerVehicleID(playerid) == CIAVehicle18 ||
		GetPlayerVehicleID(playerid) == CIAVehicle19)
        {
		    if(gTeam[playerid] != TEAM_CIA)
		    {
				SendClientMessage(playerid,COLOR_ERROR,"Only CIA Personnel can use the CIA vehicles.");
				RemovePlayerFromVehicle(playerid);
		        return 1;
			}
			SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_CIA Vehicle_]]");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Welcome to your CIA Personnel vehicle.");
			return 1;
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(GetPlayerVehicleID(playerid) == FBIVehicle1 || GetPlayerVehicleID(playerid) == FBIVehicle2 ||
	    GetPlayerVehicleID(playerid) == FBIVehicle3 || GetPlayerVehicleID(playerid) == FBIVehicle4 ||
	    GetPlayerVehicleID(playerid) == FBIVehicle5 || GetPlayerVehicleID(playerid) == FBIVehicle6 ||
	    GetPlayerVehicleID(playerid) == FBIVehicle7 || GetPlayerVehicleID(playerid) == FBIVehicle8 ||
	    GetPlayerVehicleID(playerid) == FBIVehicle9 || GetPlayerVehicleID(playerid) == FBIVehicle10 ||
        GetPlayerVehicleID(playerid) == FBIVehicle11 || GetPlayerVehicleID(playerid) == FBIVehicle12 ||
		GetPlayerVehicleID(playerid) == FBIVehicle13 || GetPlayerVehicleID(playerid) == FBIVehicle14 ||
		GetPlayerVehicleID(playerid) == FBIVehicle15 || GetPlayerVehicleID(playerid) == FBIVehicle16 ||
		GetPlayerVehicleID(playerid) == FBIVehicle17)
        {
		    if(GetPlayerSkin(playerid) != 286)
		    {
				SendClientMessage(playerid,COLOR_ERROR,"Only FBI Personnel can use the FBI vehicles.");
				RemovePlayerFromVehicle(playerid);
		        return 1;
			}
			SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_FBI Vehicle_]]");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Welcome to your FBI Personnel vehicle.");
			return 1;
		}
	}
	    
	return 1;
}

//==============================================================================

public OnPlayerEnterCheckpoint(playerid)
{
	if(getCheckpointType(playerid) == CP_SFPDEnt)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,10);
	    SetPlayerPos(playerid,246.8460,114.5714,1003.2188);
		SetPlayerFacingAngle(playerid,359.8049);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_SFPDExit)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,-1604.8246,718.6995,11.8512);
	    SetPlayerFacingAngle(playerid,7.1270);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_DropOff)
	{
	    SendClientMessage(playerid,COLOR_WHITE,"This is where Law Enforcement Officers drop criminals off to prison.");
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_BankEnt)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,2310.9771,-14.8475,26.7422);
	    SetPlayerFacingAngle(playerid,271.5594);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_BankExit)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,-1499.4198,919.6614,7.1875);
	    SetPlayerFacingAngle(playerid,89.8244);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_BankMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    ShowPlayerDialog(playerid,DIALOG_BANK_LIST,DIALOG_STYLE_LIST,"Bank Options","Withdraw Money\nDeposit Money\nCheck Balance\nTransfer Funds","Select","Cancel");
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CIAEnt)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		if(gTeam[playerid] != TEAM_CIA)
		{
			SendClientMessage(playerid,COLOR_ERROR,"Only CIA Personnel can enter this building. If your a terrorist you can use /blowup to blow up this building.");
			return 1;
		}
		if(CIABuildingBlown >= 1)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"The CIA building has been blown up, you must wait for it to be rebuilt before entering it.");
		    return 1;
		}
	    SetPlayerInterior(playerid,3);
	    SetPlayerPos(playerid,288.1016,175.0982,1007.1794);
	    SetPlayerFacingAngle(playerid,354.5702);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CIAExit || getCheckpointType(playerid) == CP_CIAExit2)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,-1232.2139,739.2380,6.6299);
	    SetPlayerFacingAngle(playerid,81.8141);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CIASat)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		if(CIASatBlown >= 1)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"The CIA satelite has been blown up, you must wait for it to be rebuilt before using it.");
		    return 1;
		}
	    ShowPlayerDialog(playerid,DIALOG_CIASAT,DIALOG_STYLE_INPUT,"{FFFF00}CIA Satelite","{FFFFFF}Please enter the Player ID you wish to view","Ok","Cancel");
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_FBIEnt)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,6);
	    SetPlayerPos(playerid,246.783996,67.900199,1003.640625);
	    SetPlayerFacingAngle(playerid,354.5702);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_FBIExit)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,-1759.7393,961.4783,24.8828);
	    SetPlayerFacingAngle(playerid,178.4752);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_SupaSaveEnt)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,10);
	    SetPlayerPos(playerid,6.0945,-24.1830,1003.5494);
	    SetPlayerFacingAngle(playerid,358.1200);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_SupaSaveExit)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,-2445.4060,749.0485,35.1719);
	    SetPlayerFacingAngle(playerid,181.7117);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_SupaSaveMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_LIST,"{FF0000}Supa Save Menu","{FFFFFF}Rope(5x) ($10000)\nScissors(1x) ($5000)\nSausage Rolls(5x) ($15000)\nAnti STI(1x) ($20000)\nSecure Wallet(1x) ($5000)\nNeedle and Syringe(1x) ($5000)\n{FF0000}Attempt Robbery","Ok","Cancel");
	    return 1;
	}
	if(getCheckpointType(playerid) == CP_DrugHouseCaltonHeights || getCheckpointType(playerid) == CP_DrugHouseOceanFlats || getCheckpointType(playerid) == CP_DrugHouseParadiso || getCheckpointType(playerid) == CP_DrugHouseJuniperHollow)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || gTeam[playerid] == TEAM_MEDIC)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"Dude, i do not sell anything here, why you at my back door?");
		    return 1;
		}
	    ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_LIST,"{FF0000}Drug House Menu","Weed - 100g ($20000)\nWeed - 500g($80000)\nWeed - 1000g ($150000)\nWeed - 5000g ($500000)\nHeroin - 5 Injections ($10000)\nHeroin - 20 Injections ($30000)\nHeroin - 50 Injections ($80000)\nHeroin - 200 Injections ($250000)\n{FF0000}Attempt Robbery","Ok","Cancel");
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_ShipYard)
	{
	    SendClientMessage(playerid,COLOR_WHITE,"Welcome to the Shipyard. This is where you can sell stolen vehicles when carjacker.");
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_OttoCP)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		ShowPlayerDialog(playerid,DIALOG_OTTO,DIALOG_STYLE_LIST,"{FF0000}Otto's Car Menu","{FFFFFF}Infernus ($120000)\nTurismo ($120000)\nHotring Racer ($200000)\nSuper GT ($150000)\nSultan ($50000)\nStretch ($80000)\nElegy ($60000)\nElegant ($40000)\nBullet ($100000)\nBuffalo ($50000)\nJester ($90000)\nClub ($40000)\n{FF0000}Attempt Robbery","Ok","Cancel");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_BombShop)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		if(gTeam[playerid] < 9)
		{
		    SendClientMessage(playerid,COLOR_ERROR,"We do not sell anything here ..");
		    return 1;
		}
		ShowPlayerDialog(playerid,DIALOG_BOMBSHOP,DIALOG_STYLE_LIST,"{FF0000}Bomb Shop Menu","{FFFFFF}C4 (1x - $5000)\nC4 (5x - $20000)\nC4 (20x - $80000)","Ok","Cancel");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CIASatBlow)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"This satelite is used by the CIA to watch players. Terrorists can blow it up with /blowup.");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CIABridge)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"This bridge is used by the CIA to get to their Headquarters. Terrorists can blow it up with /blowup.");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_BurgerShotMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the Burger Shot.");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CluckinBellMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the Cluckin Bell.");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_Ammunation)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the Ammunation.");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_GayDarMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Gay Dar Station.");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_ZeroMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Zero's");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_MistysMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Misty's");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_GYM)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the GYM");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_School)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the Driving School");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_WangCars)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Wang Cars");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_Train)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the Train Station");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_Barbers)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the Barbers");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_Hospital)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		ShowPlayerDialog(playerid,DIALOG_HOSPITAL,DIALOG_STYLE_LIST,"Hospital Menu","{FFFFFF}Heal ($5000)\nCure ($5000)\nHeal and Cure ($10000)\n{FF0000}Attempt Robbery","Ok","Cancel");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CityHallEnt)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,3);
	    SetPlayerPos(playerid,381.7616,173.7224,1008.3828);
	    SetPlayerFacingAngle(playerid,89.1092);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_CityHallExit)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SetPlayerInterior(playerid,0);
	    SetPlayerPos(playerid,-2744.8018,376.0189,4.3648);
	    SetPlayerFacingAngle(playerid,89.1092);
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
    if(getCheckpointType(playerid) == CP_CityHallMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
	    SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob the City Hall");
	    return 1;
	}
	
	if(getCheckpointType(playerid) == CP_Jizzys)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Jizzy's Nightclub");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_PizzaMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Well Stacked Pizza");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_ZipMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Zip");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_VictimMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Victim");
		return 1;
	}
	
	if(getCheckpointType(playerid) == CP_BincoMain)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must exit your vehicle before entering a checkpoint.");
	        return 1;
		}
		SendClientMessage(playerid,COLOR_ERROR,"Type /robstore to rob Binco");
		return 1;
	}
	return 1;
}

//==============================================================================

public OnPlayerLeaveCheckpoint(playerid)
{
	if(getCheckpointType(playerid) == CP_SupaSaveMain)
	{
	    if(RobbingSupaSave[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Supa Save robbery attempt failed. You left the checkpoint ..");
		    RobbingSupaSave[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Hospital)
	{
	    if(RobbingHospital[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Hospital robbery attempt failed. You left the checkpoint ..");
		    RobbingHospital[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_ZipMain)
	{
	    if(RobbingDownZip[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Zip robbery attempt failed. You left the checkpoint ..");
		    RobbingDownZip[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_BincoMain)
	{
	    if(RobbingJHBinco[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Binco robbery attempt failed. You left the checkpoint ..");
		    RobbingJHBinco[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_CityHallMain)
	{
	    if(RobbingCityHall[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"City Hall robbery attempt failed. You left the checkpoint ..");
		    RobbingCityHall[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_VictimMain)
	{
	    if(RobbingDownVictim[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Victim robbery attempt failed. You left the checkpoint ..");
		    RobbingDownVictim[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Jizzys)
	{
	    if(RobbingJizzys[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Jizzy's robbery attempt failed. You left the checkpoint ..");
		    RobbingJizzys[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_BurgerShotMain)
	{
	    if(RobbingGarciaBurgerShot[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Burger Shot robbery attempt failed. You left the checkpoint ..");
		    RobbingGarciaBurgerShot[playerid] =0;
		    return 1;
		}
		if(RobbingDownBurgerShot[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Burger Shot robbery attempt failed. You left the checkpoint ..");
		    RobbingDownBurgerShot[playerid] =0;
		    return 1;
		}
		if(RobbingJHBurgerShot[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Burger Shot robbery attempt failed. You left the checkpoint ..");
		    RobbingJHBurgerShot[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_PizzaMain)
	{
	    if(RobbingEsplanadePizza[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Well Stacked Pizza robbery attempt failed. You left the checkpoint ..");
		    RobbingEsplanadePizza[playerid] =0;
		    return 1;
		}
		if(RobbingFinancialPizza[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Well Stacked Pizza robbery attempt failed. You left the checkpoint ..");
		    RobbingFinancialPizza[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_CluckinBellMain)
	{
	    if(RobbingOceanCluckinBell[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Cluckin Bell robbery attempt failed. You left the checkpoint ..");
		    RobbingOceanCluckinBell[playerid] =0;
		    return 1;
		}
		if(RobbingDownCluckinBell[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Cluckin Bell robbery attempt failed. You left the checkpoint ..");
		    RobbingDownCluckinBell[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Ammunation)
	{
	    if(RobbingAmmunation[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Ammunation robbery attempt failed. You left the checkpoint ..");
		    RobbingAmmunation[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_GayDarMain)
	{
	    if(RobbingGayDar[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Gay Dar Station robbery attempt failed. You left the checkpoint ..");
		    RobbingGayDar[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_ZeroMain)
	{
	    if(RobbingZero[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Zero's robbery attempt failed. You left the checkpoint ..");
		    RobbingZero[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_MistysMain)
	{
	    if(RobbingMistys[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Misty's robbery attempt failed. You left the checkpoint ..");
		    RobbingMistys[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_GYM)
	{
	    if(RobbingGYM[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"GYM robbery attempt failed. You left the checkpoint ..");
		    RobbingGYM[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_School)
	{
	    if(RobbingSchool[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Driving School robbery attempt failed. You left the checkpoint ..");
		    RobbingSchool[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_WangCars)
	{
	    if(RobbingWang[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Wang Cars robbery attempt failed. You left the checkpoint ..");
		    RobbingWang[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Train)
	{
	    if(RobbingTrain[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Train Station robbery attempt failed. You left the checkpoint ..");
		    RobbingTrain[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_Barbers)
	{
	    if(RobbingBarbers[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Barbers robbery attempt failed. You left the checkpoint ..");
		    RobbingBarbers[playerid] =0;
		    return 1;
		}
		return 1;
	}
	if(getCheckpointType(playerid) == CP_DrugHouseCaltonHeights || getCheckpointType(playerid) == CP_DrugHouseOceanFlats || getCheckpointType(playerid) == CP_DrugHouseParadiso || getCheckpointType(playerid) == CP_DrugHouseJuniperHollow)
	{
	    if(RobbingDrugHouse[playerid] >= 1)
	    {
		    SendClientMessage(playerid,COLOR_ERROR,"Drug House robbery attempt failed. You left the checkpoint ..");
		    RobbingDrugHouse[playerid] =0;
		    return 1;
		}
		return 1;
	}
	return 1;
}

//==============================================================================

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

//==============================================================================

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

//==============================================================================

public OnRconCommand(cmd[])
{
	return 1;
}

//==============================================================================

public OnPlayerRequestSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
    if (!udb_Exists(PlayerName(playerid)))
	{
        ShowRegisterScreen(playerid);
		return 0;
	}
	if (!PLAYERLIST_authed[playerid]) {
		ShowLoginScreen(playerid);
		return 0;
	}
	if(gTeam[playerid] < 9 && SavedWantedLevel[playerid] != 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this class as you were wanted last time you left the server.");
	    return 0;
	}
	if(gTeam[playerid] < 9 && SavedJailTime[playerid] != 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You cannot use this class as you were in jail last time you left the server.");
	    return 0;
	}
	if(gTeam[playerid] == TEAM_ARMY && CanUseArmy[playerid] != 1337)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have permission to use this class. You can apply for it on our forums.");
		return 0;
	}
	if(gTeam[playerid] == TEAM_CIA && CanUseCIA[playerid] != 1337)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have permission to use this class. You can apply for it on our forums.");
		return 0;
	}
	if(GetPlayerSkin(playerid) == 286 && GetPlayerScore(playerid) <= 499)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have permission to use this class. You must gain 500 score before using this class.");
		return 0;
	}
	if(gTeam[playerid] == TEAM_COP && GetPlayerScore(playerid) <= 49)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You do not have permission to use this class. You must gain 50 score before using this class.");
		return 0;
	}
	return 1;
}

//==============================================================================

public OnObjectMoved(objectid)
{
	return 1;
}

//==============================================================================

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

//==============================================================================

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == FBIInsidePickup || pickupid == FBIRoofPickup || pickupid == FBIGaragePickup)
	{
		SendClientMessage(playerid,COLOR_DODGERBLUE,"To use the FBI Elevator use /liftup and /liftdown");
		return 1;
	}
	return 1;
}

//==============================================================================

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

//==============================================================================

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

//==============================================================================

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

//==============================================================================

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if(Current == SkillMenu)
	{
		TogglePlayerControllable(playerid, 1);
		switch(row)
		{
			case 0:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}RAPIST INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Rapist commands.\n{FFFFFF}Job: Your job is to rape players and infect them with STI's such as Chlamydia.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,22,100);
			    GivePlayerWeapon(playerid,4,1);
		        gTeam[playerid] = TEAM_RAPIST;
		        SetPlayerToTeamColour(playerid);
		        CanChooseSkill[playerid] =0;
			}
			case 1:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}DRUG DEALER INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Drug Dealer commands.\n{FFFFFF}Job: To supply other players with drugs. Make sure they pay up!\n{FFFFFF}Respond to players when they call for you with the /drugdealer command.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
			   	GivePlayerWeapon(playerid,22,50);
		       	GivePlayerWeapon(playerid,28,100);
		       	GivePlayerWeapon(playerid,5,1);
	           	gTeam[playerid] = TEAM_DRGDEL;
	           	SetPlayerToTeamColour(playerid);
	           	HasWeed[playerid] =50;
	           	HasHeroin[playerid] =3;
	           	CanChooseSkill[playerid] =0;
			}
			case 2:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}GUN DEALER INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Gun Dealer commands.\n{FFFFFF}Job: To sell weapons to other players. Make sure the pay up!\n{FFFFFF}Respond to players when they call for you with the /gundealer command.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,30,500);
		        GivePlayerWeapon(playerid,32,150);
	            gTeam[playerid] = TEAM_GUNDEL;
	            SetPlayerToTeamColour(playerid);
				CanChooseSkill[playerid] =0;
			}
			case 3:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}HITMAN INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Hitman commands.\n{FFFFFF}Job: To kill players that appear on the /hitlist. Do not kill people unless they are on this list.\n{FFFFFF}Respond to the /hitlist whenever players place a hit on someone using /placehit.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,27,250);
		        GivePlayerWeapon(playerid,23,100);
		        GivePlayerWeapon(playerid,31,500);
	            gTeam[playerid] = TEAM_HITMAN;
	            SetPlayerToTeamColour(playerid);
	            CanChooseSkill[playerid] =0;
       		}
			case 4:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}CAR JACKER INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Car Jacker commands.\n{FFFFFF}Job: You can steal vehicles that people are driving or have bought and sell them to the Shipyard.\n{FFFFFF}Search around San Fierro for cars that you can steal, you can then take these cars to the Shipyard for money.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,6,1);
               	GivePlayerWeapon(playerid,24,200);
               	GivePlayerWeapon(playerid,28,300);
               	gTeam[playerid] = TEAM_CARJACK;
               	SetPlayerToTeamColour(playerid);
               	CanChooseSkill[playerid] =0;
       		}
			case 5:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}KIDNAPPER INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Kidnapper commands.\n{FFFFFF}Job: You can kidnap people using the /kidnap command, infect them with STD's and do watever you want with them.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,27,250);
               	GivePlayerWeapon(playerid,23,100);
               	GivePlayerWeapon(playerid,30,500);
               	gTeam[playerid] = TEAM_KIDNAP;
               	SetPlayerToTeamColour(playerid);
               	CanChooseSkill[playerid] =0;
            }
			case 6:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}THIEF INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Thief commands.\n{FFFFFF}Job: To rob as many places and people as you can to make money.\n{FFFFFF}Use /robskill to see your robbing level and see what you can rob.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,30,500);
               	GivePlayerWeapon(playerid,23,70);
               	GivePlayerWeapon(playerid,2,1);
               	gTeam[playerid] = TEAM_THIEF;
               	SetPlayerToTeamColour(playerid);
               	CanChooseSkill[playerid] =0;
       		}
			case 7:
			{
                ShowPlayerDialog(playerid,DIALOG_SKILLINFO,DIALOG_STYLE_MSGBOX,"{4169FF}TERRORIST INFORMATION:","{FFFFFF}Commands: Type /commands for a list of Terrorist commands.\n{FFFFFF}Job: To blow things up in San Fierro.\n{FFFFFF}You can buy C4 from the bomb shop to use in your terrorism.\n{FFFFFF}Use /tskill to see your terrorism level and what you can blow up.\n{FFFFFF}Please remember to abide by the server /rules, or you may be banned.","Ok","Cancel");
				GivePlayerWeapon(playerid,30,500);
               	GivePlayerWeapon(playerid,34,60);
               	GivePlayerWeapon(playerid,23,150);
               	gTeam[playerid] = TEAM_TERRO;
               	SetPlayerToTeamColour(playerid);
               	CanChooseSkill[playerid] =0;
      		}
		}
	}
	return 1;
}

//==============================================================================

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid,1);
	return 1;
}

//==============================================================================

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

//==============================================================================

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new string[128];
    if(newkeys == KEY_LOOK_BEHIND) //Starting / Stoping vehicle engine
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
			new engine,lights,alarm,doors,bonnet,boot,objective;
			new vid = GetPlayerVehicleID(playerid);
		    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
			if(engine == VEHICLE_PARAMS_ON && !IsAPlane(vid) && !IsACycleBike(vid))
			{
			    SpamStrings[playerid] +=2;
			    if(SpamStrings[playerid] >= MAX_SPAM)
				{
				    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before trying to turn on/off the engine again.");
				    return 0;
			    }
				SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(GetDistanceBetweenPlayers(playerid,i) < 10)
				    {
				        format(string,sizeof(string),"%s(%d) spins the vehicle's engine key and turns off the engine.",PlayerName(playerid),playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
					}
				}
				return 1;
			}
			if(engine != VEHICLE_PARAMS_ON && !IsAPlane(vid) && !IsACycleBike(vid))
			{
			    SpamStrings[playerid] +=2;
			    if(SpamStrings[playerid] >= MAX_SPAM)
				{
				    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before trying to turn on/off the engine again.");
				    return 0;
			    }
				SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(GetDistanceBetweenPlayers(playerid,i) < 10)
				    {
						format(string,sizeof(string),"%s(%d) spins the vehicle's engine key and turns on the engine.",PlayerName(playerid),playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
					}
				}
				return 1;
			}
		}
		return 1;
	}
	
	
    if(newkeys & KEY_SECONDARY_ATTACK && PlayerToPoint(1.0, playerid, -1619.1694,689.5911,7.1875)) //SFPD Shutter Inside
	{
		if(gTeam[playerid] != TEAM_CIA && gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY)
		{
			SendClientMessage(playerid,COLOR_ERROR,"Access Denied");
			return 1;
		}
		SpamStrings[playerid] +=2;
	    if(SpamStrings[playerid] >= MAX_SPAM)
		{
		    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before opening/closing again.");
		    return 0;
	    }
		SetPlayerPos(playerid, -1619.1694,689.5911,7.1875);
		SetPlayerFacingAngle(playerid, 269.9927);
		LoopingAnim(playerid, "HEIST9", "Use_SwipeCard", 3.0, 0, 0, 0, 0, 0);
		if(SFPDShutterOpen == 0)
		{
			MoveObject(SFPDShutter, -1620.61669922,688.17712402,12.80728531, 4);
			SendClientMessage(playerid, COLOR_DODGERBLUE, "Access Granted");
			SFPDShutterOpen =1;
			return 1;
		}
		if(SFPDShutterOpen == 1)
		{
			MoveObject(SFPDShutter, -1620.61669922,688.17712402,7.80728531, 4);
			SFPDShutterOpen =0;
			return 1;
		}
		return 1;
	}

	if(newkeys & KEY_SECONDARY_ATTACK && PlayerToPoint(1.0, playerid, -1622.1335,687.1992,7.1875)) //SFPD Shutter Outside
	{
		if(gTeam[playerid] != TEAM_CIA && gTeam[playerid] != TEAM_COP && gTeam[playerid] != TEAM_ARMY)
		{
			SendClientMessage(playerid,COLOR_ERROR,"Access Denied");
			return 1;
		}
		SpamStrings[playerid] +=2;
	    if(SpamStrings[playerid] >= MAX_SPAM)
		{
		    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before opening/closing again.");
		    return 0;
	    }
		SetPlayerPos(playerid, -1622.1335,687.1992,7.1875);
		SetPlayerFacingAngle(playerid, 0.2336);
		LoopingAnim(playerid, "HEIST9", "Use_SwipeCard", 3.0, 0, 0, 0, 0, 0);
		if(SFPDShutterOpen == 0)
		{
			MoveObject(SFPDShutter, -1620.61669922,688.17712402,12.80728531, 4);
			SendClientMessage(playerid, COLOR_DODGERBLUE, "Access Granted");
			SFPDShutterOpen =1;
			return 1;
		}
		if(SFPDShutterOpen == 1)
		{
			MoveObject(SFPDShutter, -1620.61669922,688.17712402,7.80728531, 4);
			SFPDShutterOpen =0;
			return 1;
		}
		return 1;
	}
	
	if(newkeys & KEY_SECONDARY_ATTACK && PlayerToPoint(1.0, playerid, 245.3787,73.5715,1003.6406)) //FBI Shutter Inside
	{
		if(GetPlayerSkin(playerid) != 286)
		{
			SendClientMessage(playerid,COLOR_ERROR,"Access Denied");
			return 1;
		}
		SpamStrings[playerid] +=2;
	    if(SpamStrings[playerid] >= MAX_SPAM)
		{
		    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before opening/closing again.");
		    return 0;
	    }
		SetPlayerPos(playerid, 245.3787,73.5715,1003.6406);
		SetPlayerFacingAngle(playerid, 91.2136);
		LoopingAnim(playerid, "HEIST9", "Use_SwipeCard", 3.0, 0, 0, 0, 0, 0);
		if(FBIShutterOpen == 0)
		{
			MoveObject(FBIShutter, 246.42794800,72.70855713,1009.26043701, 3);
			SendClientMessage(playerid, COLOR_DODGERBLUE, "Access Granted");
			FBIShutterOpen =1;
			return 1;
		}
		if(FBIShutterOpen == 1)
		{
			MoveObject(FBIShutter, 246.42794800,72.70855713,1004.26043701, 3);
			FBIShutterOpen =0;
			return 1;
		}
		return 1;
	}

	if(newkeys & KEY_SECONDARY_ATTACK && PlayerToPoint(1.0, playerid, 247.7420,71.6222,1003.6406)) //FBI Shutter Outside
	{
		if(GetPlayerSkin(playerid) != 286)
		{
			SendClientMessage(playerid,COLOR_ERROR,"Access Denied");
			return 1;
		}
		SpamStrings[playerid] +=2;
	    if(SpamStrings[playerid] >= MAX_SPAM)
		{
		    SendClientMessage(playerid, COLOR_ERROR, "Please do not spam. Please wait before opening/closing again.");
		    return 0;
	    }
		SetPlayerPos(playerid, 247.7420,71.6222,1003.6406);
		SetPlayerFacingAngle(playerid, 3.7928);
		LoopingAnim(playerid, "HEIST9", "Use_SwipeCard", 3.0, 0, 0, 0, 0, 0);
		if(FBIShutterOpen == 0)
		{
			MoveObject(FBIShutter, 246.42794800,72.70855713,1009.26043701, 3);
			SendClientMessage(playerid, COLOR_DODGERBLUE, "Access Granted");
			FBIShutterOpen =1;
			return 1;
		}
		if(FBIShutterOpen == 1)
		{
			MoveObject(FBIShutter, 246.42794800,72.70855713,1004.26043701, 3);
			FBIShutterOpen =0;
			return 1;
		}
		return 1;
	}
	return 1;
}

//==============================================================================

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

//==============================================================================

public OnPlayerUpdate(playerid)
{
	return 1;
}

//==============================================================================

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

//==============================================================================

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

//==============================================================================

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

//==============================================================================

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

//==============================================================================

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new pname[24];
	new string[128];
	GetPlayerName(playerid,pname,sizeof(pname));
	if(dialogid == DIALOG_SUPASAVE)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(GetPlayerMoney(playerid) < 10000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $10000 to buy Rope(5x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				HasRope[playerid] +=5;
				GivePlayerMoney(playerid,-10000);
				format(string,sizeof(string),"Supa Save Cashier: Hitler\nItem Bought: Rope(5x)\nTotal Cost: $10000\nCash Given: $10000\nChange: $0\nRopes in Inventory: %d",HasRope[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 1)
	        {
	            if(GetPlayerMoney(playerid) < 5000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $5000 to buy Scissors(1x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				HasScissors[playerid] +=1;
				GivePlayerMoney(playerid,-5000);
				format(string,sizeof(string),"Supa Save Cashier: Hitler\nItem Bought: Scissors(1x)\nTotal Cost: $5000\nCash Given: $5000\nChange: $0\nScissors in Inventory: %d",HasScissors[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 2)
	        {
	            if(GetPlayerMoney(playerid) < 15000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $15000 to buy Sausage Rolls(5x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				HasSausageRolls[playerid] +=5;
				GivePlayerMoney(playerid,-15000);
				format(string,sizeof(string),"Supa Save Cashier: Hitler\nItem Bought: Sausage Rolls(5x)\nTotal Cost: $15000\nCash Given: $15000\nChange: $0\nSausage Rolls in Inventory: %d",HasSausageRolls[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 3)
	        {
	            if(GetPlayerMoney(playerid) < 20000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $20000 to buy Anti STI(1x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				HasAntiSTI[playerid] +=1;
				GivePlayerMoney(playerid,-20000);
				format(string,sizeof(string),"Supa Save Cashier: Hitler\nItem Bought: Anti STI(1x)\nTotal Cost: $20000\nCash Given: $20000\nChange: $0\nAnti STI in Inventory: %d",HasAntiSTI[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 4)
	        {
	            if(GetPlayerMoney(playerid) < 5000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $5000 to buy a Secure Wallet(1x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				HasSecureWallet[playerid] +=1;
				GivePlayerMoney(playerid,-5000);
				format(string,sizeof(string),"Supa Save Cashier: Hitler\nItem Bought: Secure Wallet(1x)\nTotal Cost: $5000\nCash Given: $5000\nChange: $0\nSecure Wallets in Inventory: %d",HasSecureWallet[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 5)
	        {
	            if(GetPlayerMoney(playerid) < 5000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $5000 to buy a Needle and Syringe(1x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				if(HasNeedleAndSyringe[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You already have a needle and a syringe in your inventory, why on earth would you want another one?");
				    return 1;
				}
				HasNeedleAndSyringe[playerid] +=1;
				GivePlayerMoney(playerid,-5000);
				format(string,sizeof(string),"Supa Save Cashier: Hitler\nItem Bought: Needle and Syringe(1x)\nTotal Cost: $5000\nCash Given: $5000\nChange: $0\nNeedles and Syringes in Inventory: %d",HasNeedleAndSyringe[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 6)
	        {
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Supa Save menu.");
	                return 1;
				}
				if(IsCuffed[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob the Supa Save while cuffed, how could you manage that?");
				    return 1;
				}
				if(IsFrozen[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob the Supa Save while frozen by an administrator, how could you manage that?");
				    return 1;
				}
				if(getCheckpointType(playerid) != CP_SupaSaveMain)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You must be in the Supa Save main checkpoint in order to rob it.");
				    return 1;
				}
				if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || gTeam[playerid] == TEAM_MEDIC)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob things with your class/skill.");
				    return 1;
				}
				if(SupaSaveRobbedRecently >= 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"Supa Save has been robbed recently. Please wait before robbing it again.");
				    return 1;
				}
				SupaSaveRobbedRecently =300;
				RobbingSupaSave[playerid] =25;
				IncreaseWantedLevel(playerid,4);
				IncreasePlayerScore(playerid,1);
				format(string,sizeof(string),"Robbing Supa Save.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingSupaSave[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Robbery",string,"Ok","Cancel");

				format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob Supa Save! Get To Supa Save and arrest the suspect.",pname,playerid);
				SendClientMessageToAllCops(string);
				
				format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Supa Save ..",pname,playerid);
				SendClientMessageToAll(COLOR_RED,string);
				
				format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Supa Save ..",pname,playerid);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				return 1;
			}
			return 1;
		}
	}
	if(dialogid == DIALOG_INVENTORY)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(HasC4[playerid] == 0)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have any C4 to add to your inventory.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				HasC4[playerid] --;
				HasPackC4[playerid] ++;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have added a block of C4 to your inventory.");
				return 1;
			}
			if(listitem == 1)
	        {
	            if(HasRope[playerid] == 0)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have any Rope to add to your inventory.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				HasRope[playerid] --;
				HasPackRope[playerid] ++;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have added a rope to your inventory.");
				return 1;
			}
			if(listitem == 2)
	        {
	            if(GetPlayerMoney(playerid) == 0)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have any Money to add to your inventory.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				new total =HasPackMoney[playerid] + GetPlayerMoney(playerid);
				if(total > 2000000)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"Your backpack cannot hold more than $2 Million. Put some in the bank.");
				    return 1;
				}
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have added all the money in your pockets into your inventory.");
				HasPackMoney[playerid] +=GetPlayerMoney(playerid);
				GivePlayerMoney(playerid,-GetPlayerMoney(playerid));
				return 1;
			}
			if(listitem == 3)
	        {
	            if(HasPackC4[playerid] == 0)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have any C4 to remove from your inventory.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				HasC4[playerid] ++;
				HasPackC4[playerid] --;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have taken a block of C4 from your inventory.");
				return 1;
			}
			if(listitem == 4)
	        {
	            if(HasPackRope[playerid] == 0)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have any Rope to remove from your inventory.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				HasRope[playerid] ++;
				HasPackRope[playerid] --;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have taken a rope from your inventory.");
				return 1;
			}
			if(listitem == 5)
	        {
	            if(HasPackMoney[playerid] == 0)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have any Money to remove from your inventory.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				if(HasPackMoney[playerid] <= 150000)
				{
					SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have taken all the money in your inventory into your pockets.");
                    GivePlayerMoney(playerid,HasPackMoney[playerid]);
					HasPackMoney[playerid] -=HasPackMoney[playerid];
				}
				if(HasPackMoney[playerid] > 150000)
				{
					SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have taken $150,000 from your inventory into your pockets.");
					HasPackMoney[playerid] -=150000;
					GivePlayerMoney(playerid,150000);
				}
				return 1;
			}
			if(listitem == 6)
	        {
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use your Inventory.");
	                return 1;
				}
				format(string,sizeof(string),"Blocks of C4: %d.\nCoils of Rope: %d.\nAmount of Money: $%d.",HasPackC4[playerid],HasPackRope[playerid],HasPackMoney[playerid]);
				ShowPlayerDialog(playerid,DIALOG_INVENTORY,DIALOG_STYLE_MSGBOX,"{FF0000}Inventory List",string,"Ok","Cancel");
				return 1;
			}
			return 1;
		}
	}
	if(dialogid == DIALOG_HOSPITAL)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            new Float:phealth;
	            GetPlayerHealth(playerid,phealth);
	            if(GetPlayerMoney(playerid) < 5000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $5000 to get a heal from the Hospital.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Hospital menu.");
	                return 1;
				}
				if(phealth == 100)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You do not need to be healed. Your health is fine.");
				    return 1;
				}
				SetPlayerHealth(playerid,100);
				GivePlayerMoney(playerid,-5000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have been healed by the docters at the Hospital.");
				return 1;
			}
			if(listitem == 1)
	        {
	            if(GetPlayerMoney(playerid) < 5000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $5000 to get a cure from the Hospital.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Hospital menu.");
	                return 1;
				}
				if(HasSTI[playerid] == 0)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You do not have any infections. You do not need cured.");
				    return 1;
				}
				HasSTI[playerid] =0;
				GivePlayerMoney(playerid,-5000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have been cured by the docters at the Hospital.");
				return 1;
			}
			if(listitem == 2)
	        {
	            new Float:phealth;
	            GetPlayerHealth(playerid,phealth);
	            if(GetPlayerMoney(playerid) < 10000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $10000 to get a heal and cure from the Hospital.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Hospital menu.");
	                return 1;
				}
				if(phealth == 100 && HasSTI[playerid] == 0)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You do not need to be healed or cured. Your health is fine.");
				    return 1;
				}
				HasSTI[playerid] =0;
				SetPlayerHealth(playerid,100);
				GivePlayerMoney(playerid,-10000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have been healed and cured by the docters at the Hospital.");
				return 1;
			}
			if(listitem == 3)
	        {
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Hospital menu.");
	                return 1;
				}
				if(IsCuffed[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob the Hospital while cuffed, how could you manage that?");
				    return 1;
				}
				if(IsFrozen[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob the Hospital while frozen by an administrator, how could you manage that?");
				    return 1;
				}
				if(RobSkill[playerid] < 20)
				{
			    	SendClientMessage(playerid,COLOR_ERROR,"You must have a robbing skill level of 20 to rob the Hospital. Check /robskill to see what you can rob.");
			    	return 1;
				}
				if(getCheckpointType(playerid) != CP_Hospital)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You must be in the Hospital main checkpoint in order to rob it.");
				    return 1;
				}
				if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || gTeam[playerid] == TEAM_MEDIC)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob things with your class/skill.");
				    return 1;
				}
				if(HospitalRobbedRecently >= 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"The Hospital has been robbed recently. Please wait before robbing it again.");
				    return 1;
				}
				HospitalRobbedRecently =300;
				RobbingHospital[playerid] =25;
				IncreaseWantedLevel(playerid,4);
				IncreasePlayerScore(playerid,1);
				format(string,sizeof(string),"Robbing Hospital.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingHospital[playerid]);
				ShowPlayerDialog(playerid,DIALOG_HOSPITAL,DIALOG_STYLE_MSGBOX,"{FF0000}Hospital Robbery",string,"Ok","Cancel");

				format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Hospital! Get To the Hospital and arrest the suspect.",pname,playerid);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the Hospital ..",pname,playerid);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the Hospital ..",pname,playerid);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				return 1;
			}
			return 1;
		}
	}
	if(dialogid == DIALOG_BOMBSHOP)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(GetPlayerMoney(playerid) < 5000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $5000 to buy C4 (1x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Bomb Shop menu.");
	                return 1;
				}
				HasC4[playerid] ++;
				GivePlayerMoney(playerid,-5000);
				format(string,sizeof(string),"Bomb Dealer: Osama Bin Laden\nItem Bought: C4 (1x)\nTotal Cost: $5000\nCash Given: $5000\nChange: $0\nC4 in Inventory: %d",HasC4[playerid]);
				ShowPlayerDialog(playerid,DIALOG_BOMBSHOP,DIALOG_STYLE_MSGBOX,"{FF0000}Bomb Shop Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 1)
	        {
	            if(GetPlayerMoney(playerid) < 20000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $20000 to buy C4 (5x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Bomb Shop menu.");
	                return 1;
				}
				HasC4[playerid] +=5;
				GivePlayerMoney(playerid,-20000);
				format(string,sizeof(string),"Bomb Dealer: Osama Bin Laden\nItem Bought: C4 (5x)\nTotal Cost: $20000\nCash Given: $20000\nChange: $0\nC4 in Inventory: %d",HasC4[playerid]);
				ShowPlayerDialog(playerid,DIALOG_BOMBSHOP,DIALOG_STYLE_MSGBOX,"{FF0000}Bomb Shop Receipt",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 2)
	        {
	            if(GetPlayerMoney(playerid) < 80000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $80000 to buy C4 (20x).");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Bomb Shop menu.");
	                return 1;
				}
				HasC4[playerid] +=20;
				GivePlayerMoney(playerid,-80000);
				format(string,sizeof(string),"Bomb Dealer: Osama Bin Laden\nItem Bought: C4 (20x)\nTotal Cost: $80000\nCash Given: $80000\nChange: $0\nC4 in Inventory: %d",HasC4[playerid]);
				ShowPlayerDialog(playerid,DIALOG_BOMBSHOP,DIALOG_STYLE_MSGBOX,"{FF0000}Bomb Shop Receipt",string,"Ok","Cancel");
				return 1;
			}
			return 1;
		}
		return 1;
	}
	if(dialogid == DIALOG_OTTO)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(GetPlayerMoney(playerid) < 120000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $120000 to buy an Infernus.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-120000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased an Infernus from Otto's Cars for $120000.");
				new bcar;
				bcar = CreateVehicle(411,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased an Infernus from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,120000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=120000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 1)
	        {
	            if(GetPlayerMoney(playerid) < 120000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $120000 to buy a Turismo.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-120000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Turismo from Otto's Cars for $120000.");
				new bcar;
				bcar = CreateVehicle(451,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Turismo from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,120000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=120000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 2)
	        {
	            if(GetPlayerMoney(playerid) < 200000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $200000 to buy a Hotring Racer.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-200000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Hotring Racer from Otto's Cars for $200000.");
				new bcar;
				bcar = CreateVehicle(494,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Hotring Racer from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,200000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=200000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 3)
	        {
	            if(GetPlayerMoney(playerid) < 150000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $150000 to buy a Super GT.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-150000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Super GT from Otto's Cars for $150000.");
				new bcar;
				bcar = CreateVehicle(506,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Super GT from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,150000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=150000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 4)
	        {
	            if(GetPlayerMoney(playerid) < 50000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $50000 to buy a Sultan.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-50000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Sultan from Otto's Cars for $50000.");
				new bcar;
				bcar = CreateVehicle(560,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Sultan from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,50000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=50000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 5)
	        {
	            if(GetPlayerMoney(playerid) < 80000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $80000 to buy a Stretch.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-80000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Stretch from Otto's Cars for $80000.");
				new bcar;
				bcar = CreateVehicle(409,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Stretch from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,80000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=80000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 6)
	        {
	            if(GetPlayerMoney(playerid) < 60000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $60000 to buy an Elegy.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-60000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased an Elegy from Otto's Cars for $60000.");
				new bcar;
				bcar = CreateVehicle(562,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased an Elegy from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,60000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=60000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 7)
	        {
	            if(GetPlayerMoney(playerid) < 40000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $40000 to buy an Elegant.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-40000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased an Elegant from Otto's Cars for $40000.");
				new bcar;
				bcar = CreateVehicle(507,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased an Elegant from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,40000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=40000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 8)
	        {
	            if(GetPlayerMoney(playerid) < 100000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $100000 to buy a Bullet.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-100000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Bullet from Otto's Cars for $100000.");
				new bcar;
				bcar = CreateVehicle(541,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Bullet from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,100000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=100000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 9)
	        {
	            if(GetPlayerMoney(playerid) < 50000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $50000 to buy a Buffalo.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-50000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Buffalo from Otto's Cars for $50000.");
				new bcar;
				bcar = CreateVehicle(402,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Buffalo from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,50000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=50000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 10)
	        {
	            if(GetPlayerMoney(playerid) < 90000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $90000 to buy a Jester.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-90000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Jester from Otto's Cars for $90000.");
				new bcar;
				bcar = CreateVehicle(559,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Jester from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,90000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=90000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 11)
	        {
	            if(GetPlayerMoney(playerid) < 40000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $40000 to buy a Club.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Cars menu.");
	                return 1;
				}
				GivePlayerMoney(playerid,-40000);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have purchased a Club from Otto's Cars for $40000.");
				new bcar;
				bcar = CreateVehicle(589,-1649.8687,1218.8984,7.0115,224.3334,-1,-1,999999999999);
				VehicleInfo[bcar][bought] =playerid;
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(OttoOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased a Club from your Otto's Cars business.",pname,playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,40000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash +=40000;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 12)
	        {
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Otto's Car menu.");
	                return 1;
				}
				if(IsCuffed[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob Otto's Cars while cuffed, how could you manage that?");
				    return 1;
				}
				if(IsFrozen[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob Otto's Cars while frozen by an administrator, how could you manage that?");
				    return 1;
				}
				if(RobSkill[playerid] < 20)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"Your robbing skill is too low to rob Otto's Cars. You need level 20. See /robskill for what you can rob.");
				    return 1;
				}
				if(getCheckpointType(playerid) != CP_OttoCP)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You must be in the Otto's Cars main checkpoint in order to rob it.");
				    return 1;
				}
				if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || gTeam[playerid] == TEAM_MEDIC)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob things with your class/skill.");
				    return 1;
				}
				if(OttoRobbedRecently >= 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"Otto's Cars has been robbed recently. Please wait before robbing it again.");
				    return 1;
				}
				OttoRobbedRecently =300;
				RobbingOtto[playerid] =25;
				IncreaseWantedLevel(playerid,4);
				IncreasePlayerScore(playerid,1);
				format(string,sizeof(string),"Robbing Otto's Cars.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingOtto[playerid]);
				ShowPlayerDialog(playerid,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Robbery",string,"Ok","Cancel");

				format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob Supa Save! Get To Supa Save and arrest the suspect.",pname,playerid);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at Otto's Cars ..",pname,playerid);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at Otto's Cars ..",pname,playerid);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				return 1;
			}
			return 1;
		}
	}
	if(dialogid == DIALOG_DRUGHOUSE)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(GetPlayerMoney(playerid) < 20000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $20000 to buy 100g of weed.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasWeed[playerid] +=100;
				GivePlayerMoney(playerid,-20000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 100g of Weed.\nItem Cost: $20000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
				for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 100g of Weed from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,20000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=20000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 1)
	        {
	            if(GetPlayerMoney(playerid) < 80000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $80000 to buy 500g of weed.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasWeed[playerid] +=500;
				GivePlayerMoney(playerid,-80000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 500g of Weed.\nItem Cost: $80000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 500g of Weed from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,80000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=80000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 2)
	        {
	            if(GetPlayerMoney(playerid) < 150000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $150000 to buy 1000g of weed.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasWeed[playerid] +=1000;
				GivePlayerMoney(playerid,-150000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 1000g of Weed.\nItem Cost: $150000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 1000g of Weed from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,150000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=150000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 3)
	        {
	            if(GetPlayerMoney(playerid) < 500000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $500000 to buy 5000g of weed.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasWeed[playerid] +=5000;
				GivePlayerMoney(playerid,-500000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 5000g of Weed.\nItem Cost: $500000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 5000g of Weed from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,500000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=500000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 4)
	        {
	            if(GetPlayerMoney(playerid) < 10000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $10000 to buy 5 Injections of Heroin.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasHeroin[playerid] +=5;
				GivePlayerMoney(playerid,-10000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 5 Injections of Heroin.\nItem Cost: $10000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 5 Injections of Heroin from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,10000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=10000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 5)
	        {
	            if(GetPlayerMoney(playerid) < 30000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $30000 to buy 20 Injections of Heroin.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasHeroin[playerid] +=20;
				GivePlayerMoney(playerid,-30000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 20 Injections of Heroin.\nItem Cost: $30000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 20 Injections of Heroin from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,10000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=30000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 6)
	        {
	            if(GetPlayerMoney(playerid) < 80000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $80000 to buy 50 Injections of Heroin.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasHeroin[playerid] +=50;
				GivePlayerMoney(playerid,-80000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 50 Injections of Heroin.\nItem Cost: $80000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 50 Injections of Heroin from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,80000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=80000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 7)
	        {
	            if(GetPlayerMoney(playerid) < 250000)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You do not have $250000 to buy 200 Injections of Heroin.");
	                return 1;
				}
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				HasHeroin[playerid] +=200;
				GivePlayerMoney(playerid,-250000);
				format(string,sizeof(string),"Drug House Location: %s.\nItem Bought: 200 Injections of Heroin.\nItem Cost: $250000.",zones[current_zone][zone_name]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Receipt",string,"Ok","Cancel");
                for(new i=0; i<MAX_PLAYERS; i++)
				{
				    if(DrugHouseOwner[i] == 1337)
				    {
				        format(string,sizeof(string),"[PURCHASE] %s(%d) has purchased 200 Injections of Heroin from your %s Drug House.",pname,playerid,zones[current_zone][zone_name]);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(i,250000);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash +=250000;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
				return 1;
			}
			if(listitem == 8)
	        {
	            if(IsSpawned[playerid] != 1)
	            {
	                SendClientMessage(playerid,COLOR_ERROR,"You must be alive and spawned to use the Drug House menu.");
	                return 1;
				}
				if(IsCuffed[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob the Drug House while cuffed, how could you manage that?");
				    return 1;
				}
				if(IsFrozen[playerid] == 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob the Drug House while frozen by an administrator, how could you manage that?");
				    return 1;
				}
				if(RobSkill[playerid] < 10)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"Your robbing skill is too low to rob the Drug House. You need level 10. See /robskill for what you can rob.");
				    return 1;
				}
				if(getCheckpointType(playerid) != CP_DrugHouseCaltonHeights && getCheckpointType(playerid) != CP_DrugHouseOceanFlats && getCheckpointType(playerid) != CP_DrugHouseParadiso && getCheckpointType(playerid) != CP_DrugHouseJuniperHollow)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You must be in the Drug House main checkpoint in order to rob it.");
				    return 1;
				}
				if(gTeam[playerid] == TEAM_COP || gTeam[playerid] == TEAM_ARMY || gTeam[playerid] == TEAM_CIA || gTeam[playerid] == TEAM_MEDIC)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"You cannot rob things with your class/skill.");
				    return 1;
				}
				if(DrugHouseRobbedRecently >= 1)
				{
				    SendClientMessage(playerid,COLOR_ERROR,"The Drug House has been robbed recently. Please wait before robbing it again.");
				    return 1;
				}
				new current_zone;
				current_zone = player_zone[playerid];
				DrugHouseRobbedRecently =300;
				RobbingDrugHouse[playerid] =25;
				IncreaseWantedLevel(playerid,4);
				IncreasePlayerScore(playerid,1);
				format(string,sizeof(string),"Robbing the Drug House.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDrugHouse[playerid]);
				ShowPlayerDialog(playerid,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Robbery",string,"Ok","Cancel");

				format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has begun to rob the Drug House! Location: %s.",pname,playerid,zones[current_zone][zone_name]);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has begun a robbery at the %s Drug House ..",pname,playerid,zones[current_zone][zone_name]);
				SendClientMessageToAll(COLOR_RED,string);
				
				format(string,sizeof(string),"%s(%d) has begun to rob your Drug House at %s. Get over there and kill him.",PlayerName(playerid),playerid,zones[current_zone][zone_name]);
				SendClientMessageToDHOwner(string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has begun a robbery at the %s Drug House ..",pname,playerid,zones[current_zone][zone_name]);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				return 1;
			}
			return 1;
		}
	}
	if(dialogid == DIALOG_CIASAT)
	{
	    if(response == 1)
	    {
	        new ID =strval(inputtext);
	        if(!strlen(inputtext))
	        {
		        SendClientMessage(playerid,COLOR_ERROR,"Please enter the Player ID of the person you want to view.");
		        return 1;
			}
			if(!IsPlayerConnected(ID))
			{
			    SendClientMessage(playerid,COLOR_ERROR,"That Player ID is not connected to the server. Please enter the Player ID of the person you want to view.");
			    return 1;
			}
			if(IsSpawned[ID] != 1)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"That Player ID is dead. Please enter the Player ID of the person you want to view.");
			    return 1;
			}
			if(JailTime[ID] >= 1)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"That Player ID is in prison. Please enter the Player ID of the person you want to view.");
			    return 1;
			}
			if(IsPlayerInAnyVehicle(ID))
			{
				new sname[24];
				GetPlayerName(ID,sname,sizeof(sname));
			    new pveh =GetPlayerVehicleID(ID);
				CIAPlayerBeingViewed[playerid] =ID;
				CIAIsBeingWatched[ID] =1;
				
				for(new w=0; w<13; w++)
				{
		    		GetPlayerWeaponData(playerid,w,PlayerWeapon[playerid][w],PlayerAmmo[playerid][w]);
				}
				
				new pint = GetPlayerInterior(ID);
				SetPlayerInterior(playerid,pint);
				TogglePlayerSpectating(playerid,1);
				PlayerSpectateVehicle(playerid,pveh);

				SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_CIA Satelite Viewing_]]");
				format(string,sizeof(string),"You are now viewing %s(%d) through the CIA Satelite Imagery.",sname,ID);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				return 1;
			}
			if(!IsPlayerInAnyVehicle(ID))
			{
				new sname[24];
				GetPlayerName(ID,sname,sizeof(sname));
				CIAPlayerBeingViewed[playerid] =ID;
				CIAIsBeingWatched[ID] =1;
				
				for(new w=0; w<13; w++)
				{
		    		GetPlayerWeaponData(playerid,w,PlayerWeapon[playerid][w],PlayerAmmo[playerid][w]);
				}
				
				new pint = GetPlayerInterior(ID);
				SetPlayerInterior(playerid,pint);
				TogglePlayerSpectating(playerid,1);
				PlayerSpectatePlayer(playerid,ID);

				SendClientMessage(playerid,COLOR_DEADCONNECT,"[[_CIA Satelite Viewing_]]");
				format(string,sizeof(string),"You are now viewing %s(%d) through the CIA Satelite Imagery.",sname,ID);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				return 1;
			}
			return 1;
		}
	}

	if(dialogid == DIALOG_BANK_LIST)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            ShowPlayerDialog(playerid,DIALOG_BANK_WITHDRAW,DIALOG_STYLE_INPUT,"Withdraw Money","Please enter the amount you wish to withdraw","Ok","Cancel");
				return 1;
			}
			if(listitem == 1)
			{
			    ShowPlayerDialog(playerid,DIALOG_BANK_DEPOSIT,DIALOG_STYLE_INPUT,"Deposit Money","Please enter the amount you wish to deposit","Ok","Cancel");
				return 1;
			}
			if(listitem == 2)
			{
			    format(string,sizeof(string),"Account Holder: %s(%d).\nBranch Location: San Fierro.\nBank Balance: $%d.",pname,playerid,BankCash[playerid]);
			    ShowPlayerDialog(playerid,DIALOG_BANK_BALANCE,DIALOG_STYLE_MSGBOX,"Bank Balance",string,"Ok","Cancel");
				return 1;
			}
			if(listitem == 3)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Please use '/transfer (Player ID) (Amount)' to transfer money to someone's account.");
				return 1;
			}
		}
	}
	
	if(dialogid == DIALOG_BANK_WITHDRAW)
	{
	    if(response == 1)
	    {
	        new value =strval(inputtext);
	        if(!strlen(inputtext))
	        {
	            SendClientMessage(playerid,COLOR_ERROR,"Please enter the amount you wish to withdraw from your account.");
	            ShowPlayerDialog(playerid,DIALOG_BANK_WITHDRAW,DIALOG_STYLE_INPUT,"Withdraw Money","Please enter the amount you wish to withdraw","Ok","Cancel");
	            return 1;
			}
			if(value < 5000 || value > 500000)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Please enter a value between $5000 and $500000.");
			    ShowPlayerDialog(playerid,DIALOG_BANK_WITHDRAW,DIALOG_STYLE_INPUT,"Withdraw Money","Please enter the amount you wish to withdraw","Ok","Cancel");
			    return 1;
			}
			if(BankCash[playerid] < value)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"You do not have that amount of money in your bank account to withdraw.");
			    ShowPlayerDialog(playerid,DIALOG_BANK_WITHDRAW,DIALOG_STYLE_INPUT,"Withdraw Money","Please enter the amount you wish to withdraw","Ok","Cancel");
			    return 1;
			}
			BankCash[playerid] -=value;
			GivePlayerMoney(playerid,value);
			TextDrawSetString(MessageTD[playerid],"FUNDS WITHDRAWN");
			TextDrawShowForPlayer(playerid,MessageTD[playerid]);
			MessageTDTime[playerid] =5;
			
			format(string,sizeof(string),"Account Holder: %s(%d).\nBranch Location: San Fierro.\nWithdraw Amount: $%d.\nNew Balance: $%d.",pname,playerid,value,BankCash[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BANK_BALANCE,DIALOG_STYLE_MSGBOX,"Bank Balance",string,"Ok","Cancel");
			
			format(string,sizeof(string),"2[BANK ACTION] %s(%d) has withdrawn $%d from his bank account.",pname,playerid,value);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
	}
	
	if(dialogid == DIALOG_BANK_DEPOSIT)
	{
	    if(response == 1)
	    {
	        new value =strval(inputtext);
	        if(!strlen(inputtext))
	        {
	            SendClientMessage(playerid,COLOR_ERROR,"Please enter the amount you wish to deposit from your account.");
	            ShowPlayerDialog(playerid,DIALOG_BANK_DEPOSIT,DIALOG_STYLE_INPUT,"Deposit Money","Please enter the amount you wish to deposit","Ok","Cancel");
	            return 1;
			}
			if(value < 5000 || value > 500000)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Please enter a value between $5000 and $500000.");
			    ShowPlayerDialog(playerid,DIALOG_BANK_DEPOSIT,DIALOG_STYLE_INPUT,"Deposit Money","Please enter the amount you wish to deposit","Ok","Cancel");
			    return 1;
			}
			if(GetPlayerMoney(playerid) < value)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"You do not have that amount of money in your pockets to deposit into the bank.");
			    ShowPlayerDialog(playerid,DIALOG_BANK_DEPOSIT,DIALOG_STYLE_INPUT,"Deposit Money","Please enter the amount you wish to deposit","Ok","Cancel");
			    return 1;
			}
			BankCash[playerid] +=value;
			GivePlayerMoney(playerid,-value);
			TextDrawSetString(MessageTD[playerid],"FUNDS DEPOSITED");
			TextDrawShowForPlayer(playerid,MessageTD[playerid]);
			MessageTDTime[playerid] =5;

			format(string,sizeof(string),"Account Holder: %s(%d).\nBranch Location: San Fierro.\nDeposit Amount: $%d.\nNew Balance: $%d.",pname,playerid,value,BankCash[playerid]);
			ShowPlayerDialog(playerid,DIALOG_BANK_BALANCE,DIALOG_STYLE_MSGBOX,"Bank Balance",string,"Ok","Cancel");

			format(string,sizeof(string),"2[BANK ACTION] %s(%d) has deposited $%d into his bank account.",pname,playerid,value);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
	}
			
    if(dialogid == DIALOG_LOGIN)
    {
        if (response == 0)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must login before playing on this server.");
	        ShowLoginScreen(playerid);
	        return 1;
	    }
	    if (response == 1)
	    {
            if (strlen(inputtext) == 0)
			{
			    SendClientMessage(playerid,COLOR_ERROR,"Please enter your password for your account in the box below.");
				ShowLoginScreen(playerid);
				return 1;
			}
			if (udb_CheckLogin(PlayerName(playerid),inputtext))
			{
				BankCash[playerid] =dUserINT(PlayerName(playerid)).("Bankcash");
		   		GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("Money")-GetPlayerMoney(playerid));
		        SetPlayerScore(playerid,dUserINT(PlayerName(playerid)).("Score")-GetPlayerScore(playerid));
		        CanUseArmy[playerid] =dUserINT(PlayerName(playerid)).("Army");
		        CanUseCIA[playerid] =dUserINT(PlayerName(playerid)).("CIA");
		        AdminLevel[playerid] =dUserINT(PlayerName(playerid)).("Adminlevel");
		        IsRegularPlayer[playerid] =dUserINT(PlayerName(playerid)).("RegularPlayer");
		        NameBanned[playerid] =dUserINT(PlayerName(playerid)).("Nameban");
		        DrugHouseOwner[playerid] =dUserINT(PlayerName(playerid)).("DrugHouseOwner");
		        OttoOwner[playerid] =dUserINT(PlayerName(playerid)).("OttoOwner");
		        TerroristSkill[playerid] =dUserINT(PlayerName(playerid)).("TSkill");
		        RobSkill[playerid] =dUserINT(PlayerName(playerid)).("RobSkill");
		        HasPackC4[playerid] =dUserINT(PlayerName(playerid)).("HasPackC4");
		        HasPackRope[playerid] =dUserINT(PlayerName(playerid)).("HasPackRope");
		        HasPackMoney[playerid] =dUserINT(PlayerName(playerid)).("HasPackMoney");
		        SavedWantedLevel[playerid] =dUserINT(PlayerName(playerid)).("SavedWantedLevel");
		        SavedJailTime[playerid] =dUserINT(PlayerName(playerid)).("SavedJailTime");
		   		new pIp[16];
				GetPlayerIp(playerid, pIp, sizeof(pIp));
				dUserSet(PlayerName(playerid)).("IP", pIp);
	   			PLAYERLIST_authed[playerid]=true;
	      		return SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have successfully logged in! Your previous stats have been restored.");
            }
            ShowLoginScreen(playerid);
			CheckPasswordAttempts(playerid);
        }
        return 1;
	}
	if(dialogid == DIALOG_REGISTER)
    {
        if (response == 0)
	    {
	        SendClientMessage(playerid,COLOR_ERROR,"You must register before playing on this server.");
			ShowRegisterScreen(playerid);
			return 1;
	    }
	    if (response == 1)
	    {
            if (udb_Exists(PlayerName(playerid)))
            {
                SendClientMessage(playerid,COLOR_ERROR,"This account already exists, please choose a different player name.");
                return 1;
			}
            if (strlen(inputtext)==0)
			{
		        SendClientMessage(playerid,COLOR_ERROR,"Please enter your password in the box to register in this server.");
                ShowRegisterScreen(playerid);
				return 1;
			}
            if (udb_Create(PlayerName(playerid),inputtext))
			{
		        SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have registered, now please enter your password in the box to login.");
                ShowLoginScreen(playerid);
		        PLAYERLIST_authed[playerid]=true;
		        dUserSetINT(PlayerName(playerid)).("Money",7500);
			    dUserSetINT(PlayerName(playerid)).("Bankcash",5000);
				dUserSetINT(PlayerName(playerid)).("Score",0);
			    dUserSetINT(PlayerName(playerid)).("Adminlevel",0);
			    dUserSetINT(PlayerName(playerid)).("Nameban",0);
			    dUserSetINT(PlayerName(playerid)).("Army",0);
			    dUserSetINT(PlayerName(playerid)).("CIA",0);
			    dUserSetINT(PlayerName(playerid)).("RegularPlayer",0);
			    dUserSetINT(PlayerName(playerid)).("Nameban",0);
			    dUserSetINT(PlayerName(playerid)).("DrugHouseOwner",0);
			    dUserSetINT(PlayerName(playerid)).("OttoOwner",0);
			    dUserSetINT(PlayerName(playerid)).("TSkill",0);
			    dUserSetINT(PlayerName(playerid)).("RobSkill",0);
			    dUserSetINT(PlayerName(playerid)).("HasPackC4",0);
			    dUserSetINT(PlayerName(playerid)).("HasPackRope",0);
			    dUserSetINT(PlayerName(playerid)).("HasPackMoney",0);
		     	dUserSetINT(PlayerName(playerid)).("SavedJailTime",0);
			    dUserSetINT(PlayerName(playerid)).("SavedWantedLevel",0);
				new pIp[16];
				GetPlayerIp(playerid, pIp, sizeof(pIp));
				dUserSet(PlayerName(playerid)).("IP", pIp);
			}
            return true;
	    }
	    return 1;
    }
    if(dialogid == DIALOG_CHANGEPASS)
    {
        if (response == 0)
	    {
			return 1;
	    }
	    if (response == 1)
	    {
            if (strlen(inputtext)==0)
			{
		        SendClientMessage(playerid,COLOR_ERROR,"Please enter your desired password in the box.");
                ShowChangePassScreen(playerid);
				return 1;
			}
            udb_UserSetInt(PlayerName(playerid),"password_hash",udb_hash(inputtext));
            format(string,sizeof(string),"You have successfully changed your password to '%s', use this to login from now on.",inputtext);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
            return true;
	    }
	    return 1;
    }
    if(dialogid == DIALOG_CHANGENAME)
    {
        if (response == 0)
	    {
			return 1;
	    }
	    if (response == 1)
	    {
            if (strlen(inputtext)==0)
			{
		        SendClientMessage(playerid,COLOR_ERROR,"Please enter your desired name in the box.");
                ShowChangeNameScreen(playerid);
				return 1;
			}
//            udb_RenameUser(PlayerName(playerid),inputtext);
            SetPlayerName(playerid,inputtext);
            format(string,sizeof(string),"You have successfully changed your name to '%s', use this to login from now on.",inputtext);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
            return true;
	    }
	    return 1;
    }
	return 1;
}

//==============================================================================

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

//==============================================================================

//IRC Commands
forward IRC_ConnectDelay(tempid);
public IRC_ConnectDelay(tempid)
{
	switch (tempid)
	{
		case 1:
		{
			// Connect the first bot
			gBotID[0] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_1_NICKNAME, BOT_1_REALNAME, BOT_1_USERNAME);
		}
		case 2:
		{
		    new string[128];
			// Connect the second bot
			gBotID[1] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_2_NICKNAME, BOT_2_REALNAME, BOT_2_USERNAME);
			IRC_GroupSay(gGroupID, IRC_CHANNEL,"5#####################################");
			format(string,sizeof(string),"5%s (%s)",sabbv,svname);
			IRC_GroupSay(gGroupID, IRC_CHANNEL,string);
			format(string,sizeof(string),"5Version %s",sversion);
			IRC_GroupSay(gGroupID, IRC_CHANNEL,string);
		    IRC_GroupSay(gGroupID, IRC_CHANNEL,"5The sexual Gamemode.");
		    IRC_GroupSay(gGroupID, IRC_CHANNEL,"5#####################################");
		}
		case 3:
		{
		    // Connect the admin bot
			gBotID[2] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_3_NICKNAME, BOT_3_REALNAME, BOT_3_USERNAME);
		}
	}
	return 1;
}

stock GetPlayerID(const Name[])
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new pName[MAX_PLAYER_NAME];
	        GetPlayerName(i, pName, sizeof(pName));
	        if(strcmp(Name, pName, true)==0)
	        {
	            return i;
	        }
	    }
	}
	return -1;
}

public IRC_OnConnect(botid)
{
	new string[256];
	printf("*** IRC_OnConnect: Bot ID %d connected!", botid);
	// Join the channel
	if(botid == 1 || botid == 2)
	{
		IRC_JoinChannel(botid, IRC_CHANNEL);
		format(string,sizeof(string),"PRIVMSG NickServ :identify %s",IRC_BOT_PASSWORD);
		IRC_SendRaw(botid, string);
		IRC_AddToGroup(gGroupID, botid);
	}
	if(botid == 3)
	{
	    format(string,sizeof(string),"PRIVMSG NickServ :identify %s",IRC_BOT_PASSWORD);
        IRC_SendRaw(botid, string);
        format(string,sizeof(string),"JOIN %s :%s",IRC_ADMINCHANNEL,IRC_ADMINCHANNEL_PASSWORD);
		IRC_SendRaw(botid, string);
		IRC_AddToGroup(gGroupAdminID, botid);
	}
	// Add the bot to the group
	return 1;
}

/*
	Note that this callback is executed whenever a current connection is closed
	OR whenever a connection attempt fails. Reconnecting too fast can flood the
	IRC server and possibly result in a ban. It is recommended to set up
	connection reattempts on a timer, as demonstrated here.
*/

public IRC_OnDisconnect(botid)
{
	printf("*** IRC_OnDisconnect: Bot ID %d disconnected!", botid);
	if (botid == gBotID[0])
	{
		// Reset the bot ID
		gBotID[0] = 0;
		// Wait 20 seconds for the first bot
		SetTimerEx("IRC_ConnectDelay", 20000, 0, "d", 1);
	}
	else if (botid == gBotID[1])
	{
		// Reset the bot ID
		gBotID[1] = 0;
		// Wait 25 seconds for the second bot
		SetTimerEx("IRC_ConnectDelay", 25000, 0, "d", 2);
	}
	else if (botid == gBotID[2])
	{
		// Reset the bot ID
		gBotID[2] = 0;
		// Wait 30 seconds for the third bot
		SetTimerEx("IRC_ConnectDelay", 30000, 0, "d", 3);
	}
	printf("*** IRC_OnDisconnect: Bot ID %d attempting to reconnect...", botid);
	// Remove the bot from the group
	IRC_RemoveFromGroup(gGroupID, botid);
	return 1;
}

public IRC_OnJoinChannel(botid, channel[])
{
	printf("*** IRC_OnJoinChannel: Bot ID %d joined channel %s!", botid, channel);
	return 1;
}

/*
	If the bot cannot immediately rejoin the channel (in the event, for example,
	that the bot is kicked and then banned), you might want to set up a timer
	here as well for rejoin attempts.
*/

public IRC_OnLeaveChannel(botid, channel[], message[])
{
	printf("*** IRC_OnLeaveChannel: Bot ID %d left channel %s (%s)!", botid, channel, message);
	IRC_JoinChannel(botid, channel);
	return 1;
}

public IRC_OnUserDisconnect(botid, user[], host[], message[])
{
	printf("*** IRC_OnUserDisconnect (Bot ID %d): User %s (%s) disconnected! (%s)", botid, user, host, message);
	return 1;
}

public IRC_OnUserJoinChannel(botid, channel[], user[], host[])
{
	printf("*** IRC_OnUserJoinChannel (Bot ID %d): User %s (%s) joined channel %s!", botid, user, host, channel);
	return 1;
}

public IRC_OnUserLeaveChannel(botid, channel[], user[], host[], message[])
{
	printf("*** IRC_OnUserLeaveChannel (Bot ID %d): User %s (%s) left channel %s (%s)!", botid, user, host, channel, message);
	return 1;
}

public IRC_OnUserNickChange(botid, oldnick[], newnick[], host[])
{
	printf("*** IRC_OnUserNickChange (Bot ID %d): User %s (%s) changed his nick to %s!", botid, oldnick, host, newnick);
	return 1;
}

public IRC_OnUserSetChannelMode(botid, channel[], user[], host[], mode[])
{
	printf("*** IRC_OnUserSetChannelMode (Bot ID %d): User %s (%s) on %s set mode: %s!", botid, user, host, channel, mode);
	return 1;
}

public IRC_OnUserSetChannelTopic(botid, channel[], user[], host[], topic[])
{
	printf("*** IRC_OnUserSetChannelTopic (Bot ID %d): User %s (%s) on %s set topic: %s!", botid, user, host, channel, topic);
	return 1;
}

public IRC_OnUserNotice(botid, recipient[], user[], host[], message[])
{
	printf("*** IRC_OnUserNotice (Bot ID %d): User %s (%s) sent notice to %s: %s", botid, user, host, recipient, message);
	// Someone sent the second bot a notice (probably a network service)
	if (!strcmp(recipient, BOT_2_NICKNAME))
	{
		IRC_Notice(botid, user, "You sent me a notice!");
	}
	return 1;
}

/*
	This callback is useful for logging, debugging, or catching error messages
	sent by the IRC server.
*/

public IRC_OnReceiveRaw(botid, message[])
{
	new
		File:file;
	if (!fexist("irc_log.txt"))
	{
		file = fopen("irc_log.txt", io_write);
	}
	else
	{
		file = fopen("irc_log.txt", io_append);
	}
	if (file)
	{
		fwrite(file, message);
		fwrite(file, "\r\n");
		fclose(file);
	}
	return 1;
}

/*
	Some examples of channel commands are here. You can add more very easily;
	their implementation is identical to that of ZeeX's zcmd.
*/

public Say(channel[], msg[])
{
    if(!strcmp(IRC_CHANNEL,channel,false))
	{
		IRC_GroupSay(gGroupID, channel, msg);
	}
	if(!strcmp(IRC_ADMINCHANNEL,channel,false))
	{
		IRC_GroupSay(gGroupAdminID, channel, msg);
	}
}

public LSay(channel[], msg[])
{
    if(!strcmp(IRC_CHANNEL,channel,false))
	{
		IRC_Say(1, channel, msg);
	}
	if(!strcmp(IRC_ADMINCHANNEL,channel,false))
	{
		IRC_Say(3, channel, msg);
	}
}

IRCCMD:commands(botid, channel[], user[], host[], params[])
{
	#pragma unused params
	if(IRC_IsOwner(botid, channel, user))
	{
	    LSay(channel,"2IRC Commands (At Owner level):");
	    LSay(channel,"2!say !pm !players !warn !mute !unmute !admin !jail");
	    LSay(channel,"2!adan !kick !freeze !unfreeze !spawn !ban !kill");
	    LSay(channel,"2!unban !nameban !rcon !text !ip !gmx !setlevel");
	    return 1;
	}
	if(IRC_IsAdmin(botid, channel, user))
	{
	    LSay(channel,"2IRC Commands (At Admin level):");
	    LSay(channel,"2!say !pm !players !warn !mute !unmute !admin !jail");
	    LSay(channel,"2!adan !kick !freeze !unfreeze !spawn !ban !kill");
	    LSay(channel,"2!unban !nameban !rcon !text !ip !gmx");
	    return 1;
	}
	if(IRC_IsOp(botid, channel, user))
	{
	    LSay(channel,"2IRC Commands (At Op level):");
	    LSay(channel,"2!say !pm !players !warn !mute !unmute !admin");
	    LSay(channel,"2!jail !adan !kick !freeze !unfreeze !spawn");
	    return 1;
	}
	if(IRC_IsHalfop(botid, channel, user))
	{
	    LSay(channel,"2IRC Commands (At Half Op level):");
	    LSay(channel,"2!say !pm !players !warn !mute !unmute !admin");
	    return 1;
	}
	if(IRC_IsVoice(botid, channel, user))
	{
	    LSay(channel,"2IRC Commands (At voice level):");
	    LSay(channel,"2!say !pm !players");
	    return 1;
	}
	return 1;
}

IRCCMD:setlevel(botid, channel[], user[], host[], params[])
{
    if (IRC_IsOwner(botid, channel, user))
	{
	    new endid;
		new level;
		new strmessage[128];
		if(sscanf(params, "ui", endid, level))
		{
			format(strmessage,sizeof(strmessage),"USAGE: !setlevel (Player Name/ID) (level)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage,sizeof(strmessage),"2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		if(AdminLevel[endid] == level)
		{
		    format(strmessage,sizeof(strmessage),"%s(%d) is already at the Administrator level: %d",PlayerName(endid),endid,level);
		    Say(channel,strmessage);
		    return 1;
		}
		if(PLAYERLIST_authed[endid] != 1)
		{
	        format(strmessage,sizeof(strmessage),"%s(%d) is not logged into to the server. You must wait till they login before you set their administrator level.",PlayerName(endid),endid);
		    Say(channel,strmessage);
		    return 1;
		}
		format(strmessage,sizeof(strmessage),"[ADMIN LEVEL CHANGE] Owner %s has given %s(%d) the administrator level %d from IRC.",user,PlayerName(endid),endid,level);
		SendClientMessageToAll(COLOR_ADMIN,strmessage);

		SendClientMessage(endid,COLOR_ADMIN,"Your admin level has been changed by the Server Owner. To see your new commands type /adcmds.");
		AdminLevel[endid] =level;

		format(strmessage,sizeof(strmessage),"9[ADMIN LEVEL CHANGE] Owner %s has given %s(%d) the administrator level %d from IRC.",user,PlayerName(endid),endid,level);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,strmessage);
	}
	return 1;
}

IRCCMD:say(botid, channel[], user[], host[], params[])
{
	// Check if the user has at least voice in the channel
	if (IRC_IsVoice(botid, channel, user))
	{
		// Check if the user entered any text
		if (!isnull(params))
		{
			// Echo the formatted message
			new msg[112];
		 	format(msg,sizeof(msg), "(IRC) %s: %s", user, params);
			SendClientMessageToAll(COLOR_LIGHTBLUE, msg);
			format(msg, sizeof(msg),"(IRC) %s: %s", user, params);
			Say(channel,msg);
		}
	}
	return 1;
}

IRCCMD:unban(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
   		new string[128];
	   	if(!strlen(params))
 		{
		   	format(string, sizeof(string), "USAGE: !unban (Player Name)");
	  	   	Say(channel,string);
       		return 1;
   		}
		if(!udb_Exists(params))
		{
	   		format(string, sizeof(string), "The player file %s is not found.",params);
	        Say(channel,string);
	        return 1;
   		}
	    new strMsg[24];
	    format(strMsg, sizeof(strMsg), "unbanip %s", dUser(params).("IP"));
	    SendRconCommand(strMsg);
	   	new strMsg3[150];
	   	format(strMsg3, sizeof(strMsg3), "reloadbans");
	   	SendRconCommand(strMsg3);
	   	new nameban = dUserINT(params).("Nameban");
	   	if(nameban == 0)
	   	{
	       	format(string, sizeof(string), "The Player Name %s is not banned.", params);
	       	Say(channel,string);
	       	return 1;
	   	}
	   	dUserSetINT(params).("Nameban", 0);
	   	format(string, sizeof(string), "%s has been unbanned. (IP and Name)",params);
	   	printf("%s", string);
	   	Say(channel,string);
	   	return 1;
	}
   	return 1;
}

IRCCMD:nameban(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
   		new string[128];
		if(!strlen(params))
		{
		   format(string, sizeof(string), "USAGE: !nameban (Player Name)");
	  	   Say(channel,string);
	       return 1;
   		}
		if(!udb_Exists(params))
		{
	   		format(string, sizeof(string), "The Player file %s is not found.",params);
	        Say(channel,string);
	        return 1;
   		}
	    new strMsg[24];
	    format(strMsg, sizeof(strMsg), "banip %s", dUser(params).("IP"));
	    SendRconCommand(strMsg);
		new strMsg3[150];
	   	format(strMsg3, sizeof(strMsg3), "reloadbans");
	   	SendRconCommand(strMsg3);
	   	new nameban = dUserINT(params).("Nameban");
	   	if(nameban == 1)
	   	{
   	 		format(string, sizeof(string), "The Player Name %s is already banned.", params);
	       	Say(channel,string);
	       	return 1;
	   	}
	   	dUserSetINT(params).("Nameban", 1);
	   	format(string, sizeof(string), "%s has been banned. (IP and Name)",params);
	   	Say(channel,string);
	   	return 1;
   	}
   	return 1;
}

IRCCMD:ban(botid, channel[], user[], host[], params[])
{
	// Check if the user is at least a halfop in the channel
	if (IRC_IsAdmin(botid, channel, user))
	{
		new strmessage[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "us[100]", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !ban (Player Name/ID) (Reason)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has banned %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has banned %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		Say(channel,strmessage);
    	if(udb_Exists(PlayerName(endid)) && PLAYERLIST_authed[endid])
		{
			dUserSetINT(PlayerName(endid)).("nameban",1);
		}
		Banning[endid] = 1;
        SetTimer("BanPlayer",700,0);
  	}
	return true;
}

IRCCMD:kick(botid, channel[], user[], host[], params[])
{
	// Check if the user is at least an op in the channel
	if (IRC_IsOp(botid, channel, user))
	{
		new strmessage[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "us[100]", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !kick (Player Name/ID) (Reason)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has kicked %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has kicked %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		Say(channel,strmessage);
		Kicking[endid] =1;
		SetTimer("KickPlayer",700,0);
	}
	return true;
}

IRCCMD:rcon(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
		if (!isnull(params))
		{
			if (strcmp(params, "exit", true) != 0 && strfind(params, "loadfs irc", true) == -1)
			{
				new msg[128];
				format(msg, sizeof(msg), "RCON command %s has been executed.", params);
				Say(channel,msg);
				SendRconCommand(params);
			}
		}
	}
	return 1;
}

IRCCMD:admin(botid, channel[], user[], host[], params[])
{
	if (IRC_IsHalfop(botid, channel, user))
	{
		if (!isnull(params))
		{
			new msg[112];
			format(msg,sizeof(msg), "Admin on IRC: %s", params);
			SendClientMessageToAll(COLOR_ADMIN, msg);
			format(msg,sizeof(msg), "Admin on IRC: %s",  params);
		 	Say(channel,msg);
	 	}
 	}
	return 1;
}

IRCCMD:players(botid, channel[], user[], host[], params[])
{
	if (IRC_IsVoice(botid, channel, user))
	{
	new count;
	new PlayerNames[750];
//	new a = GetPlayerID(PlayerNames);
	for(new i=0; i<=MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    if(count == 0)
		    {
		        new PlayerName1[MAX_PLAYER_NAME];
				GetPlayerName(i, PlayerName1, sizeof(PlayerName1));
			 	format(PlayerNames, sizeof(PlayerNames),"%d %s[%d]1",IrcColor[i],PlayerName1,i);
				count++;
			}
			else
			{
			    new PlayerName1[MAX_PLAYER_NAME];
   				GetPlayerName(i, PlayerName1, sizeof(PlayerName1));
		 		format(PlayerNames, sizeof(PlayerNames),"%s, %d %s[%d]1",PlayerNames,IrcColor[i],PlayerName1,i);
				count++;
			}
		}
		else { if(count == 0) format(PlayerNames, sizeof(PlayerNames), "4No Players Online!"); }
	}

    new counter = 0;
    new lolz[750];
	for(new i=0; i<=MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i)) counter++;
	}

	format(lolz, sizeof(lolz), "2Connected Players[%d]: %s", counter, PlayerNames);
 	Say(channel,lolz);
  	#pragma unused channel,user,host,params
  	}
	return 1;
}
IRCCMD:adan(botid, channel[], user[], host[], params[])
{
	if (IRC_IsOp(botid, channel, user))
	{
		if (!isnull(params))
		{
			new msg[112];
			format(msg,sizeof(msg), "%s", params);
			GameTextForAll(msg, 7000, 3);
			format(msg,sizeof(msg), "9[ANNOUNCEMENT by %s] %s", user, params);
			Say(channel,msg);
		}
	}
	return 1;
}
IRCCMD:text(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
		if (!isnull(params))
		{
	        new msg[112];
	        format(msg,sizeof(msg),"%s",params);
	        SendClientMessageToAll(COLOR_WHITE, msg);
	        format(msg, sizeof(msg),"9[TEXT] %s",params);
	        Say(channel,msg);
		}
	}
    return 1;
}
IRCCMD:pm(botid, channel[], user[], host[], params[])
{
	if (IRC_IsVoice(botid, channel, user))
	{
		if (!isnull(params))
		{
			new string [128];
			new string2[128];
			new ID;
			new cmdreason[100];
		 	if(sscanf(params, "us[100]", ID, cmdreason))
		 	{
			 	format(string, sizeof(string), "USAGE: !pm (Player Name/ID) (Message)", ID);
			 	Say(channel,string);
			 	return 1;
			}
			if(!IsPlayerConnected(ID))
			{
				format(string, sizeof(string), "2ERROR: \2;%d\2; is not an active ID.", ID);
			 	Say(channel,string);
			 	return 1;
			}
		    format(string,sizeof(string),"6[IRC PM] From %s to %s(%d): %s",user,PlayerName(ID),ID,cmdreason);
			Say(channel,string);
		    format(string2, sizeof(string2), "[IRC PM] %s: %s", user, cmdreason);
		    SendClientMessage(ID,COLOR_YELLOW,string2);
		    PlayerPlaySound(ID,1085,0.0,0.0,0.0);
		}
	}
   	return 1;
}
IRCCMD:kill(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
		new strmessage[128];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !kill (Player Name/ID) (Reason - Optional)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		SetPlayerHealth(endid, 0);
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has killed %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has killed %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		Say(channel,strmessage);
 	}
 	return 1;
}
IRCCMD:jail(botid, channel[], user[], host[], params[])
{
	if (IRC_IsOp(botid, channel, user))
	{
		new strmessage[150];
		new endid;
		new time;
		new cmdreason[128];
		if(sscanf(params, "uiz", endid, time, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !jail (Player Name/ID) (Seconds) (Reason - Optional)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has jailed %s(%d) for %d seconds for reason: %s",PlayerName(endid),endid,time,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has jailed %s(%d) for %d seconds for reason: %s",PlayerName(endid),endid,time,cmdreason);
		Say(channel,strmessage);
		//TextDraw
		TextDrawShowForPlayer(endid,JailTimer[endid]);

		//Others
		ResetPlayerWeapons(endid);

	    new rnd = random(sizeof(JailSpawnPoints));
	    JailTime[endid] =time;
	    IsCuffed[endid] =0;
	    CuffTime[endid] =0;
	    TotalJailTime[endid] =time;
	    SetPlayerInterior(endid,10);
	    SetPlayerPos(endid,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
	    SetPlayerFacingAngle(endid,JailSpawnPoints[rnd][3]);
	    TogglePlayerControllable(endid,1);
	    SetPlayerWantedLevel(endid,0);
	    SetPlayerToTeamColour(endid);
	}
	return 1;
}
IRCCMD:ip(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
		new strmessage[150];
		new ipstring[25];
		new endid;
		if(sscanf(params, "u", endid))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !ip (Player Name/ID)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		GetPlayerIp(endid,ipstring,255);
		format(strmessage, sizeof(strmessage), "%s(%d)'s IP:%s", PlayerName(endid),endid,ipstring);
		Say(channel,strmessage);
	}
	return 1;
}
IRCCMD:spawn(botid, channel[], user[], host[], params[])
{
	if (IRC_IsOp(botid, channel, user))
	{
		new strmessage[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !spawn (Player Name/ID) (Reason - Optional)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has spawned %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has spawned %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		Say(channel,strmessage);
		SpawnPlayer(endid);
	}
	return true;
}
IRCCMD:mute(botid, channel[], user[], host[], params[])
{
	if (IRC_IsHalfop(botid, channel, user))
	{
		new strMsg[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strMsg, sizeof(strMsg), "USAGE: !mute (Player Name/ID) (Reason - Optional)");
			Say(channel,strMsg);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strMsg, sizeof(strMsg), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strMsg);
		 	return 1;
		}
		format(strMsg, sizeof(strMsg), "[ADMIN] IRC Administrator has muted %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strMsg);
		format(strMsg, sizeof(strMsg), "9[ADMIN] IRC Administrator has muted %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		Say(channel,strMsg);
		IsMuted[endid] =1;
	}
	return true;
}
IRCCMD:unmute(botid, channel[], user[], host[], params[])
{
	if (IRC_IsHalfop(botid, channel, user))
	{
		new strMsg[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strMsg, sizeof(strMsg), "USAGE: !unmute (Player Name/ID) (Reason - Optional)");
			Say(channel,strMsg);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strMsg, sizeof(strMsg), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strMsg);
		 	return 1;
		}
		format(strMsg, sizeof(strMsg), "[ADMIN] IRC Administrator has unmuted %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strMsg);
		format(strMsg, sizeof(strMsg), "9[ADMIN] IRC Administrator has unmuted %s(%d) for reason: %s",PlayerName(endid),endid,cmdreason);
		Say(channel,strMsg);
		IsMuted[endid] =0;
	}
	return true;
}
IRCCMD:gmx(botid, channel[], user[], host[], params[])
{
	if (IRC_IsAdmin(botid, channel, user))
	{
		new strmessage[150];
		format(strmessage, sizeof(strmessage), "Server GMX from an IRC Administrator");
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		Say(channel,strmessage);
		SendRconCommand("gmx");
	}
	return true;
}
IRCCMD:warn(botid, channel[], user[], host[], params[])
{
 	if (IRC_IsHalfop(botid, channel, user))
	{
	    new string[128];
		new strmessage[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !warn (Player Name/ID) (Reason - Optional)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		if(Warns[endid] >= 0 && Warns[endid] < 2)
		{
			Warns[endid] ++;
			format(string,sizeof(string),"[ADMIN] Administrator has warned %s(%d) [%d/3] for reason: %s.",PlayerName(endid),endid,Warns[endid],cmdreason);
			SendClientMessageToAll(COLOR_ADMIN,string);

			format(string,sizeof(string),"9[ADMIN] Administrator has warned %s(%d) [%d/3] for reason: %s.",PlayerName(endid),endid,Warns[endid],cmdreason);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			return 1;
		}
		if(Warns[endid] == 2)
		{
		    format(string,sizeof(string),"[ADMIN] IRC Administrator has warned %s(%d) [3/3] for reason: %s.",PlayerName(endid),endid,Warns[endid],cmdreason);
			SendClientMessageToAll(COLOR_ADMIN,string);
			format(string,sizeof(string),"[AUTO KICK] %s(%d) has been auto kicked by our auto admin for too many admin warnings. [3/3]",PlayerName(endid),endid);
			SendClientMessageToAll(COLOR_ADMIN,string);

			format(string,sizeof(string),"9[ADMIN] IRC Administrator has warned %s(%d) [3/3] for reason: %s.",PlayerName(endid),endid,Warns[endid],cmdreason);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			format(string,sizeof(string),"9[AUTO KICK] %s(%d) has been auto kicked by our auto admin for too many admin warnings. [3/3]",PlayerName(endid),endid);
			IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			Kicking[endid] =1;
			Warns[endid] =0;
			SetTimer("KickPlayer",700,0);
			return 1;
		}
	}
	return 1;
}
IRCCMD:freeze(botid, channel[], user[], host[], params[])
{
 	if (IRC_IsOp(botid, channel, user))
	{
		new strmessage[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !freeze (Player Name/ID) (Reason - Optional)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has frozen %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has frozen %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		Say(channel,strmessage);
		IsFrozen[endid] =1;
		TogglePlayerControllable(endid, 0);
 	}
	return true;
}
IRCCMD:unfreeze(botid, channel[], user[], host[], params[])
{
 	if (IRC_IsOp(botid, channel, user))
	{
		new strmessage[150];
		new endid;
		new cmdreason[128];
		if(sscanf(params, "uz", endid, cmdreason))
		{
			format(strmessage, sizeof(strmessage), "USAGE: !unfreeze (Player Name/ID) (Reason - Optional)");
			Say(channel,strmessage);
			return 1;
		}
		if(!IsPlayerConnected(endid))
		{
			format(strmessage, sizeof(strmessage), "2ERROR: \2;%d\2; is not an active ID.", endid);
		 	Say(channel,strmessage);
		 	return 1;
		}
		format(strmessage, sizeof(strmessage), "[ADMIN] IRC Administrator has unfrozen %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		SendClientMessageToAll(COLOR_ADMIN, strmessage);
		format(strmessage, sizeof(strmessage), "9[ADMIN] IRC Administrator has unfrozen %s(%d) for reason: %s", PlayerName(endid),endid,cmdreason);
		Say(channel,strmessage);
		IsFrozen[endid] =0;
		TogglePlayerControllable(endid, 1);
 	}
	return true;
}

//==============================================================================

//FUNCTIONS
public SFPDGatesOpen()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
        if(PlayerToPoint(10.0, i, -1627.33483887,688.32006836,9.80140114) && SFPDGateOpen == 0 && IsPlayerInAnyVehicle(i))
        {
            if(gTeam[i] == TEAM_COP || gTeam[i] == TEAM_ARMY || gTeam[i] == TEAM_CIA)
            {
	        	MoveObject(SFPDRightGate, -1617.33483887,688.32006836,9.80140114, 5);
				MoveObject(SFPDLeftGate, -1646.18347168,688.50933838,9.80140114, 5);
				SFPDGateOpen =1;
				SetTimer("SFPDGatesClose",7000,0);
			}
        }
    }
}

public SFPDGatesClose()
{
    MoveObject(SFPDRightGate, -1627.33483887,688.32006836,9.80140114, 5);
	MoveObject(SFPDLeftGate, -1636.18347168,688.50933838,9.80140114, 5);
	SFPDGateOpen =0;
}

public FBIRightGatesOpen()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
        if(PlayerToPoint(10.0, i, -1781.65063477,971.39666748,26.50776672) && FBIRightGateOpen == 0)
        {
            if(gTeam[i] == TEAM_COP || gTeam[i] == TEAM_ARMY || gTeam[i] == TEAM_CIA)
            {
	        	MoveObject(FBIRightGate, -1781.65063477,971.39666748,31.50776672, 5);
				FBIRightGateOpen =1;
				SetTimer("FBIRightGatesClose",7000,0);
			}
        }
    }
}

public FBIRightGatesClose()
{
    MoveObject(FBIRightGate, -1781.65063477,971.39666748,26.50776672, 5);
	FBIRightGateOpen =0;
}

public FBILeftGatesOpen()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
        if(PlayerToPoint(10.0, i, -1781.49548340,996.09625244,26.50776672) && FBILeftGateOpen == 0)
        {
            if(gTeam[i] == TEAM_COP || gTeam[i] == TEAM_ARMY || gTeam[i] == TEAM_CIA)
            {
	        	MoveObject(FBILeftGate, -1781.49548340,996.09625244,31.50776672, 5);
				FBILeftGateOpen =1;
				SetTimer("FBILeftGatesClose",7000,0);
			}
        }
    }
}

public FBILeftGatesClose()
{
    MoveObject(FBILeftGate, -1781.49548340,996.09625244,26.50776672, 5);
	FBILeftGateOpen =0;
}

public CIAGatesOpen()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
        if(PlayerToPoint(10.0, i, -1337.82531738,783.17510986,9.24380112) && CIAGateOpen == 0)
        {
            if(gTeam[i] == TEAM_COP || gTeam[i] == TEAM_ARMY || gTeam[i] == TEAM_CIA)
            {
	        	MoveObject(CIARightGate, -1337.82531738,773.17510986,9.24380112, 5);
				MoveObject(CIALeftGate, -1336.73291016,801.96447754,9.24380112, 5);
				CIAGateOpen =1;
				SetTimer("CIAGatesClose",7000,0);
			}
        }
    }
}

public CIAGatesClose()
{
    MoveObject(CIARightGate, -1337.82531738,783.17510986,9.24380112, 5);
	MoveObject(CIALeftGate, -1336.73291016,791.96447754,9.24380112, 5);
	CIAGateOpen =0;
}

public ArmyGatesOpen()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
        if(PlayerToPoint(10.0, i, -1530.15380859,482.34051514,8.83757210) && ArmyGateOpen == 0)
        {
            if(gTeam[i] == TEAM_COP || gTeam[i] == TEAM_ARMY || gTeam[i] == TEAM_CIA)
            {
	        	MoveObject(ArmyGate, -1540.15380859,482.34051514,8.83757210, 5);
				ArmyGateOpen =1;
				SetTimer("ArmyGatesClose",7000,0);
			}
        }
    }
}

public ArmyGatesClose()
{
    MoveObject(ArmyGate, -1530.15380859,482.34051514,8.83757210, 5);
	ArmyGateOpen =0;
}

public RemoveRoadblock(playerid)
{
	DestroyDynamicObject(PlayerInfo[playerid][pRoadblock]);
	PlayerInfo[playerid][pRoadblock] = 0;
	return 1;
}

public SendClientMessageToAllAdmins(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(AdminLevel[i] >= 1)
			{
			    SendClientMessage(i,COLOR_ADMIN,msg);
			}
		}
	}
}

public SendClientMessageToAllRegulars(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(IsRegularPlayer[i] == 1337)
			{
			    SendClientMessage(i,COLOR_ROYALBLUE,msg);
			}
		}
	}
}

public SendClientMessageToDHOwner(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(DrugHouseOwner[i] == 1337)
			{
			    SendClientMessage(i,COLOR_RED,msg);
			}
		}
	}
}

public SendClientMessageToAllCops(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(HasLawEnforcementRadio[i] == 1)
			{
			    SendClientMessage(i,COLOR_DODGERBLUE,msg);
			}
		}
	}
}

public SendClientMessageToAllMedics(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i] == TEAM_MEDIC)
			{
			    SendClientMessage(i,COLOR_FORESTGREEN,msg);
			}
		}
	}
}

public SendClientMessageToAllDDealers(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i] == TEAM_DRGDEL)
			{
			    SendClientMessage(i,COLOR_RED,msg);
			}
		}
	}
}

public SendClientMessageToAllHitmen(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i] == TEAM_HITMAN)
			{
			    SendClientMessage(i,COLOR_RED,msg);
			}
		}
	}
}

public SendClientMessageToAllGDealers(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i] == TEAM_GUNDEL)
			{
			    SendClientMessage(i,COLOR_LIGHTBLUE,msg);
			}
		}
	}
}

public SendClientMessageToAllMechanics(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i] == TEAM_CARFIX)
			{
			    SendClientMessage(i,COLOR_LIGHTBLUE,msg);
			}
		}
	}
}

public SendClientMessageToAllDrivers(msg[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i] == TEAM_DRIVER)
			{
			    SendClientMessage(i,COLOR_DARKOLIVEGREEN,msg);
			}
		}
	}
}

public TimeWorld()
{
	if(gametime == 0 && gameday == 7 && gameweek == 4)
	{
	     SendRconCommand("gmx");
	}
	gametime++;
	if(gametime >= 24)
	{
		gametime =0;
	}
	if(gametime == 0)
	{
		gameday ++;
	}
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
	    {
        	SetPlayerTime(i,gametime,0);
		}
	}
	new string[30];
	SetWorldTime(gametime);
	format(string, sizeof(string), "[GAME TIME] %d:00", gametime);
	SendClientMessageToAll(COLOR_WHITE, string);
	if(gametime == 0 && gameday == 1)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Monday");
	}
	if(gametime == 0 && gameday == 2)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Tuesday");
	}
	if(gametime == 0 && gameday == 3)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Wednesday");
	}
	if(gametime == 0 && gameday == 4)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Thursday");
	}
	if(gametime == 0 && gameday == 5)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Friday");
	}
	if(gametime == 0 && gameday == 6)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Saturday");
	}
	if(gametime == 0 && gameday == 7)
	{
		SendClientMessageToAll(COLOR_WHITE,"[GAME DAY] Sunday");
	}
	if(gametime == 23 && gameday == 7)
	{
		gameweek ++;
		gameday =1;
		if(gameweek == 1)
		{
			SendClientMessageToAll(COLOR_WHITE,"[GAME WEEK] 1");
		}
		if(gameweek == 2)
		{
			SendClientMessageToAll(COLOR_WHITE,"[GAME WEEK] 2");
		}
		if(gameweek == 3)
		{
			SendClientMessageToAll(COLOR_WHITE,"[GAME WEEK] 3");
		}
		if(gameweek == 4)
		{
			SendClientMessageToAll(COLOR_WHITE,"[GAME WEEK] 4");
		}
	}
	if(gametime == 23 && gameday == 7 && gameweek == 4)
	{
		SendClientMessageToAll(COLOR_ADMIN,"[AUTO ADMIN] The server will restart in one game hour to give it a nice fresh start.");
	}
}

public IncreaseWantedLevel(playerid,Value)
{
	new string[128];
	new pcol =GetPlayerColor(playerid);
	new pwlvl = GetPlayerWantedLevel(playerid);
	pwlvl +=Value;
	SetPlayerWantedLevel(playerid,pwlvl);
	format(string,sizeof(string),"[WANTED LEVEL INCREASE] Your wanted level has been increased to Level: %d",pwlvl);
	SendClientMessage(playerid,pcol,string);
	return 1;
}

public IncreasePlayerScore(playerid,Value)
{
	new pscore = GetPlayerScore(playerid);
	pscore +=Value;
	SetPlayerScore(playerid,pscore);
	return 1;
}

public DecreasePlayerScore(playerid,Value)
{
	new pscore = GetPlayerScore(playerid);
	pscore -=Value;
	SetPlayerScore(playerid,pscore);
	return 1;
}

public HasSTITimer()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(HasSTI[i] == 1)
	    {
	        new string[128];
	        new Float:phealth;
			GetPlayerHealth(i,phealth);
			if(phealth > 5)
			{
			    SetPlayerHealth(i,phealth-5);
			    return 1;
			}
			if(phealth <= 5)
			{
				DiedFromSTI[i] =1;
				SetPlayerHealth(i,phealth-5);
				format(string,sizeof(string),"[STI DEATH] %s(%d) has died from a Sexually Transmitted Infection ..",PlayerName(i),i);
				SendClientMessageToAll(COLOR_PINK,string);

				format(string,sizeof(string),"13[STI DEATH] %s(%d) has died from a Sexually Transmitted Infection ..",PlayerName(i),i);
	            IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
	            return 1;
			}
		}
	}
	return 1;
}

public getCheckpointType(playerID)
{
	return checkpointType[playerCheckpoint[playerID]];
}

public checkpointUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
  		{
		  	for(new j=0; j < MAX_POINTS; j++)
  			{
				if(isPlayerInArea(i, checkCoords[j]))
   				{
   					if(playerCheckpoint[i]!=j)
    				{
					    DisablePlayerCheckpoint(i);
					    SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],checkpoints[j][3]);
					    playerCheckpoint[i] = j;
				    }
   				}
   				else
   				{
   					if(playerCheckpoint[i]==j)
    				{
    					DisablePlayerCheckpoint(i);
    					playerCheckpoint[i] = 999;
    				}
   				}
  			}
  		}
	}
}

public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3])
	{
		return 1;
	}
	return 0;
}

////xobject
public Timer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
		if(IsPlayerConnected(i))
		    PlayerObjectUpdate(i);
}

PlayerObjectUpdate(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	for(new i = 0; i < sizeof(Objects); i++)
	{
	    if(!Player[playerid][view][i])
	    {
	        if(IsInReach(pos[0],pos[1],pos[2],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	        {
	            Player[playerid][view][i] = true;
	            Player[playerid][objid][i] = CreatePlayerObject(playerid,Objects[i][xmodelid],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][orx],Objects[i][ory],Objects[i][orz],350.0);
	        }
	    } else if(!IsInReach(pos[0],pos[1],pos[2],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	    {
            Player[playerid][view][i] = false;
            DestroyPlayerObject(playerid,Player[playerid][objid][i]);
	    }
	}
}

public SetPlayerPosWithObjects(playerid,Float:x,Float:y,Float:z)
{
	for(new i = 0; i < sizeof(Objects); i++)
	{
	    if(!Player[playerid][view][i])
	    {
	        if(IsInReach(x,y,z,Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	        {
	            Player[playerid][view][i] = true;
	            Player[playerid][objid][i] = CreatePlayerObject(playerid,Objects[i][xmodelid],Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][orx],Objects[i][ory],Objects[i][orz],350.0);
	        }
	    } else if(!IsInReach(x,y,z,Objects[i][ox],Objects[i][oy],Objects[i][oz],Objects[i][viewdist]))
	    {
            Player[playerid][view][i] = false;
            DestroyPlayerObject(playerid,Player[playerid][objid][i]);
	    }
	}
	SetPlayerPos(playerid,Float:x,Float:y,Float:z);
}

public IsAPlane(carid)
{
	if(GetVehicleModel(carid) == 519 ||////Shamal
	GetVehicleModel(carid) == 520 ||////Hydra
	GetVehicleModel(carid) == 476 ||////Rustler
	GetVehicleModel(carid) == 593 ||////Dodo
	GetVehicleModel(carid) == 553 ||////Nevada
	GetVehicleModel(carid) == 513 ||////Stuntplane
	GetVehicleModel(carid) == 512 ||////Cropdust
	GetVehicleModel(carid) == 577 ||////At-400
	GetVehicleModel(carid) == 592 ||////Andromeda
	GetVehicleModel(carid) == 511 ||////Beagle
	GetVehicleModel(carid) == 539 ||////Vortex
	GetVehicleModel(carid) == 464 ||////Rc-Barron
	GetVehicleModel(carid) == 460) ////Skimmer
	{
		return 1;
	}
	return 0;
}

public IsACycleBike(carid)
{
	if(GetVehicleModel(carid) == 509 ||////Bike
	GetVehicleModel(carid) == 481 ||////BMX
	GetVehicleModel(carid) == 510) ////Mountain Bike
	{
		return 1;
	}
	return 0;
}

public HasIlegalWeapon(playerid)
{
	if(GetPlayerWeapon(playerid) == 16 || GetPlayerWeapon(playerid) == 17 || GetPlayerWeapon(playerid) == 35 ||
	GetPlayerWeapon(playerid) == 36 || GetPlayerWeapon(playerid) == 37 || GetPlayerWeapon(playerid) == 38 ||
	GetPlayerWeapon(playerid) == 39 || GetPlayerWeapon(playerid) == 40 || GetPlayerWeapon(playerid) == 18)
	{
	    return 1;
	}
	return 0;
}

public ServerOneSecondVariables()
{
	//Supa Save robbed recently
	if(SupaSaveRobbedRecently >= 1)
	{
	    SupaSaveRobbedRecently --;
	}
	
	//Ammunation robbed recently
	if(AmmunationRobbedRecently >= 1)
	{
	    AmmunationRobbedRecently --;
	}
	
	//GYM robbed recently
	if(GYMRobbedRecently >= 1)
	{
	    GYMRobbedRecently --;
	}
	
	//City Hall Robbed Recently
	if(CityHallRobbedRecently >= 1)
	{
	    CityHallRobbedRecently --;
	}
	
	//Espanade Pizza robbed recently
	if(EsplanadePizzaRobbedRecently >= 1)
	{
	    EsplanadePizzaRobbedRecently --;
	}
	
	//Financial Pizza robbed recently
	if(FinancialPizzaRobbedRecently >= 1)
	{
	    FinancialPizzaRobbedRecently --;
	}
	
	//Downtown Victim robbed recently
	if(DownVictimRobbedRecently >= 1)
	{
	    DownVictimRobbedRecently --;
	}
	
	//Juniper Hill Binco robbed recently
	if(JHBincoRobbedRecently >= 1)
	{
	    JHBincoRobbedRecently --;
	}
	
	//Downtown Zip robbed recently
	if(DownZipRobbedRecently >= 1)
	{
	    DownZipRobbedRecently --;
	}
	
	//Jizzys robbed recently
	if(JizzysRobbedRecently >= 1)
	{
	    JizzysRobbedRecently --;
	}
	
	//Hospital robbed recently
	if(HospitalRobbedRecently >= 1)
	{
	    HospitalRobbedRecently --;
	}
	
	//Train Station robbed recently
	if(TrainRobbedRecently >= 1)
	{
	    TrainRobbedRecently --;
	}
	
	//Barbers robbed recently
	if(BarbersRobbedRecently >= 1)
	{
	    BarbersRobbedRecently --;
	}
	
	//Wang Cars robbed recently
	if(WangRobbedRecently >= 1)
	{
	    WangRobbedRecently --;
	}
	
	//Driving School robbed recently
	if(SchoolRobbedRecently >= 1)
	{
	    SchoolRobbedRecently --;
	}
	
	//Mistys robbed recently
	if(MistysRobbedRecently >= 1)
	{
	    MistysRobbedRecently --;
	}
	
	//GayDarStation robbed recently
	if(GayDarRobbedRecently >= 1)
	{
	    GayDarRobbedRecently --;
	}
	
	//Zero's robbed recently
	if(ZeroRobbedRecently >= 1)
	{
	    ZeroRobbedRecently --;
	}
	
	//Ocean CluckinBell robbed recently
	if(OceanCluckinBellRobbedRecently >= 1)
	{
	    OceanCluckinBellRobbedRecently --;
	}
	
	//Down CluckinBell robbed recently
	if(DownCluckinBellRobbedRecently >= 1)
	{
	    DownCluckinBellRobbedRecently --;
	}
	
	//Garcia Burger Shot robbed recently
	if(GarciaBurgerShotRobbedRecently >= 1)
	{
	    GarciaBurgerShotRobbedRecently --;
	}
	
	//Downtown Burger Shot robbed recently
	if(DownBurgerShotRobbedRecently >= 1)
	{
	    DownBurgerShotRobbedRecently --;
	}
	
	//Juniper Hollow Burger Shot robbed recently
	if(JHBurgerShotRobbedRecently >= 1)
	{
	    JHBurgerShotRobbedRecently --;
	}
	
	//Drug House robbed recently
	if(DrugHouseRobbedRecently >= 1)
	{
	    DrugHouseRobbedRecently --;
	}
	
	//Otto's robbed recently
	if(OttoRobbedRecently >= 1)
	{
	    OttoRobbedRecently --;
	}
	
	//CIA Building Blown
	if(CIABuildingBlown >= 1)
	{
	    CIABuildingBlown --;
	}
	
	//CIA Satelite Blown
	if(CIASatBlown >= 1)
	{
	    CIASatBlown --;
	}
	
	//CIA Bridge Blown
	if(CIABridgeBlown >= 1)
	{
	    CIABridgeBlown --;
	}
	
	//Car bomb explosion
	for(new v=0; v<MAX_VEHICLES; v++)
	{
	    if(VehicleInfo[v][bombed] > 1)
	    {
	        VehicleInfo[v][bombed] --;
		}
		if(VehicleInfo[v][bombed] == 1)
		{
		    new Float:x, Float:y, Float:z;
		    GetVehiclePos(v, x, y, z);

			CreateExplosion(x, y, z, 6, 10.0);
		    SetVehicleToRespawn(v);
		    VehicleInfo[v][bombed] =0;
		}
	}
}

public PlayerOneSecondVariables()
{
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new string[128];
	        new pname[24];
	        GetPlayerName(i,pname,sizeof(pname));
	        
	        //Robberies//
	        if(RobbingSupaSave[i] > 1)
	        {
	            RobbingSupaSave[i] --;
				format(string,sizeof(string),"Robbing Supa Save.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingSupaSave[i]);
				ShowPlayerDialog(i,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Robbery",string,"Ok","Cancel");
			}
			if(RobbingSupaSave[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingSupaSave[i] =0;
				format(string,sizeof(string),"Supa Save Robbery Complete.\nYou robbed a total of $%d from Supa Save.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_SUPASAVE,DIALOG_STYLE_MSGBOX,"{FF0000}Supa Save Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);
				
				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}
				
				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from Supa Save! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);
				
				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Supa Save! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);
				
				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Supa Save! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingAmmunation[i] > 1)
	        {
	            RobbingAmmunation[i] --;
				format(string,sizeof(string),"Robbing Ammunation.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingAmmunation[i]);
				ShowPlayerDialog(i,DIALOG_AMMUNATION,DIALOG_STYLE_MSGBOX,"{FF0000}Ammunation Robbery",string,"Ok","Cancel");
			}
			if(RobbingAmmunation[i] == 1)
			{
			    new mrand =random(150000);
			    RobbingAmmunation[i] =0;
				format(string,sizeof(string),"Ammunation Robbery Complete.\nYou robbed a total of $%d from Ammunation.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_AMMUNATION,DIALOG_STYLE_MSGBOX,"{FF0000}Ammunation Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Ammunation! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Ammunation! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Ammunation! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingJizzys[i] > 1)
	        {
	            RobbingJizzys[i] --;
				format(string,sizeof(string),"Robbing Jizzy's.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingJizzys[i]);
				ShowPlayerDialog(i,DIALOG_JIZZYS,DIALOG_STYLE_MSGBOX,"{FF0000}Jizzy's Robbery",string,"Ok","Cancel");
			}
			if(RobbingJizzys[i] == 1)
			{
			    new mrand =random(150000);
			    RobbingJizzys[i] =0;
				format(string,sizeof(string),"Jizzy's Robbery Complete.\nYou robbed a total of $%d from Jizzy's.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_JIZZYS,DIALOG_STYLE_MSGBOX,"{FF0000}Jizzy's Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from Jizzy's! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Jizzy's! Someone is going to be killed ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Jizzy's! Someone is going to be killed ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingCityHall[i] > 1)
	        {
	            RobbingCityHall[i] --;
				format(string,sizeof(string),"Robbing City Hall.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingCityHall[i]);
				ShowPlayerDialog(i,DIALOG_CITYHALL,DIALOG_STYLE_MSGBOX,"{FF0000}City Hall Robbery",string,"Ok","Cancel");
			}
			if(RobbingCityHall[i] == 1)
			{
			    new mrand =random(150000);
			    RobbingCityHall[i] =0;
				format(string,sizeof(string),"City Hall Robbery Complete.\nYou robbed a total of $%d from the City Hall.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_CITYHALL,DIALOG_STYLE_MSGBOX,"{FF0000}City Hall Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the City Hall! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the City Hall! The Mayor isn't happy ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the City Hall! The Mayor isn't happy ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingHospital[i] > 1)
	        {
	            RobbingHospital[i] --;
				format(string,sizeof(string),"Robbing Hospital.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingHospital[i]);
				ShowPlayerDialog(i,DIALOG_HOSPITAL,DIALOG_STYLE_MSGBOX,"{FF0000}Hospital Robbery",string,"Ok","Cancel");
			}
			if(RobbingHospital[i] == 1)
			{
			    new mrand =random(150000);
			    RobbingHospital[i] =0;
				format(string,sizeof(string),"Hospital Robbery Complete.\nYou robbed a total of $%d from the Hospital.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_HOSPITAL,DIALOG_STYLE_MSGBOX,"{FF0000}Hospital Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Hospital! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the Hospital! Someone doesn't like sick people ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the Hospital! Someone doesn't like sick people ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingBarbers[i] > 1)
	        {
	            RobbingBarbers[i] --;
				format(string,sizeof(string),"Robbing Barbers.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingBarbers[i]);
				ShowPlayerDialog(i,DIALOG_BARBERS,DIALOG_STYLE_MSGBOX,"{FF0000}Barbers Robbery",string,"Ok","Cancel");
			}
			if(RobbingBarbers[i] == 1)
			{
			    new mrand =random(150000);
			    RobbingBarbers[i] =0;
				format(string,sizeof(string),"Barbers Robbery Complete.\nYou robbed a total of $%d from the Barbers.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_BARBERS,DIALOG_STYLE_MSGBOX,"{FF0000}Barbers Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Barbers! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the Barbers! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the Barbers! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingTrain[i] > 1)
	        {
	            RobbingTrain[i] --;
				format(string,sizeof(string),"Robbing Train Station.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingTrain[i]);
				ShowPlayerDialog(i,DIALOG_TRAIN,DIALOG_STYLE_MSGBOX,"{FF0000}Train Station Robbery",string,"Ok","Cancel");
			}
			if(RobbingTrain[i] == 1)
			{
			    new mrand =random(150000);
			    RobbingTrain[i] =0;
				format(string,sizeof(string),"Train Station Robbery Complete.\nYou robbed a total of $%d from the Train Station.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_TRAIN,DIALOG_STYLE_MSGBOX,"{FF0000}Train Station Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Train Station! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the Train Station! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the Train Station! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingWang[i] > 1)
	        {
	            RobbingWang[i] --;
				format(string,sizeof(string),"Robbing Wang Cars.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingWang[i]);
				ShowPlayerDialog(i,DIALOG_WANGCARS,DIALOG_STYLE_MSGBOX,"{FF0000}Wang Cars Robbery",string,"Ok","Cancel");
			}
			if(RobbingWang[i] == 1)
			{
			    new mrand =random(200000);
			    RobbingWang[i] =0;
				format(string,sizeof(string),"Wang Cars Robbery Complete.\nYou robbed a total of $%d from Wang Cars.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_WANGCARS,DIALOG_STYLE_MSGBOX,"{FF0000}Wang Cars Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Wang Cars! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Wang Cars! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Wang Cars! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingGayDar[i] > 1)
	        {
	            RobbingGayDar[i] --;
				format(string,sizeof(string),"Robbing Gay Dar Station.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingGayDar[i]);
				ShowPlayerDialog(i,DIALOG_GAYDAR,DIALOG_STYLE_MSGBOX,"{FF0000}Gay Dar Station Robbery",string,"Ok","Cancel");
			}
			if(RobbingGayDar[i] == 1)
			{
			    new mrand =random(100000);
			    RobbingGayDar[i] =0;
				format(string,sizeof(string),"Gay Dar Station Robbery Complete.\nYou robbed a total of $%d from Gay Dar Station.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_GAYDAR,DIALOG_STYLE_MSGBOX,"{FF0000}Gay Dar Station Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from Gay Dar Station! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Gay Dar Station! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Gay Dar Station! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingGYM[i] > 1)
	        {
	            RobbingGYM[i] --;
				format(string,sizeof(string),"Robbing GYM.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingGYM[i]);
				ShowPlayerDialog(i,DIALOG_GYM,DIALOG_STYLE_MSGBOX,"{FF0000}GYM Robbery",string,"Ok","Cancel");
			}
			if(RobbingGYM[i] == 1)
			{
			    new mrand =random(100000);
			    RobbingGYM[i] =0;
				format(string,sizeof(string),"GYM Robbery Complete.\nYou robbed a total of $%d from the GYM.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_GYM,DIALOG_STYLE_MSGBOX,"{FF0000}GYM Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the GYM! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the GYM! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the GYM! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingSchool[i] > 1)
	        {
	            RobbingSchool[i] --;
				format(string,sizeof(string),"Robbing Driving School.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingSchool[i]);
				ShowPlayerDialog(i,DIALOG_SCHOOL,DIALOG_STYLE_MSGBOX,"{FF0000}Driving School Robbery",string,"Ok","Cancel");
			}
			if(RobbingSchool[i] == 1)
			{
			    new mrand =random(100000);
			    RobbingSchool[i] =0;
				format(string,sizeof(string),"Driving School Robbery Complete.\nYou robbed a total of $%d from the Driving School.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_SCHOOL,DIALOG_STYLE_MSGBOX,"{FF0000}Driving School Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Driving School! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the Driving School! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the Driving School! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingZero[i] > 1)
	        {
	            RobbingZero[i] --;
				format(string,sizeof(string),"Robbing Zero's.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingZero[i]);
				ShowPlayerDialog(i,DIALOG_ZERO,DIALOG_STYLE_MSGBOX,"{FF0000}Zero's Robbery",string,"Ok","Cancel");
			}
			if(RobbingZero[i] == 1)
			{
			    new mrand =random(100000);
			    RobbingZero[i] =0;
				format(string,sizeof(string),"Zero's Robbery Complete.\nYou robbed a total of $%d from Zero's.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_ZERO,DIALOG_STYLE_MSGBOX,"{FF0000}Zero's Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from Zero's! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Zero's! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Zero's! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingMistys[i] > 1)
	        {
	            RobbingMistys[i] --;
				format(string,sizeof(string),"Robbing Misty's.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingMistys[i]);
				ShowPlayerDialog(i,DIALOG_MISTYS,DIALOG_STYLE_MSGBOX,"{FF0000}Misty's Robbery",string,"Ok","Cancel");
			}
			if(RobbingMistys[i] == 1)
			{
			    new mrand =random(100000);
			    RobbingMistys[i] =0;
				format(string,sizeof(string),"Misty's Robbery Complete.\nYou robbed a total of $%d from Misty's.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_MISTYS,DIALOG_STYLE_MSGBOX,"{FF0000}Misty's Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from Misty's! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Misty's! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Misty's! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingEsplanadePizza[i] > 1)
	        {
	            RobbingEsplanadePizza[i] --;
				format(string,sizeof(string),"Robbing Well Stacked Pizza.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingEsplanadePizza[i]);
				ShowPlayerDialog(i,DIALOG_PIZZA,DIALOG_STYLE_MSGBOX,"{FF0000}Well Stacked Pizza Robbery",string,"Ok","Cancel");
			}
			if(RobbingEsplanadePizza[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingEsplanadePizza[i] =0;
				format(string,sizeof(string),"Well Stacked Pizza Robbery Complete.\nYou robbed a total of $%d from Well Stacked Pizza.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_PIZZA,DIALOG_STYLE_MSGBOX,"{FF0000}Well Stacked Pizza Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Esplanade Well Stacked Pizza! Go and arrest the suspect.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Well Stacked Pizza! Free meals all around ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Well Stacked Pizza! Free meals all around ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingFinancialPizza[i] > 1)
	        {
	            RobbingFinancialPizza[i] --;
				format(string,sizeof(string),"Robbing Well Stacked Pizza.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingFinancialPizza[i]);
				ShowPlayerDialog(i,DIALOG_PIZZA,DIALOG_STYLE_MSGBOX,"{FF0000}Well Stacked Pizza Robbery",string,"Ok","Cancel");
			}
			if(RobbingFinancialPizza[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingFinancialPizza[i] =0;
				format(string,sizeof(string),"Well Stacked Pizza Robbery Complete.\nYou robbed a total of $%d from Well Stacked Pizza.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_PIZZA,DIALOG_STYLE_MSGBOX,"{FF0000}Well Stacked Pizza Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Financial Well Stacked Pizza! Go and arrest the suspect.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Well Stacked Pizza! Free meals all around ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Well Stacked Pizza! Free meals all around ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingDownVictim[i] > 1)
	        {
	            RobbingDownVictim[i] --;
				format(string,sizeof(string),"Robbing Victim.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownVictim[i]);
				ShowPlayerDialog(i,DIALOG_VICTIM,DIALOG_STYLE_MSGBOX,"{FF0000}Victim Robbery",string,"Ok","Cancel");
			}
			if(RobbingDownVictim[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingDownVictim[i] =0;
				format(string,sizeof(string),"Victim Robbery Complete.\nYou robbed a total of $%d from Victim.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_VICTIM,DIALOG_STYLE_MSGBOX,"{FF0000}Victim Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Downtown Victim! Go and arrest the suspect.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Victim! Clothes prices have rocketed! ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Victim! Clothes prices have rocketed! ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingJHBinco[i] > 1)
	        {
	            RobbingJHBinco[i] --;
				format(string,sizeof(string),"Robbing Binco.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingJHBinco[i]);
				ShowPlayerDialog(i,DIALOG_BINCO,DIALOG_STYLE_MSGBOX,"{FF0000}Binco Robbery",string,"Ok","Cancel");
			}
			if(RobbingJHBinco[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingJHBinco[i] =0;
				format(string,sizeof(string),"Binco Robbery Complete.\nYou robbed a total of $%d from Binco.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_BINCO,DIALOG_STYLE_MSGBOX,"{FF0000}Binco Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Juniper Hill Binco! Go and arrest the suspect.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Binco! Clothes prices have rocketed! ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Binco! Clothes prices have rocketed! ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingDownZip[i] > 1)
	        {
	            RobbingDownZip[i] --;
				format(string,sizeof(string),"Robbing Zip.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownZip[i]);
				ShowPlayerDialog(i,DIALOG_ZIP,DIALOG_STYLE_MSGBOX,"{FF0000}Zip Robbery",string,"Ok","Cancel");
			}
			if(RobbingDownZip[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingDownZip[i] =0;
				format(string,sizeof(string),"Zip Robbery Complete.\nYou robbed a total of $%d from Zip.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_ZIP,DIALOG_STYLE_MSGBOX,"{FF0000}Zip Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Downtown Zip! Go and arrest the suspect.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Zip! Jeans prices have rocketed! ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Zip! Jeans prices have rocketed! ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingGarciaBurgerShot[i] > 1)
	        {
	            RobbingGarciaBurgerShot[i] --;
				format(string,sizeof(string),"Robbing Burger Shot.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingGarciaBurgerShot[i]);
				ShowPlayerDialog(i,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");
			}
			if(RobbingGarciaBurgerShot[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingGarciaBurgerShot[i] =0;
				format(string,sizeof(string),"Burger Shot Robbery Complete.\nYou robbed a total of $%d from Burger Shot.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Garcia Burger Shot! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Burger Shot! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Burger Shot! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingDownBurgerShot[i] > 1)
	        {
	            RobbingDownBurgerShot[i] --;
				format(string,sizeof(string),"Robbing Burger Shot.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownBurgerShot[i]);
				ShowPlayerDialog(i,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");
			}
			if(RobbingDownBurgerShot[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingDownBurgerShot[i] =0;
				format(string,sizeof(string),"Burger Shot Robbery Complete.\nYou robbed a total of $%d from Burger Shot.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Downtown Burger Shot! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Burger Shot! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Burger Shot! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingJHBurgerShot[i] > 1)
	        {
	            RobbingJHBurgerShot[i] --;
				format(string,sizeof(string),"Robbing Burger Shot.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingJHBurgerShot[i]);
				ShowPlayerDialog(i,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");
			}
			if(RobbingJHBurgerShot[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingJHBurgerShot[i] =0;
				format(string,sizeof(string),"Burger Shot Robbery Complete.\nYou robbed a total of $%d from Burger Shot.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_BURGERSHOT,DIALOG_STYLE_MSGBOX,"{FF0000}Burger Shot Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Juniper Hollow Burger Shot! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Burger Shot! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Burger Shot! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingOceanCluckinBell[i] > 1)
	        {
	            RobbingOceanCluckinBell[i] --;
				format(string,sizeof(string),"Robbing Cluckin Bell.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingOceanCluckinBell[i]);
				ShowPlayerDialog(i,DIALOG_CLUCKINBELL,DIALOG_STYLE_MSGBOX,"{FF0000}Cluckin Bell Robbery",string,"Ok","Cancel");
			}
			if(RobbingOceanCluckinBell[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingOceanCluckinBell[i] =0;
				format(string,sizeof(string),"Cluckin Bell Robbery Complete.\nYou robbed a total of $%d from Cluckin Bell.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_CLUCKINBELL,DIALOG_STYLE_MSGBOX,"{FF0000}Cluckin Bell Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Ocean Flats Cluckin Bell! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Cluckin Bell! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Cluckin Bell! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingDownCluckinBell[i] > 1)
	        {
	            RobbingDownCluckinBell[i] --;
				format(string,sizeof(string),"Robbing Cluckin Bell.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDownCluckinBell[i]);
				ShowPlayerDialog(i,DIALOG_CLUCKINBELL,DIALOG_STYLE_MSGBOX,"{FF0000}Cluckin Bell Robbery",string,"Ok","Cancel");
			}
			if(RobbingDownCluckinBell[i] == 1)
			{
			    new mrand =random(50000);
			    RobbingDownCluckinBell[i] =0;
				format(string,sizeof(string),"Cluckin Bell Robbery Complete.\nYou robbed a total of $%d from Cluckin Bell.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_CLUCKINBELL,DIALOG_STYLE_MSGBOX,"{FF0000}Cluckin Bell Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);

				if(RobSkill[i] < 20)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Downtown Cluckin Bell! Get after the suspect and arrest them.",pname,i,mrand);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Cluckin Bell! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Cluckin Bell! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			}
			if(RobbingDrugHouse[i] > 1)
	        {
	            RobbingDrugHouse[i] --;
				format(string,sizeof(string),"Robbing Drug House.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingDrugHouse[i]);
				ShowPlayerDialog(i,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Robbery",string,"Ok","Cancel");
			}
			if(RobbingDrugHouse[i] == 1)
			{
			    new current_zone;
			    current_zone = player_zone[i];
			    new mrand =random(100000);
			    RobbingDrugHouse[i] =0;
				format(string,sizeof(string),"Drug House Robbery Complete.\nYou robbed a total of $%d from the Drug House.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_DRUGHOUSE,DIALOG_STYLE_MSGBOX,"{FF0000}Drug House Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);
				
				if(RobSkill[i] < 30)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from the Drug House! Location: %s.",pname,i,mrand,zones[current_zone][zone_name]);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from the %s Drug House! Someone is having an early holiday ..",pname,i,mrand,zones[current_zone][zone_name]);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from the %s Drug House! Someone is having an early holiday ..",pname,i,mrand,zones[current_zone][zone_name]);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				for(new j=0; j<MAX_PLAYERS; j++)
				{
				    if(DrugHouseOwner[j] == 1337)
				    {
				        format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed $%d from your %s Drug House.",pname,i,mrand,zones[current_zone][zone_name]);
						SendClientMessage(j,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(j,-mrand);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(DrugHouseOwnerName).("Bankcash");
				bcash -=mrand;
				dUserSetINT(DrugHouseOwnerName).("Bankcash",bcash);
			}
			if(RobbingOtto[i] > 1)
	        {
	            RobbingOtto[i] --;
				format(string,sizeof(string),"Robbing Otto's Cars.\nFinish Robbery in: %d seconds.\nPolice are on the way.",RobbingOtto[i]);
				ShowPlayerDialog(i,DIALOG_OTTO,DIALOG_STYLE_MSGBOX,"{FF0000}Otto's Cars Robbery",string,"Ok","Cancel");
			}
			if(RobbingOtto[i] == 1)
			{
			    new current_zone;
			    current_zone = player_zone[i];
			    new mrand =random(200000);
			    RobbingOtto[i] =0;
				format(string,sizeof(string),"Otto's Cars Robbery Complete.\nYou robbed a total of $%d from Otto's Cars.\nWatch out for police!",mrand);
                ShowPlayerDialog(i,DIALOG_OTTO,DIALOG_STYLE_MSGBOX,"{FF0000}Otto's Cars Robbery",string,"Ok","Cancel");
				SendClientMessage(i,COLOR_RED,string);
				GivePlayerMoney(i,mrand);
				
				if(RobSkill[i] < 40)
				{
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your robbing skill has increased. You can check /robskill to see your skill level and see what you can rob next.");
				    RobSkill[i] ++;
				}

				format(string,sizeof(string),"[POLICE RADIO] Robbery: Suspect %s(%d) has robbed a total of $%d from Otto's Cars! Location: %s.",pname,i,mrand,zones[current_zone][zone_name]);
				SendClientMessageToAllCops(string);

				format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed a total of $%d from Otto's Cars! Someone is having an early holiday ..",pname,i,mrand);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[ROBBERY] %s(%d) has robbed a total of $%d from Otto's Cars! Someone is having an early holiday ..",pname,i,mrand);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				for(new j=0; j<MAX_PLAYERS; j++)
				{
				    if(OttoOwner[j] == 1337)
				    {
				        format(string,sizeof(string),"[ROBBERY] %s(%d) has robbed $%d from your Otto's Cars business.",pname,i,mrand);
						SendClientMessage(j,COLOR_LIGHTBLUE,string);
						GivePlayerMoney(j,-mrand);
						return 1;
					}
				}
				new bcash;
				bcash = dUserINT(OttoOwnerName).("Bankcash");
				bcash -=mrand;
				dUserSetINT(OttoOwnerName).("Bankcash",bcash);
			}
			
			//Anti Weapon Cheat
			if(HasIlegalWeapon(i))
			{
			    if(IsSpawned[i] == 1)
			    {
			        if(PLAYERLIST_authed[i] == 1)
			        {
					    if(AdminLevel[i] == 0)
					    {
						    format(string,sizeof(string),"[AUTO BAN] %s(%d) has been banned by the Anti-Cheat for spawning an ilegal weapon.",pname,i);
						    SendClientMessageToAll(COLOR_ADMIN,string);

						    SendClientMessage(i,COLOR_RED,"You have been banned from this server for spawning an ilegal weapon.");
						    SendClientMessage(i,COLOR_RED,"You can appeal this ban on the forums, but we usually don't unban hackers.");

						    format(string,sizeof(string),"9[AUTO BAN] %s(%d) has been banned by the Anti-Cheat for spawning an ilegal weapon.",pname,i);
							IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
							Banning[i] =1;
							SetTimer("BanPlayer",700,0);
						}
					}
				}
			}
			
			//Anti Jetpack Cheat
			new pSpecialAction = GetPlayerSpecialAction(i);
   			if (pSpecialAction == SPECIAL_ACTION_USEJETPACK && AdminLevel[i] == 0 && IsSpawned[i] == 1)
			{
			    format(string,sizeof(string),"[AUTO BAN] %s(%d) has been banned by the Anti-Cheat for spawning a jetpack.",pname,i);
			    SendClientMessageToAll(COLOR_ADMIN,string);
			    
			    SendClientMessage(i,COLOR_RED,"You have been banned from this server for spawning a jetpack.");
			    SendClientMessage(i,COLOR_RED,"You can appeal this ban on the forums, but we usually don't unban hackers.");

			    format(string,sizeof(string),"9[AUTO BAN] %s(%d) has been banned by the Anti-Cheat for spawning a jetpack.",pname,i);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				Banning[i] =1;
				SetTimer("BanPlayer",700,0);
			}
			
			//Cash Increases && Anti Cash-Hack
			if(GetPlayerMoney(i) > OldCash[i])
			{
				new difference;
				difference = GetPlayerMoney(i) - OldCash[i];
				new current_zone;
    			current_zone = player_zone[i];
                format(string, sizeof(string), "14[CASH INCREASE] %s(%d)'s money has increased from $%d to $%d (Total: %d). Location: %s",pname,i,OldCash[i],GetPlayerMoney(i),difference,zones[current_zone][zone_name]);
				IRC_GroupSay(gGroupID, IRC_CHANNEL,string);
				if(difference >= 1500000 && AdminLevel[i] == 0)
				{
				ResetPlayerMoney(i);
				format(string, sizeof(string), "[AUTO BAN] %s(%d) has been banned by the Anti-Cheat for cash hacking.",pname,i);
				SendClientMessageToAll(COLOR_ADMIN, string);
				
				format(string, sizeof(string), "9[AUTO BAN] %s(%d) has been banned by the Anti-Cheat for cash hacking.",pname,i);
				IRC_GroupSay(gGroupID, IRC_CHANNEL,string);
				
				SendClientMessage(i,COLOR_RED,"You have been banned from this server for spawning money.");
			    SendClientMessage(i,COLOR_RED,"You can appeal this ban on the forums, but we usually don't unban hackers.");

				Banning[i] =1;
				SetTimer("BanPlayer",700,0);
				}
				OldCash[i] = GetPlayerMoney(i);
			}
			if(GetPlayerMoney(i) < OldCash[i])
			{
			    OldCash[i] = GetPlayerMoney(i);
			}
	        
	        //SPAM
	        if(SpamStrings[i] >= 1)
			{
				SpamStrings[i] -=2;
			}
	        
	        //MessageTDTime
	        if(MessageTDTime[i] > 1)
	        {
	            MessageTDTime[i] --;
			}
			if(MessageTDTime[i] == 1)
			{
				TextDrawHideForPlayer(i,MessageTD[i]);
			}
			
			//Sat Timer
			if(StoppedSatViewing[i] > 1)
			{
			    StoppedSatViewing[i] --;
			}
			if(StoppedSatViewing[i] == 1)
			{
			    StoppedSatViewing[i] =0;
			    ResetPlayerWeapons(i);
			    
			    for(new w=0; w<13; w++)
				{
					GivePlayerWeapon(i,PlayerWeapon[i][w],PlayerAmmo[i][w]);
				}
			}
			
			//Tackled
			if(IsTackled[i] > 1)
			{
			    IsTackled[i] --;
			}
			if(IsTackled[i] == 1)
			{
			    IsTackled[i] =0;
			    if(IsCuffed[i] == 0)
			    {
			    	TogglePlayerControllable(i,1);
				}
			}
			
			//Attempted to Tackle
			if(AttemptedToTackleRecently[i] >= 1)
			{
			    AttemptedToTackleRecently[i] --;
			}
			
			//Attempted to Rob
			if(AttemptedToRobRecently[i] >= 1)
			{
			    AttemptedToRobRecently[i] --;
			}
			
			//Attempted to Kidnap
			if(AttemptedToKidnapRecently[i] >= 1)
			{
			    AttemptedToKidnapRecently[i] --;
			}
			
			//Attempted to Rape
			if(AttemptedToRapeRecently[i] >= 1)
			{
			    AttemptedToRapeRecently[i] --;
			}
			
			//Called for medic
			if(CalledForMedic[i] >= 1)
			{
			    CalledForMedic[i] --;
			}
			
			//Called For Weapon Dealer
			if(CalledForWeaponDealer[i] >= 1)
			{
			    CalledForWeaponDealer[i] --;
			}
			
			//Called for taxi
			if(CalledForTaxi[i] >= 1)
			{
			    CalledForTaxi[i] --;
			}
			
			//Called for Drug Dealer
			if(CalledForDrugDealer[i] >= 1)
			{
			    CalledForDrugDealer[i] --;
			}
			
			//Called for mechanic
			if(CalledForMechanic[i] >= 1)
			{
			    CalledForMechanic[i] --;
			}
			
			//Given weed recently
			if(GivenWeedRecently[i] >= 1)
			{
			    GivenWeedRecently[i] --;
			}
			
			//Placed Hit Recently
			if(PlacedHitRecently[i] >= 1)
			{
			    PlacedHitRecently[i] --;
			}
			
			//Given weapon recently
			if(GivenWeaponRecently[i] >= 1)
			{
			    GivenWeaponRecently[i] --;
			}
			
			//Give heroin recently
			if(GivenHeroinRecently[i] >= 1)
			{
			    GivenHeroinRecently[i] --;
			}
			
			//Has raped recently
			if(HasRapedRecently[i] >= 1)
			{
			    HasRapedRecently[i] --;
			}
			
			//Has blown vehicle recently
			if(HasBlownVehicleRecently[i] >= 1)
			{
			    HasBlownVehicleRecently[i] --;
			}
			
			//Has robbed recently
			if(HasRobbedRecently[i] >= 1)
			{
			    HasRobbedRecently[i] --;
			}
			
			//Has kidnapped recently
			if(HasKidnappedRecently[i] >= 1)
			{
			    HasKidnappedRecently[i] --;
			}
			
			//Kidnap Escape
			if(IsKidnapped[i] > 1)
			{
			    IsKidnapped[i] --;
			}
			if(IsKidnapped[i] == 1)
			{
			    SendClientMessage(i,COLOR_ERROR,"You have managed to wiggle out of the rope and have gotten free! Run!");
			    IsKidnapped[i] =0;
			    TogglePlayerControllable(i,1);
			}
			
			//Has Hit
			if(HasHit[i] >= 1)
			{
			    HasHit[i] --;
			}
			
			//Smoking Weed
			if(SmokingWeed[i] > 1)
			{
			    new Float:phealth;
			    GetPlayerHealth(i,phealth);
			    SmokingWeed[i] --;
			    if(phealth < 100)
			    {
			        SetPlayerHealth(i,phealth+1);
				}
			}
			if(SmokingWeed[i] == 1)
			{
			    SendClientMessage(i,COLOR_ERROR,"Your joint has gone out, you have finished smoking the weed.");
			    SmokingWeed[i] =0;
			    SetPlayerDrunkLevel(i,0);
			}
			
			//Injected Heroin
			if(InjectedHeroin[i] > 1)
			{
				InjectedHeroin[i] --;
			}
			if(InjectedHeroin[i] == 1)
			{
			    InjectedHeroin[i] =0;
			    SendClientMessage(i,COLOR_ERROR,"The effects of your heroin have worn off. You feel normal now.");
			}
			
			//Weapons in prison
			if(GetPlayerWeapon(i) != 0)
			{
			    if(JailTime[i] >= 1)
			    {
					ResetPlayerWeapons(i);
				}
			}
			
			//Has Eaten Sausage Recently
			if(HasEatenSausageRecently[i] >= 1)
			{
			    HasEatenSausageRecently[i] --;
			}
	        
	        //JailTime
	        if(JailTime[i] > 1)
	        {
	            //Timer
	            format(string,sizeof(string),"Jailtime: %d",JailTime[i]);
	            TextDrawSetString(JailTimer[i],string);
	            
	            JailTime[i] --;
			}
			if(JailTime[i] == 1)
			{
			    format(string,sizeof(string),"[JAIL] %s(%d) has been released from San Fierro Prison after %d seconds in jail.",pname,i,TotalJailTime[i]);
			    SendClientMessageToAll(COLOR_ORANGE,string);
			    format(string,sizeof(string),"7[JAIL] %s(%d) has been released from San Fierro Prison after %d seconds in jail.",pname,i,TotalJailTime[i]);
			    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

				TotalJailTime[i] =0;
				JailTime[i] =0;
				TextDrawHideForPlayer(i,JailTimer[i]);
				
				SetPlayerPos(i,225.8451,112.8976,1003.2188);
				SetPlayerFacingAngle(i,1.0816);
				SetCameraBehindPlayer(i);
			}
			
			//Cuff time
			if(CuffTime[i] > 1)
			{
			    CuffTime[i] --;
			}
			if(CuffTime[i] == 1)
			{
			    format(string,sizeof(string),"[AUTO ADMIN] %s(%d) has been uncuffed by our anti-abuse system.",pname,i);
			    SendClientMessageToAll(COLOR_ADMIN,string);
			    format(string,sizeof(string),"9[AUTO ADMIN] %s(%d) has been uncuffed by our anti-abuse system.",pname,i);
			    IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			    
			    IsCuffed[i] =0;
			    CuffTime[i] =0;
			    StopLoopingAnim(i);
			    TogglePlayerControllable(i,1);
			}
	        
	        //Ticket time
	        if(TimeToPayTicket[i] >= 2)
	        {
	            TimeToPayTicket[i] --;
			}
			if(TimeToPayTicket[i] == 1)
			{
			    format(string,sizeof(string),"[POLICE RADIO] Suspect %s(%d) has failed to pay their ticket. Arrest the suspect whenever you can.",pname,i);
			    SendClientMessageToAllCops(string);

				SendClientMessage(i,COLOR_RED,"You have failed to pay your ticket of $2000 using /payticket and your wanted level has been increased.");
				IncreaseWantedLevel(i,4);
				TimeToPayTicket[i] =0;
				HasTicket[i] =0;
			}
			    
	        //Cuff Attempt
	        if(AttemptedToCuffRecently[i] >= 1)
	        {
	            AttemptedToCuffRecently[i] --;
			}
			
			//HasBeenReportedRecently
			if(HasBeenReportedRecently[i] >= 1)
			{
			    HasBeenReportedRecently[i] --;
			}
			
	        //Wanted levels
	        if(GetPlayerWantedLevel(i) >= 1 && GetPlayerWantedLevel(i) <=3)
	        {
	            SetPlayerColor(i,COLOR_YELLOW);
			}
			if(GetPlayerWantedLevel(i) >= 4 && GetPlayerWantedLevel(i) <=19)
	        {
	            if(HasTicket[i] == 1)
	            {
	                HasTicket[i] =0;
	                TimeToPayTicket[i] =0;
				}
	            SetPlayerColor(i,COLOR_ORANGE);
			}
			if(GetPlayerWantedLevel(i) >= 20)
	        {
	            if(HasTicket[i] == 1)
	            {
	                HasTicket[i] =0;
	                TimeToPayTicket[i] =0;
				}
	            SetPlayerColor(i,COLOR_RED);
			}
			if(GetPlayerWantedLevel(i) == 0)
			{
			    SetPlayerToTeamColour(i);
			}
	        
	    	//IRC Colors
			if(GetPlayerWantedLevel(i) >= 1 && GetPlayerWantedLevel(i) <= 3)
		    {
	          	IrcColor[i]=8;
	       	}
	       	if(GetPlayerWantedLevel(i) >= 4 && GetPlayerWantedLevel(i) <= 19)
		    {
	          	IrcColor[i]=7;
	       	}
	       	if(GetPlayerWantedLevel(i) >= 20)
		    {
			  	IrcColor[i]=4;
	       	}
	       	if(gTeam[i]==TEAM_COP)
		   	{
		   		IrcColor[i]=12;
	    	}
	    	if(gTeam[i]==TEAM_ARMY)
		   	{
		   		IrcColor[i]=3;
	   		}
	   		if(gTeam[i] == TEAM_CIA)
	   		{
	   		    IrcColor[i]=5;
			}
			if(gTeam[i] == TEAM_CARFIX)
			{
			    IrcColor[i]=1;
			}
			if(gTeam[i] == TEAM_DRIVER)
			{
			    IrcColor[i]=9;
			}
	    	if(gTeam[i]==TEAM_MEDIC)
		   	{
		  		IrcColor[i]=9;
	    	}
	    	if(gTeam[i] >= 9 && GetPlayerWantedLevel(i) == 0)
	    	{
	    	    IrcColor[i] =1;
			}
	    	if(IsSpawned[i] == 0)
		  	{
		  		IrcColor[i]=14;
		  	}
		}
	}
	return 1;
}

public SafeSetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
	SetPlayerPos(playerid, x,y,z);
	return 1;
}

public CheckPasswordAttempts(playerid)
{
	if(PasswordAttempts[playerid] == 0)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have entered an incorrect password. Repeated attempts may get you kicked from the server. (Attempt 1/3)");
	    PasswordAttempts[playerid] ++;
	    return 1;
	}
	if(PasswordAttempts[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_ERROR,"You have entered an incorrect password. Repeated attempts may get you kicked from the server. (Attempt 2/3)");
	    PasswordAttempts[playerid] ++;
	    return 1;
	}
	if(PasswordAttempts[playerid] == 2)
	{
	    new string[128];
	    SendClientMessage(playerid,COLOR_ERROR,"You have entered an incorrect password. You have been automatically kicked from the server. (Attempt 3/3)");
		format(string,sizeof(string),"[AUTO KICK] %s(%d) Too many incorrect password attempts. (Attempt 3/3)",PlayerName(playerid),playerid);
		SendClientMessageToAll(COLOR_ADMIN,string);
		format(string,sizeof(string),"9[AUTO KICK] %s(%d) Too many incorrect password attempts. (Attempt 3/3)",PlayerName(playerid),playerid);
		IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
		Kicking[playerid] =1;
		SetTimer("KickPlayer",300,0);
	    return 1;
	}
	return 1;
}

public TaxiPay()
{
	new string[128];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		for(new j=0; j<MAX_PLAYERS; j++)
		{
			if(PayingTaxi[i] == 1)
			{
			    if(HasTaxiFare[j] == i)
			    {
			        if(GetPlayerVehicleID(i) == GetPlayerVehicleID(j))
			        {
			            if(GetPlayerMoney(i) < SkillPrice[j])
			            {
			                SendClientMessage(i,COLOR_ERROR,"You cannot afford to pay the taxi fare.");
			                RemovePlayerFromVehicle(i);
			                return 1;
						}
			            GivePlayerMoney(i,-SkillPrice[j]);
			            GivePlayerMoney(j,SkillPrice[j]);
			            format(string,sizeof(string),"%s(%d) has recieved $%d from %s(%d)'s fare.",PlayerName(j),j,SkillPrice[j],PlayerName(i),i);
			            IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
			            return 1;
					}
				}
			}
		}
	}
	return 1;
}

public TextDrawColorChange()
{
	new crand =random(6);
	if(crand == 1)
	{
	    TextDrawColor(WebsiteTD,COLOR_BLUE);
	    TextDrawColor(VersionTD,COLOR_RED);
	}
	if(crand == 2)
	{
	    TextDrawColor(WebsiteTD,COLOR_RED);
	    TextDrawColor(VersionTD,COLOR_BLUE);
	}
	if(crand == 3)
	{
	    TextDrawColor(WebsiteTD,COLOR_PINK);
	    TextDrawColor(VersionTD,COLOR_GREEN);
	}
	if(crand == 4)
	{
	    TextDrawColor(WebsiteTD,COLOR_GREEN);
	    TextDrawColor(VersionTD,COLOR_PINK);
	}
	if(crand == 5)
	{
	    TextDrawColor(WebsiteTD,COLOR_LIGHTBLUE);
	    TextDrawColor(VersionTD,COLOR_VIOLETBLUE);
	}
	if(crand == 6)
	{
	    TextDrawColor(WebsiteTD,COLOR_VIOLETBLUE);
	    TextDrawColor(VersionTD,COLOR_LIGHTBLUE);
	}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    TextDrawHideForPlayer(i,WebsiteTD);
		    TextDrawHideForPlayer(i,VersionTD);
		    TextDrawShowForPlayer(i,WebsiteTD);
		    TextDrawShowForPlayer(i,VersionTD);
		}
	}
}

public GameModeText() // There is more Types of the normal message because we want this shown the most often.
{
	new string[128];
	new grand =random(9);
	if(grand == 1)
	{
	    format(string,sizeof(string),"hostname {%s} %s v%s",sabbv,svname,sversion);
	    SendRconCommand(string);
	}
	if(grand == 2)
	{
	    format(string,sizeof(string),"hostname {%s} Visit our website at: %s.",sabbv,sweb);
	    SendRconCommand(string);
	}
	if(grand == 3)
	{
	    format(string,sizeof(string),"hostname {%s} Join the fun on %s!",sabbv,svname);
	    SendRconCommand(string);
	}
	if(grand == 4)
	{
	    format(string,sizeof(string),"hostname {%s} This is Cops and Robbers at it's best!",sabbv);
	    SendRconCommand(string);
	}
	if(grand == 5)
	{
	    format(string,sizeof(string),"hostname {%s} Come play with our great Regular Players.",sabbv);
	    SendRconCommand(string);
	}
	if(grand == 6)
	{
	    format(string,sizeof(string),"hostname {%s} %s v%s",sabbv,svname,sversion);
	    SendRconCommand(string);
	}
	if(grand == 7)
	{
	    format(string,sizeof(string),"hostname {%s} %s v%s",sabbv,svname,sversion);
	    SendRconCommand(string);
	}
	if(grand == 8)
	{
	    format(string,sizeof(string),"hostname {%s} %s v%s",sabbv,svname,sversion);
	    SendRconCommand(string);
	}
	if(grand == 9)
	{
	    format(string,sizeof(string),"hostname {%s} %s v%s",sabbv,svname,sversion);
	    SendRconCommand(string);
	}
}

public RandomMessage()
{
	new mrand =random(10);
	new string[128];
	if(mrand == 1)
	{
	    format(string,sizeof(string),"Visit our website and forums at: %s.",sweb);
	    SendClientMessageToAll(COLOR_GREEN,string);
	    SendClientMessageToAll(COLOR_GREEN,"This is where you will meet and greet all of our regular players and Administrators.");
	    SendClientMessageToAll(COLOR_GREEN,"You can also recieve information or ask questions here, so pop in every once and a while.");
	}
	if(mrand == 2)
	{
	    SendClientMessageToAll(COLOR_GREEN,"Our server has a CIA class that lets players view other players through the CIA satelite.");
	    format(string,sizeof(string),"You can apply to use this class on our forums located at: %s.",sweb);
	    SendClientMessageToAll(COLOR_GREEN,string);
	}
	if(mrand == 3)
	{
	    format(string,sizeof(string),"We have quite strict rules here at %s, so if you want to stay safe, read /rules and /pc.",sabbv);
	    SendClientMessageToAll(COLOR_GREEN,string);
	    SendClientMessageToAll(COLOR_GREEN,"If you are caught breaking these rules, you may be punished by our Server Administrators.");
	}
	if(mrand == 4)
	{
	    SendClientMessageToAll(COLOR_GREEN,"Our Regular Player system lets players use extra commands such as:");
	    SendClientMessageToAll(COLOR_GREEN,"Being able to talk to all Regular Players through the use of the /rc command.");
	    SendClientMessageToAll(COLOR_GREEN,"Being able to place roadblocks while spawned as law enforcement with /crb.");
	    SendClientMessageToAll(COLOR_GREEN,"To become a regular player you must have 500 score or more and atleast 100 posts on our forums.");
		format(string,sizeof(string),"Want to become one? Apply today at: %s.",sweb);
		SendClientMessageToAll(COLOR_GREEN,string);
	}
	if(mrand == 5)
	{
	    format(string,sizeof(string),"%s has an army class where you can fly hydra, hunters and even drive tanks.",sabbv);
	    SendClientMessageToAll(COLOR_GREEN,string);
	    SendClientMessageToAll(COLOR_GREEN,"Does this appeal to you? Once our Regular Players have been Regular for 2 weeks, they get to apply for this class.");
	}
	if(mrand == 6)
	{
	    SendClientMessageToAll(COLOR_GREEN,"We have an IRC channel where you can talk to your friends and even talk to players ingame while your not ingame.");
	    SendClientMessageToAll(COLOR_GREEN,"To get on to this channel and see what it is about, download an mIRC client such as IceChat or mIRC.");
	    format(string,sizeof(string),"Once you have done this you can connect to: IRC: %s and Channel: %s. This will enable you to use the features.",IRC_SERVER,IRC_CHANNEL);
	    SendClientMessageToAll(COLOR_GREEN,string);
	}
	if(mrand == 7)
	{
	    format(string,sizeof(string),"%s scriptors are always checking for new things to add to the server.",sabbv);
	    SendClientMessageToAll(COLOR_GREEN,string);
	    format(string,sizeof(string),"If you have an idea to give them, then post in our suggestions board located on our forums at: %s.",sweb);
	    SendClientMessageToAll(COLOR_GREEN,string);
	}
	if(mrand == 8)
	{
	    SendClientMessageToAll(COLOR_GREEN,"Hacking and the use of ilegal mods are strictly not permitted on this server.");
	    SendClientMessageToAll(COLOR_GREEN,"If you see a hacker, ilegal modder, or rule breaker, then use '/report (Player Name/ID) (Reason)' to report them to our Server Administrators.");
	}
	if(mrand == 9)
	{
	    format(string,sizeof(string),"Here at %s, we have an FBI class that enables you to use better law enforcement vehicles.",sabbv);
	    SendClientMessageToAll(COLOR_GREEN,string);
	    SendClientMessageToAll(COLOR_GREEN,"You can use this class when you reach 500 score, so if it appeals to you, then get working towards the score you need!");
	}
	if(mrand == 10)
	{
	    SendClientMessageToAll(COLOR_GREEN,"We are always on the lookout for new Server Administrators to replace old or retired ones.");
	    SendClientMessageToAll(COLOR_GREEN,"You never know, if you behave well and don't break the rules, you could be chosen to become one.");
	    SendClientMessageToAll(COLOR_GREEN,"Just remember, you should never ask to become a Server Administrator as we choose them and it lowers your chances of becoming one.");
	}
}

public PlantingOneCIABridge()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABridge[i] == 1)
	        {
	            SetPlayerPos(i,-1492.1862,807.0270,7.1875);
	            SetPlayerFacingAngle(i,84.0542);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingTwoCIABridge",5000,0);
			}
		}
	}
}

public PlantingTwoCIABridge()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABridge[i] == 1)
	        {
	            SetPlayerPos(i,-1459.6245,811.5567,15.7142);
	            SetPlayerFacingAngle(i,351.9567);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingThreeCIABridge",5000,0);
			}
		}
	}
}

public PlantingThreeCIABridge()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABridge[i] == 1)
	        {
	            SetPlayerPos(i,-1444.3687,793.4705,16.8176);
	            SetPlayerFacingAngle(i,173.6684);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("FinalPlantCIABridge",5000,0);
			}
		}
	}
}

public FinalPlantCIABridge()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABridge[i] == 1)
	        {
	            TextDrawSetString(MessageTD[i],"PLANTED");
	            TextDrawShowForPlayer(i,MessageTD[i]);
	            MessageTDTime[i] =5;
	            SetTimer("CIABridgeExplosionOne",5000,0);

	            SetPlayerPos(i,-1548.1466,801.4399,7.2656);
	            SetPlayerFacingAngle(i,84.6808);
	            SetCameraBehindPlayer(i);
	            TogglePlayerControllable(i,1);

	            SendClientMessage(i,COLOR_ERROR,"You have planted the bombs on the bridge and they are rigged to explode in 5 seconds, move back!");
			}
		}
	}
}

public CIABridgeExplosionOne()
{
	CreateExplosion(-1492.1862,807.0270,7.1875,6,10.0);
	SetTimer("CIABridgeExplosionTwo",500,0);
}

public CIABridgeExplosionTwo()
{
	CreateExplosion(-1459.6245,811.5567,15.7142,6,10.0);
	SetTimer("CIABridgeExplosionThree",500,0);
}

public CIABridgeExplosionThree()
{
	CreateExplosion(-1444.3687,793.4705,16.8176,6,10.0);
	SetTimer("CIABridgeExplosionFour",500,0);
}

public CIABridgeExplosionFour()
{
	CreateExplosion(-1436.4833,803.0739,16.9973,6,10.0);
	SetTimer("CIABridgeExplosionFive",500,0);
}

public CIABridgeExplosionFive()
{
	new string[128];
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABridge[i] == 1)
	        {
				CreateExplosion(-1514.7216,809.9594,7.5343,6,10.0);
				DestroyObject(CIABridge);
				SetTimer("RestoreCIABridge",480000,0);

				IncreaseWantedLevel(i,20);
				IncreasePlayerScore(i,2);

				if(TerroristSkill[i] < 40)
				{
				    TerroristSkill[i] ++;
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your terrorist level has increased. Check out /tlevel to see your level and what you can blow up next.");
				}

				CIABridgeBlown =480;

				format(string,sizeof(string),"[TERRORIST ACTION] %s(%d) has blown the CIA Bridge with high powered explosives!",PlayerName(i),i);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[TERRORIST ACTION] %s(%d) has blown the CIA Bridge with high powered explosives!",PlayerName(i),i);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

				format(string,sizeof(string),"[POLICE RADIO] Terrorism: %s(%d) has blown the CIA Bridge with high powered explosives! Arrest the suspect.",PlayerName(i),i);
				SendClientMessageToAllCops(string);
			}
		}
	}
}

public RestoreCIABridge()
{
	CIABridge = CreateObject(5296,-1484.06884766,806.24200439,11.40033340,0.00000000,0.00000000,173.24121094); //object(laroads_26a_las01)(1)
	SendClientMessageToAll(COLOR_LIGHTBLUE,"[RESTORATION BUILD] The CIA Bridge has been re-built by a large group of builders. The CIA can now use it again.");
}

public PlantingOneCIASat()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIASat[i] == 1)
	        {
	            SetPlayerPos(i,-1317.6372,802.0458,10.3938);
	            SetPlayerFacingAngle(i,347.2098);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingTwoCIASat",5000,0);
			}
		}
	}
}

public PlantingTwoCIASat()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIASat[i] == 1)
	        {
	            SetPlayerPos(i,-1304.4319,811.6154,9.8552);
	            SetPlayerFacingAngle(i,78.3906);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingThreeCIASat",5000,0);
			}
		}
	}
}

public PlantingThreeCIASat()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIASat[i] == 1)
	        {
	            SetPlayerPos(i,-1314.4484,824.9018,9.9675);
	            SetPlayerFacingAngle(i,157.0381);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingFourCIASat",5000,0);
			}
		}
	}
}

public PlantingFourCIASat()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIASat[i] == 1)
	        {
	            SetPlayerPos(i,-1327.2623,814.9333,10.1724);
	            SetPlayerFacingAngle(i,246.0256);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("FinalPlantCIASat",5000,0);
			}
		}
	}
}

public FinalPlantCIASat()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIASat[i] == 1)
	        {
	            TextDrawSetString(MessageTD[i],"PLANTED");
	            TextDrawShowForPlayer(i,MessageTD[i]);
	            MessageTDTime[i] =5;
	            SetTimer("CIASatExplosionOne",5000,0);

	            SetPlayerPos(i,-1332.1198,799.4351,6.6299);
	            SetPlayerFacingAngle(i,83.0907);
	            SetCameraBehindPlayer(i);
	            TogglePlayerControllable(i,1);

	            SendClientMessage(i,COLOR_ERROR,"You have planted the bombs on the satelite and they are rigged to explode in 5 seconds, move back!");
			}
		}
	}
}

public CIASatExplosionOne()
{
	CreateExplosion(-1317.6372,802.0458,10.3938,6,10.0);
	SetTimer("CIASatExplosionTwo",500,0);
}

public CIASatExplosionTwo()
{
	CreateExplosion(-1304.4319,811.6154,9.8552,6,10.0);
	SetTimer("CIASatExplosionThree",500,0);
}

public CIASatExplosionThree()
{
	CreateExplosion(-1314.4484,824.9018,9.9675,6,10.0);
	SetTimer("CIASatExplosionFour",500,0);
}

public CIASatExplosionFour()
{
	CreateExplosion(-1327.2623,814.9333,10.1724,6,10.0);
	SetTimer("CIASatExplosionFive",500,0);
}

public CIASatExplosionFive()
{
	new string[128];
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIASat[i] == 1)
	        {
				CreateExplosion(-1315.2103,812.2455,59.6543,6,10.0);
				DestroyObject(CIASat);
				SetTimer("RestoreCIASat",480000,0);

				IncreaseWantedLevel(i,20);
				IncreasePlayerScore(i,2);

				if(TerroristSkill[i] < 30)
				{
				    TerroristSkill[i] ++;
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your terrorist level has increased. Check out /tlevel to see your level and what you can blow up next.");
				}

				CIASatBlown =480;

				format(string,sizeof(string),"[TERRORIST ACTION] %s(%d) has blown the CIA Satelite with high powered explosives!",PlayerName(i),i);
				SendClientMessageToAll(COLOR_RED,string);

				format(string,sizeof(string),"4[TERRORIST ACTION] %s(%d) has blown the CIA Satelite with high powered explosives!",PlayerName(i),i);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);

				format(string,sizeof(string),"[POLICE RADIO] Terrorism: %s(%d) has blown the CIA Satelite with high powered explosives! Arrest the suspect.",PlayerName(i),i);
				SendClientMessageToAllCops(string);
			}
		}
	}
}

public RestoreCIASat()
{
	CIASat = CreateObject(16613,-1316.09350586,813.32238770,5.31122589,0.00000000,0.00000000,81.75177002); //object(des_bigtelescope)(1)
	SendClientMessageToAll(COLOR_LIGHTBLUE,"[RESTORATION BUILD] The CIA Satelite has been re-built by a large group of builders. The CIA can now use it again.");
}

public PlantingOneCIABuilding()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABuilding[i] == 1)
	        {
	            SetPlayerPos(i,-1224.1930,718.0573,6.6299);
	            SetPlayerFacingAngle(i,262.2958);
	            SetCameraBehindPlayer(i);
	            
	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingTwoCIABuilding",5000,0);
			}
		}
	}
}

public PlantingTwoCIABuilding()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABuilding[i] == 1)
	        {
	            SetPlayerPos(i,-1218.6826,759.9905,6.6299);
	            SetPlayerFacingAngle(i,261.9825);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("PlantingThreeCIABuilding",5000,0);
			}
		}
	}
}

public PlantingThreeCIABuilding()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABuilding[i] == 1)
	        {
	            SetPlayerPos(i,-1187.8752,742.5909,7.1299);
	            SetPlayerFacingAngle(i,172.3682);
	            SetCameraBehindPlayer(i);

	            ApplyAnimation(i, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	            SetTimer("FinalPlantCIABuilding",5000,0);
			}
		}
	}
}

public FinalPlantCIABuilding()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABuilding[i] == 1)
	        {
	            TextDrawSetString(MessageTD[i],"PLANTED");
	            TextDrawShowForPlayer(i,MessageTD[i]);
	            MessageTDTime[i] =5;
	            SetTimer("CIABuildingExplosionOne",5000,0);
	            
	            SetPlayerPos(i,-1232.2139,739.2380,6.6299);
	            SetPlayerFacingAngle(i,81.8141);
	            SetCameraBehindPlayer(i);
	            TogglePlayerControllable(i,1);
	            
	            SendClientMessage(i,COLOR_ERROR,"You have planted the bombs on the building and they are rigged to explode in 5 seconds, move back!");
			}
		}
	}
}

public CIABuildingExplosionOne()
{
	CreateExplosion(-1224.1930,718.0573,6.6299,6,10.0);
	SetTimer("CIABuildingExplosionTwo",500,0);
}

public CIABuildingExplosionTwo()
{
	CreateExplosion(-1218.6826,759.9905,6.6299,6,10.0);
	SetTimer("CIABuildingExplosionThree",500,0);
}

public CIABuildingExplosionThree()
{
	CreateExplosion(-1187.8752,742.5909,7.1299,6,10.0);
	SetTimer("CIABuildingExplosionFour",500,0);
}

public CIABuildingExplosionFour()
{
	CreateExplosion(-1224.0089,761.1788,23.9479,6,10.0);
	SetTimer("CIABuildingExplosionFive",500,0);
}

public CIABuildingExplosionFive()
{
	CreateExplosion(-1230.4664,711.9915,28.0763,6,10.0);
	SetTimer("CIABuildingExplosionSix",500,0);
}

public CIABuildingExplosionSix()
{
	CreateExplosion(-1222.2784,734.8787,6.6299,6,10.0);
	SetTimer("CIABuildingExplosionSeven",500,0);
}

public CIABuildingExplosionSeven()
{
	CreateExplosion(-1220.7913,750.0654,6.6299,6,10.0);
	SetTimer("CIABuildingExplosionEight",500,0);
}

public CIABuildingExplosionEight()
{
	new string[128];
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlantingCIABuilding[i] == 1)
	        {
				CreateExplosion(-1199.9523,763.7290,6.6299,6,10.0);
				DestroyObject(CIABuilding);
				SetTimer("RestoreCIABuilding",480000,0);
				
				IncreaseWantedLevel(i,20);
				IncreasePlayerScore(i,2);
				
				if(TerroristSkill[i] < 30)
				{
				    TerroristSkill[i] ++;
				    SendClientMessage(i,COLOR_LIGHTBLUE,"Your terrorist level has increased. Check out /tlevel to see your level and what you can blow up next.");
				}
				
				CIABuildingBlown =480;
				
				format(string,sizeof(string),"[TERRORIST ACTION] %s(%d) has blown the CIA Headquarters with high powered explosives!",PlayerName(i),i);
				SendClientMessageToAll(COLOR_RED,string);
				
				format(string,sizeof(string),"4[TERRORIST ACTION] %s(%d) has blown the CIA Headquarters with high powered explosives!",PlayerName(i),i);
				IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
				
				format(string,sizeof(string),"[POLICE RADIO] Terrorism: %s(%d) has blown the CIA Headquarters with high powered explosives! Arrest the suspect.",PlayerName(i),i);
				SendClientMessageToAllCops(string);
			}
		}
	}
}

public RestoreCIABuilding()
{
	CIABuilding = CreateObject(4564,-1207.69787598,737.33392334,114.88327789,0.00000000,0.00000000,352.52142334); //object(laskyscrap2_lan)(1)
	SendClientMessageToAll(COLOR_LIGHTBLUE,"[RESTORATION BUILD] The CIA Headquarters has been re-built by a large group of builders. The CIA can now use it again.");
}

public ResetVariables(playerid)
{
	IsSpawned[playerid] =0;
	Banning[playerid] =0;
	Kicking[playerid] =0;
	IsMuted[playerid] =0;
	IsFrozen[playerid] =0;
	gTeam[playerid] =0;
	CanChooseSkill[playerid] =0;
	PLAYERLIST_authed[playerid] =0;
	PasswordAttempts[playerid] =0;
	BankCash[playerid] =0;
	CanUseArmy[playerid] =0;
	CanUseCIA[playerid] =0;
	AdminLevel[playerid] =0;
	HasWeed[playerid] =0;
	IrcColor[playerid] =0;
	HasLawEnforcementRadio[playerid] =0;
	gPlayerUsingLoopingAnim[playerid] =0;
	IsCuffed[playerid] =0;
	AttemptedToCuffRecently[playerid] =0;
	HasUsedDeath[playerid] =0;
	IsRegularPlayer[playerid] =0;
	HasTicket[playerid] =0;
	TimeToPayTicket[playerid] =0;
	playerCheckpoint[playerid] =0;
	JailTime[playerid] =0;
	TotalJailTime[playerid] =0;
	LastVehicle[playerid] =0;
	CuffTime[playerid] =0;
	IsDetained[playerid] =0;
	MessageTDTime[playerid] =0;
	HasBeenReportedRecently[playerid] =0;
	CIAPlayerBeingViewed[playerid] =-1;
	CIAIsBeingWatched[playerid] =0;
	StoppedSatViewing[playerid] =0;
	IsTackled[playerid] =0;
	HasRope[playerid] =0;
	HasScissors[playerid] =0;
	HasSausageRolls[playerid] =0;
	HasAntiSTI[playerid] =0;
	HasSecureWallet[playerid] =0;
	HasNeedleAndSyringe[playerid] =0;
	SpamStrings[playerid] =0;
	Warns[playerid] =0;
	InAdminMode[playerid] =0;
	IsBeingSpectated[playerid] =0;
	SpectatingPlayer[playerid] =0;
	AdminKilled[playerid] =0;
	CalledForMedic[playerid] =0;
	CalledForMechanic[playerid] =0;
	CalledForDrugDealer[playerid] =0;
	CalledForTaxi[playerid] =0;
	CalledForWeaponDealer[playerid] =0;
	SkillPrice[playerid] =2000;
	HasSTI[playerid] =0;
	PayingTaxi[playerid] =0;
	HasTaxiFare[playerid] =-1;
	OnDuty[playerid] =0;
	TeamKillWarning[playerid] =0;
	NameBanned[playerid] =0;
	OldCash[playerid] =0;
	DiedFromSTI[playerid] =0;
	HasRapedRecently[playerid] =0;
	SmokingWeed[playerid] =0;
	InjectedHeroin[playerid] =0;
	RobbingDrugHouse[playerid] =0;
	RobbingSupaSave[playerid] =0;
	GivenWeaponRecently[playerid] =0;
	PlacedHitRecently[playerid] =0;
	HasHit[playerid] =0;
	HitMoney[playerid] =0;
	IsKidnapped[playerid] =0;
	AttemptedToKidnapRecently[playerid] =0;
	HasKidnappedRecently[playerid] =0;
	AttemptedToRobRecently[playerid] =0;
	HasRobbedRecently[playerid] =0;
	RobbingOtto[playerid] =0;
	afktag[playerid] =0;
	Away[playerid] =0;
	HasC4[playerid] =0;
	HasBlownVehicleRecently[playerid] =0;
	TerroristSkill[playerid] =0;
	IsPlantingCIABuilding[playerid] =0;
	IsPlantingCIASat[playerid] =0;
	IsPlantingCIABridge[playerid] =0;
	RobSkill[playerid] =0;
	RobbingGarciaBurgerShot[playerid] =0;
	RobbingDownBurgerShot[playerid] =0;
	RobbingJHBurgerShot[playerid] =0;
	RobbingOceanCluckinBell[playerid] =0;
	RobbingDownCluckinBell[playerid] =0;
	RobbingAmmunation[playerid] =0;
	RobbingGayDar[playerid] =0;
	RobbingZero[playerid] =0;
	RobbingMistys[playerid] =0;
	RobbingGYM[playerid] =0;
	RobbingSchool[playerid] =0;
	RobbingWang[playerid] =0;
	RobbingTrain[playerid] =0;
	RobbingBarbers[playerid] =0;
	RobbingHospital[playerid] =0;
	RobbingJizzys[playerid] =0;
	RobbingEsplanadePizza[playerid] =0;
	RobbingFinancialPizza[playerid] =0;
	RobbingDownZip[playerid] =0;
	RobbingDownVictim[playerid] =0;
	RobbingJHBinco[playerid] =0;
	RobbingCityHall[playerid] =0;
	HasPackC4[playerid] =0;
	HasPackRope[playerid] =0;
	HasPackMoney[playerid] =0;
	for(new w=0; w<13; w++)
	{
		PlayerWeapon[playerid][w] =0;
		PlayerAmmo[playerid][w] =0;
	}
	return 1;
}

public KickPlayer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(Kicking[i] == 1)
		{
		    new rnd =random(sizeof(JailSpawnPoints));
		    SetPlayerInterior(i,10);
		    SetPlayerPos(i,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(i,JailSpawnPoints[rnd][3]);
		    Kick(i);
		}
	}
	return 1;
}

public BanPlayer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(Banning[i] == 1)
		{
		    new string[128];
		    new rnd =random(sizeof(JailSpawnPoints));
		    SetPlayerInterior(i,10);
		    SetPlayerPos(i,JailSpawnPoints[rnd][0],JailSpawnPoints[rnd][1],JailSpawnPoints[rnd][2]);
		    SetPlayerFacingAngle(i,JailSpawnPoints[rnd][3]);
			dUserSetINT(PlayerName(i)).("Nameban",1);
			format(string,sizeof(string),"|| You have been banned from %s ||",svname);
			SendClientMessage(i,COLOR_RED,string);
			SendClientMessage(i,COLOR_RED,"||         You can appeal this ban on our forums.        ||");
			format(string,sizeof(string),"||                     %s                   ||",sweb);
			SendClientMessage(i,COLOR_RED,string);
			SendClientMessage(i,COLOR_RED,"||   Players are reminded that we do not unban hackers.  ||");
		    Ban(i);
		}
	}
	return 1;
}

public Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

//==============================================================================

//STOCK FUNCTIONS
stock GetPlayersInTeam(TEAM)
{
    new players;
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (gTeam[i] == TEAM) players++;
        }
    }
    return players;
}

stock ShowLoginScreen(playerid)
{
	new string[128];
    format(string, sizeof(string), "Welcome back %s\nBefore playing you must login\nEnter your password below and click login",PlayerName(playerid));
    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,"Login required",string,"Login","Cancel");
}

stock ShowRegisterScreen(playerid)
{
    new string[128];
    format(string, sizeof(string), "Welcome to the server %s\nThis server requires you to register an account before playing\nEnter your desired password below then click ok",PlayerName(playerid));
    ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registration required",string,"Register","Cancel");
}

stock ShowChangePassScreen(playerid)
{
    new string[128];
    format(string, sizeof(string), "Please make sure you enter your new password correctly.\nEnter your desired password below then click ok.",PlayerName(playerid));
    ShowPlayerDialog(playerid,DIALOG_CHANGEPASS,DIALOG_STYLE_INPUT,"Enter the new password.",string,"Change","Cancel");
}

stock ShowChangeNameScreen(playerid)
{
    new string[128];
    format(string, sizeof(string), "Please make sure you enter your new name correctly.\nEnter your desired name below then click ok.",PlayerName(playerid));
    ShowPlayerDialog(playerid,DIALOG_CHANGENAME,DIALOG_STYLE_INPUT,"Enter the new name.",string,"Change","Cancel");
}

stock PlayerName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}

stock CreateRoadblock(Object,Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(Roadblocks[i][sCreated] == 0)
  	    {
            Roadblocks[i][sCreated] = 1;
            Roadblocks[i][sX] = x;
            Roadblocks[i][sY] = y;
            Roadblocks[i][sZ] = z-0.7;
            Roadblocks[i][sObject] = CreateDynamicObject(Object, x, y, z-0.9, 0, 0, Angle);
	        return 1;
  	    }
  	}
  	return 0;
}

stock DeleteAllRoadblocks(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 100, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
	  	    if(Roadblocks[i][sCreated] == 1)
	  	    {
	  	        Roadblocks[i][sCreated] = 0;
	            Roadblocks[i][sX] = 0.0;
	            Roadblocks[i][sY] = 0.0;
	            Roadblocks[i][sZ] = 0.0;
	            DestroyDynamicObject(Roadblocks[i][sObject]);
	  	    }
  	    }
	}
    return 0;
}


stock DeleteClosestRoadblock(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
  	        if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0.0;
                Roadblocks[i][sY] = 0.0;
                Roadblocks[i][sZ] = 0.0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

//==============================================================================

LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    gPlayerUsingLoopingAnim[playerid] = 1;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
}

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

PlayerToPoint(Float:radius, playerid, Float:X, Float:Y, Float:Z)
{
    new Float:oldpos[3], Float:temppos[3];
    GetPlayerPos(playerid, oldpos[0], oldpos[1], oldpos[2]);
    temppos[0] = (oldpos[0] -X);
    temppos[1] = (oldpos[1] -Y);
    temppos[2] = (oldpos[2] -Z);
    if(((temppos[0] < radius) && (temppos[0] > -radius)) && ((temppos[1] < radius) && (temppos[1] > -radius)) && ((temppos[2] < radius) && (temppos[2] > -radius)))
    {
        return true;
    }
    return false;
}

//==============================================================================
