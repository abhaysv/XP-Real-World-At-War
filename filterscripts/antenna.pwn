#define FILTERSCRIPT

#include <a_samp>

forward antrespawn();

new ObjectHP[MAX_OBJECTS],
	bool:ObjectDamage[MAX_OBJECTS];
	
new Object_Active[5];
new Object_ID[5];

public OnFilterScriptInit()
{
//    SetTimer("antrespawn", 300000, false);
    SetTimer("antrespawn",300000,0);
    for(new i; i< 5; i++){
    
        Object_Active[i] = 0;
    
    }
	//Let's loop through MAX_OBJECTS and reset their HP.
	for(new i; i< MAX_OBJECTS; i++) {
 		ObjectHP[i] = 0;
		/*What the above code does is, it loops till 1000 as MAX_OBJECT's value is 1000.
		Basically it does:
		ObjectHP[0] = 0;
		ObjectHP[1] = 0;
		ObjectHP[2] = 0;
		...
		ObjectHP[999] = 0; */

		//On the grouped method, I'm also resetting the assigned objects.
		ObjectDamage[i] = false;
		/* This performs in a loop in such a way that :
		ObjectDamage[0] = false;
		ObjectDamage[1] = false;
		ObjectDamage[2] = false;
		...
		ObjectDamage[3] = false; */
	}
	/*
	Now, these are the objects which requires to be assigned to face damage.
	I'll retrieve the object IDs and assign those IDs to face damage.
	I'm declaring an array to retrieve the object IDs.*/
	 //There's 5 objects, so size of 5.
	Object_ID[0] = CreateObject(1682, 404.43066,2467.08984,34.33960,0.00000,0.00000,359.87799);// Australia ant
	Object_ID[1] = CreateObject(1682, -295.68008, 2613.12280, 68.47643,   0.00000, 0.00000, 329.03064);// Usa Ant
	Object_ID[2] = CreateObject(1682, -1536.91064, 2537.67285, 60.15484,   0.00000, 0.00000, 306.91672);// Vietnam
	Object_ID[3] = CreateObject(1682, -820.04688, 1556.85962, 35.53960,   0.00000, 0.00000, 270.00000);//Arabia
	Object_ID[4] = CreateObject(1682, -156.80182, 1130.76709, 24.45772,   0.00000, 0.00000, 0.00000);
	Create3DTextLabel("Team Australia Antenna:\nAntenna ID 0", 0x008080FF, 402.72391, 2473.06445, 29.51463, 0, 0);
	Create3DTextLabel("Team USA Antenna:\nAntenna ID 1", 0x008080FF, -289.47678, 2619.81348, 62.92615, 0, 0);
	Create3DTextLabel("Team Vietnam Antenna:\nAntenna ID 2", 0x008080FF, -1530.90393, 2541.06445, 55.43130, 0, 0);
	Create3DTextLabel("Team Arabia Antenna:\nAntenna ID 3", 0x008080FF, -817.68158, 1557.06384, 29.39157, 0, 0);
	Create3DTextLabel("Team Soviet Antenna:\nAntenna ID 4", 0x008080FF, -155.96533, 1138.15771, 19.35114, 0, 0);
//	CreateObject(18848, 1486.46, -2439.21, 12.50,   0.00, 0.00, 0.00); //A normal object which isn't assigned to face damage.
	//I've created 5 objects which are S-A-M missile launchers (Unbreakable) and also grouped.
	//Now, let me set their HP and assign them.
	//This time, we'll set the HP only to the assigned ones.
	//First of all, let me assign the ones.
	for(new i; i< 5; i++) {
		ObjectDamage[Object_ID[i]] = true; //The ObjectDamage boolean sets true to the object ids which have been retrieved.
		/*Under loop, it does more faster and does in a way like this :
		ObjectDamage[Object_ID[0]] = true;
		ObjectDamage[Object_ID[1]] = true;
		...
		ObjectDamage[Object_ID[4]] = true; */
	}
	//Now just like I did before on the earlier method, I'm setting object's HP.
	//But this time,I'm setting the HP of valid and assigned objects only.
	for(new i; i< MAX_OBJECTS; i++) {
	    if(!IsValidObject(i)) continue; //Skips if it's not a valid object.
	    if(ObjectDamage[i] == false) continue; //If they're not assigned or not set to true, it will skip.
	    ObjectHP[i] = 5000;
		Object_Active[i] = 1; //You can also change the HP rate according to the model ID of objects.
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
 	//We must know if the bullet hit type is related to object, so use an if statement and verify if it's hitting an object.
	if(hittype == BULLET_HIT_TYPE_OBJECT) { //In case if player hits an object
		if(IsValidObject(hitid)) { /*The callback may get called only if hitting valid objects, but still to verify much,
		we can know if it's a valid object or not using 'IsValidObject'. Here, in case if it's a valid object, then:
		We're gonna reduce it's HP. Reducing a custom value wouldn't seem to be good, so let's randomize the value.
		Reducing also depends on the firerates, so if player got good firerates, reducing would go fastly.
		*/

		//This time, we're also looking if the object ID is assigned to true, else it won't get damaged!
			if(ObjectDamage[hitid] == true) { //In case if it's assigned or true, it will damage.

				ObjectHP[hitid] -= random(10) + 1;
				/*
				Here, we're reducing the ObjectHP of the object ID which is called on this callback. It reduces from a
				minimum of 1. random(max) means it will return any numbers starting from random to the max specified value.
				I've added additional +1 to it because in case if 0 is the result, it sums up and doesn't result in 0.

				Now, in case if object's HP goes at 0 or lower than that, we must destroy it. */
				if(ObjectHP[hitid] >= 0) { //If object's HP is either 0 or 1.
					new str[128]; //We will need to declare a string to display the message.
					//I'll be using GameTextForPlayer because if we're using SendClientMessage, it could always spam.
					format(str, sizeof(str), "~G~ANTENNA DAMAGED!~N~~Y~ANTENNA ID ~W~: ~R~ %d~N~~Y~HP LEFT ~W~: ~R~ %d", hitid, ObjectHP[hitid]);
					//I've formatted the string which includes the information of object id and it's HP left.
					GameTextForPlayer(playerid, str, 1800, 3);
					//I'm displaying the info to player. I'm using style '3' because it's the better one in case if this callback is being called at many times.
				}
				if(ObjectHP[hitid] <= 0) { //If objectHP of that object is either 0 or lower,:
			    	DestroyObject(hitid);
			    	Object_Active[hitid] = 0;
			    	new aName[MAX_PLAYER_NAME], string2[128];
	    			GetPlayerName(playerid, aName,sizeof(aName));
	    			format(string2,sizeof(string2),"%s has destroyed an enemy antenna and disrupted enemy the communication systems.",aName);
   					SendClientMessageToAll(0x80FF8096,string2);
				}
			}

		}
	}
	return 1;
}
public antrespawn()
{
//	SetTimer("antrespawn", 1000, false);
	SetTimer("antrespawn",300000,0);
 	for(new i; i< 5; i++)     // Creting Object again if its destroyed
 	{
        if(Object_Active[i] == 1) continue; //Skips if object already exists
        if(Object_Active[i] == 0)
        {
            if(i == 0)  Object_ID[0] = CreateObject(1682, 404.43066,2467.08984,34.33960,0.00000,0.00000,359.87799);
            if(i == 1)  Object_ID[1] = CreateObject(1682, -295.68008, 2613.12280, 68.47643,   0.00000, 0.00000, 329.03064);
            if(i == 2)  Object_ID[2] = CreateObject(1682, -1536.91064, 2537.67285, 60.15484,   0.00000, 0.00000, 306.91672);
            if(i == 3)  Object_ID[3] = CreateObject(1682, -820.04688, 1556.85962, 35.53960,   0.00000, 0.00000, 270.00000);
            if(i == 4)  Object_ID[4] = CreateObject(1682, -156.80182, 1130.76709, 24.45772,   0.00000, 0.00000, 0.00000);
            
         }

    }

	//Now just like I did before on the earlier method, I'm setting object's HP.
	//But this time,I'm setting the HP of valid and assigned objects only.
	for(new i; i< MAX_OBJECTS; i++) {
	    if(!IsValidObject(i)) continue; //Skips if it's not a valid object.
	    if(ObjectDamage[i] == false) continue; //If they're not assigned or not set to true, it will skip.
	    ObjectHP[i] = 5000; //You can also change the HP rate according to the model ID of objects.

	}
}
