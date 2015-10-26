// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <MidoStream>

new harborgate;
new hydragate;
new navygate;
new armyenter;
new armyexit;

#define COLOR_GREY 0xAFAFAFAA
#define LIGHTRED 0xFF6347AA

forward Resetharbor();
forward Resetnavy();
forward Resethydra();

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Easter Basin Army by Geso");
	print("--------------------------------------\n");
	
	DisableInteriorEnterExits();

    CreateStreamObject(10815, -1359.739502, 355.316986, -2.312834, 0.0000, 0.0000, 44.6907, 500); //navy
    CreateStreamObject(10815, -1359.718994, 390.668823, -2.392133, 0.0000, 0.0000, 44.6907, 500);
    CreateStreamObject(16773, -1463.784302, 494.791473, 1.267900, 0.0000, 0.0000, 89.3814, 500);
    CreateStreamObject(16773, -1463.650269, 506.928314, 1.255725, 0.0000, 0.0000, 89.3814, 500);
    CreateStreamObject(16773, -1463.668335, 507.004425, 3.937663, 0.0000, 0.0000, 89.3814, 500);
    CreateStreamObject(16773, -1463.823853, 495.850677, 3.978096, 0.0000, 0.0000, 89.3814, 500);
    CreateStreamObject(987, -1733.726563, 263.463562, 6.189351, 0.0000, 0.0000, 346.2490, 500);
    CreateStreamObject(987, -1722.143677, 260.626465, 6.187500, 0.0000, 0.0000, 1.7189, 500);
    CreateStreamObject(987, -1710.134399, 260.974854, 6.187500, 0.0000, 0.0000, 358.2811, 500);
    CreateStreamObject(987, -1698.178711, 260.606018, 6.187500, 0.0000, 0.0000, 358.2811, 500);
    CreateStreamObject(987, -1686.266113, 260.257477, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1650.391357, 260.102264, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1662.357300, 260.287415, 6.187500, 0.0000, 0.0000, 359.1406, 500);
    CreateStreamObject(987, -1674.281982, 260.262085, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1638.430420, 260.094666, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1626.459106, 260.091888, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1614.500000, 260.091766, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1602.547363, 260.080200, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1590.623901, 260.074707, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1578.725708, 260.054840, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1530.938232, 260.276855, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1554.842285, 260.000519, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1518.917480, 260.194489, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1542.893433, 260.019104, 6.187500, 0.0000, 0.0000, 1.7189, 500);
    CreateStreamObject(987, -1566.768555, 260.019470, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1506.923340, 260.159119, 6.187499, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1494.982178, 260.164490, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1483.020386, 260.173370, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1459.057617, 260.116028, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1471.058838, 260.168732, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1444.379639, 292.091736, 6.180916, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1432.444092, 292.077118, 6.180916, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1420.474854, 292.082764, 6.180916, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1408.553955, 292.090668, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1396.570313, 292.117157, 6.180916, 0.0000, 0.0000, 0.0000, 500);
	CreateStreamObject(987, -1384.614136, 292.105621, 6.187500, 0.0000, 0.0000, 0.0000, 500); //navy
    CreateStreamObject(987, -1372.675781, 292.083313, 6.180916, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1360.715210, 292.088684, 6.187501, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1354.749756, 292.115967, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1342.836670, 292.093079, 6.187500, 0.0000, 0.0000, 44.6907, 500);
    CreateStreamObject(987, -1336.432983, 298.417511, 6.187500, 0.0000, 0.0000, 44.6907, 500);
    CreateStreamObject(987, -1327.931641, 306.758881, 6.187500, 0.0000, 0.0000, 91.1002, 500);
    CreateStreamObject(987, -1328.205322, 318.719788, 6.187500, 0.0000, 0.0000, 91.1002, 500);
    CreateStreamObject(987, -1328.436768, 330.685730, 6.187500, 0.0000, 0.0000, 91.1002, 500);
    CreateStreamObject(987, -1328.568726, 342.636749, 6.187500, 0.0000, 0.0000, 171.8873, 500);
    CreateStreamObject(10610, -1338.397705, 433.206207, -4.326708, 0.0000, 0.0000, 270.6187, 500);
    CreateStreamObject(987, -1338.120728, 404.191742, 6.187500, 0.0000, 0.0000, 28.3614, 500);
    CreateStreamObject(987, -1327.591919, 409.783508, 6.187500, 0.0000, 0.0000, 90.2407, 500);
    CreateStreamObject(987, -1327.630127, 421.707916, 6.174556, 0.0000, 0.0000, 90.2407, 500);
    CreateStreamObject(987, -1327.587158, 433.626038, 6.180916, 0.0000, 0.0000, 359.9999, 500);
    CreateStreamObject(987, -1315.616211, 433.622803, 6.187500, 0.0000, 0.0000, 359.9999, 500);
    CreateStreamObject(987, -1303.656982, 433.642761, 6.180916, 0.0000, 0.0000, 359.9999, 500);
    CreateStreamObject(987, -1291.694092, 433.649841, 6.180917, 0.0000, 0.0000, 0.8593, 500);
    CreateStreamObject(987, -1279.757813, 433.825378, 6.180915, 0.0000, 0.0000, 0.8593, 500);
    CreateStreamObject(987, -1267.806030, 434.000732, 6.180916, 0.0000, 0.0000, 359.9999, 500);
    CreateStreamObject(987, -1255.848389, 434.002441, 6.180916, 0.0000, 0.0000, 359.9999, 500);
    CreateStreamObject(987, -1243.895752, 433.998383, 6.180914, 0.0000, 0.0000, 359.9999, 500);
    CreateStreamObject(3268, -1534.768188, 371.648834, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(3268, -1534.757935, 401.536224, 6.187500, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(3996, -1403.690063, 426.212067, 5.878221, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(5130, -1336.069458, 478.770660, 8.226678, 0.0000, 0.0000, 225.0684, 500);
    CreateStreamObject(5130, -1336.089111, 490.073578, 8.209474, 0.0000, 0.0000, 45.4463, 500);
    CreateStreamObject(3279, -1539.381836, 478.023132, 6.063116, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(3279, -1333.660034, 305.678467, 5.913116, 0.0000, 0.0000, 220.7712, 500);
    CreateStreamObject(987, -1447.129395, 260.076813, 6.187500, 0.0000, 0.0000, 79.0682, 500);
    CreateStreamObject(987, -1444.877075, 271.801361, 6.187500, 0.0000, 0.0000, 91.1003, 500);
    CreateStreamObject(4874, -1425.622681, 365.100372, 32.450146, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(16771, -1669.369629, 282.876465, 12.758995, 0.0000, 0.0000, 358.2811, 500);
    CreateStreamObject(16098, -1570.801758, 321.726135, 10.592936, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(10810, -1236.584961, 442.702820, 11.185941, 0.0000, 0.0000, 201.0040, 500);
    CreateStreamObject(9241, -1250.361694, 465.872498, 7.446400, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(987, -1494.893433, 481.528229, 6.187499, 0.0000, 0.0000, 180.3777, 500);
    CreateStreamObject(987, -1482.960083, 481.587433, 6.187500, 0.0000, 0.0000, 180.3777, 500);
    CreateStreamObject(987, -1470.993896, 481.626556, 6.187500, 0.0000, 0.0000, 180.3777, 500);
    CreateStreamObject(987, -1459.012085, 481.501190, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1447.052612, 481.401733, 6.187502, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1435.087402, 481.273804, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1423.131348, 481.164276, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1411.178223, 481.056641, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1399.258545, 480.942963, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1387.286133, 481.021027, 6.187500, 0.0000, 0.0000, 180.3777, 500);
    CreateStreamObject(987, -1375.335449, 481.277710, 6.187500, 0.0000, 0.0000, 181.2371, 500);
    CreateStreamObject(987, -1363.397949, 481.366028, 6.187500, 0.0000, 0.0000, 180.3777, 500);
    CreateStreamObject(987, -1351.407349, 481.427521, 6.187500, 0.0000, 0.0000, 180.3777, 500);
    CreateStreamObject(987, -1339.432373, 481.716309, 6.187500, 0.0000, 0.0000, 181.2371, 500);
    CreateStreamObject(987, -1321.440063, 481.665741, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1309.487549, 481.555542, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1297.551147, 481.417419, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1285.646729, 481.318573, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1273.681763, 481.217560, 6.187500, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1261.735596, 481.120544, 6.180916, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1249.815552, 481.015778, 6.180916, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1237.857056, 480.901367, 6.180916, 0.0000, 0.0000, 179.5182, 500);
    CreateStreamObject(987, -1228.520142, 473.459259, 6.187499, 0.0000, 0.0000, 141.7027, 500);
    CreateStreamObject(987, -1221.908936, 463.535919, 6.187500, 0.0000, 0.0000, 123.6546, 500);
    CreateStreamObject(987, -1220.809082, 451.689423, 6.187500, 0.0000, 0.0000, 95.2934, 500);
    CreateStreamObject(987, -1220.760864, 439.786713, 6.187499, 0.0000, 0.0000, 90.1368, 500);
    CreateStreamObject(987, -1230.824463, 434.115906, 6.187500, 0.0000, 0.0000, 29.1170, 500);
    CreateStreamObject(987, -1231.960571, 433.930847, 6.186312, 0.0000, 0.0000, 24.9235, 500);
    CreateStreamObject(10610, -1488.141602, 311.050018, 16.673296, 0.0000, 0.0000, 180.3777, 500); //navy
    CreateStreamObject(10830, -1419.635742, 267.365173, 8.250486, 0.0000, 0.0000, 134.9317, 500); //harbor
    CreateStreamObject(987, -1444.961060, 276.162292, 6.182335, 0.0000, 0.0000, 91.1003, 500);
    CreateStreamObject(10830, -1419.761719, 267.407776, 2.975925, 179.6223, 0.0000, 225.0684, 500);
    CreateStreamObject(17546, -1418.546021, 232.805466, 4.397602, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(17546, -1466.157959, 250.029709, 4.120750, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(17068, -1420.552979, 284.471954, -0.094595, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(17068, -1413.971436, 284.365265, -0.046526, 0.0000, 0.0000, 0.0000, 500);
    CreateStreamObject(11495, -1423.486084, 245.939392, -0.043181, 0.0000, 0.0000, 0.0000, 500); //navy harbor
    
    CreateVehicle(520,-1444.2360,391.5374,4.2957,270.0261,-1,-1,6000); // hydra1
    CreateVehicle(520,-1443.7474,355.5935,4.4253,269.2490,-1,-1,6000); // hydra2
    CreateVehicle(520,-1420.0693,495.4032,18.9620,307.3848,-1,-1,6000); // hydra3
    CreateVehicle(520,-1404.5834,495.5542,18.9531,323.7704,-1,-1,6000); // hydra4
    CreateVehicle(520,-1574.1329,304.7929,7.9099,89.9078,-1,-1,6000); // ^^hydra
    CreateVehicle(432,-1655.4523,264.4482,7.2169,88.0744,-1,-1,6000); // rhino1
    CreateVehicle(432,-1653.4678,269.9901,7.2179,86.7408,-1,-1,6000); // rhino2
    CreateVehicle(432,-1652.9629,274.7720,7.2195,87.4114,-1,-1,6000); // rhino3
    CreateVehicle(433,-1684.2689,265.8936,7.6410,268.1562,-1,-1,6000); // barracks1
    CreateVehicle(433,-1683.8285,270.5491,7.6409,268.9097,-1,-1,6000); // barracks2
    CreateVehicle(433,-1684.5278,276.4470,7.6414,267.7325,-1,-1,6000); // barracks3
    CreateVehicle(425,-1248.0492,465.8495,9.8673,91.9576,-1,-1,6000); // hunter
    CreateVehicle(425,-1442.4445,362.2488,33.4940,0.9630,-1,-1,6000); // hunter2
    CreateVehicle(425,-1612.7679,282.4687,7.7520,2.5777,-1,-1,6000); // hunter3
    CreateVehicle(470,-1411.5125,437.3889,7.1806,180.7973,-1,-1,6000); // patriot1
    CreateVehicle(470,-1406.9109,437.3021,7.1776,178.7262,-1,-1,6000); // patriot2
    CreateVehicle(470,-1400.8499,437.1671,7.1799,180.6048,-1,-1,6000); // patriot3
    CreateVehicle(470,-1397.0590,437.1986,7.1787,179.4182,-1,-1,6000); // patriot4
    CreateVehicle(470,-1473.0126,437.5127,7.1819,268.9641,-1,-1,6000); // patriot5
    CreateVehicle(470,-1253.7776,438.8663,7.1781,63.4070,-1,-1,6000); // ^^patriot
    CreateVehicle(470,-1686.3549,281.5611,7.1985,268.9318,-1,-1,6000); // ^^patriot
    CreateVehicle(470,-1686.1251,285.7851,7.1976,269.2419,-1,-1,6000); // ^^patriot
    CreateVehicle(432,-1652.7772,281.4388,7.2212,87.0771,-1,-1,6000); // ^^rhino
    CreateVehicle(470,-1566.6953,291.0585,7.1804,89.7204,-1,-1,6000); // patriot^^
    CreateVehicle(470,-1460.1393,314.9211,7.1753,358.5235,-1,-1,6000); // patriot^^
    CreateVehicle(470,-1476.6591,290.1544,7.1798,89.6961,-1,-1,6000); // patriot^^
    CreateVehicle(470,-1334.9216,336.8700,7.1832,182.0530,-1,-1,6000); // patriot^^
    CreateVehicle(470,-1529.2961,418.7972,7.1815,88.8153,-1,-1,6000); // patriot^^
    CreateVehicle(595,-1442.3375,504.0426,0.2836,91.0768,10,10,6000); // launch
    CreateVehicle(595,-1442.9741,508.8918,0.2546,91.7782,10,10,6000); // launch
    CreateVehicle(470,-1307.7755,477.7745,7.1786,133.9182,-1,-1,6000); // patriot__
    CreateVehicle(470,-1312.6714,478.1263,7.1814,134.2973,-1,-1,6000); // patriot__
    CreateVehicle(507,-1344.5664,415.7534,7.0125,0.4952,0,0,6000); // airforce
    CreateVehicle(507,-1348.2111,415.8526,7.0123,0.3123,0,0,6000); // airforce
    CreateVehicle(507,-1352.2341,415.6541,7.0133,0.3565,0,0,6000); // airforce
    CreateVehicle(507,-1475.9318,286.5323,7.0116,89.8796,0,0,6000); // airforce
    CreateVehicle(447,-1314.0879,493.1172,18.2463,358.6966,0,0,6000); // sea sparrow
    CreateVehicle(447,-1302.6036,493.1836,18.2454,355.5961,0,0,6000); // sea sparrow
    CreateVehicle(595,-1423.1746,282.0843,0.3312,181.2507,4,110,6000); // launch
    CreateVehicle(595,-1416.5485,279.3810,0.1578,182.6255,4,110,6000); // launch
    CreateVehicle(472,-1426.2065,248.8060,0.0323,3.8704,2,1,6000); // coastguard
    CreateVehicle(472,-1431.3307,248.3588,0.0008,0.9222,2,1,6000); // coastguard
    CreateVehicle(427,-1447.7531,283.0437,7.3194,359.2068,37,37,6000); // navy enforcer
    
   	armyexit = CreatePickup(1318, 23, 246.8923, 63.3568, 1003.6406, 10); 
    armyenter = CreatePickup(1318, 23, -1475.0480, 294.1882, 7.1875);
   	hydragate = CreateObject(8378, -1339.185303, 372.924530, 11.900875, 0.0000, 0.0000, 269.7591);
	navygate = CreateObject(969, -1534.671875, 482.415161, 6.377946, 0.0000, 0.0000, 359.1406);
	harborgate = CreateObject(8378, -1396.935303, 257.808868, 1.620848, 0.0000, 0.0000, 268.8997);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/openhydra", cmdtext, true, 10) == 0)
    {
        if(IsPlayerAdmin(playerid) == 1 || GetPlayerSkin(playerid) == 287 || GetPlayerSkin(playerid) == 179)
        {
            MoveObject(hydragate, -1339.185303, 372.924530, -4.300875, 2.00);
            SetTimer("Resethydra",14000,0); //verander zelf de tijd.  (nu sluit die na 5 seconden)
            return 1;
        }
    }

   	if (strcmp("/openharbor", cmdtext, true, 10) == 0)
    {
        if(IsPlayerAdmin(playerid) == 1 || GetPlayerSkin(playerid) == 287 || GetPlayerSkin(playerid) == 179)
        {
            MoveObject(harborgate, -1396.935303, 257.808868, -10.620848, 2.00);
            SetTimer("Resetharbor",14000,0); //verander zelf de tijd.  (nu sluit die na 5 seconden)
            return 1;
        }
    }

    if (strcmp("/openarmy", cmdtext, true, 10) == 0)
    {
        if(IsPlayerAdmin(playerid) == 1 || GetPlayerSkin(playerid) == 287 || GetPlayerSkin(playerid) == 179)
        { // Admins en playerskin 287 en 179 mogen de gate openen.
            MoveObject(navygate, -1525.671875, 482.415161, 6.377946, 2.00);
            SetTimer("Resetnavy",7000,0);
            return 1;
        }
    }
    
   	if(strcmp("/armycmds", cmdtext, true) == 0)
	{
        if(IsPlayerAdmin(playerid) == 1 || GetPlayerSkin(playerid) == 287 || GetPlayerSkin(playerid) == 179)
        SendClientMessage(playerid, COLOR_GREY,"||------------Army commands-----------||");
		SendClientMessage(playerid, LIGHTRED,"To open the gate to enter the base: /openarmy");
        SendClientMessage(playerid, LIGHTRED,"To open the gate of the hydra garages: /openhydra");
        SendClientMessage(playerid, LIGHTRED,"To open the gate of the harbor: /openharbor");
        return 1;
    }
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
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
	if(pickupid == armyenter) // Pickup of enter
	{
        SetPlayerVirtualWorld(playerid, 10);
		SetPlayerInterior(playerid, 6);
		SetPlayerPos(playerid, 247.783996, 64.900199, 1003.640625);
  		SetPlayerFacingAngle(playerid, 0.0);
		return 1;
	}

	if(pickupid == armyexit) // Pickup of exit
	{
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, -1470.0480, 294.1882, 7.1875);
  		SetPlayerFacingAngle(playerid, 0.0);
		return 1;
	}
	return 1;
}

public Resethydra()
   {
   MoveObject(hydragate, -1339.185303, 372.924530, 11.900875, 2.00);
   }

public Resetnavy()
   {
   MoveObject(navygate, -1534.671875, 482.415161, 6.377946, 2.00);
   }

public Resetharbor()
   {
   MoveObject(harborgate, -1396.935303, 257.808868, 1.620848, 2.00);
   }
