
//______________________________________________________________________________
//              ADMIN AREA BY Xmx4life aka haseeb khan and perfectboy aka abhay
//______________________________________________________________________________

//_-_includes
#include <a_samp>
#include <streamer>

//____[Gates & other]____
new admingate;
new adminsecretgate;
new pickupup;

//________[Admin Vehicle (Hydra)|______________
new adminhydra;

//____[Forwards-Timers]____
forward AdminGateClose(playerid);
forward SecretGateClose(playerid);


public OnFilterScriptInit()
{
print("\n--------------------------------------");
print(" Admin Area Version [0.7] ");
printf(" -By: Chris10			 ");
print("--------------------------------------\n");
/////////////////////////////Objects & Cars////////////////////////////////////////////
CreateObject(18450, 983.29980, -2346.39941, 11.70000,   0.00000, 0.00000, 41.99524);
CreateObject(18450, 923.90002, -2399.80005, 11.70000,   0.00000, 0.00000, 221.99524);
CreateObject(12814, 885.89941, -2438.59961, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(12814, 865.40002, -2458.50000, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(12814, 844.00000, -2479.10010, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(12814, 802.59998, -2463.80005, 12.10000,   0.00000, 0.24719, 313.98926);
CreateObject(12814, 823.00000, -2499.30005, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(12814, 838.09998, -2429.30005, 12.00000,   0.00000, 0.00000, 313.98926);
CreateObject(12814, 893.69922, -2486.29980, 12.00000,   0.00000, 0.00000, 313.98926);
CreateObject(3749, 908.29999, -2413.69995, 17.90000,   0.00000, 0.00000, 313.98926);
CreateObject(10244, 780.39941, -2461.69922, 8.60000,   0.00000, 0.00000, 225.99976);
CreateObject(3187, 847.89941, -2424.39941, 16.10000,   0.00000, 0.00000, 223.99475);
CreateObject(7885, 851.69922, -2463.59961, 12.00000,   0.00000, 0.00000, 223.99475);
CreateObject(987, 836.90002, -2431.50000, 12.00000,   0.00000, 0.00000, 132.00000);
CreateObject(987, 834.09961, -2428.50000, 12.00000,   0.00000, 0.00000, 131.98975);
CreateObject(987, 882.69922, -2480.59961, 12.00000,   0.00000, 0.00000, 313.99475);
CreateObject(987, 890.70001, -2489.19995, 12.00000,   0.00000, 0.00000, 313.99475);
CreateObject(987, 892.90002, -2491.60010, 12.00000,   0.00000, 0.00000, 313.99475);
CreateObject(993, 855.79999, -2538.60010, 13.60000,   0.00000, 0.00000, 40.00000);
CreateObject(993, 848.09998, -2538.19995, 13.60000,   0.00000, 0.00000, 313.99573);
CreateObject(993, 848.59998, -2530.89990, 13.60000,   0.00000, 0.00000, 219.99475);
CreateObject(2114, 855.79980, -2532.09961, 12.20000,   0.00000, 0.00000, 0.00000);
CreateObject(946, 850.70001, -2539.39990, 14.20000,   0.00000, 0.00000, 324.00000);
CreateObject(946, 847.00000, -2535.30005, 14.20000,   0.00000, 0.00000, 323.99780);
CreateObject(1764, 848.69922, -2524.89941, 12.00000,   0.00000, 0.00000, 309.99573);
CreateObject(2093, 848.29980, -2527.50000, 12.00000,   0.00000, 0.00000, 87.98950);
CreateObject(10244, 788.29999, -2459.10010, 4.00000,   0.00000, 0.00000, 136.48907);
CreateObject(12814, 809.59961, -2462.29980, 4.80000,   0.00000, 0.00000, 312.98401);
CreateObject(1595, 824.90002, -2502.50000, 17.30000,   0.00000, 0.00000, 336.00000);
CreateObject(8131, 808.70001, -2496.60010, 22.70000,   0.00000, 0.00000, 42.00000);
CreateObject(993, 883.59998, -2513.89990, 13.60000,   0.00000, 0.00000, 227.99023);
CreateObject(993, 883.29999, -2507.50000, 13.60000,   0.00000, 0.00000, 317.98975);
CreateObject(993, 876.40002, -2507.39990, 13.60000,   0.00000, 0.00000, 227.98828);
CreateObject(2008, 874.29999, -2511.39990, 12.00000,   0.00000, 0.00000, 46.00000);
CreateObject(2008, 876.09998, -2509.60010, 12.00000,   0.00000, 0.00000, 45.99976);
CreateObject(2008, 878.00000, -2507.19995, 12.00000,   0.00000, 0.00000, 45.99976);
CreateObject(2008, 881.40002, -2507.10010, 12.00000,   0.00000, 0.00000, 315.99976);
CreateObject(2008, 883.29999, -2508.69995, 12.00000,   0.00000, 0.00000, 315.99426);
CreateObject(2008, 884.29999, -2512.50000, 12.00000,   0.00000, 0.00000, 227.99426);
CreateObject(2008, 882.50000, -2514.60010, 12.00000,   0.00000, 0.00000, 227.99377);
CreateObject(2008, 880.90002, -2516.39990, 12.00000,   0.00000, 0.00000, 227.99377);
CreateObject(2748, 832.29999, -2510.10010, 12.60000,   0.00000, 0.00000, 50.00000);
CreateObject(2748, 833.29999, -2508.89990, 12.60000,   0.00000, 0.00000, 49.99878);
CreateObject(2748, 834.29999, -2507.69995, 12.60000,   0.00000, 0.00000, 49.99878);
CreateObject(2748, 837.00000, -2510.00000, 12.60000,   0.00000, 0.00000, 229.99878);
CreateObject(2748, 836.00000, -2511.19995, 12.60000,   0.00000, 0.00000, 229.99329);
CreateObject(2748, 835.00000, -2512.39990, 12.60000,   0.00000, 0.00000, 229.99329);
CreateObject(2762, 835.50000, -2509.10010, 12.40000,   0.00000, 0.00000, 50.00000);
CreateObject(2762, 834.20001, -2510.69995, 12.40000,   0.00000, 0.00000, 49.99878);
CreateObject(2784, 832.00000, -2513.19995, 13.30000,   0.00000, 0.00000, 319.99731);
CreateObject(3383, 838.59998, -2517.19995, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(3383, 841.79999, -2514.30005, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(839, 845.59998, -2496.30005, 13.40000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 838.20001, -2445.60010, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 816.09998, -2494.60010, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 847.50000, -2529.89990, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 814.50000, -2467.19995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 887.20001, -2499.60010, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 830.20001, -2513.50000, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 830.00000, -2478.50000, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 851.00000, -2491.00000, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(12814, 858.29999, -2506.89990, 12.00000,   0.00000, 0.00000, 43.98926);
CreateObject(12814, 844.09998, -2520.60010, 12.00000,   0.00000, 0.00000, 43.99475);
CreateObject(12814, 814.70001, -2470.60010, -3.00000,   359.93408, 270.99426, 314.48364);
CreateObject(12814, 799.00000, -2485.80005, -3.00000,   359.93408, 270.99426, 225.73657);
CreateObject(12814, 809.89941, -2441.39941, -2.90000,   359.93408, 270.99426, 133.97827);
CreateObject(3824, 814.09998, -2444.30005, 8.10000,   0.00000, 0.00000, 224.74731);
CreateObject(3842, 826.09961, -2459.29980, 8.30000,   0.00000, 0.00000, 317.99927);
CreateObject(8131, 813.50000, -2503.39990, 22.70000,   0.00000, 0.00000, 41.99524);
CreateObject(900, 814.40002, -2451.30005, 14.60000,   0.00000, 0.00000, 260.00000);
CreateObject(12814, 802.39941, -2463.69922, 12.00000,   359.75006, 179.75293, 133.98816);
CreateObject(8171, 813.00000, -2441.10010, -57.10000,   271.76331, 188.12988, 232.12463);
CreateObject(8171, 837.00000, -2418.69995, -57.10000,   272.25769, 186.33362, 230.33386);
CreateObject(8171, 874.70001, -2407.50000, -57.20000,   271.02173, 194.05151, 149.55750);
CreateObject(8171, 864.19922, -2423.69922, -57.10000,   272.25769, 186.32813, 232.32239);
CreateObject(8171, 919.79980, -2454.39941, -57.10000,   271.26343, 191.30493, 145.55237);
CreateObject(8171, 897.29999, -2431.19995, -57.20000,   271.26343, 191.30493, 145.55237);
CreateObject(8171, 892.00000, -2425.69995, -57.20000,   271.26343, 191.30493, 146.30237);
CreateObject(2784, 837.20001, -2506.60010, 13.30000,   0.00000, 0.00000, 319.99329);
CreateObject(2784, 838.09998, -2512.80005, 13.30000,   0.00000, 0.00000, 231.99329);
CreateObject(2784, 831.00000, -2506.60010, 13.30000,   0.00000, 0.00000, 231.99280);
CreateObject(7617, 851.00000, -2464.69995, 33.30000,   0.00000, 0.00000, 318.00000);
CreateObject(13630, 1005.79999, -2325.89990, 20.50000,   0.00000, 0.00000, 211.99670);
CreateObject(14781, 870.79999, -2521.69995, 13.10000,   0.00000, 0.00000, 314.00000);
CreateObject(14781, 866.09998, -2526.10010, 13.10000,   0.00000, 0.00000, 313.99878);
CreateObject(3819, 864.29999, -2518.39990, 12.90000,   0.00000, 0.00000, 133.99475);
CreateObject(8171, 806.09998, -2444.50000, -56.90000,   270.79236, 289.14008, 332.39600);
CreateObject(12814, 906.39941, -2474.19922, 12.00000,   0.00000, 0.00000, 313.98926);
CreateObject(8171, 918.79999, -2480.39990, -57.10000,   271.26343, 191.30493, 55.80237);
CreateObject(8171, 890.59998, -2508.10010, -57.00000,   271.26343, 191.29944, 55.54944);
CreateObject(8171, 863.70001, -2534.30005, -57.00000,   271.26343, 191.29395, 55.54688);
CreateObject(8171, 838.29999, -2533.39990, -57.00000,   271.26343, 191.29395, 326.04688);
CreateObject(8171, 810.09998, -2505.00000, -57.00000,   271.26343, 191.29395, 326.04675);
CreateObject(8171, 788.90002, -2483.50000, -57.10000,   271.26343, 191.29395, 326.04675);
CreateObject(12814, 778.59998, -2471.89990, -13.00000,   272.01520, 172.95599, 216.94958);
CreateObject(687, 883.79999, -2494.60010, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(687, 881.20001, -2498.89990, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(12814, 778.09998, -2471.60010, -13.30000,   272.01050, 172.95227, 38.69702);
CreateObject(12814, 841.20001, -2443.39990, -3.00000,   359.93408, 270.99426, 316.48413);
CreateObject(12814, 838.79999, -2429.19995, 4.80000,   0.00000, 0.00000, 312.98401);
CreateObject(12814, 832.09998, -2425.30005, -3.00000,   359.93408, 270.99426, 138.48413);
CreateObject(8171, 848.40002, -2406.30005, -57.20000,   271.02173, 194.05151, 237.05750);
CreateObject(8171, 876.40002, -2406.39990, -57.20000,   271.01624, 194.04602, 326.04700);
CreateObject(8171, 847.79999, -2405.30005, -57.20000,   271.01624, 194.04602, 58.80200);
CreateObject(12814, 867.00000, -2422.89990, -10.20000,   0.00000, 90.00000, 43.23389);
CreateObject(12814, 838.79999, -2429.19995, 11.90000,   0.00000, 180.00000, 130.98407);
CreateObject(12814, 853.79980, -2420.19922, 4.80000,   0.00000, 0.00000, 311.73157);
CreateObject(12814, 868.59998, -2435.30005, 12.00000,   0.00000, 0.00000, 313.99475);
CreateObject(2780, 822.00000, -2436.89990, 4.80000,   0.00000, 0.00000, 0.00000);
CreateObject(3267, 874.90002, -2412.69995, 12.00000,   0.00000, 0.00000, 312.00000);
CreateObject(3267, 881.59998, -2417.50000, 12.00000,   0.00000, 0.00000, 311.99524);
CreateObject(3267, 903.20001, -2440.19995, 12.00000,   0.00000, 0.00000, 311.99524);
CreateObject(3267, 906.59998, -2446.39990, 12.00000,   0.00000, 0.00000, 311.99524);
CreateObject(2985, 834.09998, -2445.19995, 4.80000,   0.00000, 0.00000, 218.00000);
CreateObject(2985, 830.09998, -2429.80005, 4.80000,   0.00000, 0.00000, 217.99622);
CreateObject(3279, 945.90002, -2366.69995, 12.80000,   0.00000, 0.00000, 310.00000);
CreateObject(3279, 957.00000, -2383.39941, 12.80000,   0.00000, 0.00000, 131.99524);
CreateObject(3524, 916.90002, -2413.30005, 14.90000,   0.00000, 0.00000, 90.00000);
CreateObject(3524, 908.70001, -2405.80005, 14.90000,   0.00000, 0.00000, 90.00000);
CreateObject(3524, 868.59998, -2445.10010, 14.90000,   0.00000, 0.00000, 120.00000);
CreateObject(3524, 871.90002, -2447.80005, 14.90000,   0.00000, 0.00000, 119.99814);
CreateObject(3524, 850.79999, -2427.10010, 3.70000,   0.00000, 0.00000, 324.00000);
CreateObject(3524, 851.70001, -2428.00000, 3.70000,   0.00000, 0.00000, 323.99780);
CreateObject(3524, 851.90002, -2427.10010, 3.70000,   0.00000, 0.00000, 323.99780);
CreateObject(3524, 843.90002, -2419.19995, 3.70000,   0.00000, 0.00000, 323.99780);
CreateObject(3524, 843.00000, -2418.30005, 3.70000,   0.00000, 0.00000, 323.99780);
CreateObject(3524, 844.20001, -2417.80005, 3.70000,   0.00000, 0.00000, 323.99780);
CreateObject(6965, 918.59998, -2467.60010, 15.10000,   0.00000, 0.00000, 0.00000);
CreateObject(12814, 768.29999, -2496.69995, 12.40000,   359.25470, 0.24628, 313.74365);
CreateObject(12814, 756.29999, -2491.00000, -12.80000,   271.03461, 13.77380, 55.76208);
CreateObject(12814, 756.50000, -2511.00000, -12.70000,   272.00500, 172.94678, 306.94202);
CreateObject(12814, 772.90002, -2510.10010, -12.80000,   271.99951, 172.94128, 32.94153);
CreateObject(12814, 783.70001, -2500.89990, -12.90000,   271.99951, 172.94128, 34.18677);
CreateObject(2114, 857.20001, -2533.69995, 12.20000,   0.00000, 0.00000, 0.00000);
CreateObject(1764, 846.70001, -2522.30005, 12.00000,   0.00000, 0.00000, 309.99573);
CreateObject(2093, 846.00000, -2524.89990, 12.00000,   0.00000, 0.00000, 87.98950);
CreateObject(987, 863.90002, -2420.00000, 11.90000,   0.00000, 0.00000, 46.00000);
CreateObject(987, 876.40002, -2407.30005, 11.90000,   0.00000, 0.00000, 225.99976);
CreateObject(987, 863.50000, -2419.89990, 11.90000,   0.00000, 0.00000, 133.99976);
CreateObject(987, 857.90002, -2413.89990, 11.90000,   0.00000, 0.00000, 134.99451);
CreateObject(987, 849.59998, -2405.19995, 11.90000,   0.00000, 0.00000, 44.99451);
CreateObject(987, 854.29999, -2400.60010, 11.90000,   0.00000, 0.00000, 44.98901);
CreateObject(987, 861.90002, -2392.80005, 11.90000,   0.00000, 0.00000, 314.98901);
CreateObject(987, 867.79999, -2398.89990, 11.90000,   0.00000, 0.00000, 314.98352);
CreateObject(13132, 903.20001, -2477.30005, 15.20000,   0.00000, 0.00000, 318.00000);
CreateObject(8210, 914.90002, -2487.00000, 15.00000,   0.00000, 0.00000, 224.00000);
CreateObject(8210, 875.00000, -2525.50000, 15.00000,   0.00000, 0.00000, 223.99475);
CreateObject(8210, 813.59998, -2511.50000, 15.00000,   0.00000, 0.00000, 133.49475);
CreateObject(8210, 800.29999, -2445.50000, 15.00000,   0.00000, 0.00000, 43.23938);
CreateObject(987, 827.20001, -2421.00000, 12.00000,   0.00000, 0.00000, 219.98975);
CreateObject(987, 859.59998, -2540.80005, 12.00000,   0.00000, 0.00000, 221.98474);
CreateObject(987, 851.29999, -2548.50000, 12.00000,   0.00000, 0.00000, 133.98425);
CreateObject(987, 843.29999, -2540.00000, 12.00000,   0.00000, 0.00000, 135.98376);
CreateObject(987, 837.79999, -2534.30005, 12.00000,   0.00000, 0.00000, 140.73328);
CreateObject(987, 863.50000, -2419.89990, 16.20000,   0.00000, 0.00000, 133.99475);
CreateObject(987, 858.09998, -2412.69995, 16.20000,   0.00000, 0.00000, 133.99475);
CreateObject(691, 862.09998, -2435.50000, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(691, 910.20001, -2451.89990, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(691, 915.70001, -2476.30005, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(691, 885.40002, -2420.00000, 12.00000,   0.00000, 0.00000, 0.00000);
CreateObject(5154, 766.00000, -2497.69995, 47.90000,   0.00000, 0.00000, 133.98926);



CreateVehicle(556, 885.8000, -2462.2000, 16.8000, 312.0000, -1, -1, 100);
CreateVehicle(400, 877.7000, -2451.0000, 17.1000, 316.0000, -1, -1, 100);
CreateVehicle(503, 872.3000, -2420.3999, 15.5000, 314.0000, -1, -1, 100);
CreateVehicle(503, 875.8000, -2423.1001, 15.5000, 313.9948, -1, -1, 100);
CreateVehicle(503, 879.2000, -2426.3999, 15.5000, 313.9948, -1, -1, 100);
CreateVehicle(411, 900.3000, -2437.1001, 12.8000, 136.0000, -1, -1, 100);
CreateVehicle(411, 906.2000, -2443.0000, 12.8000, 135.9998, -1, -1, 100);
CreateVehicle(556, 899.5000, -2459.5000, 16.8000, 47.9952, -1, -1, 100);
CreateVehicle(561, 848.7998, -2432.7998, 8.2000, 315.9998, -1, -1, 100);
CreateVehicle(568, 839.3000, -2421.1001, 8.1000, 316.0000, -1, -1, 100);

////////////////////////////////////////////////////////////////////////////////

//_______________________________________[Gates & other]________________________
admingate = CreateObject(2938, 907.20001, -2414.60010, 14.70000,   0.00000, 0.00000, 224.74182); //object(shutter_vegas) (1)
adminsecretgate = CreateObject(3829, 820.39941, -2452.79980, 8.30000,   0.00000, 0.00000, 43.99475); //object(box_hse_04_sfxrf) (1)
pickupup = CreateObject(5154, 766.00000, -2497.69995, 9.60000,   0.00000, 0.00000, 133.98975); //object(dk_cargoshp03d) (1)
//______________________________________________________________________________
//____________________________[Admin Only Vehicle]______________________________
adminhydra = AddStaticVehicleEx(520,863.50000000,-2407.30004883,10.00000000,313.99475098,-1,-1,15); //Hydra
//______________________________________________________________________________
return 1;
}

public OnFilterScriptExit()
{
	printf("\n--------> Admin Area by Chris10 Unloaded. <----------");
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	CreateDynamicPickup(1275,2,767.1139,-2498.0601,13.7720,-1,-1,-1,100);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/ahelp", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		SendClientMessage(playerid,0x0080FFFF,"_____| Admin Area Commands |_____");
		SendClientMessage(playerid,0xFF0000FF,"/adminarea |-{FFFFFF}Teleports you to the Admin Area [OUTSDIDE THE GATE]");
		SendClientMessage(playerid,0xFF0000FF,"/adminhouse |-{FFFFFF}Teleports you to the Admin House");
		SendClientMessage(playerid,0xFF0000FF,"/adminpark |-{FFFFFF}Teleport you to the admin park [BEHIND ADMIN HOUSE]");
		SendClientMessage(playerid,0xFF0000FF,"/agate |-{FFFFFF}Opens the main Admin Gate");
		SendClientMessage(playerid,0xFF0000FF,"/secretarea |-{FFFFFF}Opens The Secret Gate");
        SendClientMessage(playerid,0x0080FFFF,"_________________________________");
		}
		else
		{
		SendClientMessage(playerid,0xFF0000FF,"Only Admins Can Use This Command");
		}
		return 1;
	}
	if (strcmp("/adminarea", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		SetPlayerPos(playerid,923.1180,-2401.5078,13.0437);
		SetPlayerFacingAngle(playerid,131.3587);
		SendClientMessage(playerid,0xFFFF00FF,"You have teleported to the Admin Area");
		}
		else
		{
		SendClientMessage(playerid,0xFF0000FF,"Only Admins Can Use This Command");
		}
		return 1;
	}
	if (strcmp("/adminhouse", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		SetPlayerPos(playerid,869.1640,-2447.3088,13.0078);
		SendClientMessage(playerid,0xFFFF00FF,"You have teleported to the Admin House");
		}
		else
		{
		SendClientMessage(playerid,0xFF0000FF,"Only Admins Can Use This Command");
		}
		return 1;
	}
 	if (strcmp("/adminpark", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		SetPlayerPos(playerid,842.7676,-2491.4177,13.0078);
		SendClientMessage(playerid,0xFFFF00FF,"You have teleported to the Admin Park");
		}
		else
		{
		SendClientMessage(playerid,0xFF0000FF,"Only Admins Can Use This Command");
		}
		return 1;
	}
	if (strcmp("/agate", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerAdmin(playerid))
		{
		MoveObject(admingate,907.90002441,-2413.00000000,21.10000038,2.0);
		SendClientMessage(playerid,0x80FF00FF,"Admin Main Gate is now openning.");
		SetTimer("AdminGateClose",7000,0);
		}
		else
		{
		SendClientMessage(playerid,0xFF0000FF,"Only Admins Can Use This Command");
		}
		return 1;
	}
	if (strcmp("/secretarea", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		MoveObject(adminsecretgate,820.40002441,-2452.80004883,0.30000001,2.0);
		SendClientMessage(playerid,0x80FF00FF,"Secret Gate is now openning.");
		SetTimer("SecretGateClose",7000,0);
		}
		else
		{
		SendClientMessage(playerid,0xFF0000FF,"Only Admins Can Use This Command");
		}
		return 1;
	}
	return 0;
}
public AdminGateClose(playerid)
{
		MoveObject(admingate,907.20001221,-2414.60009766,14.69999981,2.0);
		SendClientMessage(playerid,0xFF8000FF,"Admin Gate is now closing");
		return 1;
}
public SecretGateClose(playerid)
{
		MoveObject(adminsecretgate,820.39941406,-2452.79980469,8.30000019,2.0);
		SendClientMessage(playerid,0xFF8000FF,"Secret Gate is now closing");
		return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(vehicleid == adminhydra)
	{
 	if(!IsPlayerAdmin(playerid))
 	{
 	RemovePlayerFromVehicle(playerid);
 	SendClientMessage(playerid,0xFF0000FF,"You are not allowed to use this vehicle");
 	}
	 else
 	{
 	SendClientMessage(playerid,0x80FF00FF,"Welcome to your Admin Vehicle");
	}
	}
	return 1;
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}
public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{

	
	MoveObject(pickupup,766.00000000,-2497.69995117,47.90000153,1.5);
	SendClientMessage(playerid,0xFF0080FF,"YOU ARE GOING UP");

	return 1;
}
forward GoingDown();
public GoingDown()
{
	MoveObject(pickupup,766.00000000,-2497.69995117,9.60000038,1.5);
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
