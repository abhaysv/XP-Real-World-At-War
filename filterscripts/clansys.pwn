
    #include <a_samp>
    #include <zcmd> // http://forum.sa-mp.com/showthread.php?t=91354
    //Variables
    #define MAX_GROUPS 100 // Change this if you think you are going to ever have over 100 groups.

    enum ginfo
    {
            grname[75],
            leader,
            active
    };

    enum pginfo
    {
            gid,
            order,
            invited,
            attemptjoin
    };

    new group[MAX_PLAYERS][pginfo];
    new groupinfo[MAX_GROUPS][ginfo];

    public OnFilterScriptInit()
    {
            for(new x; x<MAX_PLAYERS; x++)
            {
                    group[x][gid] = -1;
                    group[x][order] = -1;
                    group[x][invited] = -1;
                    group[x][attemptjoin] = -1;
            }
            print("  BFBO Group Script  ");
            return 1;
    }

    public OnPlayerConnect(playerid)
    {
            group[playerid][gid] = -1;
            group[playerid][invited] = -1;
            group[playerid][attemptjoin] = -1;
            return 1;
    }

    public OnPlayerDisconnect(playerid, reason)
    {
        LeaveGroup(playerid, 2);
        return 1;
    }

    COMMAND:clancreate(playerid, params[])
    {
            if(group[playerid][gid] != -1) return SendClientMessage(playerid, 0xFF0000, "Leave your clan with {FFFFFF}/clanleave{FF0000} before creating a new one!");
            if(strlen(params) > 49 || strlen(params) < 3) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/clancreate{FF0000} (Group name 3-50 characters)!");
            if(IsGroupTaken(params)) return SendClientMessage(playerid, 0xFF0000, "Group name is already in use!");
            CreateGroup(params, playerid);
            return 1;
    }

    COMMAND:clanleave(playerid, params[])
    {
            if(group[playerid][gid] == -1) return SendClientMessage(playerid, 0xFF0000, "You are not in a clan to leave one!");
            LeaveGroup(playerid, 0);
            return 1;
    }

    COMMAND:claninvite(playerid, params[])
    {
            if(group[playerid][order] != 1) return SendClientMessage(playerid, 0xFF0000, "You are not the leader of the clan, you cannot invite people!");
            new cid;
            if(isnull(params)) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/claninvite{FF0000} (playerid)");
            cid = strval(params);
            if(!IsPlayerConnected(cid)) return SendClientMessage(playerid, 0xFF0000, "Player Is not connected!");
            if(group[cid][gid] == group[playerid][gid]) return SendClientMessage(playerid, 0xFF0000, "Player Is already in your clan!");
            if(group[cid][invited] == group[playerid][gid]) return SendClientMessage(playerid, 0xFF0000, "Player has already been invited to your clan!");
            if(group[cid][attemptjoin] == group[playerid][gid]) return GroupJoin(cid, group[playerid][gid]);
            group[cid][invited] = group[playerid][gid];
            new string[125], pname[24];
            GetPlayerName(playerid, pname, 24);
            format(string, sizeof(string), "You have been invited to join clan {FFFFFF}%s(%d){FFCC66} by {FFFFFF}%s(%d). /clanjoin %d", groupinfo[group[playerid][gid]][grname], group[playerid][gid], pname, playerid, group[playerid][gid]);
            SendClientMessage(cid, 0xFFCC66, string);
            GetPlayerName(cid, pname, 24);
            format(string, sizeof(string), "You have invited {FFFFFF}%s(%d){FFCC66} to join your clan!", pname, cid);
            SendClientMessage(playerid, 0xFFCC66, string);
            return 1;
    }

    COMMAND:clanleader(playerid, params[])
    {
            if(group[playerid][order] != 1) return SendClientMessage(playerid, 0xFF0000, "You are not the leader of the clan, you cannot change the leader!");
            new cid;
            if(isnull(params)) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/clanleader{FF0000} (playerid)");
            cid = strval(params);
            if(!IsPlayerConnected(cid)) return SendClientMessage(playerid, 0xFF0000, "Player Is not connected!");
            if(cid == playerid)  return SendClientMessage(playerid, 0xFF0000, "You are already group leader, silly.");
            if(group[playerid][gid] != group[cid][gid]) return SendClientMessage(playerid, 0xFF0000, "Player Is not in your group!");
            ChangeMemberOrder(group[playerid][gid], 1);
            group[playerid][order] = GroupMembers(group[playerid][gid]);
            return 1;
    }

    COMMAND:clanjoin(playerid, params[])
    {
            if(group[playerid][gid] != -1) return SendClientMessage(playerid, 0xFF0000, "You are already in a group! Leave your current one before joining another one!");
            new grid;
            if( (isnull(params) && group[playerid][invited] != -1 ) || ( strval(params) == group[playerid][invited] && group[playerid][invited] != -1) ) return GroupJoin(playerid, group[playerid][invited]);
            if(isnull(params)) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/clanjoin{FF0000} (groupid)");
            grid = strval(params);
            if(!groupinfo[grid][active]) return SendClientMessage(playerid, 0xFF0000, "The clan you have tried to join doesn't exist!");
            group[playerid][attemptjoin] = grid;
            new string[125], pname[24];
            GetPlayerName(playerid, pname, 24);
            format(string, sizeof(string), "You have requested to join clan %s(ID:%d)", groupinfo[grid][grname], grid);
            SendClientMessage(playerid, 0xFFCC66, string);
            format(string, sizeof(string), "{FFFFFF}%s(%d) {FFCC66}has requested to join your clan. Type /claninvite %d to accept", pname, playerid, playerid);
            SendMessageToLeader(grid, string);
            return 1;
    }

    COMMAND:clankick(playerid, params[])
    {
            if(group[playerid][order] != 1) return SendClientMessage(playerid, 0xFF0000, "You are not the leader of a clan, you cannot kick!");
            new cid;
            if(isnull(params)) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/clankick{FF0000} (playerid)");
            cid = strval(params);
            if(!IsPlayerConnected(cid)) return SendClientMessage(playerid, 0xFF0000, "Player Is not connected!");
            if(cid == playerid)  return SendClientMessage(playerid, 0xFF0000, "You cannot kick yourself, silly.");
            if(group[playerid][gid] != group[cid][gid]) return SendClientMessage(playerid, 0xFF0000, "Player Is not in your clan!");
            LeaveGroup(cid, 1);
            return 1;
    }

    COMMAND:gm(playerid, params[])
    {
            if(group[playerid][gid] == -1) return SendClientMessage(playerid, 0xFF0000, "You are not in a clan, you cannot clan message!");
            if(isnull(params)) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/gm{FF0000} (message)");
            new pname[24], string[140+24];
            GetPlayerName(playerid, pname, 24);
            format(string, sizeof(string), "[CLAN]%s(%d): %s", pname, playerid, params);
            SendMessageToAllGroupMembers(group[playerid][gid], string);
            return 1;
    }


    COMMAND:clanlist(playerid, params[])
    {
        if(isnull(params) && group[playerid][gid] == -1) return SendClientMessage(playerid, 0xFF0000, "Usage: {FFFFFF}/clanlist{FF0000} (group)");
        if(isnull(params))
            {
                    DisplayGroupMembers(group[playerid][gid], playerid);
                    return 1;
            }
   		new grid = strval(params);
     	if(!groupinfo[grid][active]) return SendClientMessage(playerid, 0xFF0000, "The clan ID you have entered is not active!");
      	DisplayGroupMembers(grid, playerid);
       	return 1;
    }

    COMMAND:clans(playerid, params[])
    {
        ListGroups(playerid);
        return 1;
    }

    COMMAND:cleave(playerid, params[])
            return cmd_clanleave(playerid, params);

    COMMAND:ccreate(playerid, params[])
            return cmd_clancreate(playerid, params);

    COMMAND:cinvite(playerid, params[])
            return cmd_claninvite(playerid, params);

    COMMAND:cleader(playerid, params[])
            return cmd_clanleader(playerid, params);

    COMMAND:cjoin(playerid, params[])
            return cmd_clanjoin(playerid, params);

    COMMAND:ckick(playerid, params[])
            return cmd_clankick(playerid, params);

    COMMAND:cchat(playerid, params[])
            return cmd_gm(playerid, params);

    COMMAND:clist(playerid, params[])
            return cmd_clanlist(playerid, params);


    stock DisplayGroupMembers(groupid, playerid)
    {
        new amount[2], string[200], shortstr[55], pname[24];
        format(string, sizeof(string), "Clan Members for %s(ID:%d)", groupinfo[groupid][grname], groupid);
        SendClientMessage(playerid, 0xFFFFFF, string);
        string = "";
        for(new x; x<MAX_PLAYERS; x++)
            {
                if(group[x][gid] == groupid)
                {
                    amount[0] ++;
                    amount[1] ++;
                    GetPlayerName(x, pname, 24);
                    if(groupinfo[groupid][leader] != x) format(shortstr, sizeof(shortstr), "%s(%d),", pname, x);
                    if(groupinfo[groupid][leader] == x) format(shortstr, sizeof(shortstr), "[CLAN LEADER]%s(%d),", pname, x);
                    if(amount[1] == 1) format(string, sizeof(string), "%s", shortstr);
                    if(amount[1] != 1) format(string, sizeof(string), "%s %s", string, shortstr);
                    if(amount[0] == 6)
                    {
                        strdel(string, strlen(string)-1, strlen(string));
                        SendClientMessage(playerid, 0xFFCC66, string);
                        string = "";
                        amount[0] = 0;
                    }
                }
            }
        strdel(string, strlen(string)-1, strlen(string));
        if(amount[0] != 0) SendClientMessage(playerid, 0xFFCC66, string);
        return 1;
    }

    stock ListGroups(playerid)
    {
    new amount[2], string[200], shortstr[55];
    SendClientMessage(playerid, 0xFFFFFF, "Current clan:");
    for(new x=0; x<MAX_GROUPS; x++)
    {
    if(groupinfo[x][active])
    {
    amount[0] ++;
    amount[1] ++;
    format(shortstr, sizeof(shortstr), "%s(ID:%d)", groupinfo[x][grname], x);
	if(amount[1] == 1) format(string, sizeof(string), "%s", shortstr);
	if(amount[1] != 1) format(string, sizeof(string), "%s %s", string, shortstr);
 	if(amount[0] == 4)
                            {
                                SendClientMessage(playerid, 0xFFCC66, string);
                                string = "";
                                amount[0] = 0;
                            }
                    }
            }
  	if(amount[1] == 0) SendClientMessage(playerid, 0xFFFF00, "There are currently no active clan!");
  	if(amount[1] != 0) SendClientMessage(playerid, 0xFFCC66, string);
  	return 1;
    }



    stock SendMessageToLeader(groupi, message[])
        return SendClientMessage(groupinfo[groupi][leader], 0xFFCC66, message);

    stock GroupJoin(playerid, groupi)
    {
            group[playerid][gid] = groupi;
            group[playerid][order] = GroupMembers(groupi);
        	group[playerid][attemptjoin] = -1;
        	group[playerid][invited] = -1;
        	new pname[24], string[130];
            GetPlayerName(playerid, pname, 24);
        	format(string, sizeof(string), "%s has joined your clan!", pname);
        	SendMessageToAllGroupMembers(groupi, string);
            format(string, sizeof(string), "You have joined clan %s(ID:%d)", groupinfo[groupi][grname] ,groupi);
            SendClientMessage(playerid, 0xFFCC66, string);
            return 1;
    }

    stock FindNextSlot()
    {
            new id;
            while(groupinfo[id][active]) id ++;
            return id;
    }

    stock IsGroupTaken(grpname[])
    {
            for(new x; x<MAX_GROUPS; x++)
            {
                if(groupinfo[x][active] == 1)
                {
                            if(!strcmp(grpname, groupinfo[x][grname], true) && strlen(groupinfo[x][grname]) != 0) return 1;
                    }
            }
            return 0;
    }

    stock GroupInvite(playerid, groupid)
        return group[playerid][invited] = groupid;

    stock CreateGroup(grpname[], owner)
    {
            new slotid = FindNextSlot();
            groupinfo[slotid][leader] = owner;
            format(groupinfo[slotid][grname], 75, "%s", grpname);
            groupinfo[slotid][active] = 1;
            group[owner][gid] = slotid;
            group[owner][order] = 1;
            new string[120];
            format(string, sizeof(string), "You have created the clan %s(ID:%d)", grpname, slotid);
            SendClientMessage(owner, 0xFFCC66, string);
            return slotid;
    }

    stock LeaveGroup(playerid, reason)
    {
            new groupid = group[playerid][gid], orderid = group[playerid][order], string[100], pname[24];
            group[playerid][gid] = -1;
            group[playerid][order] = -1;
            GroupCheck(groupid, orderid);
            GetPlayerName(playerid, pname, 24);
            if(reason == 0)
            {
                    format(string, sizeof(string), "{FFFFFF}%s(%d){FFCC66} has left your clan!", pname, playerid);
                    SendClientMessage(playerid, 0xFFCC66, "You have left your clan");
            }
            if(reason == 1)
            {
                    format(string, sizeof(string), "{FFFFFF}%s(%d){FFCC66} has left your clan (Kicked by the leader)!", pname, playerid);
            		SendClientMessage(playerid, 0xFFCC66, "You have been kicked from your group!");
            }
        	if(reason == 2) format(string, sizeof(string), "{FFFFFF}%s(%d){FFCC66} has left your clan (Disconnected)!", pname, playerid);
            SendMessageToAllGroupMembers(groupid, string);
            return 1;
    }

    stock GroupCheck(groupid, orderid)
    {
            new gmems = GroupMembers(groupid);
            if(!gmems) groupinfo[groupid][active] = 0;
            if(gmems != 0) ChangeMemberOrder(groupid, orderid);
            return 1;
    }

    stock GroupMembers(groupid)
    {
        	if(!groupinfo[groupid][active]) return 0;
            new groupmembers;
            for(new i; i<MAX_PLAYERS; i++) if(group[i][gid] == groupid) groupmembers++;
            return groupmembers;
    }

    stock ChangeMemberOrder(groupid, orderid)
    {
            for(new x; x<MAX_PLAYERS; x++)
            {
                    if(group[x][gid] != groupid || group[x][order] < orderid) continue;
                    group[x][order] --;
                    if(group[x][order] == 1)
                    {
                            groupinfo[groupid][leader] = x;
                            new string[128], pname[24];
                            GetPlayerName(x, pname, 24);
                            format(string, sizeof(string), "{FFFFFF}%s(%d){FFCC66} has been promoted to the new group clan!", pname, x);
                            SendMessageToAllGroupMembers(groupid, string);
                    }
            }
            return 1;
    }

    stock SendMessageToAllGroupMembers(groupid, message[])
    {
            if(!groupinfo[groupid][active]) return 0;
            for(new x; x<MAX_PLAYERS; x++) if(group[x][gid] == groupid) SendClientMessage(x, 0xFFCC66, message);
            return 1;
    }

