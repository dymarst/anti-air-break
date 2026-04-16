#define FILTERSCRIPT

#include <a_samp>

new Float:LastPosZ[MAX_PLAYERS];
new LastUpdateTick[MAX_PLAYERS];
new WarningAirBreak[MAX_PLAYERS];

public OnFilterScriptInit()
{
    print("Air.pwn has been loaded.");
    return 1;
}

public OnPlayerSpawn(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    LastPosZ[playerid] = z;
    LastUpdateTick[playerid] = GetTickCount();
    return 1;
}
public OnPlayerConnect(playerid)
{
    WarningAirBreak[playerid] = 0;
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    LastPosZ[playerid] = 0.0;
    LastUpdateTick[playerid] = 0;
    return 1;
}
Float:GetPlayerSpeed(playerid)
{
    new Float:velocity[3];
    GetPlayerVelocity(playerid, velocity[0], velocity[1], velocity[2]);
    return floatsqroot((velocity[0] * velocity[0]) + (velocity[1] * velocity[1]) + (velocity[2] * velocity[2])) * 100.0;
}

public OnPlayerUpdate(playerid)
{
    new currentTick = GetTickCount();
    if((currentTick - LastUpdateTick[playerid]) >= 1000)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        
        new Float:diffZ = z - LastPosZ[playerid];
        new Float:speed = GetPlayerSpeed(playerid);
        
        if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) return 1;
        
        if(diffZ > 5.0 && speed > 0.5 && !IsPlayerInAnyVehicle(playerid))
        {
            WarningAirBreak[playerid]++;
			printf("[AIR BREAK] ID PLAYER : %d Ketinggian : %f Speed : %f Warning: %d ", playerid,diffZ, speed, WarningAirBreak[playerid]);
        	if(WarningAirBreak[playerid] > 1)
        	{
			    new name[MAX_PLAYER_NAME];
	            GetPlayerName(playerid, name, sizeof(name));

	            new str[144];
	            format(str, sizeof(str), "admin : automatically kicked %s(%d) for airbreak (on foot)", name, playerid);
	            SendClientMessageToAll(0xFF0000FF, str);
	            KickD(playerid);
			}
        }
        
        LastPosZ[playerid] = z;
        LastUpdateTick[playerid] = currentTick;
    }
    return 1;
}
forward KickPublic(playerid);
public KickPublic(playerid)
{
    return Kick(playerid);
}
forward KickD(playerid);
public KickD(playerid)
{
    SetTimerEx("KickPublic", 100, false, "d", playerid);
}
