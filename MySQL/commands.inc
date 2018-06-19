// Staff

CMD:rpwarns(playerid, params[])
{
	return cmd_resetpwarns(playerid, params);
}

CMD:testcolor(playerid, params[])
{
	new color[MAX_STRING_HEXCOLOR], message[MAX_STRING];

	if (sscanf(params, "s["#MAX_STRING_HEXCOLOR"]s["#MAX_STRING"]", color, message))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /testcolor <hex color> <message>");
	}
	else
	{
		SendClientMessageEx(playerid, INVALID_VALUE, "{%s}%s(%i): %s", color, ReturnPlayerName(playerid), playerid, message);
	}

	return 1;
}

CMD:resetpwarns(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid;
		if (sscanf(params, "u", targetid))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /resetpwarns <player>");
		}
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				playerData[targetid][pd_CurrentWarnings] = 0;
				SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have reseted %s(%i)'s current warnings.", ReturnPlayerName(targetid), targetid);
				SendClientMessageEx(targetid, COLOR_REWARD, "%s %s(%i) has reseted your current warnings.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:testhh(playerid, params[])
{
	return cmd_checkhh(playerid, params);
}

CMD:checkhh(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid;
		if (!sscanf(params, "u", targetid))
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
					{
						if (!playerData[targetid][pd_IsOnDuty])
						{
							if (IsPlayerSpawned(targetid))
							{
								new string[MAX_STRING], targetName[MAX_PLAYER_NAME];
								GetPlayerName(targetid, targetName, sizeof(targetName));
								format(string, sizeof string, "[ALERT] %s(%i) has been checked for health-hacks by %s %s(%i).", targetName, targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
								MessageToAdmins(COLOR_ALERT, string);
								CheckPlayerHealthHack(targetid, playerid);
							}
							else
							{
								SendScreenMessage(playerid, "That player is not spawned yet");
							}
						}
						else
						{
							SendScreenMessage(playerid, LOCALE_MESSAGE_CANTDOONDUTYSTAFF);
						}
					}
					else
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /checkhh <player>");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:respawnalluv(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		for (new i = 1, j = GetVehiclePoolSize(); i <= j; i ++)
		{
			if (GetVehicleEmpty(i))
			{
				SetVehicleToRespawn(i);
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s(%i) has re-spawned all unused vehicles.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:respawnallv(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		for (new i = 1, j = GetVehiclePoolSize(); i <= j; i ++)
		{
			if (IsVehicleInGame(i))
			{
				SetVehicleToRespawn(i); // Calls OnVehicleSpawn() callback.
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] All vehicles has been re-spawned by %s %s(%i).", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, message);
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:offchangepname(playerid, params[])
{
	return cmd_changename(playerid, params);
}

CMD:offsetpname(playerid, params[])
{
	return cmd_changename(playerid, params);
}

CMD:offsetname(playerid, params[])
{
	return cmd_changename(playerid, params);
}

CMD:offchangename(playerid, params[])
{
   if (playerData[playerid][pd_AdminRank] >= 5)
   {
		new targetName[MAX_PLAYER_NAME], newName[MAX_PLAYER_NAME];
		if (sscanf(params, "s["#MAX_PLAYER_NAME"]s["#MAX_PLAYER_NAME"]", targetName, newName))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /offchangepname <player name> <new name>");
		}
      else
      {
			if (IsPlayerInGame(GetPlayerId(targetName))) return SendScreenMessage(playerid, "That player is currently online, use '/changepname' instead");
			if (IsValidAccountName(newName))
			{
				new query[55 + MAX_PLAYER_NAME];
				mysql_format(gGameConnection, query, sizeof(query), "SELECT `name` FROM `accounts` WHERE `name` = '%e';", newName);
				mysql_tquery(gGameConnection, query, "OnExecuteFinish", "iiiss", THREAD_UPDATE_ACCOUNTNAME, playerid, INVALID_VALUE, newName, targetName);
			}
			else
			{
				SendScreenMessage(playerid, "The player name is not valid");
			}
		}
   }
   else
   {
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
   }

	return 1;
}

CMD:changename(playerid, params[])
{
   if (playerData[playerid][pd_AdminRank] >= 5)
   {
		new targetid, newName[MAX_PLAYER_NAME];
		if (sscanf(params, "us["#MAX_PLAYER_NAME"]", targetid, newName))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /changepname <player> <new name>");
		}
      else
      {
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (IsValidAccountName(newName))
					{
						new string[55 + MAX_PLAYER_NAME];
						mysql_format(gGameConnection, string, sizeof string, "SELECT `name` FROM `accounts` WHERE `name` = '%e';", newName);
						mysql_tquery(gGameConnection, string, "OnExecuteFinish", "iiiss", THREAD_UPDATE_ACCOUNTNAME, playerid, targetid, newName, ReturnPlayerName(targetid));
					}
					else
					{
						SendScreenMessage(playerid, "The player name is not valid");
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
   }
   else
   {
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
   }

	return 1;
}

CMD:changepname(playerid, params[])
{
	return cmd_changename(playerid, params);
}

CMD:setpname(playerid, params[])
{
	return cmd_changename(playerid, params);
}

CMD:setname(playerid, params[])
{
	return cmd_changename(playerid, params);
}

CMD:ping(playerid, params[])
{
	#pragma unused params

	new message[MAX_STRING_SHORT];
	new const count = GetTickCount();
	format(message, sizeof(message), "Took %d to execute this command.", GetTickCount() - count);
	return SendClientMessage(playerid, COLOR_REWARD, message);
}

CMD:jp(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_JETTROOPER)
	{
	if (Block_CMD[playerid][9] == false)
	{
	if (NoJP == 1)
	{
	SetPlayerSpecialAction(playerid, 2);
	SendClientMessage(playerid,COLOR_NOTIFY, "   An JetPack has been Spawned.");
	Block_CMD[playerid][9] = true;
	SetTimerEx("EnableCMD",120000,false, "dd",playerid,9);
	}
	else return SendScreenMessage(playerid, "Its No Jet Trooper Week");
	}
	else return SendScreenMessage(playerid, "You have to wait 2 minutes!");
	}
	else return SendScreenMessage(playerid, "You need to be JetTrooper Class.");
	return 1;
}

CMD:kill(playerid, params[])
{
	if (AntiSK[playerid] == 0)
	{
		SetPlayerHealth(playerid, 0.0);
		SendClientMessage(playerid, COLOR_NOTIFY, "   You have killed yourself.");
	}
	else
	{
		SendScreenMessage(playerid, "You are not allowed to Succide in Anti-SK Protection");
	}

	return true;
}

CMD:exitdm(playerid, params[])
{
	if (IsPlayerSpawned(playerid) && !IsSpectating[playerid])
	{
		SendClientMessage(playerid, COLOR_NOTIFY, "   You have left the Arena.");
		RemovePlayerFromVehicle(playerid);
		SpawnPlayer(playerid);
	}

	return 1;
}

CMD:leaveduel(playerid, params[])
{
	return cmd_exitdm(playerid, params);
}

CMD:leavepb(playerid, params[])
{
	return cmd_exitdm(playerid, params);
}

CMD:leavearena(playerid, params[])
{
	return cmd_exitdm(playerid, params);
}

CMD:suicide(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 2 || playerData[playerid][pd_ClassId] == CLASS_DEMOLISHER)
	{
		SetPlayerHealth(playerid, 0.0);
		new Float:PPos[3];
		GetPlayerPos(playerid,PPos[0],PPos[1],PPos[2]);
		CreateExplosion(PPos[0],PPos[1],PPos[2],7,10.0);
	}
	else
	{
		SendScreenMessage(playerid, "You Need To Be Demolisher or VIP");
	}

	return 1;
}

CMD:shelp(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_SUPPORT)
	{
		DisplayDialogMessage(playerid, "Commands - Class - Supporter", "{FFFFFF}/sheal - Support Your Team Mate In Range A Health Pack.\n/sammo - Support Your Team Mate In Range A Large Ammo Pack.\n/sarmour - Support Your Team Mate In Range A Armour Pack.\n/sweaps - Support Your team mate in Range Weapons.");
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_COMMANDISNOTYOURCLASS);
	}

	return 1;
}

CMD:sammo(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_SUPPORT)
	{
	if (Block_CMD[playerid][2] == false)
	{
	if (!IsEnemyInRange(playerid))
	{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	Block_CMD[playerid][2] = true;
	new string[64];
	format(string, sizeof string, "%s %s(%i) has supported you an ammo package.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
	SetTimerEx("EnableCMD",300000,false, "dd",playerid,2);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_TeamId] == playerData[playerid][pd_TeamId])
		{
			if (IsPlayerInRangeOfPoint(i, 10.0, x, y, z))
			{
				GiveAmmo(i);
				SendClientMessage(i, COLOR_REWARD, string);
			}
		}
	}
	}
	else SendScreenMessage(playerid, "You cannot use this command when enemy is in range.");
	}
	else SendScreenMessage(playerid, "You need to wait 5 minutes.");
	}
	else SendScreenMessage(playerid, "You Need To Be Support Class.");

	return 1;
}

CMD:sheal(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_SUPPORT)
	{
		if (Block_CMD[playerid][3] == false)
		{
		if (!IsEnemyInRange(playerid))
		{
		new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		Block_CMD[playerid][3] = true;
		new string[64];
		format(string, sizeof string, "%s %s(%i) has supported you an First-Aid kit.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
		SetTimerEx("EnableCMD", 300000, false, "ii", playerid, 3);
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (playerData[i][pd_TeamId] == playerData[playerid][pd_TeamId])
			{
				if (IsPlayerInRangeOfPoint(i,10.0, x, y, z))
				{
					SetPlayerHealth(i, MAX_HEALTH_PLAYER);
					SendClientMessage(i,COLOR_REWARD,string);
				}
			}
		}
		}
		else SendScreenMessage(playerid, "You cannot use this command when enemy is in range.");
		}
		else SendScreenMessage(playerid, "You need to wait 5 minutes.");
	}
	else SendScreenMessage(playerid, "You Need To Be Support Class.");

	return 1;
}

CMD:sarmour(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_SUPPORT)
	{
	if (Block_CMD[playerid][4] == false)
	{
	if (!IsEnemyInRange(playerid)) {
	new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	Block_CMD[playerid][4] = true;
	new string[64];
	format(string, sizeof string, "%s %s(%i) has supported you an armor package.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
	SetTimerEx("EnableCMD",300000,false, "dd",playerid,4);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_TeamId] == playerData[playerid][pd_TeamId])
		{
		if (IsPlayerInRangeOfPoint(i,10.0, x, y, z))
		{
			SetPlayerArmour(i,99.0);
			SendClientMessage(i,COLOR_REWARD,string);
		}
		}
	}
	}
	else SendScreenMessage(playerid, "You cannot use this command when enemy is in range.");
	}
	else SendScreenMessage(playerid, "You need to wait 5 minutes.");
	}
	else SendScreenMessage(playerid, "You Need To Be Support Class.");

	return 1;
}

CMD:sweaps(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_SUPPORT)
	{
	if (Block_CMD[playerid][14] == false)
	{
	if (!IsEnemyInRange(playerid)) {
	new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	Block_CMD[playerid][14] = true;
	new string[64];
	format(string, sizeof string, "%s %s(%i) has supported you weapons package.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
	SetTimerEx("EnableCMD",300000,false, "dd",playerid,14);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == playerData[playerid][pd_TeamId])
	{
	if (IsPlayerInRangeOfPoint(i,10.0, x, y, z) )
	GivePlayerWeaponEx(i, WEAPON_DEAGLE,50) && GivePlayerWeaponEx(i, WEAPON_SHOTGSPA, 50) && GivePlayerWeaponEx(i, WEAPON_TEC9, 50) && GivePlayerWeaponEx(i, WEAPON_KATANA, 2) && SendClientMessage(i,COLOR_REWARD,string);
	}
	}
	}
	else SendScreenMessage(playerid, "You cannot use this command when enemy is in range.");
	}
	else SendScreenMessage(playerid, "You need to wait 5 minutes.");
	}
	else SendScreenMessage(playerid, "You Need To Be Support Class.");

	return 1;
}

CMD:times(playerid, params[])
{
	new string[64];
	format(string, sizeof string, "Time left for nuke: %d Seconds", nuke_time);
	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Time left", string, "OK", "");
	return 1;
}

CMD:getppl(playerid, params[])
{
	return cmd_getppacketlost(playerid, params);
}

CMD:getppacketlost(playerid, params[])
{
	new targetid;

	if (sscanf(params, "u", targetid))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /getppacketlost <player>");
	}
	else
	{
		if (IsPlayerInGame(targetid))
		{
			if (GetPVarInt(targetid, "IsPlayerLoggedIn"))
			{
				new string[32];
				format(string, sizeof string, "{FFFFFF}Current packet lost: %f", NetStats_PacketLossPercent(targetid));
				DisplayDialogMessage(playerid, "Player - Packet Lost", string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}

	return 1;
}

CMD:cmds(playerid, params[])
{
	new COMMAND[650];
	strcat(COMMAND, "{FFFFFF}/chelp /ranks /radiostop /helisupport /clock /ep /rules /getppacketlost /s\n");
	strcat(COMMAND, "{FFFFFF}/anims /sc /st /savestat /myrank /order /pm /teams /mypacketlost /settings\n");
	strcat(COMMAND, "{FFFFFF}/duel /accept /decline /rules /anims /nukehelp /times /time /locate /setemail\n");
	strcat(COMMAND, "{FFFFFF}/admins /objectives /help /updates\n");
	strcat(COMMAND, "{FFFFFF}/kill /dhelp /changename /changepass /rcodes /dnd /vips\n");
	strcat(COMMAND, "{FFFFFF}/credits /suicide /shelp /ask(/helpme) /sendcash /helmeton /helmetoff\n");
	ShowPlayerDialog(playerid, DIALOG_COMMANDS, DIALOG_STYLE_MSGBOX, "Commands", COMMAND, "OK", "");
	return 1;
}

CMD:commands(playerid, params[])
{
	return cmd_cmds(playerid, params);
}

CMD:changeclass(playerid, params[])
{
	return cmd_sc(playerid, params);
}

CMD:sc(playerid, params[])
{
	if (playerData[playerid][pd_IsOnDuty]) return SendScreenMessage(playerid, "You must be off-duty to do that");

	if (AntiSK[playerid] == 0)
	{
		GameTextForPlayer(playerid, "~g~Class Selection ~w~On Next Death", 3000, 4);
		FirstSpawn[playerid] = 1;
	}
	else
	{
		SendScreenMessage(playerid, "You cannot change team while in AntiSK protection! Try again later");
	}

	return 1;
}

CMD:newteam(playerid, params[])
{
	return cmd_st(playerid, params);
}

CMD:changeteam(playerid, params[])
{
	return cmd_st(playerid, params);
}

CMD:st(playerid, params[])
{
	if (playerData[playerid][pd_IsOnDuty]) return SendScreenMessage(playerid, "You must be off-duty to do that");

	if (AntiSK[playerid] == 0)
	{
		ForceClassSelection(playerid);
		GameTextForPlayer(playerid, "~g~Team Selection ~w~On Next Death", 3000, 4);
		FirstSpawn[playerid] = 1;
	}
	else
	{
		SendScreenMessage(playerid, "You cannot change team while in AntiSK protection! Try again later");
	}

	return 1;
}

CMD:forceclass(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid;
		if (sscanf(params, "i", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /forceclass <player>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				CMDMessageToAdmins(playerid, "FORCECLASS");
				FirstSpawn[targetid] = 1;
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:forceteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid;
		if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /forceteam <player>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				CMDMessageToAdmins(playerid, "FORCETEAM");
				ForceClassSelection(targetid);
				SetPlayerHealth(targetid, 0.0);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:ep(playerid, params[])
{
	GivePlayerWeaponEx(playerid, WEAPON_PARACHUTE, 1);
	TakePlayerCash(playerid, 1000);
	SendClientMessage(playerid, COLOR_REWARD, "You have received a Emergency Parachute.");
	return 1;
}

CMD:nukehelp(playerid, params[])
{
	#pragma unused params

	return ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Nuke", LOCALE_HELP_NUKE, "OK", "");
}

CMD:help(playerid, params[])
{
	#pragma unused params

	return ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help", LOCALE_HELP_GENERAL, "OK", "");
}

CMD:rules(playerid, params[])
{
	#pragma unused params

	return ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Rules", LOCALE_HELP_RULES, "OK", "");
}

CMD:chelp(playerid, params[])
{
	#pragma unused params

	return ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Class", LOCALE_HELP_CLASS, "OK", "");
}

CMD:updates(playerid, params[])
{
	#pragma unused params

	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, SERVER_NAME " - Updates", "For list of updates check forums: " SERVER_URL, "OK", "");
	return 1;
}

CMD:credits(playerid, params[])
{
	#pragma unused params

	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Credits", "{FFFFFF}Lewis: {FF0000}Community Owner, Scripter\n{FFFFFF}Matthew: {FF0000}Community Co-Owner\n{FFFFFF}Mr_Police: {FF0000}Co-Owner", "OK", "");
	return 1;
}

CMD:clock(playerid, params[])
{
	if (!playerData[playerid][Clock])
	{
		playerData[playerid][Clock] = 1;
		TogglePlayerClock(playerid, 1);
		GameTextForPlayer(playerid, "~r~Syncing Time", 1000, 0);
		SendClientMessage(playerid, COLOR_NOTIFY, "   You Have Activated The Clock.");
	}
	else
	{
		playerData[playerid][Clock] = 0;
		TogglePlayerClock(playerid, 0);
		GameTextForPlayer(playerid, "~r~Clock Turned Off", 1000, 0);
		SendClientMessage(playerid,COLOR_NOTIFY, "   You Have De-Activated The Clock.");
	}

	return 1;
}

CMD:l(playerid, params[])
{
	return cmd_s(playerid, params);
}

CMD:b(playerid, params[])
{
	return cmd_s(playerid, params);
}

CMD:lc(playerid, params[])
{
	return cmd_s(playerid, params);
}

CMD:s(playerid, params[])
{
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /s <message>");

	new string[MAX_STRING], Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	format(string, sizeof string, "[LOCAL CHAT] %s(%i): %s", ReturnPlayerName(playerid), playerid, params[0]);
	SendMessageToRange(playerid, RADIUS_LOCALCHAT, GetPlayerVirtualWorld(playerid), COLOR_LOCALCHAT, string);
	return 1;
}

CMD:pm(playerid, params[])
{
	if (!playerData[playerid][Muted])
	{
		new targetid, privateMessage[MAX_STRING];
		if (sscanf(params, "us["#MAX_STRING"]", targetid, privateMessage)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /pm <player> <message>");
		if (IsPlayerInGame(targetid))
		{
			if (targetid != playerid)
			{
				if (!isDND[targetid])
				{
					new message[MAX_STRING];
					format(message, sizeof(message), "[PM] to %s(%i): %s", ReturnPlayerName(targetid), targetid, privateMessage);
					SendClientMessage(playerid, COLOR_PM, message);
					format(message, sizeof(message), "[PM] from %s(%i): %s", ReturnPlayerName(playerid), playerid, privateMessage);
					SendClientMessage(targetid, COLOR_PM, message);
					PlayerPlaySound(targetid, SOUND_RECEIVEMESSAGE, 0.0, 0.0, 0.0);
					if (!playerData[playerid][pd_AdminRank])
					{
						format(message, sizeof(message), "[PM] from %s(%i) to %s(%i): %s", ReturnPlayerName(playerid), playerid, ReturnPlayerName(targetid), targetid, privateMessage);
						MessageTo4(COLOR_STAFFCOMMAND, message);
					}
					LastPm[targetid] = playerid;
				}
				else
				{
					SendScreenMessage(playerid, "That player has disabled thier private messages");
				}
			}
			else
			{
				SendScreenMessage(playerid, "You cannot PM yourself");
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
	}

	return 1;
}

CMD:reply(playerid, params[])
{
	return cmd_rpm(playerid, params);
}

CMD:rpm(playerid, params[])
{
	if (!playerData[playerid][Muted])
	{
		new privateMessage[MAX_STRING];
		if (sscanf(params, "s[128]", privateMessage)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /rpm <message>");
		new const targetid = LastPm[playerid];
		if (IsPlayerInGame(targetid))
		{
			if (!isDND[targetid])
			{
				new message[MAX_STRING];
				format(message, sizeof(message), "[PM] to %s(%i): %s", ReturnPlayerName(targetid), targetid, privateMessage);
				SendClientMessage(playerid, COLOR_PM, message);
				format(message, sizeof(message), "[PM] from %s(%i): %s", ReturnPlayerName(playerid), playerid, privateMessage);
				SendClientMessage(targetid, COLOR_PM, message);
				PlayerPlaySound(targetid, SOUND_RECEIVEMESSAGE, 0.0, 0.0, 0.0);
				if (!playerData[playerid][pd_AdminRank])
				{
					format(message, sizeof(message), "[PM] from %s(%i) to %s(%i): %s", ReturnPlayerName(playerid), playerid, ReturnPlayerName(targetid), targetid, privateMessage);
					MessageTo4(COLOR_STAFFCOMMAND, message);
				}
				LastPm[LastPm[playerid]] = playerid;
			}
			else
			{
				SendScreenMessage(playerid, "That player has disabled thier private messages");
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
	}

	return 1;
}

CMD:dnd(playerid, params[])
{
	if (!isDND[playerid])
	{
		isDND[playerid] = 1;
		SendClientMessage(playerid, COLOR_NOTIFY, "   You will no longer receive private messages.");
	}
	else
	{
		isDND[playerid] = 0;
		SendClientMessage(playerid, COLOR_NOTIFY, "   You will now receive private messages.");
	}

	return 1;
}

CMD:ask(playerid, params[])
{
	return cmd_helpme(playerid, params);
}

CMD:helpme(playerid, params[])
{
	new message[MAX_STRING];

	if (sscanf(params, "s["#MAX_STRING"]", message)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /ask <message>");

	format(message, sizeof(message), "[HELP REQUEST] %s(%i): %s", ReturnPlayerName(playerid), playerid, message);
	SendMessageToStaff(COLOR_HELP, message);
	return 1;
}

CMD:giveweapon(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid, weaponId, ammo;
		if (sscanf(params, "uii", targetid, weaponId, ammo))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /giveweapon <player> <weapon Id> <ammo>");
		}
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				if ((weaponId < WEAPON_BRASSKNUCKLE) || (weaponId > TOTAL_WEAPONS))
				{
					return SendScreenMessage(playerid, "The weapon Id must be between 1 and " #TOTAL_WEAPONS "");
				}
				if ((ammo < 1) || (ammo > MAX_WEAPON_AMMO))
				{
					return SendScreenMessage(playerid, "The ammo must be between 1 and " #MAX_WEAPON_AMMO "");
				}
				switch (weaponId)
				{
					case 19, 20, 21:
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDWEAPON);
					}

					case WEAPON_HEATSEEKER, WEAPON_NIGHTVISIONGOGGLES, WEAPON_THERMALGOGGLES:
					{
						SendScreenMessage(playerid, "You cannot give this weapon to players");
					}

					default:
					{
						if (weaponId == WEAPON_SATCHEL)
						{
							GivePlayerWeaponEx(targetid, WEAPON_BOMB, 1);
						}
						new targetName[MAX_PLAYER_NAME], weaponName[MAX_STRING_WEAPONNAME];
						GetPlayerName(targetid, targetName, sizeof(targetName));
						GetWeaponName(weaponId, weaponName, sizeof(weaponName));
						SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have given %s(%i) a %s with %i ammo.", targetName, targetid, weaponName, ammo);
						SendClientMessageEx(targetid, COLOR_REWARD, "%s %s(%i) has given you a %s with %i ammo.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, weaponName, ammo);
						GivePlayerWeaponEx(targetid, weaponId, ammo);
						CMDMessageToAdmins(playerid, "GIVEWEAPON");
					}
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:sethealth(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] < 3) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	
	new targetid, health;
	if(sscanf(params, "ui", targetid, health)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /sethealth <player> <value>");
	if(0 > health > 100) return SendScreenMessage(playerid, "Invaild health amount");
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	new string[MAX_STRING];
	if (!IsPlayerInGame(targetid) && !playerData[targetid][pd_IsLoggedIn]) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	
	CMDMessageToAdmins(playerid, "SETHEALTH");
	format(string, sizeof string, "   You have set %s(%i) health to %i.", ReturnPlayerName(targetid), targetid, health);
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	if (targetid != playerid) { format(string, sizeof string, "%s %s(%i) has set your health to %i.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, health);
	SendClientMessage(targetid,COLOR_REWARD,string); }
	return SetPlayerHealth(targetid, health);
}

CMD:setarmour(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid, armour;
		if(sscanf(params, "ui", targetid, armour)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setarmour <player> <value>");
		if(0 > armour > 100) return SendScreenMessage(playerid, "Invaild armour amount");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		new string[MAX_STRING];
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			CMDMessageToAdmins(playerid, "SETARMOUR");
			format(string, sizeof string, "   You have set %s(%i) armour to %d.", ReturnPlayerName(targetid), targetid, armour);
			SendClientMessage(playerid,COLOR_NOTIFY,string);
			if (targetid != playerid)
			{
				format(string, sizeof string, "%s %s(%i) has set your armour to %d.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, armour);
				SendClientMessage(targetid,COLOR_REWARD,string);
			}
			SetPlayerArmour(targetid, armour - 1);
		}
		else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	}
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:setmoney(playerid, params[])
{
	return cmd_setcash(playerid, params);
}

CMD:setcash(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid, amount;
		if (sscanf(params, "ui", targetid, amount)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setmoney <player> <amount>");
		if (playerData[targetid][pd_AdminRank] > playerData[playerid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				new string[MAX_STRING];
				CMDMessageToAdmins(playerid, "setmoney");
				format(string, sizeof string, "   You have set %s(%i) money to $%i.", ReturnPlayerName(targetid), targetid, amount);
				SendClientMessage(playerid, COLOR_NOTIFY, string);
				if (targetid != playerid)
				{
					format(string, sizeof string, "%s %s(%i) has set your money to $%i.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, amount);
					SendClientMessage(targetid, COLOR_REWARD, string);
				}
				SetPlayerCash(targetid, amount);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:setscore(playerid, params[]) {
	if (playerData[playerid][pd_AdminRank] >= 5) {
		new targetid, score;
		if (sscanf(params, "ui", targetid, score)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setscore <player> <value>");
		new string[MAX_STRING];
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
			if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
			if (0 > score > 999999999) return SendScreenMessage(playerid, "Score must be between 0 and 999999999");

			CMDMessageToAdmins(playerid, "SETSCORE");
			format(string, sizeof string, "   You have set %s score to '%d' ", ReturnPlayerName(targetid), score);
			SendClientMessage(playerid,COLOR_NOTIFY,string);
			if (targetid != playerid) { format(string, sizeof string, "   %s %s has set your score to '%d'", GetStaffClassName(playerid), ReturnPlayerName(playerid), score);
			SendClientMessage(targetid,COLOR_NOTIFY,string); }
			SetPlayerScoreEx(targetid, score);
		} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:setskin(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid, skinId;
		if (sscanf(params, "ui", targetid, skinId)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setskin <player> <skin Id>");
		if (!IsValidSkin(skinId)) return SendScreenMessage(playerid, "Invaild Skin ID");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			new string[MAX_STRING];
			CMDMessageToAdmins(playerid, "SETSKIN");
			format(string, sizeof string, "   You have set %s skin to '%d", ReturnPlayerName(targetid), skinId);
			SendClientMessage(playerid,COLOR_NOTIFY,string);
			if (targetid != playerid)
			{
				format(string, sizeof string, "   %s %s has set your skin to '%d'", GetStaffClassName(playerid), ReturnPlayerName(playerid), skinId);
				SendClientMessage(targetid,COLOR_NOTIFY,string);
			}
			SetPlayerSkinEx(targetid, skinId);
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:settag(playerid, params[])
{
	if ((playerData[playerid][pd_AdminRank] >= 6) || IsPlayerAdmin(playerid))
	{
		new targetid;
		if (sscanf(params, "u", targetid))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /settag <player>");
		}
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			new targetName[MAX_PLAYER_NAME];
			GetPlayerName(targetid, targetName, sizeof(targetName));
			playerData[targetid][CTagg] = 1;
			SendClientMessageEx(targetid, COLOR_REWARD, "%s %s(%i) has allowed you to use server's tag and changed your name.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
			SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have allowed %s(%i) to use server's tag and changed their name.", targetName, targetid);
			new string[70 + MAX_PLAYER_NAME];
			mysql_format(gGameConnection, string, sizeof string, "UPDATE `accounts` SET `name` = '%e%e' WHERE `id` = %i;", SERVER_TAG, targetName, playerData[targetid][pd_AccountId]);
			mysql_tquery(gGameConnection, string);
			format(string, sizeof string, "%s%s", SERVER_TAG, targetName);
			SetPlayerName(targetid, string);
			CMDMessageToAdmins(playerid, "SETTAG");
			PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:unsettag(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 6 || IsPlayerAdmin(playerid))
	{
		new targetid;
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /unsettag <player>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			new string[MAX_STRING];
			playerData[targetid][CTagg] = 0;
			format(string, sizeof string, "   %s %s Has Dis-Allowed You To Use Tag.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
			SendClientMessage(targetid, COLOR_NOTIFY, string);
			format(string, sizeof string, "   You Have Dis-Allowed %s To Use Tag", ReturnPlayerName(targetid));
			SendClientMessage(playerid,COLOR_NOTIFY,string);
			CMDMessageToAdmins(playerid, "UNSETTAG");
			PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
		}
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:setweather(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid, weatherId;
		if (sscanf(params, "ud", targetid, weatherId)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setweather <player> <weather Id>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			new string[MAX_STRING];
			CMDMessageToAdmins(playerid, "SETWEATHER");
			format(string, sizeof string, "   You have set %s weather to '%d", ReturnPlayerName(targetid), weatherId);
			SendClientMessage(playerid,COLOR_NOTIFY,string);
			if (targetid != playerid)
			{
				format(string, sizeof string, "   %s %s has set your weather to '%d'.", GetStaffClassName(playerid), ReturnPlayerName(playerid), weatherId);
				SendClientMessage(targetid,COLOR_NOTIFY,string);
			}
			SetPlayerWeather(targetid,weatherId);
			PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:setkills(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5) {
		new targetid, kills;
		if (sscanf(params, "ud", targetid, kills)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setkills <player> <value>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
			new string[MAX_STRING];
			CMDMessageToAdmins(playerid, "SETKILLS");
			format(string, sizeof string, "   You have set %s Kills to %d.", ReturnPlayerName(targetid), kills);
			SendClientMessage(playerid,COLOR_NOTIFY,string);
			if (targetid != playerid) { format(string, sizeof string, "   %s %s has set your Kills to %d.", GetStaffClassName(playerid), ReturnPlayerName(playerid), kills);
			SendClientMessage(targetid,COLOR_NOTIFY,string); }
			playerData[targetid][pd_Kills] = kills;
			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:setdeaths(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		new targetid, deaths;
		if (sscanf(params, "ud", targetid, deaths)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setdeaths <player> <value>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
		new string[MAX_STRING];
		CMDMessageToAdmins(playerid, "SETDEATHS");
		format(string, sizeof string, "   You have set %s Deaths to '%d", ReturnPlayerName(targetid), deaths);
		SendClientMessage(playerid,COLOR_NOTIFY,string);
		if (targetid != playerid) { format(string, sizeof string, "   %s %s has set your Deaths to '%d'", GetStaffClassName(playerid), ReturnPlayerName(playerid), deaths);
		SendClientMessage(targetid,COLOR_NOTIFY,string); }
		playerData[targetid][pd_Deaths] = deaths;
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:async(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid;
		if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /async <player>");
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			GetPlayerPos(targetid, XR, YR, ZR);
			RemovePlayerFromVehicle(targetid);
			SetPlayerPos(targetid, XR, YR, ZR);
			CMDMessageToAdmins(playerid, "ASYNC");
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:setptime(playerid, params[])
{
	return cmd_settime(playerid, params); 
}

CMD:settime(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid, time;
		if (sscanf(params, "ui", targetid))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setptime <player> <hour>");
		}
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				CMDMessageToAdmins(playerid, "SETPTIME");
				PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
				SetPlayerTime(targetid, time, 0);
				SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have set %s(%i) time to %d:00", ReturnPlayerName(targetid), targetid, time);
				if (targetid != playerid)
				{
					SendClientMessageEx(targetid, COLOR_NOTIFY, "   %s %s(%i) has set your time to %d:00", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, time);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:setworld(playerid, params[])
{
	return cmd_setvw(playerid, params);
}

CMD:setvw(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new targetid, VW;
		if (sscanf(params, "ui", targetid, VW))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setvw <player> <VW Id>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (GetPVarInt(targetid, "IsPlayerLoggedIn"))
				{
					if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
					{
						SetPlayerVirtualWorld(targetid, VW);
						SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have set %s(%i)'s virtual-world to %i.", ReturnPlayerName(targetid), targetid, VW);
						SendClientMessageEx(targetid, COLOR_NOTIFY, "   %s %s(%i) has set your virtual world to %i.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, VW);
					}
					else
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:setpint(playerid, params[])
{
	return cmd_setinterior(playerid, params);
}

CMD:setinterior(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new targetid, Interior;
		if (sscanf(params, "ui", targetid, Interior))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setint <player> <interior Id>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
					{
                  if (Interior < MAX_INTERIORS)
                  {
                     SetPlayerInterior(targetid, Interior);
                     SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have set %s(%i)'s interior Id to %i.", ReturnPlayerName(targetid), targetid, Interior);
                     SendClientMessageEx(targetid, COLOR_NOTIFY, "   %s %s(%i) has changed your interior Id to %i.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, Interior);
                  }
                  else
                  {
                     SendScreenMessage(playerid, "Interior Id must be between 0 and "#MAX_INTERIORS"");
                  }
					}
					else
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:givecar(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 3 || IsPlayerAdmin(playerid)) {
new carid, targetid;
if (sscanf(params, "dd", targetid, carid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /givecar <player> <model Id>");
new targetName[MAX_PLAYER_NAME], string[MAX_STRING];
if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
if (IsPlayerInAnyVehicle(targetid)) return SendScreenMessage(playerid, "Player already has a vehicle");
if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid) {
CMDMessageToAdmins(playerid, "GIVECAR");
new Float:x, Float:y, Float:z;
GetPlayerPos(targetid,x,y,z);
CarSpawner(targetid,carid);
GetPlayerName(targetid, targetName, sizeof(targetName));
format(string, sizeof string, "%s %s(%i) has given you a vehicle.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
SendClientMessage(targetid, COLOR_REWARD, string);
format(string, sizeof string, "   You have given %s(%i) a vehicle.", targetName, targetid);
return SendClientMessage(playerid, COLOR_NOTIFY, string);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:ej(playerid, params[])
{
	return cmd_eject(playerid, params); 
}

CMD:eject(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 3)
{
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /eject <player>");
	new targetid = strval(params), string[MAX_STRING], Float:x, Float:y, Float:z;
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if (IsPlayerInAnyVehicle(targetid)) {
	CMDMessageToAdmins(playerid, "EJECT");
	if (targetid != playerid) { format(string, sizeof string, "   %s %s has ejected you from your vehicle.", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
	SendClientMessage(targetid,COLOR_NOTIFY,string); }
	format(string, sizeof string, "   You have ejected %s from their vehicle", ReturnPlayerName(targetid));
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	GetPlayerPos(targetid,x,y,z);
	return SetPlayerPos(targetid,x,y,z+3);
	} else SendScreenMessage(playerid, "Player is not in a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:aeject(playerid, params[])
{
	return cmd_leject(playerid, params);
}

CMD:leject(playerid, params[]) {
	if (playerData[playerid][pd_AdminRank]) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /leject <player>");
	new targetid = strval(params), string[MAX_STRING], Float:x, Float:y, Float:z;
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if (IsPlayerInAnyVehicle(targetid)) {
	CMDMessageToAdmins(playerid, "LEJECT");
	format(string, sizeof string, "   You have ejected %s from their vehicle.", ReturnPlayerName(targetid));
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	GetPlayerPos(targetid,x,y,z);
	return SetPlayerPos(targetid,x,y,z+3);
	} else SendScreenMessage(playerid, "Player is not in a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:ainject(playerid, params[])
{
	return cmd_linject(playerid, params);
}

CMD:linject(playerid, params[]) {
	if (playerData[playerid][pd_AdminRank] >= 3) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /linject <player>");
	new targetid = strval(params), string[MAX_STRING];
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if (!IsPlayerInAnyVehicle(targetid)) {
	if (IsPlayerInAnyVehicle(playerid)) {
	CMDMessageToAdmins(playerid, "LINJECT");
	if (targetid != playerid) { format(string, sizeof string, "   %s %s has injected you in his vehicle", GetStaffClassName(playerid), ReturnPlayerName(playerid) ); SendClientMessage(targetid,COLOR_NOTIFY,string); }
	format(string, sizeof string, "   You have injected %s into your vehicle", ReturnPlayerName(targetid)); SendClientMessage(playerid,COLOR_NOTIFY,string);
	new vehicleId = GetPlayerVehicleID(playerid);
	return PutPlayerInVehicle(targetid, vehicleId, 1);
	} else return SendScreenMessage(playerid, "You need in enter an vehicle.");
	} else return SendScreenMessage(playerid, "Player already has a vehicle.");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:sendcash(playerid, params[])
{
	return cmd_sendmoney(playerid, params); 
}

CMD:sendmoney(playerid, params[])
{
	new targetid, amount;

	if (sscanf(params, "ui", targetid, amount))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /sendmoney <player> <amount>");
	}
	else
	{
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				if (targetid != playerid)
				{
					if (amount <= 0) return SendScreenMessage(playerid, "The amount must be greater than 0");
					if (playerData[playerid][pd_Money] >= amount)
					{
						GivePlayerCash(targetid, amount);
						TakePlayerCash(playerid, amount);
						SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have given $%i cash to %s(%i).", amount, ReturnPlayerName(targetid), targetid);
						SendClientMessageEx(targetid, COLOR_REWARD, "You have received $%i cash from %s(%i).", amount, ReturnPlayerName(playerid), playerid);
					}
					else
					{
						SendScreenMessage(playerid, "You don't have enough cash");
					}
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}

	return 1;
}

CMD:givecash(playerid, params[])
{
	return cmd_givemoney(playerid, params);
}

CMD:givemoney(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid, amount;
		if (sscanf(params, "ui", targetid, amount)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /givemoney <player> <amount>");
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				if (amount <= 0) return SendScreenMessage(playerid, "The amount must be greater than 0");
				GivePlayerCash(targetid, amount);
				SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have given player %s(%i) $%i cash.", ReturnPlayerName(targetid), targetid, amount);
				SendClientMessageEx(targetid, COLOR_REWARD, "%s %s(%i) has given you $%i cash.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, amount);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:afix(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid)) {
if (isnull(params)) {
if (IsPlayerInAnyVehicle(playerid)) {
RepairVehicle(GetPlayerVehicleID(playerid));
SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
PlayerPlaySound(playerid, SOUND_VEHICLEFIX, 0.0, 0.0, 0.0);
CMDMessageToAdmins(playerid, "AFIX");
return SendClientMessage(playerid, COLOR_NOTIFY, "   The Vehicle has been Fixed.");
} else return SendScreenMessage(playerid, "You are not in a vehicle");
}
new targetid, targetName[MAX_PLAYER_NAME], string[MAX_STRING];
targetid = strval(params);

if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid) {
if (IsPlayerInAnyVehicle(targetid)) {
RepairVehicle(GetPlayerVehicleID(targetid));
SetVehicleHealth(GetPlayerVehicleID(targetid), 1000);
PlayerPlaySound(targetid, SOUND_VEHICLEFIX, 0.0, 0.0, 0.0);
CMDMessageToAdmins(playerid, "AFIX");
GetPlayerName(targetid, targetName, sizeof(targetName));
format(string, sizeof string, "   %s %s Fixed your vehicle.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessage(targetid,COLOR_NOTIFY,string);
format(string, sizeof string, "   You have fixed %s's vehicle.", targetName);
return SendClientMessage(playerid, COLOR_NOTIFY,string);
} else return SendScreenMessage(playerid, "This player isn't in a vehicle");
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEONDUTY);
}

CMD:lockveh(playerid, params[])
{
	return cmd_lockcar(playerid, params);
}

CMD:lockcar(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2) {
	if (IsPlayerInAnyVehicle(playerid)) {
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,true);
	}
	CMDMessageToAdmins(playerid, "LOCKCAR");
	playerData[playerid][DoorsLocked] = 1;
	return 1;
	} else return SendScreenMessage(playerid, "You need to be in a vehicle to lock the doors");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:unlockcar(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2) {
	if (IsPlayerInAnyVehicle(playerid)) {
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,false);
	}
	CMDMessageToAdmins(playerid, "UNLOCKCAR");
	playerData[playerid][DoorsLocked] = 0;

	return 1;
	} else return SendScreenMessage(playerid, "You need to be in a vehicle to lock the doors");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:burn(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 2) {
if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /burn <player>");
new targetid = strval(params), string[MAX_STRING], Float:x, Float:y, Float:z;
if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
CMDMessageToAdmins(playerid, "BURN");
format(string, sizeof string, "   You have burnt %s.", ReturnPlayerName(targetid));
SendClientMessage(playerid,COLOR_NOTIFY,string);
if (targetid != playerid) { format(string, sizeof string, "   %s %s has burned you.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessage(targetid,COLOR_NOTIFY,string); }
GetPlayerPos(targetid, x, y, z);
return CreateExplosion(x, y , z + 3, 1, 10);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:respawn(playerid, params[])
{
	return cmd_spawn(playerid, params);
}

CMD:spawn(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /respawn <player>");
	new targetid = strval(params), string[MAX_STRING];
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	CMDMessageToAdmins(playerid, "SPAWN");
	format(string, sizeof string, "   You have re-spawned %s(%i).", ReturnPlayerName(targetid), targetid);
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	if (targetid != playerid) { format(string, sizeof string, "   %s %s(%i) has re-spawned you.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
	SendClientMessage(targetid,COLOR_NOTIFY,string); }
	RemovePlayerFromVehicle(targetid);
	SpawnPlayer(targetid);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:disarm(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /disarm <player>");
	new targetid = strval(params), string[MAX_STRING];
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	CMDMessageToAdmins(playerid, "DISARM");  PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	format(string, sizeof string, "   You have disarmed %s.", ReturnPlayerName(targetid));
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	if (targetid != playerid) { format(string, sizeof string, "   %s %s has disarmed you.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessage(targetid, COLOR_NOTIFY, string);
	}
	ResetPlayerWeaponsEx(targetid);
	PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:d(playerid, params[])
{
	return cmd_disarm(playerid, params);
}

CMD:crash(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /crash <player>");
	new targetid = strval(params), string[MAX_STRING], Float:X,Float:Y,Float:Z;
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	CMDMessageToAdmins(playerid, "CRASH");
	GetPlayerPos(targetid,X,Y,Z);
	new objectcrash = CreatePlayerObject(targetid,189298743,X,Y,Z,0,0,0);
	DestroyObject(objectcrash);
	format(string, sizeof string, "   You have crashed %s game client.", ReturnPlayerName(targetid) );
	return SendClientMessage(playerid,COLOR_NOTIFY, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:crash2(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /crash2 <player>");
	new targetid = strval(params), string[MAX_STRING];
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	CMDMessageToAdmins(playerid, "CRASH2");
	GameTextForPlayer(targetid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 1);
	GameTextForPlayer(targetid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 2);
	GameTextForPlayer(targetid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 3);
	GameTextForPlayer(targetid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
	GameTextForPlayer(targetid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 5);
	GameTextForPlayer(targetid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 6);
	format(string, sizeof string, "   You have crashed %s game client.", ReturnPlayerName(targetid) );
	return SendClientMessage(playerid,COLOR_NOTIFY, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:ip(playerid, params[])
{
	return cmd_getip(playerid, params);
}

CMD:getpip(playerid, params[])
{
	return cmd_getip(playerid, params);
}

CMD:getip(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new targetid;
		if (sscanf(params, "u", targetid))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /getip <player>");
		}
		if (IsPlayerInGame(targetid))
		{
			if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
			{
				new targetName[MAX_PLAYER_NAME];
				GetPlayerName(targetid, targetName, sizeof(targetName));
				new string[MAX_STRING], ip[MAX_STRING_IP];
				GetPlayerIp(targetid, ip, sizeof(ip));
				format(string, sizeof string, " {FFFFFF}Player: %s(%i) - IP: %s ", targetName, targetid, ip);
				DisplayDialogMessage(playerid, "Player - IP", string);
				CMDMessageToAdmins(playerid, "IP");
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:ipcheck(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new found, string[MAX_STRING], ip[40], targetName[MAX_PLAYER_NAME];
		if (sscanf(params, "s[40]",ip)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /rangecheck <IP>");
		CMDMessageToAdmins(playerid, "IPCHECK");
		format(string, sizeof string, "   IP check has been performed on: %s ",params);
		SendClientMessage(playerid,COLOR_NOTIFY,string);
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			GetPlayerIp(i, ip, 40);
			GetPlayerName(i, targetName, sizeof(targetName));
			new namelen = strlen(ip);
			new bool:searched=false;
			for(new pos = 0; pos <= namelen; pos ++)
			{
				if (searched != true)
				{
					if (strfind(ip, params, true) == pos)
					{
						found ++;
						format(string, sizeof string, "%d - %s - %s(%d)",found, ip, targetName, i);
						SendClientMessage(playerid, COLOR_REWARD ,string);
						searched = true;
					}
				}
			}
		}
		if (found == 0) SendScreenMessage(playerid, "No players have this IP");
	}
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:oban(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetName[MAX_PLAYER_NAME], Reason[MAX_STRING_REASON];
		if (sscanf(params, "s["#MAX_PLAYER_NAME"]s["#MAX_STRING_REASON"]", targetName, Reason))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /oban <player name> <reason>");
		}
		else
		{
			if (!IsPlayerInGame(GetPlayerId(targetName)))
			{
				new string[95 + MAX_PLAYER_NAME];
				mysql_format(gGameConnection, string, sizeof string, "SELECT `id`, `ip` FROM `accounts` WHERE `name` = '%e' AND `administrator_rank` < %i;", targetName, playerData[playerid][pd_AdminRank]);
				mysql_tquery(gGameConnection, string, "OnExecuteFinish", "iiiss", THREAD_ADD_OFFLINEBAN, playerid, INVALID_VALUE, Reason, targetName);
			}
			else
			{
				SendScreenMessage(playerid, "That player is currently online, use '/ban' instead");
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:offban(playerid, params[])
{
	return cmd_oban(playerid, params);
}

CMD:offlineban(playerid, params[])
{
	return cmd_oban(playerid, params);
}

CMD:unban(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] < 4) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	new targetName[MAX_PLAYER_NAME];
	if (sscanf(params, "s["#MAX_PLAYER_NAME"]", targetName))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /unban <player name>");
	}
	else
	{
		if (IsPlayerInGame(GetPlayerId(targetName))) return SendScreenMessage(playerid, "That player is currently online and not banned");
		new query[225 + MAX_PLAYER_NAME];
		mysql_format(gGameConnection, query, sizeof(query), "SELECT `accounts`.`id`, `closed_accounts`.`account_id`, `closed_accounts`.`is_permanently` FROM `accounts`, `closed_accounts` WHERE (`accounts`.`name` = '%e') AND (`accounts`.`id` = `closed_accounts`.`account_id`) LIMIT 1;", targetName);
		mysql_tquery(gGameConnection, query, "OnExecuteFinish", "iiiss", THREAD_DELETE_BAN, playerid, INVALID_VALUE, targetName, "");
	}

	return 1;
}

CMD:unbanip(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3) {
	new
	ip[MAX_STRING_IP], string[64];
	if (sscanf(params, "s[48]",ip)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /unbanip <IP>");
	format(string, sizeof string, "unbanip %s",ip);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have unbanned IP %s.", ip);
	return 1;
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:fine(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid, amount, reason[MAX_STRING_REASON];
		if (sscanf(params, "uis["#MAX_STRING_REASON"]", targetid, amount, reason))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /fine <player> <amount> <reason>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (amount > 0)
					{
						new message[MAX_STRING];
						TakePlayerCash(targetid, amount);
						SendClientMessage(targetid, COLOR_NOTIFY, "   You have been fined.");
						format(message, sizeof(message), "[SERVER] %s(%i) has been fined $%i by %s %s(%i), reason: %s", ReturnPlayerName(targetid), targetid, amount, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, reason);
						SendClientMessageToAll(COLOR_SERVER, message);
					}
					else
					{
						SendScreenMessage(playerid, "The amount must be greater than 0");
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:orban(playerid, params[])
{
	return cmd_offrangeipban(playerid, params);
}

CMD:offrban(playerid, params[])
{
	return cmd_offrangeipban(playerid, params);
}

CMD:offiprangeban(playerid, params[])
{
	return cmd_offrangeipban(playerid, params);
}

CMD:offrangeipban(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new targetIP[MAX_STRING_IP];
		if (sscanf(params, "s[" #MAX_STRING_IP "]", targetIP))
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SYNTAX] /offrban <IP>");
		}
		else
		{
			new string[64];
			SendClientMessage(playerid, COLOR_NOTIFY, "   The range-IP has been banned from the server.");
			new Part1[4], Part2[4], Part3[4], Part4[4];
			sscanf(targetIP, "p<.>s[4]s[4]s[4]s[4]", Part1, Part2, Part3, Part4);
			format(string, sizeof string, "banip %s.%s.%s.*", Part1, Part2, Part3);
			SendRconCommand(string);
			SendRconCommand("reloadbans");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:rban(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new targetid;
		new reason[MAX_STRING_REASON];
		if (sscanf(params, "us["#MAX_STRING_REASON"]", targetid, reason))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /rban <player> <reason>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				new string[160 + MAX_STRING_REASON + MAX_STRING_IP], targetIP[MAX_STRING_IP];
				GetPlayerIp(targetid, targetIP, sizeof(targetIP));
				mysql_format(gGameConnection, string, sizeof string, "INSERT IGNORE INTO `closed_accounts` (`account_id`, `reason`, `is_permanently`, `ip`, `by_account_id`) VALUES (%i, '%e', 1, '%s', %i);", playerData[targetid][pd_AccountId], reason, targetIP, playerData[playerid][pd_AccountId]);
				mysql_tquery(gGameConnection, string);
				format(string, sizeof string, "UPDATE `accounts` SET `total_bans` = `total_bans` + 1 WHERE `id` = %i;", playerData[targetid][pd_AccountId]);
				mysql_tquery(gGameConnection, string);
				format(string, sizeof string, "[SERVER] %s(%i) has been range-IP banned by %s %s(%i).", ReturnPlayerName(targetid), targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
				SendClientMessageToAll(COLOR_SERVER, string);
				SendClientMessage(targetid, COLOR_NOTIFY, "   You have been range-IP banned and kicked from the server.");
				new Part1[4], Part2[4], Part3[4], Part4[4];
				sscanf(targetIP, "p<.>s[4]s[4]s[4]s[4]", Part1, Part2, Part3, Part4);
				format(string, sizeof string, "banip %s.%s.%s.*", Part1, Part2, Part3);
				SendRconCommand(string);
				SendRconCommand("reloadbans");
				SetTimerEx("KickEx", TIMER_KICK, false, "i", targetid);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:iprangeban(playerid, params[])
{
	return cmd_rban(playerid, params);
}

CMD:ban(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] < 2) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	new targetid, Reason[MAX_STRING_REASON];
	if (sscanf(params, "us["#MAX_STRING_REASON"]", targetid, Reason)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /ban <player> <reason>");
	if (IsPlayerInGame(targetid)) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	if (playerData[playerid][pd_AdminRank] <= playerData[targetid][pd_AdminRank]) SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);

	new string[256];
	format(string, sizeof string, "[SERVER] %s(%i) has been banned by %s %s(%i), reason: %s", ReturnPlayerName(targetid), targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, Reason);
	SendClientMessageToAll(0x8B0000FF/*COLOR_SERVER*/, string);
	mysql_format(gGameConnection, string, sizeof string, "INSERT IGNORE INTO `closed_accounts` (`account_id`, `reason`, `ip`, `by_account_id`) VALUES (%i, '%e', '%s', %i);", playerData[targetid][pd_AccountId], Reason, GetPlayerIP(targetid), playerData[playerid][pd_AccountId]);
	mysql_tquery(gGameConnection, string);
	format(string, sizeof string, "UPDATE `accounts` SET `total_bans` = `total_bans` + 1 WHERE `id` = %i;", playerData[targetid][pd_AccountId]);
	mysql_tquery(gGameConnection, string);
	SendClientMessage(targetid, COLOR_NOTIFY, "   You have been banned and kicked from the server.");
	SendClientMessage(targetid, COLOR_HINT, "[HINT] You may appeal for unban on " SERVER_URL);
	SetTimerEx("KickEx", TIMER_KICK, false, "i", targetid);
	return 1;
}

CMD:getpaccounts(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid;
		if (sscanf(params, "u", targetid))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /aka <player>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
				{
					new targetIP[MAX_STRING_IP], currentIP[4], string[MAX_STRING];
					GetPlayerIp(targetid, targetIP, sizeof(targetIP));
					sscanf(targetIP, "p<.>iiii", currentIP[0], currentIP[1], currentIP[2], currentIP[3]);
					format(string, sizeof string, "SELECT `name`, `ip`, `score`, `money` FROM `accounts` WHERE `ip` LIKE '%i.%i.%i.%%' OR `registration_ip` LIKE '%i.%i.%i.%%' LIMIT 20;", currentIP[0], currentIP[1], currentIP[2]);
					mysql_tquery(gGameConnection, string, "OnExecuteFinish", "iiiss", THREAD_GET_ACCOUNTS, playerid, INVALID_VALUE, "", "");
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:aka(playerid, params[])
{
	return cmd_getpaccounts(playerid, params);
}

CMD:getipaccounts(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetip[MAX_STRING_IP];
		if (sscanf(params, "s["#MAX_STRING_IP"]", targetip))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /getipaccounts <IP>");
		}
		else
		{
			new currentIP[4], string[MAX_STRING];
			sscanf(targetip, "p<.>iiii", currentIP[0], currentIP[1], currentIP[2], currentIP[3]);
			format(string, sizeof string, "SELECT `name`, `ip`, `score`, `money` FROM `accounts` WHERE `ip` LIKE '%i.%i.%i.%%' OR `registration_ip` LIKE '%i.%i.%i.%%' LIMIT 20;", currentIP[0], currentIP[1], currentIP[2]);
			mysql_tquery(gGameConnection, string, "OnExecuteFinish", "iiiss", THREAD_GET_ACCOUNTS, playerid, INVALID_VALUE, "", "");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:baninfo(playerid, params[])
{
	return cmd_searchban(playerid, params);
}

CMD:searchban(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new targetName[MAX_PLAYER_NAME];
		if (sscanf(params, "s["#MAX_PLAYER_NAME"]", targetName))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /baninfo <player name>");
		}
		else
		{
			if (IsPlayerInGame(GetPlayerId(targetName)))
			{
				return SendScreenMessage(playerid, "That player is currently online and not banned");
			}
			SetPVarInt(playerid, "IsCheckingByStaff", true);
			new Query[305 + MAX_PLAYER_NAME];
			mysql_format(gGameConnection, Query, sizeof(Query), "SELECT `accounts`.`id`, `closed_accounts`.*, (SELECT `accounts`.`name` FROM `accounts` WHERE `accounts`.`id` = `closed_accounts`.`by_account_id` LIMIT 1) as 'closed_by' FROM `accounts`, `closed_accounts` WHERE (`accounts`.`name` = '%e') AND (`accounts`.`id` = `closed_accounts`.`account_id`) LIMIT 1;", targetName);
			mysql_tquery(gGameConnection, Query, "OnExecuteFinish", "iiiss", THREAD_CHECK_BAN, playerid, 1, targetName, "");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:resetpcash(playerid, params[])
{
	return cmd_bankrupt(playerid, params);
}

CMD:bankrupt(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid;
		if (sscanf(params, "u", targetid))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /resetpcash <player>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					CMDMessageToAdmins(playerid, "RESETPCASH");
					SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have reseted %s(%i)'s cash to 0.", ReturnPlayerName(targetid), targetid);
					SendClientMessageEx(targetid, COLOR_REWARD, "%s %s(%i) has reseted your cash to 0.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
					SetPlayerCash(targetid, 0);
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:admincommands(playerid)
{
	return cmd_acmds(playerid);
}

CMD:admincmds(playerid)
{
	return cmd_acmds(playerid);
}

CMD:acmds(playerid)
{
	if (!playerData[playerid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	new str[2000];

	strcat(str, "Rank 1 - Trial Administrator\n");
	strcat(str, "/(res)ponse, /flip, /un(mute), /fixveh (/repair), /carcolour, /ltune, /adminarea, /linkcar, /kick\n");
	strcat(str, "/getid, /lnos, /lhy, /sound, /reports, /lp, /sendserverinfo, /baninfo, /jetpack, /rjetpack, /slap\n");
	strcat(str, "/warn\n");
	
	strcat(str, "Trial Administrator chat: . to chat with level 1+\n\n");

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		strcat(str, "Rank 2 - Server Administrator\n");
		strcat(str, "/giveweapon, /setcolour, /(un)lockcar, /burn, /spawn, /disarm, /lcar, /lbike, /(announce)2\n");
		strcat(str, "/lheli, /fine, /lboat, /lplane, /screen, /flip, /resetpwarns, /respawnall, /getplastlog, /respawnalluv\n");
		strcat(str, "/goto, /vgoto, /lgoto, /jailed, /frozen, /muted, /ls, /lsof, /lsv, /clearchat, /lmenu, /cmd, /ltmenu\n");
		strcat(str, "/write, /explode, /burn, /async, /ban\n\n");
	}

	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		strcat(str, "Rank 3 - Senior Administrator\n");
		strcat(str, "/sethealth, /setarmour, /setmoney, /setskin, /setweather, /setallskin\n");
		strcat(str, "/SETTIME, /SETWORLD, /SETINTERIOR, /FORCECLASS, /FORCETEAM, /EJECT, /RESETPCASH, /LWEAPS\n");
		strcat(str, "/LAMMO, /ADUEL, /CAR, /getipaccounts, /CARHEALTH, /CARCOLOR, /SETPING, /SETGRAVITY, /fixallveh\n");
		strcat(str, "/TELEPLAYER, /VGET, /GIVECAR, /GETTHERE, /GET, /JAIL, /UNJAIL, /FREEZE, /DESTROYCAR\n");
		strcat(str, "/UNFREEZE, /AKILL, /AKA, /DISABLECHAT, /ASTREAM, /ASTOP\n");
		strcat(str, "/SETALLWEATHER, /SETALLTIME, /SETALLWORLD, /UNFREEZEALL, /respawnallv\n");
		strcat(str, "/LWEATHER, /LTIME, /LWEAPONS, /SETPASS, /CHANGENAME, /HEALALL, /checkhh(/testhh)\n\n");
	}

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		strcat(str, "Rank 4 - Lead Administrator\n");
		strcat(str, "/enable, /disable, /unban, /rban, /crash, /spam, /godcar, /slay, /uncofig, /maze, /healnear\n");
		strcat(str, "/forbidname, /forbidword, /setname, /armourall, /saveallstats, /changepemail\n");
		strcat(str, "/spawnall, /muteall, /unmuteall, /getall, /freezeall, /giveweapon, /armornear\n");
		strcat(str, "/slapall, /explodeall, /disarmall, /ejectall, /undercover\n");
		strcat(str, "Event: /getteam, /giveteamcash, /giveteamweapon, /giveteamscore, /spawnteam, /freezeteam, /unfreezeteam, /disarmteam\n");
		
		strcat(str, "Lead Administrator chat: $ to chat with level 4+\n\n");
	}

	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		strcat(str, "Rank 5 - Head Administrator\n");
		strcat(str, "/setkills, /pickup, /fakechat, /setdeaths\n");
		strcat(str, "Weekly Events:  /disablejp, /disablespy, /disablehs\n");
		
		strcat(str, "Head adminstrator chat: @ to chat with level 5+\n\n");
	}

	if(playerData[playerid][pd_AdminRank] >= 6)
	{
		strcat(str, "Rank 6 - Master Administrator\n\n");
		strcat(str, "/setlevel, /un(settag)");
	}

	if(playerData[playerid][pd_AdminRank] >= 7)
	{
		strcat(str, "Rank 7 - Community Co Owner\n\n");
	}

	if(playerData[playerid][pd_AdminRank] >= 8)
	{
		strcat(str, "Rank 8 - Community Owner\n\n");
	}

	ShowPlayerDialog(playerid, DIALOG_COMMANDS_ADMINISTRATOR, DIALOG_STYLE_MSGBOX, "Commands - Administrator", str, "Cancel", "");
	return 1;
}

CMD:lconfig(playerid)
{
	if (playerData[playerid][pd_AdminRank] > 0)
	{
		new string[MAX_STRING];
		format(string, sizeof string, "Max Ping: %dms | ReadPms %d | ReadCmds %d | Max Admin Level %d | AdminOnlySkins %d", ServerInfo[MaxPing],  ServerInfo[ReadPMs],  ServerInfo[ReadCmds],  ServerInfo[MaxAdminLevel],  ServerInfo[AdminOnlySkins] );
		SendClientMessage(playerid,COLOR_REWARD,string);
		format(string, sizeof string, "AdminSkin1 %d | AdminSkin2 %d | NameKick %d | AntiSpam %d | AntiSwear %d", ServerInfo[AdminSkin], ServerInfo[AdminSkin2], ServerInfo[NameKick], ServerInfo[AntiSpam], ServerInfo[AntiSwear]);
		SendClientMessage(playerid,COLOR_REWARD,string);
		format(string, sizeof string, "Locked %d | SaveWeaps %d | SaveMoney %d | ConnectMessages %d | AdminCmdMsgs %d", ServerInfo[Locked], ServerInfo[GiveWeap], ServerInfo[GiveMoney], ServerInfo[ConnectMessages], ServerInfo[AdminCmdMsg] );
		SendClientMessage(playerid,COLOR_REWARD,string);
		format(string, sizeof string, "AutoLogin %d | MaxMuteWarnings %d | ChatDisabled %d | MustLogin %d | MustRegister %d", ServerInfo[AutoLogin], ServerInfo[MaxMuteWarnings], ServerInfo[DisableChat], ServerInfo[MustLogin], ServerInfo[MustRegister] );
		SendClientMessage(playerid,COLOR_REWARD,string);
	}
	return 1;
}

CMD:getinfo(playerid, params[]) {
	if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid)) {
	if (isnull(params)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /getinfo <player>");
	new targetid, string[MAX_STRING];
	targetid = strval(params);

	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	new Float:player1armour, Float:x, Float:y, Float:z, tmp2[256], P1Jailed[4], P1Frozen[4], P1Logged[4], P1Register[4], RegDate[256], TimesOn;
	GetPlayerArmour(targetid,player1armour);
	GetPlayerPos(targetid,x,y,z);

	if (playerData[targetid][JailTime]) P1Jailed = "Yes"; else P1Jailed = "No";
	if (playerData[targetid][Frozen]) P1Frozen = "Yes"; else P1Frozen = "No";
	if (playerData[targetid][pd_IsLoggedIn] == 1) P1Logged = "Yes"; else P1Logged = "No";

	format(string, sizeof string, "(Player Info) Name: %s ID: %d", ReturnPlayerName(targetid), targetid);
	SendClientMessage(playerid,COLOR_REWARD,string);
	format(string, sizeof string, "Health: %d  Armor: %d  Score: %d  Money: %d  Skin: %d  IP: %s Ping: %d",floatround(ReturnPlayerHealth(targetid)),floatround(player1armour),
	GetPlayerScore(targetid),GetPlayerMoney(targetid),GetPlayerSkin(targetid), GetPlayerIP(targetid), GetPlayerPing(targetid));
	SendClientMessage(playerid,COLOR_REWARD,string);
	format(string, sizeof string, "Interior: %d  Virtual World: %d  Wanted Level: %d  X %0.1f  Y %0.1f  Z %0.1f", GetPlayerInterior(targetid), GetPlayerVirtualWorld(targetid), GetPlayerWantedLevel(targetid), Float:x,Float:y,Float:z);
	SendClientMessage(playerid,COLOR_REWARD,string);
	format(string, sizeof string, "Times On Server: %d  Kills: %d  Deaths: %d  Ratio: %0.2f  AdminLevel: %d", TimesOn, playerData[targetid][pd_Kills], playerData[targetid][pd_Deaths], Float:playerData[targetid][pd_Kills]/Float:playerData[targetid][pd_Deaths], playerData[targetid][pd_AdminRank] );
	SendClientMessage(playerid,COLOR_REWARD,string);
	format(string, sizeof string, "Registered: %s  Logged In: %s  In Jail: %s  Frozen: %s", P1Register, P1Logged, P1Jailed, P1Frozen );
	SendClientMessage(playerid,COLOR_REWARD,string);
	format(string, sizeof string, "Last On Server: %s  Register Date: %s", tmp2, RegDate);
	SendClientMessage(playerid,COLOR_REWARD,string);

	if (IsPlayerInAnyVehicle(targetid)) {
	new Float:VHealth, carid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(carid,VHealth);
	format(string, sizeof string, "VehicleID: %d  Model: %d  Vehicle Name: %s  Vehicle Health: %d",carid, GetVehicleModel(carid), vehicleNames[GetVehicleModel(carid)-400], floatround(VHealth) );
	SendClientMessage(playerid,COLOR_REWARD,string);
	}

	new slot, ammo, weap, cnt, WeapName[24], WeapSTR[MAX_STRING], p; WeapSTR = "Weaps: ";
	for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(targetid, slot, weap, ammo); if ( ammo != 0 && weap != 0) cnt++; }
	if (cnt < 1) return SendScreenMessage(playerid, "Player has no weapons");
	else {
	for (slot = 0; slot < 14; slot++)
	{
	GetPlayerWeaponData(targetid, slot, weap, ammo);
	if (ammo > 0 && weap > 0)
	{
	GetWeaponName(weap, WeapName, sizeof(WeapName) );
	if (ammo == 65535 || ammo == 1) format(WeapSTR, sizeof(WeapSTR), "%s%s (1)",WeapSTR, WeapName);
	else format(WeapSTR, sizeof(WeapSTR), "%s%s (%d)",WeapSTR, WeapName, ammo);
	p++;
	if (p >= 5) { SendClientMessage(playerid, COLOR_REWARD, WeapSTR);
	format(WeapSTR, sizeof(WeapSTR), "Weaps: "); p = 0;
	} else format(WeapSTR, sizeof(WeapSTR), "%s,  ", WeapSTR);
	}
	}
	if (p <= 4 && p > 0) {
	string[strlen(string)-3] = '.';
	SendClientMessage(playerid, COLOR_REWARD, WeapSTR);
	}
	}
	return 1;
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:disable(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 4 || IsPlayerAdmin(playerid)) {
if (isnull(params)) {
return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /disable <namekick, antispam, ping, readcmds, readpms, admincmdmsgs, connectmsgs, autologin>");
}
new string[MAX_STRING], file[256]; format(file, sizeof(file), "ladmin/config/Config.ini");
if (strcmp(params, "namekick",true) == 0) {
ServerInfo[NameKick] = 0;
dini_IntSet(file, "NameKick",0);
format(string, sizeof string, "[SERVER] %s %s has disabled namekick.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "antispam",true) == 0)	{
ServerInfo[AntiSpam] = 0;
dini_IntSet(file, "AntiSpam",0);
format(string, sizeof string, "[SERVER] %s %s has disabled antispam", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "ping",true) == 0)	{
ServerInfo[MaxPing] = 0;
dini_IntSet(file, "MaxPing",0);
format(string, sizeof string, "[SERVER] %s %s has disabled maxping", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "readcmds",true) == 0) {
ServerInfo[ReadCmds] = 0;
dini_IntSet(file, "ReadCMDs",0);
format(string, sizeof string, "[STAFF] %s has disabled readcmds", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "readpms",true) == 0) {
ServerInfo[ReadPMs] = 0;
dini_IntSet(file, "ReadPMs",0);
format(string, sizeof string, "[STAFF] %s has disabled readpms", ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "admincmdmsgs",true) == 0) {
ServerInfo[AdminCmdMsg] = 0;
dini_IntSet(file, "AdminCMDMessages",0);
format(string, sizeof string, "[STAFF] %s has disabled AdminCMDMessages", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "connectmsgs",true) == 0)	{
ServerInfo[ConnectMessages] = 0;
dini_IntSet(file, "ConnectMessages",0);
format(string, sizeof string, "[STAFF] %s has disabled connectmessages", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "autologin",true) == 0)	{
ServerInfo[AutoLogin] = 0;
dini_IntSet(file, "AutoLogin",0);
format(string, sizeof string, "[STAFF] %s has disabled autologin", ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else {
SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /disable <antiswear / namekick / antispam / ping / readcmds / readpms / cmdmsg>");
} return 1;
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:enable(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 4 || IsPlayerAdmin(playerid)) {
if (isnull(params)) {
SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /enable <antiswear / namekick / antispam / ping / readcmds / readpms / admincmdmsgs");
return SendClientMessage(playerid,COLOR_SYNTAX, "		 / connectmsgs / autologin >");
}
new string[MAX_STRING], file[256]; format(file, sizeof(file), "ladmin/config/Config.ini");
if (strcmp(params, "antiswear",true) == 0) {
ServerInfo[AntiSwear] = 1;
dini_IntSet(file, "AntiSwear",1);
format(string, sizeof string, "[SERVER] %s %s has enabled anti-swear",GetStaffClassName(playerid),  ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "namekick",true) == 0)	{
ServerInfo[NameKick] = 1;
format(string, sizeof string, "[SERVER] %s %s has enabled namekick", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "antispam",true) == 0)	{
ServerInfo[AntiSpam] = 1;
dini_IntSet(file, "AntiSpam",1);
format(string, sizeof string, "[SERVER] %s %s has enabled antispam", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "ping",true) == 0)	{
ServerInfo[MaxPing] = 800;
dini_IntSet(file, "MaxPing",800);
format(string, sizeof string, "[SERVER] %s %s has enabled maxping", GetStaffClassName(playerid), ReturnPlayerName(playerid));
SendClientMessageToAll(COLOR_SERVER,string);
} else if (strcmp(params, "readcmds",true) == 0)	{
ServerInfo[ReadCmds] = 1;
dini_IntSet(file, "ReadCMDs",1);
format(string, sizeof string, "[STAFF] %s has enabled readcmds", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "readpms",true) == 0) {
ServerInfo[ReadPMs] = 1;
dini_IntSet(file, "ReadPMs",1);
format(string, sizeof string, "[STAFF] %s has enabled readpms", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "admincmdmsgs",true) == 0)	{
ServerInfo[AdminCmdMsg] = 1;
dini_IntSet(file, "AdminCmdMessages",1);
format(string, sizeof string, "[STAFF] %s %s has enabled AdminCMDMessages", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "connectmsgs",true) == 0) {
ServerInfo[ConnectMessages] = 1;
dini_IntSet(file, "ConnectMessages",1);
format(string, sizeof string, "[STAFF] %s %s has enabled connect-messages", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else if (strcmp(params, "autologin",true) == 0) {
ServerInfo[AutoLogin] = 1;
dini_IntSet(file, "AutoLogin",1);
format(string, sizeof string, "[STAFF] %s %s has enabled autologin", GetStaffClassName(playerid), ReturnPlayerName(playerid));
MessageToAdmins(COLOR_STAFFCOMMAND,string);
} else {
SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /enable <antiswear / namekick / antispam / ping / readcmds / readpms / cmdmsg>");
} return 1;
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:aweaps(playerid, params[])
{
	return cmd_lweaps(playerid, params);
}

CMD:lweaps(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 3) {
	GivePlayerWeaponEx(playerid,28,1000); GivePlayerWeaponEx(playerid,31,1000); GivePlayerWeaponEx(playerid,34,1000);
	GivePlayerWeaponEx(playerid,16,1000);	GivePlayerWeaponEx(playerid,42,1000);
	GivePlayerWeaponEx(playerid,14,1000); GivePlayerWeaponEx(playerid,WEAPON_PARACHUTE,1000);	GivePlayerWeaponEx(playerid,9,1);
	GivePlayerWeaponEx(playerid,WEAPON_DEAGLE,1000); GivePlayerWeaponEx(playerid,26,1000); return 1;
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:aammo(playerid, params[])
{
	return cmd_lammo(playerid, params);
}

CMD:lammo(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 5)
	{
	MaxAmmo(playerid);
	CMDMessageToAdmins(playerid, "LAMMO");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:saveallstats(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		SaveAllPlayersData();
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] All players stats has been saved by %s %s(%i).", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, message);
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:savealldata(playerid, params[])
{
	return cmd_saveallstats(playerid, params);
}

CMD:savestats(playerid, params[])
{
	#pragma unused params

	if (IsSavingAllStats) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTDOTHATRIGHTNOW);

	SavePlayerData(playerid);
	SendClientMessage(playerid, COLOR_NOTIFY, "   Your stats has been saved.");
	return 1;
}

CMD:savemydata(playerid, params[])
{
	return cmd_savestats(playerid, params);
}

CMD:savemystats(playerid, params[])
{
	return cmd_savestats(playerid, params);
}

CMD:savedata(playerid, params[])
{
	return cmd_savestats(playerid, params);
}

CMD:fixveh(playerid, params[])
{
	return cmd_repair(playerid, params);
}

CMD:repair(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank])
	{
		if (IsPlayerInAnyVehicle(playerid))
		{
			new const vehicleId = GetPlayerVehicleID(playerid);
			new Float:angle;
			GetVehicleZAngle(vehicleId, angle);
			SetVehicleZAngle(vehicleId, angle);
			RepairVehicle(vehicleId);
			SetVehicleHealth(vehicleId, MAX_VEHICLE_HEALTH);
			PlayerPlaySound(playerid, SOUND_VEHICLEFIX, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_NOTIFY, "   Your vehicle has been repaired.");
		} else SendScreenMessage(playerid, "You are not in a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:ltune(playerid, params[])
{
	#pragma unused params
	if (playerData[playerid][pd_AdminRank]) {
	if (IsPlayerInAnyVehicle(playerid)) {
	new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
	switch (LModel)
	{
	case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
	return SendScreenMessage(playerid, "You can not tune this vehicle");
	}
	CMDMessageToAdmins(playerid, "LTUNE");
	SetVehicleHealth(LVehicleID,2000.0);
	TuneLCar(LVehicleID);
	return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	} else SendScreenMessage(playerid, "You are not in a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:lhy(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank]) {
	if (IsPlayerInAnyVehicle(playerid)) {
	new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
	switch (LModel)
	{
	case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
	return SendScreenMessage(playerid, "You can not tune this vehicle!");
	}
	AddVehicleComponent(LVehicleID, 1087);
	return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	} else return SendScreenMessage(playerid, "You are not in a vehicle");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:acar(playerid, params[])
{
	return cmd_lcar(playerid, params);
}

CMD:lcar(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2) {
	if (!IsPlayerInAnyVehicle(playerid)) {
	CarSpawner(playerid,415);
	CMDMessageToAdmins(playerid, "LCAR");
	return SendClientMessage(playerid,COLOR_NOTIFY, "   The car has been created.");
	} else return SendScreenMessage(playerid, "You already have a vehicle");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:gas(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4) {
	new score;
	if(sscanf(params, "d", score)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /gas <score>");
	new string[MAX_STRING];
	CMDMessageToAdmins(playerid, "GIVEALLSCORE");
	foreach(new i : Player)
	{
		GivePlayerScore(i, score);
		PlayerPlaySound(i, 1057,0.0,0.0,0.0);
	}
	format(string,MAX_STRING, "[SERVER] %s %s(%i) has given all players %i score.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, score);
	SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:givescore(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new giveplayerid, amount;
		if (sscanf(params, "ui", giveplayerid, amount)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /givescore <player> <amount>");
		else if (!IsPlayerConnected(giveplayerid)) return SendScreenMessage(playerid, "Player not found");
		else if (amount < 0 || amount > 999999999) return SendScreenMessage(playerid, "Invalid score amount");
		{
		GivePlayerScore(giveplayerid, amount);
		SendClientMessage(playerid, COLOR_NOTIFY, "   You have given score to that player.");
		SendClientMessage(giveplayerid, COLOR_REWARD, "   You have recieved scores from an staff member.");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:giveallscore(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new score;
		if (sscanf(params, "d",score)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /giveallscore <amount>");
		new string[MAX_STRING];
		CMDMessageToAdmins(playerid, "GIVEALLSCORE");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				GivePlayerScore(i, score);
			}
		}
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
		format(string, MAX_STRING, "[SERVER] %s %s(%i) has given all players %i score.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, score);
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:giveallhelmet(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
		new SKIN_ID;
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				SKIN_ID = GetPlayerSkin(i);
				SetPlayerAttachedObject(i, SLOT_PAO_HAT, 19108, BONE_HEAD, gHelmetOffsets[SKIN_ID][0], gHelmetOffsets[SKIN_ID][1], gHelmetOffsets[SKIN_ID][2], gHelmetOffsets[SKIN_ID][3], gHelmetOffsets[SKIN_ID][4], gHelmetOffsets[SKIN_ID][5], gHelmetOffsets[SKIN_ID][6], gHelmetOffsets[SKIN_ID][7], gHelmetOffsets[SKIN_ID][8]);
				pHasHelmet[i] = true;
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] %s %s(%i) has given all players a Protection Helmet.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, message);
	}

	return 1;
}

CMD:helmeton(playerid, parmas[])
{
	if (!pHasHelmet[playerid]) return SendScreenMessage(playerid, "You dont have helmet protection");

	new const SKIN_ID = GetPlayerSkin(playerid);
	SetPlayerAttachedObject(playerid, SLOT_PAO_HAT, 19108, BONE_HEAD, gHelmetOffsets[SKIN_ID][0], gHelmetOffsets[SKIN_ID][1], gHelmetOffsets[SKIN_ID][2], gHelmetOffsets[SKIN_ID][3], gHelmetOffsets[SKIN_ID][4], gHelmetOffsets[SKIN_ID][5], gHelmetOffsets[SKIN_ID][6], gHelmetOffsets[SKIN_ID][7], gHelmetOffsets[SKIN_ID][8]);
	return 1;
}

CMD:helmetoff(playerid, parmas[])
{
	if (!pHasHelmet[playerid]) SendScreenMessage(playerid, "You dont have helmet protection");

	RemovePlayerAttachedObject(playerid, SLOT_PAO_HAT);
	return 1;
}

CMD:abike(playerid, params[])
{
	return cmd_lbike(playerid, params);
}

CMD:lbike(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		if (!IsPlayerInAnyVehicle(playerid))
		{
			CarSpawner(playerid,522);
			CMDMessageToAdmins(playerid, "LBIKE");
			SendClientMessage(playerid,COLOR_NOTIFY, "   The bike has been created.");
		} else SendScreenMessage(playerid, "You already have a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:lheli(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
	if (!IsPlayerInAnyVehicle(playerid))
	{
	CarSpawner(playerid,487);
	CMDMessageToAdmins(playerid, "LHELI");
	return SendClientMessage(playerid,COLOR_NOTIFY, "   The Helicopter has been created.");
	} else return SendScreenMessage(playerid, "You already have a vehicle");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:aboat(playerid, params[])
{
	return cmd_lboat(playerid, params);
}

CMD:lboat(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
	if (!IsPlayerInAnyVehicle(playerid))
	{
	CarSpawner(playerid,493);
	CMDMessageToAdmins(playerid, "LBOAT");
	return SendClientMessage(playerid,COLOR_NOTIFY, "   The boat has been created.");
	} else return SendScreenMessage(playerid, "You already have a vehicle");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:aplane(playerid, params[])
{
	return cmd_lplane(playerid, params);
}

CMD:lplane(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
	if (!IsPlayerInAnyVehicle(playerid)) {
	CarSpawner(playerid,513);
	CMDMessageToAdmins(playerid, "LPLANE");
	SendClientMessage(playerid,COLOR_NOTIFY, "   The plane has been created.");
	} else SendScreenMessage(playerid, "You already have a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:anos(playerid, params[])
{
	return cmd_addnos(playerid, params);
}

CMD:addnos(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		if (IsPlayerInAnyVehicle(playerid))
		{
			if (!playerData[playerid][pd_IsOnDuty]) return SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEONDUTY);
			new const vehicleId = GetPlayerVehicleID(playerid);
			if (IsNonNitroVehicle(GetVehicleModel(vehicleId)))
			{
				return SendScreenMessage(playerid, "Nitrous cannot be installed on this vehicle");
			}
			AddVehicleComponent(vehicleId, COMPONENT_10XNITROUS);
			PlayerPlaySound(playerid, SOUND_VEHICLEMOD, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_NOTIFY, "   10x Nitrous has been installed on this vehicle.");
			CMDMessageToAdmins(playerid, "addnos");
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_YOUMUSTBEINVEHICLE);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:lnos(playerid, params[])
{
	return cmd_addnos(playerid, params);
}

CMD:linkcar(playerid, params[]) {
#pragma unused params
if (IsPlayerInAnyVehicle(playerid)) {
LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(playerid));
SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(playerid));
return SendClientMessage(playerid,COLOR_NOTIFY, "   Your vehicle is now in your virtual world and interior.");
} else return SendScreenMessage(playerid, "You must be in a vehicle");
}

CMD:teleport(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		if (!playerData[playerid][pd_IsOnDuty]) return SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEONDUTY);
		new string[2750];
		for (new i = 0; i < sizeof(Lst_InteriorNames); i ++)
		{
			format(string, sizeof string, "%s%s\n", string, Lst_InteriorNames[i]);
		}
		ShowPlayerDialog(playerid, DIALOG_INTERIORSLIST, DIALOG_STYLE_LIST, "Staff - Locations", string, "Teleport", "Cancel");
		format(string, sizeof string, "");
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:tele(playerid, params[])
{
	return cmd_teleport(playerid, params);
}

CMD:base(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new loc[MAX_STRING_TEAMNAME];
		if (sscanf(params, "s[16]", loc)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /teleport <Team Names/ Area 51>");
		
		if (strfind(loc, "Eur",true) != INVALID_VALUE)
		{
			SetPlayerPos(playerid, COORDINATE_EUROBASE);
			CMDMessageToAdmins(playerid, "BASE");
		}
		else if (strfind(loc, "Russia",true) != INVALID_VALUE)
		{
			SetPlayerPos(playerid, COORDINATE_RUSSIABASE);
			CMDMessageToAdmins(playerid, "BASE");
		}
		else if (strfind(loc, "Asia", true) != INVALID_VALUE)
		{
			SetPlayerPos(playerid, COORDINATE_ASIABASE);
			CMDMessageToAdmins(playerid, "BASE");
		}
		else if (strfind(loc, "Australia", true) != INVALID_VALUE)
		{
			SetPlayerPos(playerid, COORDINATE_AUSTRALIABASE);
			CMDMessageToAdmins(playerid, "BASE");
		}
		else if (strfind(loc, "USA", true) != INVALID_VALUE)
		{
			SetPlayerPos(playerid, COORDINATE_USABASE);
			CMDMessageToAdmins(playerid, "BASE");
		}
		else if (strfind(loc, "Area", true) != INVALID_VALUE)
		{
			SetPlayerPos(playerid, COORDINATE_AREA51);
			CMDMessageToAdmins(playerid, "BASE");
		}
		else
		{
			SendScreenMessage(playerid, "The location is not valid");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:savepos(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new Float:x,Float:y,Float:z;
		new currentveh;
		currentveh = GetPlayerVehicleID(playerid);
		new Float:vehx, Float:vehy, Float:vehz;
		if (IsPlayerInAnyVehicle(playerid)) return GetVehiclePos(currentveh, vehx, vehy, vehz);
		{
			GetPlayerPos(playerid,x,y,z);
			SetPVarFloat(playerid, "xpos",x); // save X POS
			SetPVarFloat(playerid, "ypos",y); // save Y POS
			SetPVarFloat(playerid, "zpos",z); // save Z POS
			SetPVarInt(playerid, "int",GetPlayerInterior(playerid));//get interior
			SendClientMessage(playerid, COLOR_NOTIFY, "   The current position has been saved.");
			SendClientMessage(playerid, COLOR_HINT, "[HINT] You can use '/loadpos' to get teleported to your last position.");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:loadpos(playerid, params[])
{
	new currentveh;
	currentveh = GetPlayerVehicleID(playerid);
	new Float:vehx, Float:vehy, Float:vehz;
	if (IsPlayerInAnyVehicle(playerid)) return GetVehiclePos(currentveh, vehx, vehy, vehz);
	{
		SetPlayerPos(playerid, GetPVarFloat(playerid, "xpos"), GetPVarFloat(playerid, "ypos"), GetPVarFloat(playerid, "zpos"));
		CreateVehicle(currentveh, GetPVarFloat(playerid, "xpos"), GetPVarFloat(playerid, "ypos"), GetPVarFloat(playerid, "zpos"),82.2873, 0, 1, 60);
		SetPlayerInterior(playerid, GetPVarInt(playerid, "int"));
		SendClientMessage(playerid, COLOR_NOTIFY, "Loaded Saved Position.");
	}
	return 1;
}

CMD:vc(playerid, params[])
{
	return cmd_car(playerid, params);
}

CMD:cv(playerid, params[])
{
	return cmd_car(playerid, params);
}

CMD:car(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] < 3) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	new car[20], carid, colour1, colour2;
	if(sscanf(params, "s[20]D(-1)D(-1)", car, colour1, colour2)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /car <model Id/name> <color Id*> <color Id*>");
	if (!IsNumeric(car)) carid = GetVehicleModelIDFromName(car);
	if (400 > carid > 611) return  SendScreenMessage(playerid, "Invalid Vehicle Model");
	if (playerData[playerid][pCar] != INVALID_VALUE) CarDeleter(playerData[playerid][pCar]);
	
	new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;
	GetPlayerPos(playerid, X,Y,Z);
	GetPlayerFacingAngle(playerid,Angle);
	int1 = GetPlayerInterior(playerid);
	LVehicleID = CreateVehicle(carid, X+3,Y,Z, Angle, colour1, colour2, INVALID_VALUE);
	LinkVehicleToInterior(LVehicleID,int1);
	PutPlayerInVehicle(playerid, LVehicleID, 0);
	playerData[playerid][pCar] = LVehicleID;
	CMDMessageToAdmins(playerid, "CAR");
	SendClientMessageEx(playerid, COLOR_REWARD, "You have spawned a %s (%i).", vehicleNames[carid - 400], carid);
	return 1;
}

CMD:carhealth(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] < 3) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	new targetid, health;
	if (sscanf(params, "ud", targetid, health)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /carhealth <player> <value>");
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, "You cannot use this command on that player");
	if (!IsPlayerInGame(targetid) && !playerData[targetid][pd_IsLoggedIn]) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	if (!IsPlayerInAnyVehicle(targetid)) return SendScreenMessage(playerid, "Player is not in a vehicle");
	new string[MAX_STRING];
	CMDMessageToAdmins(playerid, "CARHEALTH");
	format(string, sizeof string, "   You have set %s vehicle's health to %d.", ReturnPlayerName(targetid), health);
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	if (targetid != playerid)
	{
		format(string, sizeof string, "   %s %s has set your vehicle's health to '%d'.", GetStaffClassName(playerid), ReturnPlayerName(playerid), health);
		SendClientMessage(targetid,COLOR_NOTIFY,string);
	}
	return SetVehicleHealth(GetPlayerVehicleID(targetid), health);
}

CMD:carcolour(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 3) {
	new targetid, colour1, colour2;
	if(sscanf(params, "udd", targetid, colour1, colour2)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /carcolour <player> <color Id> <color Id>");
	if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if (IsPlayerInAnyVehicle(targetid)) {
	new string[MAX_STRING];
	CMDMessageToAdmins(playerid, "CARCOLOUR");
	format(string, sizeof string, "   You have changed the colour of %s %s to '%d,%d'", ReturnPlayerName(targetid), vehicleNames[GetVehicleModel(GetPlayerVehicleID(targetid))-400], colour1, colour2 );
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	if (targetid != playerid) { format(string, sizeof string, "   %s %s has changed the colour of your %s to '%d,%d''", GetStaffClassName(playerid), ReturnPlayerName(playerid), vehicleNames[GetVehicleModel(GetPlayerVehicleID(targetid))-400], colour1, colour2 );
	SendClientMessage(targetid,COLOR_NOTIFY,string); }
	return ChangeVehicleColor(GetPlayerVehicleID(targetid), colour1, colour2);
	} else return SendScreenMessage(playerid, "Player is not in a vehicle");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:godcar(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid)) {
	if (IsPlayerInAnyVehicle(playerid)) {
	if (playerData[playerid][GodCar] == 0) {
	playerData[playerid][GodCar] = 1;
	CMDMessageToAdmins(playerid, "GODCAR");
	SetVehicleHealth(VID[playerid], 141006540);
	return SendClientMessage(playerid,COLOR_NOTIFY, "   GODCARMODE ON");
	} else {
	playerData[playerid][GodCar] = 0;
	SetVehicleHealth(VID[playerid], 1000.0);
	return SendClientMessage(playerid,COLOR_NOTIFY, "   GODCARMODE OFF"); }
	} else return SendScreenMessage(playerid, "You need to be in a car to use this command");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:slay(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new targetid;
		if (sscanf(params, "u", targetid))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /slay <player>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
					{
						SetPlayerHealth(targetid, 0.0);
						SetPlayerHealth(targetid, 0.0);
						new message[MAX_STRING];
						format(message, sizeof(message), "[SERVER] %s(%i) has been force-killed by %s %s(%i).", ReturnPlayerName(targetid), targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
						SendClientMessageToAll(COLOR_SERVER, message);
						SendClientMessage(targetid, COLOR_NOTIFY, "   You have been killed.");
					}
					else
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:id(playerid, params[])
{
	return cmd_getid(playerid, params);
}

CMD:getid(playerid, params[])
{
	if (isnull(params)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /getid <player name>");
	new found, string[MAX_STRING], targetName[MAX_PLAYER_NAME];
	format(string, sizeof string, "   Searched for %s",params);
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		GetPlayerName(i, targetName, sizeof(targetName));
		new namelen = strlen(targetName);
		new bool:searched=false;
		for(new pos=0; pos <= namelen; pos++)
		{
			if (searched != true)
			{
				if (strfind(targetName,params,true) == pos)
				{
					found ++;
					format(string, sizeof string, "%d. %s (ID %d)",found,targetName,i);
					SendClientMessage(playerid, COLOR_REWARD ,string);
					searched = true;
				}
			}
		}
	}
	
	if (!found) SendScreenMessage(playerid, "No players have this in their nick");

	return 1;
}

CMD:asay(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank]) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /asay <message>");
	new string[MAX_STRING]; format(string, sizeof string, "[ADMINISTRATOR] %s(%i): %s", ReturnPlayerName(playerid), playerid, params[0]);
	return SendClientMessageToAll(COLOR_STAFFSAY, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:setgravity(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
	if (isnull(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /setgravity <amount(-50.0-50.0)>");
	CMDMessageToAdmins(playerid, "SETGRAVITY");
	new string[MAX_STRING];
	new Float:Gravity = floatstr(params);
	format(string, sizeof string, "Admnistrator %s has set the gravity to %f.", ReturnPlayerName(playerid), Gravity);
	SetGravity(Gravity);
	return SendClientMessageToAll(COLOR_SERVER,string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:mypacketlost(playerid, params[])
{
	#pragma unused params

	new string[32];
	format(string, sizeof string, "Current packet lost: %f", NetStats_PacketLossPercent(playerid));
	DisplayDialogMessage(playerid, "My Packet Lost", string);
	return 1;
}

CMD:announce(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2 || IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /announce <message>");
		CMDMessageToAdmins(playerid, "ANNOUNCE");
		TextDrawSetString(tdAnnounce, params);
		TextDrawShowForAll(tdAnnounce);
		SetTimer("hideAnnouncement", 5000, false);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:announce2(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 2 || IsPlayerAdmin(playerid)) {
new style, time, text[100];
if (sscanf(params, "dds[100]", style, time, text)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /announce <style> <time> <text>");
if (!(style >= 0 && style <= 6) || style == 2)	return SendScreenMessage(playerid, "Invalid gametext style. Range: 0 - 6");
CMDMessageToAdmins(playerid, "ANNOUNCE2");
return GameTextForAll(text, time, style);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:serverinfo(playerid, params[])
{
	#pragma unused params

	SendClientMessage(playerid, COLOR_NOTIFY, "|------------------------- Server information -------------------------|");
	SendClientMessage(playerid, COLOR_WHITE, "Name: " SERVER_NAME " (" GAMEMODE_NAME ")");
	SendClientMessage(playerid, COLOR_WHITE, "Address: " SERVER_ADDRESS);

	if (strlen(SERVER_URL))
	{
		SendClientMessage(playerid, COLOR_WHITE, "Website: " SERVER_URL);
	}

	if (strlen(SERVER_SHOPURL))
	{
		SendClientMessage(playerid, COLOR_WHITE, "Shop: " SERVER_SHOPURL);
	}

	if (strlen(SERVER_TSADDRESS))
	{
		SendClientMessage(playerid, COLOR_WHITE, "TeamSpeak address: " SERVER_TSADDRESS);
	}

	if (strlen(SERVER_IRCCHANNEL))
	{
		SendClientMessage(playerid, COLOR_WHITE, "IRC channel: " SERVER_IRCCHANNEL);
	}

	if (strlen(SERVER_DISCORDCHANNEL))
	{
		SendClientMessage(playerid, COLOR_WHITE, "Discord channel: " SERVER_DISCORDCHANNEL);
	}

	return 1;
}

CMD:ann(playerid, params[])
{
	return cmd_announce(playerid, params);
}

CMD:ann2(playerid, params[])
{
	return cmd_announce2(playerid, params);
}

CMD:jetpack(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid)) {
SendClientMessage(playerid,COLOR_NOTIFY, "   An Jetpack has been spawned.");
CMDMessageToAdmins(playerid, "JETPACK");
return SetPlayerSpecialAction(playerid, 2);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:rjetpack(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid)) {
if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
SendClientMessage(playerid,COLOR_NOTIFY, "   The Jetpack has been removed.");
CMDMessageToAdmins(playerid, "RJETPACK");
return SetPlayerSpecialAction(playerid, 0);
} else return SendScreenMessage(playerid, "You are not using a Jetpack");
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:flip(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid)) {
	if (isnull(params)) {
	if (IsPlayerInAnyVehicle(playerid)) {
	new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(playerid, X, Y, Z); VehicleID = GetPlayerVehicleID(playerid);
	GetVehicleZAngle(VehicleID, Angle);
	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle);
	SetVehicleHealth(VehicleID,1000.0);
	CMDMessageToAdmins(playerid, "FLIP");
	return SendClientMessage(playerid, COLOR_NOTIFY, "   The vehicle has been flipped.");
	} else return SendScreenMessage(playerid, "You are not in a vehicle");
	}
	new targetid, targetName[MAX_PLAYER_NAME], string[MAX_STRING];
	targetid = strval(params);

	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid) {
	CMDMessageToAdmins(playerid, "FLIP");
	if (IsPlayerInAnyVehicle(targetid)) {
	new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(targetid, X, Y, Z); VehicleID = GetPlayerVehicleID(targetid);
	GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
	CMDMessageToAdmins(playerid, "FLIP");
	GetPlayerName(targetid, targetName, sizeof(targetName));
	format(string, sizeof string, "   %s %s has flipped your vehicle.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessage(targetid,COLOR_NOTIFY,string);
	format(string, sizeof string, "   You have flipped %s's vehicle", targetName);
	SendClientMessage(playerid, COLOR_NOTIFY,string);
	} else SendScreenMessage(playerid, "This player isn't in a vehicle");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:destroycar(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 3) EraseVehicle(GetPlayerVehicleID(playerid));
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:ltc(playerid, params[]) {
#pragma unused params
if (playerData[playerid][pd_AdminRank]) {
if (!IsPlayerInAnyVehicle(playerid)) {
if (playerData[playerid][pCar] != INVALID_VALUE) CarDeleter(playerData[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle(playerid,Angle);
LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);
PutPlayerInVehicle(playerid,LVehicleIDt,0);
CMDMessageToAdmins(playerid, "LTunedCar");		AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);
AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,0);
SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
return playerData[playerid][pCar] = LVehicleIDt;
} else return SendScreenMessage(playerid, "You already have a vehicle");
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:warp(playerid, params[])
{
	return cmd_teleplayer(playerid, params);
}

CMD:teleplayer(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3 || IsPlayerAdmin(playerid)) {
		new targetid, player2, string[MAX_STRING], Float:plocx,Float:plocy,Float:plocz;
		if (sscanf(params, "uu", targetid, player2)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /teleplayer <player> <target player>");
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
			if (IsPlayerConnected(player2) && player2 != INVALID_PLAYER_ID) {
				CMDMessageToAdmins(playerid, "TELEPLAYER");
				GetPlayerPos(player2, plocx, plocy, plocz);
				new intid = GetPlayerInterior(player2);
				SetPlayerInterior(targetid,intid);
				SetPlayerVirtualWorld(targetid,GetPlayerVirtualWorld(player2));
				if (GetPlayerState(targetid) == PLAYER_STATE_DRIVER)
				{
					new VehicleID = GetPlayerVehicleID(targetid);
					SetVehiclePos(VehicleID, plocx, plocy+4, plocz); LinkVehicleToInterior(VehicleID,intid);
					SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(player2) );
				}
				else SetPlayerPos(targetid,plocx,plocy+2, plocz);
				format(string, sizeof string, "   %s %s has teleported %s to %s location", GetStaffClassName(playerid), ReturnPlayerName(playerid), ReturnPlayerName(targetid), ReturnPlayerName(player2) );
				SendClientMessage(targetid,COLOR_NOTIFY,string);
				SendClientMessage(player2,COLOR_NOTIFY,string);
				format(string, sizeof string, "   You have teleported %s to %s location", ReturnPlayerName(targetid), ReturnPlayerName(player2) );
				return SendClientMessage(playerid,COLOR_NOTIFY,string);
			} else return SendScreenMessage(playerid, "Player2 is not connected");
		} else return SendScreenMessage(playerid, "Player1 is not connected");
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:goto(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2 || IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /goto <player>");
		new targetid, string[MAX_STRING];
		if (!IsNumeric(params)) targetid = GetPlayerId(params);
		else targetid = strval(params);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid)
		{
			CMDMessageToAdmins(playerid, "GOTO");
			new Float:x, Float:y, Float:z;
			GetPlayerPos(targetid,x,y,z);
			SetPlayerInterior(playerid,GetPlayerInterior(targetid));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(targetid));
			if (GetPlayerState(playerid) == 2)
			{
				SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);
				LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(targetid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(targetid));
			} else SetPlayerPos(playerid,x+2,y,z);
			format(string, sizeof string, "   You have teleported to %s(%i).", ReturnPlayerName(targetid), targetid);
			SendClientMessage(playerid,COLOR_NOTIFY,string);
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:vgoto(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2 || IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /vgoto [vehicleId]");
		new targetid, string[MAX_STRING];
		targetid = strval(params);
		CMDMessageToAdmins(playerid, "VGOTO");
		new Float:x, Float:y, Float:z;	GetVehiclePos(targetid,x,y,z);
		SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(targetid));
		if (GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetVehicleVirtualWorld(targetid) );
		} else SetPlayerPos(playerid,x+2,y,z);
		format(string, sizeof string, "   You have teleported to vehicle id %d", targetid);
		return SendClientMessage(playerid,COLOR_NOTIFY,string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:vget(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3 || IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /vget [vehicleId]");
		new targetid, string[MAX_STRING];
		targetid = strval(params);
		CMDMessageToAdmins(playerid, "VGET");
		new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(targetid,x+3,y,z);
		SetVehicleVirtualWorld(targetid,GetPlayerVirtualWorld(playerid));
		format(string, sizeof string, "   You have brough vehicle id %d to your location", targetid);
		return SendClientMessage(playerid,COLOR_NOTIFY,string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:agoto(playerid, params[])
{
	return cmd_lgoto(playerid, params);
}

CMD:gotop(playerid, params[])
{
	return cmd_lgoto(playerid, params);
}

CMD:lgoto(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2 || IsPlayerAdmin(playerid))
	{
		new Float:x, Float:y, Float:z;
		if (sscanf(params, "fff", x, y, z)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /lgoto [x] [y] [z]");
		CMDMessageToAdmins(playerid, "LGOTO");
		if (GetPlayerState(playerid) == 2) SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
		else SetPlayerPos(playerid,x,y,z);
		new string[MAX_STRING];
		format(string, sizeof string, "   You have teleported to %f, %f, %f.", x,y,z);
		return SendClientMessage(playerid,COLOR_NOTIFY,string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:get(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2 || IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /get <player>");
		new targetid, string[MAX_STRING];
		if (!IsNumeric(params)) targetid = GetPlayerId(params);
		else targetid = strval(params);
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid)
		{
		CMDMessageToAdmins(playerid, "GET");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetPlayerInterior(targetid,GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid,GetPlayerVirtualWorld(playerid));
		if (GetPlayerState(targetid) == 2)
		{
		new VehicleID = GetPlayerVehicleID(targetid);
		SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(GetPlayerVehicleID(targetid),GetPlayerVirtualWorld(playerid));
		} else SetPlayerPos(targetid,x+2,y,z);
		format(string, sizeof string, "   You have been teleported to %s %s(%i) location.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessage(targetid,COLOR_NOTIFY,string);
		if (!IsPlayerPaused(targetid))
		{
			format(string, sizeof string, "   You have teleported %s(%i) to your location.", ReturnPlayerName(targetid), targetid);
		}
		else
		{
			format(string, sizeof string, "   You have teleported AFK %s(%i) to your location.", ReturnPlayerName(targetid), targetid);
		}
		return SendClientMessage(playerid, COLOR_NOTIFY, string);
		} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:eget(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2|| IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /get <player>");
		new targetid, string[MAX_STRING];
		if (!IsNumeric(params)) targetid = GetPlayerId(params);
		else targetid = strval(params);
		if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid)
		{
		CMDMessageToAdmins(playerid, "GET");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetPlayerInterior(targetid,GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid,GetPlayerVirtualWorld(playerid));
		if (GetPlayerState(targetid) == 2)
		{
		new VehicleID = GetPlayerVehicleID(targetid);
		SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(GetPlayerVehicleID(targetid),GetPlayerVirtualWorld(playerid));
		} else SetPlayerPos(targetid,x+2,y,z);
		format(string, sizeof string, "   You have been teleported to %s %s location", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		SendClientMessage(targetid,COLOR_NOTIFY,string);
		format(string, sizeof string, "   You have teleported %s to your location", ReturnPlayerName(targetid) );
		TogglePlayerControllable(targetid, false);
		playerData[targetid][Frozen] = 1;
		return SendClientMessage(playerid,COLOR_NOTIFY,string);
		} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:warn(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new targetid, reason[MAX_STRING_REASON];
		if (sscanf(params, "us["#MAX_STRING_REASON"]", targetid, reason))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /warn <player> <reason>");
		}
		if (IsPlayerInGame(targetid))
		{
			if (playerData[targetid][pd_IsLoggedIn])
			{
				new message[MAX_STRING];
				CMDMessageToAdmins(playerid, "WARN");
				playerData[targetid][pd_Warnings] ++;
				playerData[targetid][pd_CurrentWarnings] ++;
				GameTextForPlayer(targetid, "~r~WARNED!", 3000, 4);
				if (playerData[targetid][pd_CurrentWarnings] < MAX_WARNINGS)
				{
					SendClientMessage(targetid, COLOR_NOTIFY, "   You have been warned.");
					format(message, sizeof (message), "[SERVER] %s(%i) has been warned by %s %s(%i), reason: %s", ReturnPlayerName(targetid), targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, reason);
				}
				else
				{
					SendClientMessage(targetid, COLOR_NOTIFY, "   You have been kicked from the server.");
					format(message, sizeof (message), "[SERVER] %s(%i) has been kicked by server, reason: Excessive warnings. (%i/%i)", ReturnPlayerName(targetid), targetid, playerData[targetid][pd_CurrentWarnings], MAX_WARNINGS);
					SetTimerEx("KickEx", TIMER_KICK, false, "i", targetid);
				}
				SendClientMessageToAll(COLOR_SERVER, message);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
			}
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:forcerules(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new targetid;
		if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /forcerules <player>");
		if (IsPlayerInGame(targetid))
		{
			if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
			new string[MAX_STRING];
			format(string, sizeof string, "[SERVER] %s %s(%i) has forced %s(%i) to read the rules.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, ReturnPlayerName(targetid), targetid);
			SendClientMessageToAll(COLOR_SERVER, string);
			CMDMessageToAdmins(playerid, "FORCERULES");
			ShowPlayerDialog(targetid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Rules", LOCALE_HELP_RULES, "OK", "");
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:kick(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new targetid;
		new reason[MAX_STRING_REASON];
		if (sscanf(params, "us["#MAX_STRING_REASON"]", targetid, reason)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /kick <player> <reason>");
		if (IsPlayerInGame(targetid))
		{
			if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
			new string[MAX_STRING];
			CMDMessageToAdmins(playerid, "KICK");
			format(string, sizeof string, "[SERVER] %s(%i) has been kicked by %s %s(%i), reason: %s", ReturnPlayerName(targetid), targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, reason);
			SendClientMessageToAll(COLOR_SERVER, string);
			SendClientMessage(targetid, COLOR_NOTIFY, "   You have been kicked from the server.");
			SetTimerEx("KickEx", TIMER_KICK, false, "i", targetid);
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	} 
	else 
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:dbike(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 2)
	{
	if (!IsEnemyInRange(playerid)) {
	CarSpawner(playerid,522);
	SendClientMessage(playerid,COLOR_NOTIFY, "   The Bike has been spawned.");
	SendCMDMessge(playerid, "DBIKE");
	}
	else SendScreenMessage(playerid, "You cannot use command when enemy is in range.");
	}
	else SendScreenMessage(playerid, "You need to be VIP rank 2 in order to use this command");

	return 1;
}

CMD:dtime(playerid, params[]) {
if (playerData[playerid][pd_VIPRank] >= 2) {
if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /dtime <hour>");
new time = strval(params), string[MAX_STRING];
format(string, sizeof string, "   The time has been changed to %d:00", time);
SendClientMessage(playerid,COLOR_NOTIFY,string);
return SetPlayerTime(playerid, time, 0);
} else return SendScreenMessage(playerid, "You need to be VIP rank 2 in order to use this command");
}

CMD:dcar(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 2)
	{
	if (!IsEnemyInRange(playerid)) {
	CarSpawner(playerid,411);
	SendClientMessage(playerid,COLOR_NOTIFY, "   The car has been spawned.");
	SendCMDMessge(playerid, "DCAR");
	}
	else SendScreenMessage(playerid, "You cannot use this command when enemy is in range.");
	}
	else SendScreenMessage(playerid, "You need to be VIP rank 2 in order to use this command");

	return 1;
}

CMD:dheli(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 2)
	{
		if (!IsEnemyInRange(playerid))
		{
			CarSpawner(playerid, 487);
			SendClientMessage(playerid,COLOR_NOTIFY, "   The Helicopter has been spawned.");
			SendCMDMessge(playerid, "DHELI");
		}
		else
		{
			SendScreenMessage(playerid, "You cannot use this command when enemy is in range");
		}
	}
	else
	{
		SendScreenMessage(playerid, "You need to be VIP rank 2 in order to use this command");
	}

	return 1;
}

CMD:dskin(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 3) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /dskin <skin Id>");
	new var = strval(params);
	if (!IsValidSkin(var)) return SendScreenMessage(playerid, "Invaild Skin Id specified");
	SetPlayerSkinEx(playerid, var);
	if (var == SKIN_STAFF) return SendScreenMessage(playerid, "You are not allowed to use staff skin");
	} else SendScreenMessage(playerid, "You Need Atleast VIP Rank 3 To Use This Command");

	return 1;
}

CMD:dchat(playerid, params[])
{
#pragma unused params
if (playerData[playerid][pd_VIPRank] || playerData[playerid][pd_AdminRank]) {
if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /dchat <message>");
new string[250];
format(string, sizeof string, "[VIP CHAT] %s(%i): %s", ReturnPlayerName(playerid), playerid, params[0]);
return SendClientMessageToAll(-1, string);
} else return SendScreenMessage(playerid, "You must be VIP to use this command");
}

CMD:dheal(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank])
	{
	if (Block_CMD[playerid][1] == false)
	{
	if (!IsEnemyInRange(playerid)) {
	SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
	SendClientMessage(playerid, COLOR_REWARD, "You have received a health package.");
	Block_CMD[playerid][1] = true;
	SetTimerEx("EnableCMD",300000,false, "dd",playerid,1); // gogo
	}
	else SendScreenMessage(playerid, "You cannot use command when enemy is in-range.");
	}
	else SendScreenMessage(playerid, "You have to wait 5 minutes!");
	}
	else SendScreenMessage(playerid, "You need to be VIP rank 1 in order to use this command");

	return 1;
}

CMD:dboost(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 3 || playerData[playerid][pd_ClassId] == CLASS_DONATOR)
	{
	if (Block_CMD[playerid][10] == false)
	{
	new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid,COLOR_NOTIFY, "   The VIP Boost has been activated.");
	Block_CMD[playerid][10] = true;
	SendCMDMessge(playerid, "DBOOST");
	SetTimerEx("EnableCMD",300000,false, "dd",playerid,10);
	new string[MAX_STRING];
	format(string, sizeof string, "VIP %s(%i) has boosted you an RPG.", ReturnPlayerName(playerid), playerid);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == playerData[playerid][pd_TeamId])
	{
	if (IsPlayerInRangeOfPoint(i,10.0, x, y, z))
	{
	GivePlayerWeaponEx(i,WEAPON_ROCKETLAUNCHER,1) && SendClientMessage(i,COLOR_REWARD,string);
	}
	}
	}
	}
	else SendScreenMessage(playerid, "You have to wait 5 minutes!");
	}
	else SendScreenMessage(playerid, "You need to be VIP rank 3 in order to use this command");

	return 1;
}

CMD:dbt(playerid, params[])
{
	return cmd_dboost(playerid, params);
}

CMD:dweaps(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 2)
	{
	if (Block_CMD[playerid][11] == false)
	{
	GivePlayerWeaponEx(playerid, 26,500);
	GivePlayerWeaponEx(playerid, WEAPON_DEAGLE,500);
	GivePlayerWeaponEx(playerid, 32,500);
	GivePlayerWeaponEx(playerid, WEAPON_ROCKETLAUNCHER,1);
	GivePlayerWeaponEx(playerid, 16,2);
	SendClientMessage(playerid,COLOR_NOTIFY, "   The VIP weapons has been appllied.");
	Block_CMD[playerid][11] = true;
	SendCMDMessge(playerid, "DWEAPS");
	SetTimerEx("EnableCMD",300000,false, "dd",playerid,11);
	}
	else SendScreenMessage(playerid, "You have to wait 5 minutes!");
	}
	else SendScreenMessage(playerid, "You need to be VIP rank 2 in order to use this command");

	return 1;
}

CMD:dammo(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank])
	{
		if (Block_CMD[playerid][7] == false)
		{
			if (GetPlayerMoney(playerid) < 30000) return SendScreenMessage(playerid, "You Need $30000 to refill your ammo!");
			GiveAmmo(playerid);
			TakePlayerCash(playerid, 30000);
			SendClientMessage(playerid, COLOR_REWARD, "You have received an ammo package.");
			Block_CMD[playerid][7] = true;
			SetTimerEx("EnableCMD", 60000, false, "ii", playerid, 7);
		}
		else
		{
			SendScreenMessage(playerid, "You have to wait 1 minutes!");
		}
	}
	else
	{
		SendScreenMessage(playerid, "You need to be VIP rank 1 in order to use this command");
	}

	return 1;
}

CMD:dcc(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank])
	{
		new col[2];
		if (sscanf(params, "ii", col[0], col[1])) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /dcc <color1 Id> <color2 Id>");
		ChangeVehicleColor(GetPlayerVehicleID(playerid), col[0],col[1]);
		SendClientMessage(playerid, COLOR_NOTIFY , "   The vehicle's color has been changed.");
	}
	else
	{
		SendScreenMessage(playerid, "You need to be VIP rank 1 in order to use this command");
	}

	return 1;
}

CMD:dnos(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank])
	{
		if (!IsPlayerInAnyVehicle(playerid)) return SendScreenMessage(playerid, "You Need be In Vehicle!");
		if (GetPlayerMoney(playerid) < 10000) return SendScreenMessage(playerid, "You Need $10000!");
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010); // Nitro
		TakePlayerCash(playerid, 10000);
		SendClientMessage(playerid, COLOR_REWARD, "x10 Nos for $10000 has been installed on this vehicle.");
	} else SendScreenMessage(playerid, "You need to be VIP rank 1 in order to use this command");

	return 1;
}

CMD:dweather(playerid, params[])
{
	if (playerData[playerid][pd_VIPRank] >= 2)
	{
		new weather;
		if (sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /Dweather <weather Id>");
		if (weather > 45 || weather < 0) return SendScreenMessage(playerid, "Invalid Weather-Id.");
		SendClientMessage(playerid, COLOR_NOTIFY, "   The weather has been changed.");
		return SetPlayerWeather(playerid, weather);
	} else return SendScreenMessage(playerid, "You need to be VIP rank 2 in order to use this command");
}

CMD:dhelp(playerid)
{
	//if (!playerData[playerid][pd_VIPRank]) return SendScreenMessage(playerid, "You Need Atleast VIP Rank 1 To Use This Command");

	new str[500];
	strcat(str, "Donator rank 1 - Bronze\n\
		/dheal, /dcc, /dnos, /dchat\n\
		Can access ALL vehicles.\n\n");

	strcat(str, "Donator rank 2 - Silver\n\
		/dcar, /dbike, /dweaps, /dboost\n\
		All previous donator features.\n\n");

	strcat(str, "Donator rank 3 - Gold\n\
		/dskin, /dcolor\n\
		All previous donator features.\n\n");

	strcat(str, "To donate please visit our forums ("#SERVER_URL") to learn more.");

	DisplayDialogMessage(playerid, "Help - Donation", str);
	return 1;
}

CMD:setpvip(playerid, params[])
{
	return cmd_setvip(playerid, params);
}

CMD:setvip(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		new targetid, rank;
		if (sscanf(params, "ui", targetid, rank))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setvip <player> <rank>");
			return SendClientMessage(playerid, COLOR_WHITE, "[RANKS] 0- Kick, 1- Bronze, 2- Silver, 3-Gold");
		}
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			if (rank > 3 || rank < 0) return 1;
			CMDMessageToAdmins(playerid, "SETVIP");
			new string[MAX_STRING];
			format(string, sizeof string, "   You have set %s VIP rank to %i.", ReturnPlayerName(targetid), rank);
			SendClientMessage(playerid, COLOR_NOTIFY,string);
			if (targetid != playerid)
			{
				format(string, sizeof string, "%s %s has set your VIP rank to %i!", GetStaffClassName(playerid), ReturnPlayerName(playerid), rank);
				SendClientMessage(targetid, COLOR_REWARD, string);
			}
			playerData[targetid][pd_VIPRank] = rank;
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:locate(playerid, params[])
{
	if (gCaptureZones[12][E_CAPTURE_OWNER] == playerData[playerid][pd_TeamId])
	{
		new targetid;
		if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /locate <player>");
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(targetid, x, y, z);
			SetPlayerMapIcon(playerid, 1, x, y, z, MAPICON_WAYPOINT, MAPICON_GLOBAL);
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		}
	}
	else
	{
		SendScreenMessage(playerid, "Your team doesn't own Big Ear");
	}

	return 1;
}

CMD:ypykick(playerid, params[])
{
	new targetid;

	if (sscanf(params, "u", targetid))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /ypykick <player>");
	}
	else
	{
		Kick(targetid);
		SendClientMessage(playerid, COLOR_NOTIFY, "   The player has been kicked.");
	}

	return 1;
}

CMD:arules(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank])
	{
		DisplayDialogMessage(playerid, "Help - Administration Rules", LOCALE_HELP_ADMINRULES);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:sendserverinfo(playerid, params[])
{
	#pragma unused params

	if (IsPlayerStaff(playerid))
	{
		SendClientMessageToAll(COLOR_NOTIFY, "|------------------------- Server Information -------------------------|");
		SendClientMessageToAll(COLOR_WHITE, "Name: " SERVER_NAME " (" GAMEMODE_NAME ")");
		SendClientMessageToAll(COLOR_WHITE, "Address: " SERVER_ADDRESS);
		if (strlen(SERVER_URL)) SendClientMessageToAll(COLOR_WHITE, "Website: " SERVER_URL);
		if (strlen(SERVER_SHOPURL)) SendClientMessageToAll(COLOR_WHITE, "Shop: " SERVER_SHOPURL);
		if (strlen(SERVER_TSADDRESS)) SendClientMessageToAll(COLOR_WHITE, "TeamSpeak address: " SERVER_TSADDRESS);
		if (strlen(SERVER_IRCCHANNEL)) SendClientMessageToAll(COLOR_WHITE, "IRC channel: " SERVER_IRCCHANNEL);
		if (strlen(SERVER_DISCORDCHANNEL)) SendClientMessageToAll(COLOR_WHITE, "Discord channel: " SERVER_DISCORDCHANNEL);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:ypycc(playerid, params[])
{
	#pragma unused params

	for (new i = 0; i < 250; i ++)
	{
		SendClientMessageToAll(INVALID_VALUE, " ");
	}

	return 1;
}

CMD:question(playerid, params[])
{
	return cmd_ask(playerid, params);
}

CMD:mynetstats(playerid, params[])
{
	#pragma unused params

	new string[512];
	GetPlayerNetworkStats(playerid, string, sizeof string);
	DisplayDialogMessage(playerid, "Account - NetworkStats", string);
	return 1;
}

CMD:fixint(playerid, params[])
{
	return cmd_fixvw(playerid, params);
}

CMD:fixvw(playerid, params[])
{
	#pragma unused params

	if ((GetPlayerVirtualWorld(playerid) == VW_OUTSIDE) && (GetPlayerInterior(playerid) == INTERIOR_OUTSIDE)) return SendScreenMessage(playerid, "Your VW/Interior is not bugged");

	if ((GetPlayerVirtualWorld(playerid) > VW_OUTSIDE) && (GetPlayerInterior(playerid) > INTERIOR_OUTSIDE)) return SendScreenMessage(playerid, "You must be outside to use this command");

	SetPlayerVirtualWorld(playerid, VW_OUTSIDE);
	SetPlayerInterior(playerid, INTERIOR_OUTSIDE);
	SendClientMessage(playerid, COLOR_NOTIFY, "   Your VW/Interior has been fixed.");
	return 1;
}

CMD:newclass(playerid, params[])
{
	return cmd_changeclass(playerid, params);
}

CMD:pmoff(playerid, params[])
{
	return cmd_dnd(playerid, params); 
}

CMD:clearmychat(playerid, params[])
{
	for (new i = 0; i < 50; i ++)
	{
		SendClientMessage(playerid, INVALID_VALUE, " ");
	}

	SendClientMessage(playerid, COLOR_NOTIFY, "   Your chatbox has been cleared.");
	return 1;
}

CMD:clearmyscreen(playerid, params[])
{
	return cmd_clearmychat(playerid, params);
}

CMD:site(playerid, params[])
{
	return cmd_serverinfo(playerid, params);
}

CMD:faq(playerid, params[])
{
	return cmd_help(playerid, params);
}

CMD:reporthelp(playerid, params[])
{
	#pragma unused params

	DisplayDialogMessage(playerid, "Help - Report", "{FFFFFF}- Do NOT spam in /report.\n- Report what you need, not who you need.\n- Be specific, report exactly what you need.\n- Do not make false reports.\n- Do not flame administrators.\n- Report only for in-game items.");
	return 1;
}

CMD:alocate(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new targetid;
		if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /alocate <player>");
		if (!IsPlayerInGame(targetid)) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
		new Float:x, Float:y, Float:z;
		GetPlayerPos(targetid, x, y, z);
		SetPlayerMapIcon(playerid, 1, x, y, z, 58, MAPICON_GLOBAL);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:playsound(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new soundid;
		if (sscanf(params, "i", soundid))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /playsound <sound Id>");
		}
		else
		{
			PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
		}
	}

	return 1;
}

CMD:slap(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new targetid;
		if (!sscanf(params, "u", targetid))
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
					{
						new Float:x, Float:y, Float:z;
						GetPlayerPos(targetid, x, y, z);
						SetPlayerPos(targetid, x, y, z + 5.0);
						PlayerPlaySound(targetid, SOUND_PUNCH, x, y, z);
						SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have slapped %s(%i).", ReturnPlayerName(targetid), targetid);
					}
					else
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /slap <player>");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:explode(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetid;
		if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /explode <player>");
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			CMDMessageToAdmins(playerid, "EXPLODE");
			new Float:burnx, Float:burny, Float:burnz;
			GetPlayerPos(targetid,burnx, burny, burnz);
			CreateExplosionForPlayer(targetid, burnx, burny , burnz, 7, 3.0);
			SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have exploded %s(%i).", ReturnPlayerName(targetid), targetid);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:jail(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new targetid, duration, reason[MAX_STRING_SHORT];
		if (sscanf(params, "uis["#MAX_STRING_SHORT"]", targetid, duration, reason))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /jail <player> <duration(second)> <reason>");
		}
		if (!playerData[targetid][JailTime])
		{
			CMDMessageToAdmins(playerid, "JAIL");
			playerData[targetid][JailTime] = duration;
			JailPlayer(targetid);
			GameTextForPlayer(targetid, "~r~IMPRISONED", 3000, 4);
			SendClientMessage(targetid, COLOR_NOTIFY, "   You have been imprisoned.");
			new string[MAX_STRING];
			format(string, sizeof string, "[SERVER] %s %s(%i) has imprisoned %s(%i), reason: %s", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, ReturnPlayerName(targetid), targetid, reason);
			SendClientMessageToAll(COLOR_SERVER, string);
		}
		else
		{
			SendScreenMessage(playerid, "Player is already in jail");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:unjail(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	new targetid;
	if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /jail <player>");
	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
	{
		if (playerData[targetid][JailTime]) return SendScreenMessage(playerid, "Player is not in jail");
		new string[MAX_STRING];
		format(string, sizeof string, "   %s %s has unjailed you.",GetStaffClassName(playerid), ReturnPlayerName(targetid));
		SendClientMessage(targetid,COLOR_NOTIFY,string);
		format(string, sizeof string, "[SERVER] %s %s has unjailed %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), ReturnPlayerName(targetid));
		JailRelease(targetid);
		return SendClientMessageToAll(COLOR_SERVER,string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	return 1;
}

CMD:jailed(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new cout;
		new targetName[MAX_PLAYER_NAME], string[MAX_STRING];
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (playerData[i][JailTime])
			{
				cout ++;
				GetPlayerName(i, targetName, sizeof(targetName));
				format(string, sizeof string, "%s\n%s(%i)", string, targetName, i);
			}
		}
		if (!cout)
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_NOTHINGFOUND);
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, "Imprisoned players:");
			SendClientMessage(playerid, COLOR_REWARD, string);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:freeze(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new targetid, targetName[MAX_PLAYER_NAME];
		if (sscanf(params, "u", targetid))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /freeze <player>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (playerData[targetid][pd_IsLoggedIn])
				{
					if (playerData[playerid][pd_AdminRank] >= playerData[targetid][pd_AdminRank])
					{
						GetPlayerName(targetid, targetName, sizeof(targetName));
						SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have freezed %s(%i).", targetName, targetid);
						SendClientMessageEx(targetid, COLOR_NOTIFY, "   %s %s(%i) has freezed you.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
						SetCameraBehindPlayer(targetid);
						TogglePlayerControllable(targetid, false);
						playerData[targetid][Frozen] = 1;
						PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
						GameTextForPlayer(targetid, "~r~Frozen!", 3000, 4);
						new message[MAX_STRING];
						format(message, sizeof(message), "[SERVER] %s(%i) has been freezed by %s %s(%i)", targetName, targetid, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
						SendClientMessageToAll(COLOR_SERVER, message);
					}
					else
					{
						SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
					}
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:unfreeze(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3|| IsPlayerAdmin(playerid))
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /unfreeze <player>");
		new targetid, string[MAX_STRING];
		targetid = strval(params);
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			if (playerData[targetid][Frozen])
			{
				CMDMessageToAdmins(playerid, "UNFREEZE");
				UnFreezeMe(targetid);
				SendClientMessage(targetid,COLOR_NOTIFY, "   You have been unfrozen.");
				format(string, sizeof string, "[SERVER] %s %s(%i) has unfrozen %s(%i).", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, ReturnPlayerName(targetid), targetid);
				return SendClientMessageToAll(COLOR_SERVER,string);
			} else SendScreenMessage(playerid, "Player is not frozen");
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:frozen(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2) {
	new bool:First2 = false, cot, playerName[MAX_PLAYER_NAME], string[MAX_STRING], i, j;

	for (i = 0, j = GetPlayerPoolSize(); i <= j; i ++) if (IsPlayerConnected(i) && playerData[i][Frozen]) cot++;
	if (cot == 0) return SendScreenMessage(playerid, "No players are frozen");

	for (i = 0, j = GetPlayerPoolSize(); i <= j; i ++) if (IsPlayerConnected(i) && playerData[i][Frozen]) {
	GetPlayerName(i, playerName, sizeof(playerName));
	if (!First2) { format(string, sizeof string, "Frozen Players: (%d)%s", i,playerName); First2 = true; }
	else format(string, sizeof string, "%s, (%d)%s ",string,i,playerName);
	}
	return SendClientMessage(playerid,COLOR_WHITE,string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:mute(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new targetid, reason[40], string[MAX_STRING];
		if (sscanf(params, "uS(No reason given)[40]", targetid, reason)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /mute <player> <reason>");
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
		if (playerData[targetid][Muted]) return SendScreenMessage(playerid, "Player is already muted");
		CMDMessageToAdmins(playerid, "MUTE");
		PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
		playerData[targetid][Muted] = 1;
		format(string, sizeof string, "   You have been muted by %s %s, reason: %s",GetStaffClassName(playerid), ReturnPlayerName(playerid), reason);
		SendClientMessage(targetid,COLOR_NOTIFY,string);
		format(string, sizeof string, "   You have muted %s, reason: %s", ReturnPlayerName(targetid), reason);
		return SendClientMessage(playerid,COLOR_NOTIFY,string);
		} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:unmute(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /unmute <player>");
	new targetid, string[MAX_STRING];
	targetid = strval(params);

	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if (playerData[targetid][Muted]) {
	CMDMessageToAdmins(playerid, "UNMUTE");
	PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	playerData[targetid][Muted] = 0;
	format(string, sizeof string, "   You have been unmuted by %s %s(%i).",GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
	SendClientMessage(targetid,COLOR_NOTIFY,string);
	format(string, sizeof string, "   You have unmuted %s(%i).", ReturnPlayerName(targetid), targetid);
	return SendClientMessage(playerid,COLOR_NOTIFY,string);
	} else SendScreenMessage(playerid, "Player is not muted");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:muted(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2) {
	new bool:First2 = false, cart, playerName[MAX_PLAYER_NAME], string[MAX_STRING], i, j;

	for (i = 0, j = GetPlayerPoolSize(); i <= j; i ++) if (IsPlayerConnected(i) && playerData[i][Muted]) cart++;
	if (cart == 0) return SendScreenMessage(playerid, "No players are muted");

	for (i = 0, j = GetPlayerPoolSize(); i <= j; i ++) if (IsPlayerConnected(i) && playerData[i][Muted]) {
	GetPlayerName(i, playerName, sizeof(playerName));
	if (!First2) { format(string, sizeof string, "Muted Players: (%d)%s", i,playerName); First2 = true; }
	else format(string, sizeof string, "%s, (%d)%s ",string,i,playerName);
	}
	return SendClientMessage(playerid,COLOR_WHITE,string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:akill(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3|| IsPlayerAdmin(playerid)) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /akill <player>");
	new targetid, string[MAX_STRING];
	targetid = strval(params);

	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if ( (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank] ) )
	return SendScreenMessage(playerid, "You cannot akill the highest level admin");
	CMDMessageToAdmins(playerid, "AKILL");
	format(string, sizeof string, "   %s %s has killed you.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessage(targetid,COLOR_NOTIFY,string);
	format(string, sizeof string, "   You have killed %s.", ReturnPlayerName(targetid));
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	return SetPlayerHealth(targetid, 0.0);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:weaps(playerid, params[]) {
if (IsPlayerStaff(playerid) || IsPlayerAdmin(playerid)) {
if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /weaps <player>");
new targetid, string[MAX_STRING], string2[64], WeapName[24], slot, weap, ammo, wh, x;
targetid = strval(params);

if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
format(string2, sizeof(string2), "   Player: %s | Weapons: (id:%d)", ReturnPlayerName(targetid), targetid);
SendClientMessage(playerid,COLOR_NOTIFY,string2);
for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(targetid, slot, weap, ammo); if ( ammo != 0 && weap != 0) wh++; }
if (wh < 1) return SendScreenMessage(playerid, "Player has no weapons");

if (wh >= 1)
{
for (slot = 0; slot < 14; slot++)
{
GetPlayerWeaponData(targetid, slot, weap, ammo);
if ( ammo != 0 && weap != 0)
{
GetWeaponName(weap, WeapName, sizeof(WeapName) );
if (ammo == 65535 || ammo == 1) format(string, sizeof string, "%s%s (1)",string, WeapName );
else format(string, sizeof string, "%s%s (%d)",string, WeapName, ammo );
x ++;
if (x >= 5)
{
SendClientMessage(playerid, COLOR_REWARD, string);
x = 0;
format(string, sizeof string, "");
}
else format(string, sizeof string, "%s,  ", string);
}
}
if (x <= 4 && x > 0) {
string[strlen(string)-3] = '.';
SendClientMessage(playerid, COLOR_REWARD, string);
}
}
return 1;
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:screen(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] < 2) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	
	new targetid, message[60];
	if (sscanf(params, "us[60]", targetid, message)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /screen <player> <message>");
	new string[MAX_STRING];

	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn] && targetid != playerid) {
	CMDMessageToAdmins(playerid, "SCREEN");
	format(string, sizeof string, "   %s %s has sent you a screen message", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessage(targetid,COLOR_NOTIFY,string);
	format(string, sizeof string, "   You have sent %s a screen message (%s)", ReturnPlayerName(targetid), params[2]);
	SendClientMessage(playerid,COLOR_NOTIFY,string);
	return GameTextForPlayer(targetid, message, 5000, 4);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
}

CMD:laston(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		new targetName[MAX_PLAYER_NAME];
		if (sscanf(params, "s["#MAX_PLAYER_NAME"]", targetName))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /getplastlog <player name>");
		}
		else
		{
			if (IsPlayerInGame(GetPlayerId(targetName)))
			{
				return SendScreenMessage(playerid, "That player is currently online, use '/stats <player>' instead");
			}
			new query[MAX_STRING];
			mysql_format(gGameConnection, query, sizeof(query), "SELECT `lastlogin_date` FROM `accounts` WHERE `name` = '%e';", targetName);
			mysql_tquery(gGameConnection, query, "OnExecuteFinish", "iiiss", THREAD_GET_LASTLOGGED, playerid, INVALID_VALUE, targetName, "");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:getplastlog(playerid, params[])
{
	return cmd_laston(playerid, params);
}

CMD:gotoco(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		new Float:x, Float:y, Float:z;
		if (sscanf(params, "fff", x, y, z))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /gotoco <X> <Y> <Z>");
		}
		else
		{
			RemovePlayerFromVehicle(playerid);
			SetPlayerPos(playerid, x, y, z);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:aduty(playerid, params[])
{
	return cmd_adminduty(playerid, params);
}

CMD:adminduty(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new message[MAX_STRING], playerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerName, sizeof(playerName));
		if (!playerData[playerid][pd_IsOnDuty])
		{
			playerData[playerid][pd_IsOnDuty] = true;
			format(message, sizeof(message), "[SERVER] %s %s(%i) is now on-duty.", GetStaffClassName(playerid), playerName, playerid);
			SetPlayerSkinEx(playerid, SKIN_STAFF);
			SetPlayerTeam(playerid, NO_TEAM);
			SetPlayerColor(playerid, COLOR_ADMIN);
			SetPlayerHealth(playerid, MAX_HEALTH_ADMINISTRATOR);
			Update3DTextLabelText(t3dRankLabel[playerid], COLOR_ADMIN, "Staff");
			playerData[playerid][pd_TeamId] = NO_TEAM;
			GivePlayerWeaponEx(playerid, WEAPON_MINIGUN, MAX_WEAPON_AMMO);
		}
		else
		{
			playerData[playerid][pd_IsOnDuty] = false;
			format(message, sizeof(message), "[SERVER] %s %s(%i) is now off-duty.", GetStaffClassName(playerid), playerName, playerid);
			ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0.0);
			playerData[playerid][pd_Deaths] --;
			FirstSpawn[playerid] = 1;
		}
		if (pHasHelmet[playerid])
		{
			new const SKIN_ID = GetPlayerSkin(playerid);
			SetPlayerAttachedObject(playerid, SLOT_PAO_HAT, 19108, BONE_HEAD, gHelmetOffsets[SKIN_ID][0], gHelmetOffsets[SKIN_ID][1], gHelmetOffsets[SKIN_ID][2], gHelmetOffsets[SKIN_ID][3], gHelmetOffsets[SKIN_ID][4], gHelmetOffsets[SKIN_ID][5], gHelmetOffsets[SKIN_ID][6], gHelmetOffsets[SKIN_ID][7], gHelmetOffsets[SKIN_ID][8]);
		}
		SendClientMessageToAll(COLOR_SERVER, message);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:pausers(playerid, params[])
{
	return cmd_afkers(playerid, params);
}

CMD:afkers(playerid, params[])
{
	if (IsPlayerStaff(playerid))
	{
		new count, string[MAX_STRING];
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				if (IsPlayerPaused(i))
				{
					format(string, sizeof string, "Player: %s | Id: %i | IP: %s", ReturnPlayerName(i), i, GetPlayerIP(i));
					SendClientMessage(playerid, COLOR_REWARD, string);
					count ++;
				}
			}
		}
		if (!count)
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_NOTHINGFOUND);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:admins(playerid, params[])
{
	new count, string[300] = "Player ID\tName\tRank\n";
	
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		
		if (playerData[i][pd_AdminRank] && !playerData[i][Hide])
		{
			format(string, sizeof string, "{FFFF00}%d\t%s\t%i", i, ReturnPlayerName(i), playerData[i][pd_AdminRank]);
			count += 1;
		}
	}
	
	if (!count) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTHINGFOUND);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "CoD:AW Administrators", string, "Okay", "");
	return 1;
}

CMD:undercover(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
	if (playerData[playerid][Hide] == 0) {
	playerData[playerid][Hide] = 1;
	SendClientMessage(playerid, COLOR_NOTIFY, "   You are now Hidden from the Admin List.");
	}
	else if (playerData[playerid][Hide] == 1) {
	playerData[playerid][Hide] = 0;
	SendClientMessage(playerid,COLOR_NOTIFY, "   You are now Visible in the Admin List.");
	}
	else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	} else return 0;

	return 1;
}

CMD:vips(playerid, params[])
{
	#pragma unused params

	new count = 0, string[800];

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_VIPRank])
		{
			format(string, sizeof string, "%s %s(%i) | VIP Level: %d\n", string, ReturnPlayerName(i), i, playerData[i][pd_VIPRank]);
			count ++;
		}
	}

	if (count == 0) SendScreenMessage(playerid, LOCALE_MESSAGE_NOTHINGFOUND);
	else ShowPlayerDialog(playerid, DONOR_DIALOG, DIALOG_STYLE_MSGBOX, "Online Donators", string, "OK", "");

	return 1;
}

CMD:setting(playerid, params[])
{
	return cmd_settings(playerid, params);
}

CMD:settings(playerid, params[])
{
	#pragma unused params

	DisplayPlayerDialog(playerid, DIALOG_SETTINGS);
	return 1;
}

CMD:changepemail(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new targetid, email[MAX_STRING_EMAIL];
		if (sscanf(params, "us["#MAX_STRING_EMAIL"]", targetid, email))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /changepemail <player> <email address>");
		}
		else
		{
			if (IsPlayerInGame(targetid))
			{
				if (GetPVarInt(targetid, "IsPlayerLoggedIn"))
				{
					new query[50 + MAX_STRING_EMAIL], targetName[MAX_PLAYER_NAME];
					GetPlayerName(targetid, targetName, sizeof(targetName));
					mysql_format(gGameConnection, query, sizeof(query), "UPDATE `accounts` SET `email` = '%e' WHERE `id` = %i;", email, playerData[targetid][pd_AccountId]);
					format(playerData[targetid][piEmail], MAX_STRING_EMAIL, "%s", email);
					mysql_tquery(gGameConnection, query);
					SendClientMessageEx(targetid, COLOR_REWARD, "Your account's email has been changed to %s", email);
					SendClientMessage(playerid, COLOR_NOTIFY, "   The player account's email has been changed.");
				}
				else
				{
					SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
				}
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:setemail(playerid, params[])
{
	if ((strlen(playerData[playerid][piEmail]) <= 0) || isnull(playerData[playerid][piEmail]))
	{
		DisplayPlayerDialog(playerid, DIALOG_ACCOUNT_EMAIL);
	}
	else
	{
		SendScreenMessage(playerid, "Just administrators are allowed to Change your account's Email");
	}

	return 1;
}

CMD:adminarea(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank])
	{
		CMDMessageToAdmins(playerid, "ADMINAREA");
		SetPlayerPosEx(playerid, COORDINATE_STAFFAREA, 90.0, 0, 3);
		GameTextForPlayer(playerid, "~g~Welcome!", 3000, 4);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:makeadmin(playerid, params[])
{
	return cmd_setlevel(playerid, params);
}

// setlevel
CMD:setlevel(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 6 || IsPlayerAdmin(playerid)) {
	new level, targetid, targetName[MAX_PLAYER_NAME], playerName[MAX_PLAYER_NAME], string[MAX_STRING];
	if (sscanf(params, "ui", targetid, level)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setlevel <player> <level(0-5)>");

	if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn]) {
	if (level > 8) return SendScreenMessage(playerid, "Incorrect Level");
	if (level == playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, "Player is already this level");
	GetPlayerName(targetid, targetName, sizeof(targetName));
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if (level > 0) format(string, sizeof string, "   %s %s has set you to Administrator level %d.", GetStaffClassName(playerid), playerName, level);
	else format(string, sizeof string, "   %s %s has revoked your administrator level.", GetStaffClassName(playerid), playerName);
	SendClientMessage(targetid, COLOR_NOTIFY, string);

	if (level > playerData[targetid][pd_AdminRank]) GameTextForPlayer(targetid, "~g~PROMOTED!", 3000, 4);
	else GameTextForPlayer(targetid, "~r~DEMOTED!", 3000, 4);

	format(string, sizeof string, "   You have made %s(%i) Administrator's level %i.", targetName, targetid, level);
	SendClientMessage(playerid, COLOR_NOTIFY, string);
	playerData[targetid][pd_AdminRank] = level;
	playerData[targetid][pd_RealAdminRank] = level;
	PlayerPlaySound(targetid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:report(playerid, params[])
{
	new targetid;
	new reason[MAX_STRING_SHORT];

	if (sscanf(params, "us["#MAX_STRING_SHORT"]", targetid, reason))
	{
		return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /report <player> <reason>");
	}

	if (IsPlayerInGame(targetid))
	{
		if (playerid == targetid) return SendScreenMessage(playerid, "You Cannot report yourself");
		if (strlen(reason) > 3)
		{
			new targetName[MAX_PLAYER_NAME], playerName[MAX_PLAYER_NAME], message[MAX_STRING];
			GetPlayerName(targetid, targetName, sizeof(targetName));
			GetPlayerName(playerid, playerName, sizeof(playerName));
			format(message, sizeof(message), "[REPORT] %s(%i) reported: %s(%i) reason: %s", playerName, playerid, targetName, targetid, reason);
			MessageToAdmins(COLOR_REPORT, message);
			format(message, sizeof(message), "[REPORT] (%s) %s(%d) reported %s(%i) reason %s", GetTime(), playerName, playerid, targetName, targetid, reason);
			for (new i = 1; i < MAX_REPORTS - 1; i ++)
			{
				Reports[i] = Reports[i + 1];
			}
			Reports[MAX_REPORTS - 1] = message;
			SendClientMessage(playerid, COLOR_NOTIFY, "   Your report has been sent to online administrator(s).");
		}
		else
		{
			SendScreenMessage(playerid, "Invalid reason specified");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	}

	return 1;
}

CMD:reports(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank])
	{
		new ReportCount;
		for(new i = 1; i < MAX_REPORTS; i++)
		{
			if (strcmp(Reports[i], "<none>", true) != 0)
			{
				ReportCount ++;
				SendClientMessage(playerid, COLOR_WHITE, Reports[i]);
			}
		}
		if (ReportCount == 0) SendScreenMessage(playerid, LOCALE_MESSAGE_NOTHINGFOUND);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:fixallveh(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		for (new i = 1, j = GetVehiclePoolSize(); i <= j; i ++)
		{
			if (IsVehicleInGame(i))
			{
				RepairVehicle(i);
				SetVehicleHealth(i, MAX_VEHICLE_HEALTH);
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] All vehicles has been fixed/repaired by %s %s(%i).", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:miniguns(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank])
	{
	new bool:First2 = false, carty, string[MAX_STRING], i, j, slot, weap, ammo;
	for (i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		for(slot = 0; slot < 14; slot ++)
		{
			GetPlayerWeaponData(i, slot, weap, ammo);
			if (ammo != 0 && weap == WEAPON_MINIGUN)
			{
			carty ++;
			if (!First2)
			{
				format(string, sizeof string, "Minigun: (%d)%s(ammo%d)", i, ReturnPlayerName(i), ammo); First2 = true;
			}
			else format(string, sizeof string, "%s, (%d)%s(ammo%d) ",string, i, ReturnPlayerName(i), ammo);
			}
		}
	}
	if (carty == 0) return SendScreenMessage(playerid, "No players have minigun");
	else return SendClientMessage(playerid,COLOR_WHITE,string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:hseeks(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank])
	{
		new bool:First2 = false, carty, string[MAX_STRING], i, j, slot, weap, ammo;
		for (i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			for(slot = 0; slot < 14; slot++)
			{
				GetPlayerWeaponData(i, slot, weap, ammo);
				if (ammo != 0 && weap == WEAPON_HEATSEEKER)
				{
					carty ++;
					if (!First2) { format(string, sizeof string, "Heat Seeker: (%d)%s(ammo%d)", i, ReturnPlayerName(i), ammo); First2 = true; }
					else format(string, sizeof string, "%s, (%d)%s(ammo%d) ",string, i, ReturnPlayerName(i), ammo);
				}
			}
		}
		if (carty == 0) return SendScreenMessage(playerid, "No players have a heat seeker");
		else return SendClientMessage(playerid,COLOR_WHITE,string);
	}
	else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:uconfig(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
	UpdateConfig();
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	CMDMessageToAdmins(playerid, "UCONFIG");
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:forbidname(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /forbidname <name>");
		new File:BLfile, string[MAX_STRING];
		BLfile = fopen("ladmin/config/ForbiddenNames.cfg",io_append);
		format(string, sizeof string, "%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid, "FORBIDNAME");
		format(string, sizeof string, "[STAFF] %s(%i) has added the name %s to the forbidden name list.", ReturnPlayerName(playerid), playerid, params);
		MessageToAdmins(COLOR_STAFFCOMMAND, string);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:forbidword(playerid, params[]) {
	if (playerData[playerid][pd_AdminRank] >= 4) {
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /forbidword <word>");
	new File:BLfile, string[MAX_STRING];
	BLfile = fopen("ladmin/config/ForbiddenWords.cfg",io_append);
	format(string, sizeof string, "%s\r\n",params[1]);
	fwrite(BLfile,string);
	fclose(BLfile);
	UpdateConfig();
	CMDMessageToAdmins(playerid, "FORBIDWORD");
	format(string, sizeof string, "[STAFF] %s has added the word %s to the forbidden word list.", ReturnPlayerName(playerid), params );
	MessageToAdmins(COLOR_STAFFCOMMAND, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:stats(playerid, params[])
{
	new targetid;

	if (isnull(params)) targetid = playerid;
	else targetid = strval(params);

	if (IsPlayerInGame(targetid))
	{
		if (playerData[targetid][pd_IsLoggedIn])
		{
			new string[2048];
			new h, m, s;
			GetSecondToTime((gettime() - Player_ConnectTime[targetid]) + playerData[targetid][pd_PlayedTime], h, m, s);
			format(string, sizeof string, "{FFFF00}[ACCOUNT]{FFFFFF} Nickname: %s, Account Id: %i, Played time: %i hours %i minutes %i seconds\n\n", ReturnPlayerName(targetid), playerData[targetid][pd_AccountId], h, m, s);
			format(string, sizeof string, "%s{FFFF00}[CHARACTER]{FFFFFF} Team: %s, Currnet Team: %s, Class: %s, Skin Id: %i\n\n", string, GetTeamName(playerData[targetid][pd_TeamId]), GetTeamName(GetPlayerTeam(targetid)), GetPlayerClassName(targetid), GetPlayerSkin(targetid));
			format(string, sizeof string, "%s{FFFF00}[RANK]{FFFFFF} Player: %s(%i), VIP: %i/3, Administrator: %i/8\n\n", string, GetPlayerRankName(targetid), GetPlayerRank(targetid), playerData[targetid][pd_VIPRank], playerData[targetid][pd_AdminRank]);
			format(string, sizeof string, "%s{FFFF00}[RESOURCE]{FFFFFF} Cash: {008000}$%i{FFFFFF}, Score: %i, Helmet: %s\n\n", string, playerData[targetid][pd_Money], playerData[targetid][pd_Score], ReturnYesNo(pHasHelmet[targetid]));
			format(string, sizeof string, "%s{FFFF00}[SKILL]{FFFFFF} K/D ratio: %0.2f, Fighting-Syle: %s(%i), Weapon skill: %i, Captured zones: %i\n\n", string, float(playerData[targetid][pd_Kills]) / float(playerData[targetid][pd_Deaths]), GetFightingStyleName(GetPlayerFightingStyle(targetid)), GetPlayerFightingStyle(targetid), 999, playerData[targetid][pd_CapturedZones]);
			format(string, sizeof string, "%s{FFFF00}[PUNISHMENT]{FFFFFF} Muted: %s, Imprison time: %i, Total warnings: %i, Current warnings: %i/0\n\n", string, ReturnYesNo(playerData[targetid][Muted]), playerData[targetid][JailTime], playerData[targetid][pd_Warnings], playerData[targetid][pd_CurrentWarnings]);
			format(string, sizeof string, "%s{FFFF00}[KILL]{FFFFFF} Total: %i, Killing-Spree: %i, Headshots: %i\n\n", string, playerData[targetid][pd_Kills], playerData[targetid][pd_KillingSpree], playerData[targetid][Headshots]);
			format(string, sizeof string, "%s{FFFF00}[DEATH]{FFFFFF} Total: %i\n\n", string, playerData[targetid][pd_Deaths]);
			ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Account - Stats", string, "OK", "");
			format(string, sizeof string, "");
		}
		else
		{
			SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	}

	return 1;
}

CMD:changepass(playerid, params[])
{
	new password[MAX_STRING_PASSWORD];

	if (sscanf(params, "s["#MAX_STRING_PASSWORD"]", password))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /changepass <new password>");
		SendClientMessage(playerid, COLOR_HINT, "[HINT] The password lenght must be between 4 and "#MAX_STRING_PASSWORD" characters.");
	}
	else
	{
		if (IsValidPassword(password, MAX_STRING_PASSWORD))
		{
			new query[MAX_STRING];
			mysql_format(gGameConnection, query, sizeof(query), "UPDATE `accounts` SET `password` = SHA1('%e') WHERE `id` = %i;", password, playerData[playerid][pd_AccountId]);
			mysql_tquery(gGameConnection, query);
			SendClientMessageEx(playerid, COLOR_NOTIFY, "   Your password has been changed to %s", password);
		}
		else
		{
			SendScreenMessage(playerid, "The password is not valid");
		}
	}

	return 1;
}

CMD:setpass(playerid, params[])
{
	return cmd_changepass(playerid, params);
}

CMD:spec(playerid, params[])
{
	return cmd_lspec(playerid, params);
}

CMD:lspec(playerid, params[])
{
	if (!IsPlayerStaff(playerid)) return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	new targetid;

	if (sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /spec <player>");

	if (playerid == targetid) return 1;

	if (!IsPlayerInGame(targetid)) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);

	if (!playerData[targetid][pd_IsLoggedIn]) return SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);

	if (playerData[targetid][pd_AdminRank] > playerData[playerid][pd_AdminRank]) return SendScreenMessage(playerid, "You are not allowed to spectate that player");
	
	if (IsSpectating[targetid]) return SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERSPECTINGSOMEONE);

	if (!IsPlayerSpawned(targetid)) return SendScreenMessage(playerid, "Player is not spawned yet");

	if (!IsSpectating[playerid])
	{
		ArmedWeapon[playerid] = GetPlayerWeapon(playerid);
		for (new i = 0; i < TOTAL_SLOT_WEAPON; i ++)
		{
			GetPlayerWeaponData(playerid, i, playerData[playerid][previousWeapons][i], playerData[playerid][previousAmmoLots][i]);
		}
		GetPlayerPos(playerid, playerData[playerid][pd_PreviousX], playerData[playerid][pd_PreviousY], playerData[playerid][pd_PreviousZ]);
		GetPlayerArmour(playerid, playerData[playerid][pd_PreviousArmor]);
		GetPlayerHealth(playerid, playerData[playerid][pd_PreviousHealth]);
		playerData[playerid][pd_PreviousVW] = GetPlayerVirtualWorld(playerid);
		playerData[playerid][pd_PreviousInterior] = GetPlayerInterior(playerid);
		RemovePlayerFromVehicle(playerid);
	}

	IsSpectating[playerid] = true;
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CMDMessageToAdmins(playerid, "SPEC");
	GetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
	GetPlayerFacingAngle(playerid, Pos[playerid][3]);
	StartSpectate(playerid, targetid);
	return 1;
}

CMD:ls(playerid, params[])
{
	return cmd_lspec(playerid, params);
}

CMD:lsp(playerid, params[])
{
	return cmd_lspec(playerid, params);
}

CMD:lsof(playerid, params[])
{
	return cmd_lspecoff(playerid, params);
}

CMD:lsoff(playerid, params[])
{
	return cmd_lspecoff(playerid, params);
}

CMD:lsv(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] || IsPlayerAdmin(playerid))
	{
	if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /lsv <vehicle Id>");
	new specvehicleid = strval(params);
	if (specvehicleid < MAX_VEHICLES)
	{
	TogglePlayerSpectating(playerid, true);
	PlayerSpectateVehicle(playerid, specvehicleid);
	playerData[playerid][SpecID] = specvehicleid;
	playerData[playerid][SpecType] = TYPE_SPECTATE_VEHICLE;
	CMDMessageToAdmins(playerid, "SPEC VEHICLE");
	GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
	GetPlayerFacingAngle(playerid,Pos[playerid][3]);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDVEHICLE);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	return 1;
}

CMD:specoff(playerid, params[])
{
	return cmd_lspecoff(playerid, params);
}

CMD:lspecoff(playerid, params[])
{
	#pragma unused params

	if (IsPlayerStaff(playerid))
	{
		if (playerData[playerid][SpecType] != TYPE_SPECTATE_NONE)
		{
			StopSpectate(playerid);
			SendClientMessage(playerid, COLOR_NOTIFY, "   Your spectation session has ended.");
		}
		else
		{
			SendScreenMessage(playerid, "You are not spectating");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:disablechat(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		CMDMessageToAdmins(playerid, "DISABLECHAT");
		new string[MAX_STRING];
		if (!ServerInfo[DisableChat])
		{
			ServerInfo[DisableChat] = 1;
			format(string, sizeof string, "[SERVER] %s %s(%i) has disabled chat.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		}
		else
		{
			ServerInfo[DisableChat] = 0;
			format(string, sizeof string, "[SERVER] %s %s(%i) has enabled chat.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		}
		SendClientMessageToAll(COLOR_SERVER, string);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:clearchat(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 2)
	{
		CMDMessageToAdmins(playerid, "CLEARCHAT");
		for(new i = 0; i < 250; i ++) SendClientMessageToAll(-1, " ");
	}
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:cc(playerid, params[])
{
	return cmd_clearchat(playerid, params);
}

CMD:pickup(playerid, params[]) {
if (playerData[playerid][pd_AdminRank] >= 5 || IsPlayerAdmin(playerid)) {
if (isnull(params)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /pickup <pickup Id>");
new pickup = strval(params), string[MAX_STRING], Float:x, Float:y, Float:z, Float:a;
CMDMessageToAdmins(playerid, "PICKUP");
GetPlayerPos(playerid, x, y, z);
GetPlayerFacingAngle(playerid, a);
x += (3 * floatsin(-a, degrees));
y += (3 * floatcos(-a, degrees));
CreatePickup(pickup, 2, x+2, y, z);
return SendClientMessage(playerid, COLOR_REWARD, string);
} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:ans(playerid, params[])
{
	return cmd_res(playerid, params);
}

CMD:response(playerid, params[])
{
	return cmd_res(playerid, params);
}

CMD:res(playerid, params[])
{
   if (IsPlayerStaff(playerid))
   {
      new targetid;
		new message[MAX_STRING];
      if (sscanf(params, "us["#MAX_STRING"]", targetid, message))
      {
         SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /res <player> <message>");
      }
      else
      {
         if (IsPlayerInGame(targetid))
         {
            if (playerData[targetid][pd_IsLoggedIn])
            {
               new string[MAX_STRING], playerName[MAX_PLAYER_NAME];
					GetPlayerName(playerid, playerName, sizeof(playerName));
               SendClientMessageEx(targetid, COLOR_HELP, "[RESPONSE] %s %s(%i): %s", GetStaffClassName(playerid), playerName, playerid, message);
               PlayerPlaySound(targetid, SOUND_RECEIVEMESSAGE, 0.0, 0.0, 0.0);
               format(string, sizeof string, "[RESPONSE] %s to %s(%i): %s", playerName, ReturnPlayerName(targetid), targetid, message);
					SendMessageToStaff(COLOR_HELP, string);
            }
            else
            {
               SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
            }
         }
         else
         {
            SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
         }
      }
   }
   else
   {
      SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
   }

	return 1;
}

CMD:fakechat(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		new targetid, message[100];
		if (sscanf(params, "us[100]", targetid, message)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /fakechat <player> <message>");
		if (IsPlayerInGame(targetid) && playerData[targetid][pd_IsLoggedIn])
		{
			if (playerData[playerid][pd_AdminRank] < playerData[targetid][pd_AdminRank]) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTUSECOMMANDONTHATPLAYER);
			CMDMessageToAdmins(playerid, "FAKECHAT");
			SendPlayerMessageToAll(targetid, message);
			return SendClientMessage(playerid,COLOR_NOTIFY, "   The Fake message has been sent.");
		} else return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:spawnall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "SPAWNAll");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
				RemovePlayerFromVehicle(i);
				SpawnPlayer(i);
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s(%i) has re-spawned all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:allmute(playerid, params[])
{
	return cmd_muteall(playerid, params);
}

CMD:muteall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "MUTEALL");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				playerData[i][Muted] = 1;
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s(%i) has muted all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:unmuteall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "UNMUTEAll");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				playerData[i][Muted] = 0;
			}
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s has unmuted all players", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		return SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:getall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "GETAll");
		new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
		GetPlayerPos(playerid,x,y,z);
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerPos(i,x+(playerid/4)+1,y+(playerid/4),z);
				SetPlayerInterior(i,interior);
			}
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s has teleported all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:healall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "HEALALL");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			PlayerPlaySound(i,1057,0.0,0.0,0.0);
			SetPlayerHealth(i, MAX_HEALTH_PLAYER);
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s has healed all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		return SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:armourall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "giveallarmor");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
			SetPlayerArmour(i, 99.0);
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s(%i) has restored all players armor.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:giveallarmor(playerid, params[])
{
	return cmd_armourall(playerid, params);
}

CMD:killall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "KILLALL");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i, 0.0);
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s(%i) has killed all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:freezeall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "FREEZEALL");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				TogglePlayerControllable(i, false);
				playerData[i][Frozen] = 1;
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s has frozen all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:unfreezeall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "UNFREEZEALL");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			PlayerPlaySound(i,1057,0.0,0.0,0.0);
			TogglePlayerControllable(i,true);
			playerData[i][Frozen] = 0;
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s(%i) has unfrozen all players.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		return SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:slapall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "SLAPALL");
		new Float:x, Float:y, Float:z;
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i,1190,0.0,0.0,0.0);
				GetPlayerPos(i,x,y,z);
				SetPlayerPos(i,x,y,z+4);
			}
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s has slapped all players", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		return SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:explodeall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "EXPLODEALL");
		new Float:x, Float:y, Float:z;
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	CreateExplosion(x, y , z, 7, 10.0);
			}
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s has exploded all players", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		return SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:disarmall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "DISARMALL");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				ResetPlayerWeaponsEx(i);
			}
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s has disarmed all players", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:ejectall(playerid, params[])
{
	#pragma unused params

	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		CMDMessageToAdmins(playerid, "EJECTALL");
		new Float:x, Float:y, Float:z;
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid)
			{
				if (IsPlayerInAnyVehicle(i))
				{
					PlayerPlaySound(i,1057,0.0,0.0,0.0);
					GetPlayerPos(i,x,y,z);
					SetPlayerPos(i,x,y,z+3);
				}
			}
		}
		new string[MAX_STRING]; format(string, sizeof string, "[SERVER] %s %s has ejected all players", GetStaffClassName(playerid), ReturnPlayerName(playerid) );
		return SendClientMessageToAll(COLOR_SERVER, string);
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
}

CMD:setallweather(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		new weatherId;
		if (sscanf(params, "i", weatherId))
		{
			return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setallweather <weather Id(0-"#MAX_WEATHER")>");
		}
		CMDMessageToAdmins(playerid, "SETALLWEATHER");
		new string[MAX_STRING];
		SetWeather(weatherId);
		format(string, sizeof string, "[SERVER] The weather has been changed by %s %s(%i).", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOR_SERVER, string);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:setalltime(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setalltime <hour>");
		new var = strval(params), string[MAX_STRING];
		if (var > 24) return SendScreenMessage(playerid, "Invalid hour");
		CMDMessageToAdmins(playerid, "SETALLTIME");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			PlayerPlaySound(i,1057,0.0,0.0,0.0);
			SetPlayerTime(i, var, 0);
		}
		format(string, sizeof string, "[SERVER] %s %s has set all players time to '%d:00'.", GetStaffClassName(playerid), ReturnPlayerName(playerid), var );
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:setallskin(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setalllskin <skin Id>");
		new skinId;
		if (sscanf(params, "i", skinId)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setallskin <skin Id>");
		if (!IsValidSkin(skinId)) return SendScreenMessage(playerid, "Invaild Skin Id specified");
		CMDMessageToAdmins(playerid, "setallskin");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			PlayerPlaySound(i, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
			SetPlayerSkinEx(i, skinId);
		}
		new string[MAX_STRING];
		format(string, sizeof string, "[SERVER] %s %s(%i) has set all players skin to Id '%i'.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, skinId);
		SendClientMessageToAll(COLOR_SERVER, string);
	} 
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:setallworld(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /setallworld <vw Id>");
		new var = strval(params), string[MAX_STRING];
		CMDMessageToAdmins(playerid, "SETALLWORLD");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			PlayerPlaySound(i,1057,0.0,0.0,0.0);
			SetPlayerVirtualWorld(i,var);
		}
		format(string, sizeof string, "[SERVER] %s %s has set all players virtual worlds to '%d'.", GetStaffClassName(playerid), ReturnPlayerName(playerid), var );
		SendClientMessageToAll(COLOR_SERVER, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:astop(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 3)
	{
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i)) continue;
			StopAudioStreamForPlayer(i);
			SendClientMessage(i, COLOR_SERVER, "[SERVER] An administrator gas stopped the music.");
		}
	} else return SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:giveallmoney(playerid, params[])
{
	return cmd_giveallcash(playerid, params);
}

CMD:giveallcash(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		if (isnull(params)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /giveallmoney <amount>");
		new var = strval(params), string[MAX_STRING];
		CMDMessageToAdmins(playerid, "giveallmoney");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i))
			{
				GivePlayerCash(i, var);
			}
		}
		format(string, sizeof string, "[SERVER] %s %s(%i) has given all players $%i.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, var);
		SendClientMessageToAll(COLOR_SERVER, string);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:giveallweapon(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new Weap, ammo, string[MAX_STRING];
		if (sscanf(params, "ii", Weap, ammo)) return SendClientMessage(playerid,COLOR_SYNTAX, "[SYNTAX] /giveallweapon <weapon> <ammo>");
		if (Weap == WEAPON_MINIGUN || Weap == WEAPON_HEATSEEKER) return SendScreenMessage(playerid, "You Can't Give Those Weapons!");
		CMDMessageToAdmins(playerid, "GIVEALLWEAPON");
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			GivePlayerWeaponEx(i, Weap, ammo);
		}
		format(string, sizeof string, "[SERVER] %s %s(%i) has given all players weapon %s with %i ammo.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, ReturnWeaponName(Weap), ammo);
		SendClientMessageToAll(COLOR_SERVER, string);
	}
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:sv(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		new vehID;
		if (sscanf(params, "i", vehID)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /sv <vehicle Id>");
		if (!IsVehicleInGame(vehID)) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDVEHICLE);
		SetVehicleToRespawn(vehID);
		SendClientMessage(playerid, COLOR_NOTIFY, "   The vehicle has been re-spawned.");
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:dv(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank])
	{
		static vehID;
		if ( sscanf( params, "i",  vehID ) ) return SendClientMessage( playerid, COLOR_SYNTAX, "[SYNTAX] /dv <vehicle Id>" );
		if ( vehID == INVALID_VEHICLE_ID ) return SendScreenMessage( playerid, "Invalid vehicle ID" );
		DestroyVehicle(vehID);
	}

	return 1;
}

CMD:duel(playerid, params[])
{
	if (DuelActive == true) return SendScreenMessage(playerid, "There is already an ongoing duel, wait for it to end");
	new target, cost;
	if (sscanf(params, "ui", target, cost)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /duel <player> <bet amount>");
	if(!IsPlayerConnected(target)) return SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);
	if(!playerData[target][pd_IsLoggedIn]) return SendScreenMessage(playerid, LOCALE_MESSAGE_PLAYERNOTLOGGED);
	if (target == playerid) return 1;
	if (cost < 5000) return SendScreenMessage(playerid, "Bet amount cannot be lower than $5,000");
	if (cost > 100000) return SendScreenMessage(playerid, "Bet amount cannot be higher than $100,000");
	if (GetPlayerMoney(playerid) < cost) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANNOTAFFORD);
	if (playerData[target][pd_IsOnDuty]) return SendScreenMessage(playerid, "You cannot offer to on-duty staff");

	new string[MAX_STRING];
	format(string, sizeof string, "%s(%i) has sent you a duel invitation for $%i. Type /accept to accept, or type /decline to refuse.", ReturnPlayerName(playerid), playerid, cost);
	SendClientMessage(target, COLOR_REWARD, string);

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		if ((Invited[i] == playerid) || (Invited[i] == target))
		{
			Invited[i] = INVALID_VALUE;
		}
	}

	Invited[playerid] = INVALID_VALUE;
	Invited[target] = playerid;
	format(string, sizeof string, "   The duel invitation has been sent to %s(%i).", ReturnPlayerName(target), target);
	SendClientMessage(playerid, COLOR_NOTIFY, string);
	WinningPrice = cost;
	return 1;
}

CMD:accept(playerid, params[])
{
	if (Invited[playerid] == INVALID_VALUE) return SendScreenMessage(playerid, "You haven't recieved duel invitation from anyone");
	if (DuelActive == true) return SendScreenMessage(playerid, "There is already an ongoing duel. Wait for it to end");
	if (GetPlayerState(playerid) == 9) return SendScreenMessage(playerid, "You can not accept a duel invitation during spectating");
	if (GetPlayerState(Invited[playerid]) == 9) return SendScreenMessage(playerid, "The player who sent you duel invitation is currently in spec mode");
	if (playerData[playerid][pd_IsOnDuty]) return SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	if (GetPlayerMoney(playerid) < WinningPrice)
	{
		SendScreenMessage(playerid, "You dont have that much money, duel declined");
		return cmd_decline(playerid, "");
	}

	new tName[MAX_PLAYER_NAME], p1Name[MAX_PLAYER_NAME], string[MAX_STRING];
	GetPlayerName(playerid, tName, sizeof(tName));
	GetPlayerName(Invited[playerid], p1Name, sizeof(p1Name));
	format(string, sizeof string, "[ARENA] The duel between %s(%i) and %s(%i) has started.",tName,playerid,p1Name,Invited[playerid]);
	SendClientMessageToAll(COLOR_NEWS, string);
	DuelActive = true;
	IsDueling[Invited[playerid]] = true;
	IsDueling[playerid] = true;
	DuelOpponentId[Invited[playerid]] = playerid;
	DuelOpponentId[playerid] = Invited[playerid];
	SetPlayerInterior(playerid, INTERIOR_PAINTBALL);
	SetPlayerInterior(Invited[playerid], INTERIOR_PAINTBALL); // TODO: Use setplayerposEX.
	SetPlayerPos(playerid, -973.0, 1060.0, 1345.9);
	SetPlayerPos(Invited[playerid], -1132.0, 1057.0, 1346.9);
	SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
	SetPlayerHealth(Invited[playerid], MAX_HEALTH_PLAYER);
	SetPlayerArmour(playerid, 0.0);
	SetPlayerArmour(Invited[playerid], 0.0);
	GivePlayerWeaponEx(playerid, WEAPON_KATANA, 1);
	GivePlayerWeaponEx(Invited[playerid],WEAPON_KATANA,1);
	GivePlayerWeaponEx(playerid,WEAPON_DEAGLE,100);
	GivePlayerWeaponEx(Invited[playerid],WEAPON_DEAGLE,100);
	GivePlayerWeaponEx(playerid,WEAPON_SHOTGSPA,500);
	GivePlayerWeaponEx(Invited[playerid],WEAPON_SHOTGSPA,100);
	GivePlayerWeaponEx(playerid,WEAPON_M4,100);
	GivePlayerWeaponEx(Invited[playerid],WEAPON_M4,100);
	GivePlayerWeaponEx(playerid,WEAPON_SNIPER,100);
	GivePlayerWeaponEx(Invited[playerid],WEAPON_SNIPER,100);
	SetPlayerTeam(playerid, NO_TEAM);
	SetPlayerTeam(Invited[playerid], NO_TEAM);
	SetPlayerColor(playerid, COLOR_TEAM_NONE);
	SetPlayerColor(playerid, COLOR_TEAM_NONE);
	SetCameraBehindPlayer(playerid);
	SetCameraBehindPlayer(Invited[playerid]);
	SetPlayerArmedWeapon(playerid, WEAPON_FIST);
	SetPlayerArmedWeapon(Invited[playerid], WEAPON_FIST);
	Invited[playerid] = INVALID_VALUE;
	return 1;
}

CMD:myenv(playerid, params[])
{
	#pragma unused params

	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	SendClientMessageEx(playerid, COLOR_REWARD, "Your environment information: X:%f, Y:%f, Z:%f, A:%0.2f VW:%i Int:%i", x, y, z, a, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	return 1;
}

CMD:decline(playerid, params[])
{
	if (Invited[playerid] == INVALID_VALUE) return SendScreenMessage(playerid, "You haven't recieved duel invitation from anyone");

	SendClientMessageEx(Invited[playerid], COLOR_NOTIFY, "   %s(%i) has declined your duel invitation.", ReturnPlayerName(playerid), playerid);
	Invited[playerid] = INVALID_VALUE;
	return 1;
}

CMD:anims(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Commands - Animations", "{FFFFFF}/handsup /drunk /bomb /getarrested /laugh /robman\n/crossarms /lay /hide /vomit /eat /wave /taichi /wine\n/deal /crack /smokem /smokef /sit /chat /dance /fuck /cigar", "OK", "");
	return 1;
}

CMD:handsup(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);

CMD:cellin(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

CMD:cellout(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

CMD:drunk(playerid, params[]) return AnimLoopPlayer(playerid, "PED", "WALK_DRUNK",4.0,1,1,1,1,0);

CMD:bomb(playerid, params[]) return	ClearAnimations(playerid),AnimPlayer(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);

CMD:getarrested(playerid, params[]) return AnimLoopPlayer(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, INVALID_VALUE); // Gun Arrest

CMD:laugh(playerid, params[]) return AnimPlayer(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh

CMD:lookout(playerid, params[]) return AnimPlayer(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout

CMD:robman(playerid, params[]) return AnimLoopPlayer(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob

CMD:crossarms(playerid, params[]) return AnimLoopPlayer(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, INVALID_VALUE); // Arms crossed

CMD:lay(playerid, params[]) return AnimLoopPlayer(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down

CMD:hide(playerid, params[]) return AnimLoopPlayer(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Taking Cover

CMD:vomit(playerid, params[]) return AnimPlayer(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!

CMD:eat(playerid, params[]) return AnimPlayer(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger

CMD:wave(playerid, params[]) return  AnimLoopPlayer(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave

CMD:slapass(playerid, params[]) return AnimPlayer(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping

CMD:deal(playerid, params[]) return AnimPlayer(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs

CMD:crack(playerid, params[]) return AnimLoopPlayer(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack

CMD:smokem(playerid, params[]) return AnimLoopPlayer(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Smoke

CMD:smokef(playerid, params[]) return AnimLoopPlayer(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Female Smoking

CMD:sit(playerid, params[]) return AnimLoopPlayer(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Sit

CMD:chat(playerid, params[]) return AnimPlayer(playerid, "PED", "IDLE_CHAT",4.0,0,0,0,0,0);

CMD:fuck(playerid, params[]) return AnimPlayer(playerid, "PED", "fucku",4.0,0,0,0,0,0);

CMD:taichi(playerid, params[]) return AnimLoopPlayer(playerid, "PARK", "Tai_Chi_Loop",4.0,1,0,0,0,0);

CMD:chairsit(playerid, params[]) return AnimLoopPlayer(playerid, "BAR", "dnk_stndF_loop",4.0,1,0,0,0,0);

CMD:dance(playerid, params[])
{
	new dancestyle;

	if (!sscanf(params, "d", dancestyle))
	{
		if (dancestyle == 1) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		else if (dancestyle == 2) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		else if (dancestyle == 3) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		else if (dancestyle == 4) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		else GameTextForPlayer(playerid, "~r~Invalid Dance-id~n~~w~[SYNTAX] ~y~/Dance (1-4)", 3000, 4);
	}
	else GameTextForPlayer(playerid, "~w~[SYNTAX] ~y~/Dance (1-4)", 3000, 4);

	return 1;
}

CMD:cigar(playerid, params[])
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
	return 1;
}

CMD:wine(playerid, params[])
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
	return 1;
}

CMD:radiostop(playerid, params[])
{
	SendClientMessage(playerid, COLOR_NOTIFY, "Stopped all the streamings.");
	StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:astats(playerid, params[])
{
	new string[MAX_STRING], pDeaths, targetid;
	if (isnull(params)) targetid = playerid;
	else targetid = strval(params);

	if (IsPlayerConnected(targetid))
	{
		new Float:x, Float:y, Float:z, Float:armor;
		GetPlayerPos(playerid, x,y,z);
		GetPlayerArmour(playerid, armor);
		PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
		if (playerData[targetid][pd_Deaths] == 0) pDeaths = 1;
		else pDeaths = playerData[targetid][pd_Deaths];
		format(string, sizeof string, "%s's Kills: %d | Deaths: %d | Ratio: %0.2f | Money: $%d |Score: %d | Health: %d | Armour: %d", 
		ReturnPlayerName(targetid), playerData[targetid][pd_Kills], playerData[targetid][pd_Deaths], Float:playerData[targetid][pd_Kills]/Float:pDeaths,GetPlayerMoney(targetid), GetPlayerScore(playerid), floatround(ReturnPlayerHealth(playerid)),armor);
		SendClientMessage(playerid, COLOR_REWARD, string);
	} else SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDPLAYER);

	return 1;
}

CMD:teams(playerid, params[])
{
	new string[MAX_STRING_SHORT];
	format(string, sizeof string, "Team: %s | Players: %i", gTeams[2][E_TEAM_NAME], GetTeamCount(TEAM_EUROPE));
	SendClientMessage(playerid, gTeams[2][E_TEAM_COLOR], string);
	format(string, sizeof string, "Team: %s | Players: %i", gTeams[0][E_TEAM_NAME], GetTeamCount(TEAM_ASIA));
	SendClientMessage(playerid, gTeams[0][E_TEAM_COLOR], string);
	format(string, sizeof string, "Team: %s | Players: %i", gTeams[4][E_TEAM_NAME], GetTeamCount(TEAM_USA));
	SendClientMessage(playerid, gTeams[4][E_TEAM_COLOR], string);
	format(string, sizeof string, "Team: %s | Players: %i", gTeams[3][E_TEAM_NAME], GetTeamCount(TEAM_RUSSIA));
	SendClientMessage(playerid, gTeams[3][E_TEAM_COLOR], string);
	format(string, sizeof string, "Team: %s | Players: %i", gTeams[1][E_TEAM_NAME], GetTeamCount(TEAM_AUSTRALIA));
	SendClientMessage(playerid, gTeams[1][E_TEAM_COLOR], string);
	return 1;
}

CMD:getteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
	new team[MAX_STRING_TEAMNAME], Float:x, Float:y, Float:z, interior = GetPlayerInterior(playerid), world = GetPlayerVirtualWorld(playerid);
	if (sscanf(params, "s[16]",team)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /getteam < Team Name >");
	GetPlayerPos(playerid, x, y, z);
	//---------USA------------------------
	if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_USA)
	{
	SetPlayerInterior(i, interior);
	SetPlayerVirtualWorld(i, world);
	SetPlayerPos(i, x+3, y, z);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has teleported team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	//---------------------------------
	//--------Europe----------------
	if (strfind(params,gTeams[2][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_EUROPE)
	{
	SetPlayerPos(i, x+3, y, z);
	SetPlayerInterior(i, interior);
	SetPlayerVirtualWorld(i, world);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has teleported team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}

	if (strfind(params,gTeams[0][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_ASIA)
	{
	SetPlayerPos(i, x+3, y, z);
	SetPlayerInterior(i, interior);
	SetPlayerVirtualWorld(i, world);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has teleported team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	//----------Russian-------
	if (strfind(params,gTeams[3][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_RUSSIA)
	{
	SetPlayerPos(i, x+3, y, z);
	SetPlayerInterior(i, interior);
	SetPlayerVirtualWorld(i, world);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has teleported team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	//-----------Australia---------
	if (strfind(params,gTeams[1][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_AUSTRALIA)
	{
	SetPlayerPos(i, x+3, y, z);
	SetPlayerInterior(i, interior);
	SetPlayerVirtualWorld(i, world);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has teleported team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	}
	else SendScreenMessage(playerid,LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:spawnteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
	new team[MAX_STRING_TEAMNAME];
	if (sscanf(params, "s[16]",team)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /spawnteam < Team Name >");
	//---------USA------------------------
	if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_USA)
	{
	RemovePlayerFromVehicle(i);
	SpawnPlayer(i);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has spawned team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	//---------------------------------
	//--------Europe----------------
	if (strfind(params,gTeams[2][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_EUROPE)
	{
	RemovePlayerFromVehicle(i);
	SpawnPlayer(i);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has spawned team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}

	if (strfind(params,gTeams[0][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_ASIA)
	{
	RemovePlayerFromVehicle(i);
	SpawnPlayer(i);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has spawned team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	//----------Russian-------
	if (strfind(params,gTeams[3][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_RUSSIA)
	{
	RemovePlayerFromVehicle(i);
	SpawnPlayer(i);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has spawned team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	//-----------Australia---------
	if (strfind(params,gTeams[1][E_TEAM_NAME],true) != INVALID_VALUE)
	{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
	if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
	if (playerData[i][pd_TeamId] == TEAM_AUSTRALIA)
	{
	RemovePlayerFromVehicle(i);
	SpawnPlayer(i);
	}
	}
	new string[100];
	format(string, sizeof string, "[SERVER] %s %s has spawned team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid),params);
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	}
	else SendScreenMessage(playerid,LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:freezeteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new teamName[MAX_STRING_TEAMNAME];
		if (sscanf(params, "s["#MAX_STRING_TEAMNAME"]i", teamName)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /freezeteam < Team Name >");
		new teamId = NO_TEAM;
		if (strfind(params, gTeams[0][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_ASIA;
		}
		else if (strfind(params, gTeams[1][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_AUSTRALIA;
		}
		else if (strfind(params, gTeams[2][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_EUROPE;
		}
		else if (strfind(params, gTeams[3][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_RUSSIA;
		}
		else if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_USA;
		}
		else
		{
			return SendScreenMessage(playerid, "Invalid team-name specified");
		}
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				if (playerData[i][pd_TeamId] == teamId)
				{
					TogglePlayerControllable(i, false);
					playerData[i][Frozen] = 1;
				}
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] %s %s(%i) has frozen team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, GetTeamName(teamId));
		SendClientMessageToAll(COLOR_SERVER, message);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:unfreezeteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new teamName[MAX_STRING_TEAMNAME];
		if (sscanf(params, "s["#MAX_STRING_TEAMNAME"]i", teamName)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /unfreezeteam < Team Name >");
		new teamId = NO_TEAM;
		if (strfind(params, gTeams[0][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_ASIA;
		}
		else if (strfind(params, gTeams[1][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_AUSTRALIA;
		}
		else if (strfind(params, gTeams[2][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_EUROPE;
		}
		else if (strfind(params, gTeams[3][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_RUSSIA;
		}
		else if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_USA;
		}
		else
		{
			return SendScreenMessage(playerid, "Invalid team-name specified");
		}
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				if (playerData[i][pd_TeamId] == teamId)
				{
					TogglePlayerControllable(i, true);
					playerData[i][Frozen] = 0;
				}
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] %s %s(%i) has unfrozen team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, GetTeamName(teamId));
		SendClientMessageToAll(COLOR_SERVER, message);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:disarmteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new teamName[MAX_STRING_TEAMNAME];
		if (sscanf(params, "s["#MAX_STRING_TEAMNAME"]i", teamName)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /disarmteam < Team Name >");
		new teamId = NO_TEAM;
		if (strfind(params, gTeams[0][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_ASIA;
		}
		else if (strfind(params, gTeams[1][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_AUSTRALIA;
		}
		else if (strfind(params, gTeams[2][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_EUROPE;
		}
		else if (strfind(params, gTeams[3][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_RUSSIA;
		}
		else if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_USA;
		}
		else
		{
			return SendScreenMessage(playerid, "Invalid team-name specified");
		}
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				if (playerData[i][pd_TeamId] == teamId)
				{
					ResetPlayerWeaponsEx(i);
				}
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] %s %s(%i) has disarmed team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, GetTeamName(teamId));
		SendClientMessageToAll(COLOR_SERVER, message);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:giveteamscore(playerid, params[])
{
	return cmd_gsteam(playerid, params);
}

CMD:gsteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new teamName[MAX_STRING_TEAMNAME], amount;
		if (sscanf(params, "s["#MAX_STRING_TEAMNAME"]i", teamName, amount)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /giveteamscore < Team Name > <amount>");
		new teamId = NO_TEAM;
		if (strfind(params, gTeams[0][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_ASIA;
		}
		else if (strfind(params, gTeams[1][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_AUSTRALIA;
		}
		else if (strfind(params, gTeams[2][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_EUROPE;
		}
		else if (strfind(params, gTeams[3][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_RUSSIA;
		}
		else if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_USA;
		}
		else
		{
			return SendScreenMessage(playerid, "Invalid team-name specified");
		}
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				if (playerData[i][pd_TeamId] == teamId)
				{
					GivePlayerScore(i, amount);
				}
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] %s %s(%i) has given %i score(s) to team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, amount, GetTeamName(teamId));
		SendClientMessageToAll(COLOR_SERVER, message);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:giveteammoney(playerid, params[])
{
	return cmd_givecashteam(playerid, params);
}

CMD:giveteamcash(playerid, params[])
{
	return cmd_givecashteam(playerid, params);
}

CMD:givecashteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new teamName[MAX_STRING_TEAMNAME], amount;
		if (sscanf(params, "s["#MAX_STRING_TEAMNAME"]i", teamName, amount)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /giveteamcash < Team Name > <amount>");
		new teamId = NO_TEAM;
		if (strfind(params, gTeams[0][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_ASIA;
		}
		else if (strfind(params, gTeams[1][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_AUSTRALIA;
		}
		else if (strfind(params, gTeams[2][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_EUROPE;
		}
		else if (strfind(params, gTeams[3][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_RUSSIA;
		}
		else if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_USA;
		}
		else
		{
			return SendScreenMessage(playerid, "Invalid team-name specified");
		}
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
			{
				if (playerData[i][pd_TeamId] == teamId)
				{
					GivePlayerCash(i, amount);
				}
			}
		}
		new message[MAX_STRING];
		format(message, sizeof(message), "[SERVER] %s %s(%i) has given $%i cash to team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, amount, GetTeamName(teamId));
		SendClientMessageToAll(COLOR_SERVER, message);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:healnear(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new radius;
		if (sscanf(params, "i", radius))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /healnear <radius>");
		}
		else
		{
			if ((radius < 1) || (radius > 500)) return SendScreenMessage(playerid, "Radius must be between 1 and 500");
			new count;
			for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
			{
				if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
				{
					if (IsPlayerInRangeOfPlayer(playerid, i, radius))
					{
						SetPlayerHealth(i, MAX_HEALTH_PLAYER);
						count ++;
					}
				}
			}
			SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have healed everyone(%i) nearby.", count);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:armornear(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new radius;
		if (sscanf(params, "i", radius))
		{
			SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /armornear <radius>");
		}
		else
		{
			if ((radius < 1) || (radius > 500)) return SendScreenMessage(playerid, "Radius must be between 1 and 500");
			new count;
			for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
			{
				if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
				{
					if (IsPlayerInRangeOfPlayer(playerid, i, radius))
					{
						SetPlayerArmour(playerid, 99.0);
						count ++;
					}
				}
			}
			SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have given armor to everyone(%i) nearby.", count);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:giveteamweapon(playerid, params[])
{
	return cmd_giveweaponteam(playerid, params);
}

CMD:giveweaponteam(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 4)
	{
		new teamName[MAX_STRING_TEAMNAME];
		new weaponId, ammo;
		if (sscanf(params, "s["#MAX_STRING_TEAMNAME"]ii", teamName, weaponId, ammo)) return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /giveteamweapon < Team Name > <weapon> <ammo>");
		new teamId = NO_TEAM;
		if (strfind(params, gTeams[0][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_ASIA;
		}
		else if (strfind(params, gTeams[1][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_AUSTRALIA;
		}
		else if (strfind(params, gTeams[2][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_EUROPE;
		}
		else if (strfind(params, gTeams[3][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_RUSSIA;
		}
		else if (strfind(params, gTeams[4][E_TEAM_NAME], true) != INVALID_VALUE)
		{
			teamId = TEAM_USA;
		}
		else
		{
			return SendScreenMessage(playerid, "Invalid team-name specified");
		}
		if ((weaponId < WEAPON_BRASSKNUCKLE) || (weaponId > TOTAL_WEAPONS))
		{
			return SendScreenMessage(playerid, "The weapon Id must be between 1 and " #TOTAL_WEAPONS "");
		}
		if ((ammo < 1) || (ammo > MAX_WEAPON_AMMO))
		{
			return SendScreenMessage(playerid, "The ammo must be between 1 and " #MAX_WEAPON_AMMO "");
		}
		switch (weaponId)
		{
			case 19, 20, 21:
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDWEAPON);
			}

			case WEAPON_HEATSEEKER, WEAPON_NIGHTVISIONGOGGLES, WEAPON_THERMALGOGGLES:
			{
				SendScreenMessage(playerid, "You cannot give this weapon to players");
			}

			default:
			{
				for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
				{
					if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
					{
						if (playerData[i][pd_TeamId] == teamId)
						{
							if (weaponId == WEAPON_SATCHEL)
							{
								GivePlayerWeaponEx(i, WEAPON_BOMB, 1);
							}
							GivePlayerWeaponEx(i, weaponId, ammo);
						}
					}
				}
				new message[MAX_STRING];
				format(message, sizeof(message), "[SERVER] %s %s(%i) has given %s(%iA) to team %s.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, ReturnWeaponName(weaponId), ammo, GetTeamName(teamId));
				SendClientMessageToAll(COLOR_SERVER, message);
			}
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:ranks(playerid)
{
	new str[100] = "{FFFFFF}";
	for(new i; i < sizeof gRanks; i++)
	{
		format(str, sizeof str, "Rank %i - %s - %d < Score\n", (i + 1), gRanks[i][E_RANK_NAME], gRanks[i][E_RANK_SCORE]);
		strcat(gString, str);
	}

	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Ranks", gString, "OK", "");
	return 1;
}

CMD:rcodes(playerid, params[])
{
	#pragma unused params

	return ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Radio Codes", LOCALE_HELP_RADIOCODES, "OK", "");
}

CMD:r1(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Attack!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r2(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Sniper On The Base!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r3(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Roger That.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r4(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Negative.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r5(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Tank incoming!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r6(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Missle Incoming!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r7(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Cover Me!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r8(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Area Secure.", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:r9(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Grenade!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

return 1;
}

CMD:r10(playerid, params[])
{
	if (!playerData[playerid][pd_IsOnDuty])
	{
		if (playerData[playerid][pd_TeamId] != NO_TEAM)
		{
			if (!playerData[playerid][Muted])
			{
				new string[MAX_STRING_SHORT];
				format(string, sizeof string, "[TEAM ORDER] %s %s(%i): Spy In The Base!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid);
				SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), string);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
			}
		}
		else
		{
			SendScreenMessage(playerid, "You are not part of any team");
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}

	return 1;
}

CMD:tr(playerid, params[])
{
	return cmd_r(playerid, params);
}

CMD:r(playerid, params[])
{
	if (playerData[playerid][pd_IsOnDuty])
	{
		return SendScreenMessage(playerid, "You must be off-duty to use that");
	}

	if (playerData[playerid][Muted])
	{
		return SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
	}

	new message[MAX_STRING];

	if (sscanf(params, "s["#MAX_STRING"]", message))
	{
		return SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /r <message>");
	}

	format(message, sizeof(message), "[TEAM RADIO] %s %s(%i): %s", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid, message);
	SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), message);
	return 1;
}

CMD:order(playerid, params[])
{
	return cmd_r(playerid, params);
}

CMD:myrank(playerid, params[])
{
	new string[MAX_STRING];
	format(string, sizeof string, "{FFFFFF}Your current rank status: " COLOR_INLINE_SCORE "Scores %i {FFFFFF}| " COLOR_INLINE_SCORE "Rank: %s", GetPlayerScore(playerid), GetPlayerRankName(playerid));
	DisplayDialogMessage(playerid, "Player - Rank", string);
	return 1;
}

CMD:sync(playerid, params[])
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
	SetPlayerPos(playerid, Float:X + 1.0, Float:Y, Float:Z);
	SendClientMessage(playerid, COLOR_NOTIFY, "   You have synced yourself.");
	return 1;
}

CMD:forum(playerid, params[])
{
	return cmd_serverinfo(playerid, params);
}

CMD:objective(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Objectives", "{FF0000}> Your Objective is to Kill Players\n> Make killing spree \n>Capture the zones", "OK", "");
	return 1;
}

CMD:helisupport(playerid, params[])
{
	new const vehicleId = GetPlayerVehicleID(playerid);

	switch (GetVehicleModel(vehicleId))
	{
		case VEHICLE_HUNTER:
		{
			if (heliobjects[vehicleId][0]) return SendScreenMessage(playerid, "This vehicle already has support objects");
			DestroyObject(heliobjects[vehicleId][0]);
			DestroyObject(heliobjects[vehicleId][1]);
			heliobjects[vehicleId][0] = CreateObject(18756, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, 100.0);
			heliobjects[vehicleId][1] = CreateObject(18756, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, 100.0);
			AttachObjectToVehicle(heliobjects[vehicleId][0], vehicleId, 0.95, -2.05, 0.9, 0.0, -90.0, 0.0);
			AttachObjectToVehicle(heliobjects[vehicleId][1], vehicleId, -1.8, -2.05, 0.9, 0.0, -90.0, 0.0);
		}

		default:
		{
			SendScreenMessage(playerid, "You must be in a Hunter to use this command");
		}
	}

	return 1;
}

CMD:spyhelp(playerid, params[])
{
	if (playerData[playerid][pd_ClassId] == CLASS_SPY)
	{
		if (NoSpy == 1)
		{
			ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, "Help - Class - Spy", "{00FF28}/spyeurope - Europe Team\n{E10000}/spyruss - Russian Team\n{FF7E19}/spyuae - ASIA Team\n{FF0000}/spyusa - USA Team\n{AD00CC}/spyaus - AUS Team", "OK", "");
		}
		else
		{
			SendScreenMessage(playerid, "Its Not Spy Week");
		}
	}
	else
	{
		SendScreenMessage(playerid, "You need to be Spy to use this command");
	}

	return 1;
}

CMD:disablespy(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5) {
	new string[MAX_STRING];
	if (NoSpy == 1) {
	NoSpy = 0;
	CMDMessageToAdmins(playerid, "DISABLESPY");
	format(string, sizeof string, "[SERVER] %s %s has disabled spy features.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	else if (NoSpy == 0) {
	NoSpy = 1;
	CMDMessageToAdmins(playerid, "DISABLESPY");
	format(string, sizeof string, "[SERVER] %s %s has enabled spy features.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	}
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:disablejp(playerid, params[]) {
	if (playerData[playerid][pd_AdminRank] >= 5) {
	new string[MAX_STRING];
	if (NoJP == 1) {
	NoJP = 0;
	CMDMessageToAdmins(playerid, "DISABLEJP");
	format(string, sizeof string, "[SERVER] %s %s has disabled Jet Trooper features.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	else if (NoJP == 0) {
	NoJP = 1;
	CMDMessageToAdmins(playerid, "DISABLEJP");
	format(string, sizeof string, "[SERVER] %s %s has enabled Jet Trooper features.", GetStaffClassName(playerid), ReturnPlayerName(playerid));
	SendClientMessageToAll(COLOR_SERVER, string);
	}
	}
	else SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);

	return 1;
}

CMD:disablehv(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		new string[MAX_STRING];
		if (HV)
		{
			HV = 0;
			CMDMessageToAdmins(playerid, "DISABLEHV");
			format(string, sizeof string, "[SERVER] %s %s(%i) has disabled Heavy Vehicles feature.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
			SendClientMessageToAll(COLOR_SERVER, string);
		}
		else
		{
			HV = 1;
			CMDMessageToAdmins(playerid, "DISABLEHV");
			format(string, sizeof string, "[SERVER] %s %s(%i) has enabled Heavy Vehicles feature.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid);
			SendClientMessageToAll(COLOR_SERVER, string);
		}
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

CMD:disablehs(playerid, params[])
{
	if (playerData[playerid][pd_AdminRank] >= 5)
	{
		new string[MAX_STRING], className[MAX_STRING_CLASSNAME], playerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playerName, sizeof(playerName));
		format(className, sizeof(className), "%s", GetStaffClassName(playerid));
		if (gHeadshotState)
		{
			gHeadshotState = 0;
			format(string, sizeof string, "[SERVER] %s %s(%i) has disabled Headshot feature.", className, playerName, playerid);
		}
		else
		{
			gHeadshotState = 1;
			format(string, sizeof string, "[SERVER] %s %s(%i) has enabled Headshot feature.", className, playerName, playerid);
		}
		SendClientMessageToAll(COLOR_SERVER, string);
		CMDMessageToAdmins(playerid, "DISABLEHS");
		PlaySoundForAll(SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	}
	else
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_NOTAUTHORIZEDCOMMAND);
	}

	return 1;
}

// Player

CMD:calculate(playerid, params[])
{
	new method[10];
	new value1, value2;

	if (sscanf(params, "is[10]i", value1, method, value2))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "[SYNTAX] /calculate <value> <operation> <value>");
		SendClientMessage(playerid, COLOR_WHITE, "[OPERATIONS] +, -, /, *");
		return 1;
	}

	if (strcmp(method, "multiply", true) == 0 || strcmp(method, "*", true) == 0)
	{
		new sum = value1 * value2;
		SendClientMessageEx(playerid, COLOR_REWARD, "%s * %s = %s", (value1), (value2), (sum));
	}

	if (strcmp(method, "divide", true) == 0 || strcmp(method, "/", true) == 0)
	{
		if (value2 == 0) return SendScreenMessage(playerid, "Divided by zero");
		new sum = value1 / value2;
		SendClientMessageEx(playerid, COLOR_REWARD, "%s / %s = %s", (value1), (value2), (sum));
	}

	if (strcmp(method, "add", true) == 0 || strcmp(method, "+", true) == 0)
	{
		new sum = value1 + value2;
		SendClientMessageEx(playerid, COLOR_REWARD, "%s + %s = %s", (value1), (value2), (sum));
	}

	if (strcmp(method, "subtract", true) == 0 || strcmp(method, "-", true) == 0)
	{
		new sum = value1 - value2;
		SendClientMessageEx(playerid, COLOR_REWARD, "%s - %s = %s", (value1), (value2), (sum));
	}

	return 1;
}

CMD:flipcoin(playerid, params[])
{
	#pragma unused params

	new string[45 + MAX_PLAYER_NAME], playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));

	switch (random(100))
	{
		case 0 .. 50: format(string, sizeof string, "*** %s flips a coin that lands on heads ***", playerName);

		case 51 .. 100: format(string, sizeof string, "*** %s flips a coin that lands on tails ***", playerName);
	}

	SendMessageToRange(playerid, RADIUS_LOCALCHAT, GetPlayerVirtualWorld(playerid), COLOR_MEDO, string);
	return 1;
}

CMD:dice(playerid, params[])
{
	#pragma unused params

	new string[45 + MAX_PLAYER_NAME];
	format(string, sizeof string, "*** %s rolls a dice that lands on %i ***", ReturnPlayerName(playerid), random(6));
	SendMessageToRange(playerid, RADIUS_LOCALCHAT, GetPlayerVirtualWorld(playerid), COLOR_MEDO, string);
	return 1;
}
