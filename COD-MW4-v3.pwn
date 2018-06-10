//===============================================================================================
//|| Siege Gaming's Call of Duty : Modern Warfare 4 || Version 3 || Website : Siege-Gaming.Tk  ||
//===============================================================================================
//|| 'Cheat Buster' (the) anti-cheat which busts mosts of the regular and common cheats        ||
//|| Anti-illegal kill system (a part of anti-cheat) which busts car-park/ heli-blade and ram  ||
//|| New capture zones with mappings || Unique vehicle health system || Kick/ Bans are delayed ||
//|| Added commands to disable unique features for Level 5+ || Disabled chat system (fixed)    ||
//|| Added a object creation system for Level 5+ || Added a unique spawn system                ||
//|| Updated and added a lot of new commands (/cmds) and admin commands (/acmds)               ||
//|| Added a vehicle ejection system, works with the key 'Y' || Cool looking textdraws added   ||
//|| Added special features for some capture zones! now fight with modern tactics 			   ||
//|| Added a headshot system with helmet and distance counter || Name tags' LOS disabled       ||
//|| Added Nuke for Area 51 with time checking (/times) and nuke help commands (/nukehelp)     ||
//|| Added music streaming commands for admins || Added updates (/updates) command             ||
//|| Added class help (/chelp) command || Added team radio codes (/rcodes) || Knife bug fixed  ||
//|| Team mates can no longer damage their team mates vehicles || No drive-by as driver        ||
//|| Achievement system (/achs) with a more than 5 achs with rewards and textdraws  		   ||
//|| Added a new class and team selection system || Fixed all major bugs with capture zones    ||
//|| Added a unique automatic AFK system, players can no longer AFK capture zones!             ||
//|| If player doesn't registers/ logs in with-in the specific time, they are kicked           ||
//|| Added bonus zone system; capture bonus zone to earn bonus score and cash           	   ||
//|| Added bonus player system; kill the bonus player to earn bonus score and cash			   ||
//|| Killer recieves score for killing a capturer and stopping the zone from being captured    ||
//|| Added sample code for two new CP features: assist capturing and score fine on CP lost	   ||

//|| Added Toxic for Biological Ship and added toxic help command (/toxichelp)                 ||
//|| Added a shooting mission in Area 51 zone with map || Added a duel system                  ||
//===============================================================================================
//|| NOTE: Do not un-comment any code, if you don't know what you're doing.                    ||
//===============================================================================================
//|| Credits To:  [TWO]eXposed (ALiSCRIPTER) For Editing The GM                  			   ||
//||              Jarnu, xF4Life for there awesome scripts and ideas                           ||
//||              Respective owners of the includes, who made the impossible possible          ||
//||              Incognito, Zeex, Lorenc, DracoBlue, Lethal, Y_Less, Gammix...                ||
//|| Notes:	  If ever this script gets leaked or released, you're'nt allowed to remove the...  ||
//||          credits else you will be NUKED by [TWO]eXposed (ALiSCRIPTER)                     ||
//===============================================================================================
//|| Official colors: 0x80C732FF {80C732} | {D7374C} 0xD7374CFF | {FFFFFF} 0xFFFFFFFF          ||
//===============================================================================================
#include <a_samp>
#include <streamer>
#include <Dini>
#include <lethaldudb2>
#include <sscanf2>
#include <gangzonesc>
#include <izcmd>

//===========================
#define TEAM_EUROPE 0
#define TEAM_ARAB 1
#define TEAM_SOVIET 2
#define TEAM_USA 3
#define TEAM_AUS 4
#define TEAM_NONE 5
#define MAX_TEAMS 6

#undef MAX_PLAYERS
	#define MAX_PLAYERS	50

//#pragma dynamic 145000

#define SpamLimit (3000)

#define SNAKE 0  //Snakes farm - Done
#define BAY 1 //Bay sea shore - Done
#define A51 2 //Area 51 - Done
#define ARMY 3 //army restaurant - Done
#define PETROL 4 //army petrol bunk - Done
#define OIL 5 //oil factory - Done
#define DESERT 6 //gas station - Done
#define QUARRY 7 //Quarry - Done
#define GUEST 8 //Army guest house - Done
#define EAR 9 //Big ear - Done
#define DA 10 //Desert Airport - Done
#define AMMU 11 //Ammunation - Done
#define DAM 12 //Sherman Dam - Done
#define BELL 13 //Cluckin Bell - Done
#define RUSTY 14 //Rusty Bridge - Done
#define GHOST 15 //Ghost Town - Done
#define HOSP 16 //Hospital(College Near LV Airport) - Done
#define VILLA 17 //Villa - Done
#define BIOSHIP 18 //Biological Ship
#define CERBERUS 19 //Cerberus Island
#define MAX_CP 20

//------Classes------
#define SOLDIER 0
#define PILOT 1
#define SNIPER 2
#define ENGINEER 3
#define DONOR 4
#define SPY 5
#define JET 6
#define DEMOLISHER 7
#define HEAVY 8
#define SUPPORT 9

//-----DIALOGS-----
#define CLASS_DIALOG 	1559
#define SHOPS_DIALOG 	2
#define TIMES_DIALOG 	3
#define NUKEH_DIALOG 	4
#define ANIM_DIALOG 	5
#define UPDATES_DIALOG 	6
#define CREDITS_DIALOG  7
#define ACMDS_DIALOG    8
#define BONUS_DIALOG    9
#define DIALOG_MULT     10
#define DIS_DIALOG      11
#define DONOR_DIALOG 	800
#define CMDS_DIALOG 	123
#define LOGIN_DIALOG 	125
#define REGISTER_DIALOG 126
#define DIALOG_ADMINS   127
#define DIALOG_PAUSERS  128
#define DIALOG_TEAMS    129

//============================================================================//

#define TEAM_ZONE_EUROPE_COLOR 0x00B500AA // Green
#define TEAM_ZONE_ARAB_COLOR 0xF9ED00AA// Orange
#define TEAM_ZONE_SOVIET_COLOR 0xA62A00AA //Red
#define TEAM_ZONE_USA_COLOR 0x0000E5AA //Bright Blue
#define TEAM_ZONE_AUS_COLOR 0xBA18FFAA //purple color

//============================================================================//

#define COLOR_EUROPE    "{00B500}"
#define COLOR_ARAB      "{F9ED00}"
#define COLOR_SOVIET    "{A62A00}"
#define COLOR_USA       "{0000E5}"
#define COLOR_AUS       "{BA18FF}"

#define TEAM_EUROPE_COLOR 0x00B500FF // Bright Green
#define TEAM_ARAB_COLOR 0xF9ED00FF// Orange
#define TEAM_SOVIET_COLOR 0xA62A00FF //Bright Red
#define TEAM_USA_COLOR 0x0000E5FF //Bright Blue
#define TEAM_AUS_COLOR 0xBA18FFFF //purple color

//============================================================================//

#define SNIPER_EUROPE_COLOR 0x00B50000 // Bright Green (Invisible)
#define SNIPER_ARAB_COLOR 0xF9ED0000// Orange (Invisible)
#define SNIPER_SOVIET_COLOR 0xA62A0000 //Bright Red (Invisible)
#define SNIPER_USA_COLOR 0x0000E500 //Bright Blue (Invisible)
#define SNIPER_AUS_COLOR 0xBA18FF00 //purple color (Invisible)

//============================================================================//
#define bCol					0xE60053FF
#define bColc					"{E60053}"
#define COLOR_GREEN      		0x80FF8096
#define COLOR_ROYAL        		0x00C1F6AA
#define COLOR_BROWN	       		0xA52A2AAA
#define COLOR_PURPLE       		0xC2A2DAAA
#define lightblue          		0x33CCFFAA
#define cred 				  	"{E10000}"
#define corange					"{FF7E19}"
#define cyellow 				"{0087FF}"
#define cblue					"{0087FF}"
#define cwhite 					"{FFFFFF}"
#define cgreen 					"{00FF28}"
#define cgrey                   "{969696}"
//============================================================================//

//=====  [  W E E K L Y    L O N G    E V E N T S    S Y S T E M  ]  =====//
new NoJP = 0, NoSpy = 0, NoHS = 0, HV = 0;

// Nuke
new nuke_time, NUKE, nuke_remind;

// Toxic
new toxic_time, TOXIC, toxic_remind;

new USApro, EURpro, ARBpro, SOVpro, AUSpro;
new bool:IsPrototyping[MAX_PLAYERS char ];

new bool:Capturing[MAX_PLAYERS char ];

new bool:HHelmet[MAX_PLAYERS char ];

new DisguiseKits[MAX_PLAYERS];
new RegKick[MAX_PLAYERS];

new seconds[MAX_PLAYERS];

new IsPlayerUsingAnims[MAX_PLAYERS];
new IsPlayerAnimsPreloaded[MAX_PLAYERS];

// Anti SK system - unique
new AntiSK[MAX_PLAYERS], AntiSKt[MAX_PLAYERS], AntiSKa[MAX_PLAYERS];

new rconAttempts[MAX_PLAYERS];
new DND[MAX_PLAYERS];
new LastPM[MAX_PLAYERS];
new FirstSpawn[MAX_PLAYERS];
new Spectating[MAX_PLAYERS];

// Connect TDs
new Text:Intro2, Text:Intro3, Text:Intro1;
// Kill Death TDs
new PlayerText:Kill, PlayerText:Death, Text:KDBox;

new Text:logo1, Text:logo2, Text:logo3;

//Achievement system textdraws
new Text:AchTD0, Text:AchTD1, Text:AchTD2, PlayerText:AchTD3, PlayerText:AchTD4, PlayerText:AchTD5;

//Heli - Support CMD
new heliobjects[MAX_VEHICLES][2];

//Ping Kick & Anti-Bot! :D
new PingPos;

//==========RANDOM SPAWNS=========================//
new LastSpawnID[MAX_PLAYERS];

new Float:EuropeSpawn[][] =
{
	{981.1255, 2096.9294, 11.5718},
	{862.3610, 2139.2190, 11.0434},
	{936.8976, 2222.6548, 10.2274}
};
new Float:ArabSpawn[][] =
{
	{-772.2545, 1591.2332, 28.3746},
	{-729.4348,1538.6104,40.4290},
	{-799.0009,1551.8523,27.1172}
};
new Float:SovietSpawn[][] =
{
	{-136.1105,1116.5667,20.1966},
	{-168.05872,1140.72095,19.78535},
	{-20.9232,1120.6238,19.8900}
};
new Float:AusSpawn[][] =
{
	{-1466.3636, 2613.2705, 56.0449},
	{-1531.18,2536.12,55.700000762939},
	{-1413.17,2613.4,55.799999237061}
};
new Float:USASpawn[][] =
{
	{-250.4555,2595.8433,62.8582},
	{-231.0395,2651.1475,62.8003},
	{-282.5961,2729.2774,62.1439}
};
/*
new Float:MiniSpawn[3][3] =
{
	{3156.4609, -5195.8076, 19.4043},
	{3137.2039, -5209.6660, 13.1570},
	{3102.8188, -5140.1558, 35.3608}
};
new Float:CBSpawn[3][3] =
{
	{-1129.8909, 1057.5424, 1346.4141},
	{-973.1945, 1081.6935, 1344.6327},
	{-1057.6248, 1097.7158, 1342.6323}
};*/
//============================================================================//
#define savefolder "/Users/%s.ini"
#pragma unused ret_memcpy
//#pragma dynamic 145000
#pragma tabsize 0

new WeaponNames[55][] =
{
	{"Punch"},{"Brass Knuckles"},{"Golf Club"},{"Nite Stick"},{"Knife"},{"Baseball Bat"},{"Shovel"},{"Pool Cue"},{"Katana"},{"Chainsaw"},{"Purple Dildo"},
	{"Small White Vibrator"},{"Large White Vibrator"},{"Silver Vibrator"},{"Flowers"},{"Cane"},{"Grenade"},{"Tear Gas"},{"Molotov Cocktail"},
	{""},{""},{""}, // Empty spots for ID 19-20-21 (invalid weapon id's)
	{"Colt"},{"Silenced 9mm"},{"Deagle"},{"Shotgun"},{"Sawn-off"},{"Combat Shotgun"},{"Micro SMG"},{"MP5"},{"AK-47"},{"M4"},{"Tec9"},
	{"Rifle"},{"Sniper"},{"Rocket"},{"Heat Seeker"},{"Flamethrower"},{"Minigun"},{"Satchel Charge"},{"Detonator"},
	{"Spraycan"},{"Fire Extinguisher"},{"Camera"},{"Nightvision Goggles"},{"Thermal Goggles"},{"Parachute"}, {"Fake Pistol"},{""}, {"Vehicle Ram"}, {"Helicopter Blades"}, {"Explosion"}, {""}, {"Drowned"}, {"Collision"}
};
//-----------------------------------------------------------------------------------//
//- - - S E R V E R  I N F O - - -//
#define SERVER_NAME "• CALL OF DUTY : MODERN WARFARE 4 •"
#define SERVER_RCON "coder4lyfe"
#define SERVER_MAP  "Las Venturas Deserts"
//-----------------------------------------------------------------------------------//
#define USE_MENUS       	// Comment to remove all menus.  Uncomment to enable menus
//#define DISPLAY_CONFIG 	// displays configuration in console window on filterscript load
#define SAVE_LOGS           // Comment if your server runs linux (logs wont be saved)

//-----------------------------------------------------------------------------------//
//===================================Admins Colors=========================================//
#define Color_Server_Owner          0xF60000FF  //Level 6
#define Color_Global_Admin          0xF66E00FF  //Level 5
#define Color_Lead_Admin            0x0000F6FF  //Level 4
#define Color_Senior_Admin          0xF6F600FF  //Level 3
#define Color_Server_Admin          0xF600ABFF  //Level 2
#define Color_Trial_Admin           0x00F6F6FF  //Level 1
#define Color_RCON_Administrator  	0xF60000FF  //Rcon Admin
//=============================================================================================//
#define MAX_WARNINGS 3      // /warn command

#define MAX_REPORTS 7
#define MAX_CHAT_LINES 7

#define SPAM_MAX_MSGS 5
#define SPAM_TIMELIMIT 8 // SECONDS

#define PING_MAX_EXCEEDS 4
#define PING_TIMELIMIT 60 // SECONDS

#define MAX_FAIL_LOGINS 3

// Admin Area
new AdminArea[6] =
{
	377, 	// X
	170, 	// Y
	1008, 	// Z
	90,     // Angle
	3,      // Interior
	0		// Virtual World
};

//Anti_warn
new Anti_Warn[MAX_PLAYERS], Warn[MAX_PLAYERS];

//=================//
new PlayerText:IssuerTD, PlayerText:PlayerTD;
new PlayerTDt[MAX_PLAYERS], IssuerTDt[MAX_PLAYERS];
new PlayerTDvar[MAX_PLAYERS], IssuerTDvar[MAX_PLAYERS];

new assistkill[MAX_PLAYERS] = INVALID_PLAYER_ID;

//-=Main colours=-//
#define	mw_green 0x80C732FF
#define blue 0x375FFFFF
#define red 0xFF0000AA
#define green 0x00FF0033
#define yellow 0xFFFF00AA
#define grey 0xC0C0C0AA
#define blue1 0x2641FEAA
#define lightblue 0x33CCFFAA
#define orange 0xFF9900AA
#define black 0x2C2727AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_BLACK 0x000000AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREEN1 0x33AA33AA
#define COLOR_BROWN 0xA52A2AAA
#define WHITE 0xFFFFFFFF
#define COLOR_BLUE2  0x0015FFAA

new VID[MAX_PLAYERS];

// Caps
#define UpperToLower(%1) for ( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Spec
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2

// Enums
enum _:e_PLAYER_TICK_ENUM
{
	e_PLAYER_TICK,
	e_PLAYER_LAST_UPDATE
};

enum e_PLAYER_DATA
{
	e_PLAYER_FLAGS:e_bFlags
}

enum e_PLAYER_FLAGS (<<= 1)
{
	e_bUpdate = 1,
	e_bPaused
};

static
	s_aPlayerInfo[MAX_PLAYERS][e_PLAYER_DATA],
	s_aPlayerTickInfo[MAX_PLAYERS][e_PLAYER_TICK_ENUM];

enum PlayerData
{
	Registered,
	LoggedIn,
	Level,
	Tag,
	VIP,
	Muted,
	Caps,
	Jailed,
	JailTime,
	Frozen,
	FreezeTime,
	Money,
	Kills,
	Deaths,
	Headshots,
	hours,
	mins,
	secs,
	TotalTime,
	ConnectTime,
	MuteWarnings,
	Warnings,
	TimesSpawned,
	God,
	GodCar,
	DoorsLocked,
	SpamCount,
	SpamTime,
	PingCount,
	BotPing,
	pPing[PING_MAX_EXCEEDS],
	PingTime,
	pCar,
	SpecID,
	SpecType,
	OnDuty,
	Clock,
	Hide,
	bool:AllowedIn,
	FailLogin,
	pRegAch,
	pKillAch,
	pRankAch,
	pAssAch,
	pOwnAch,
	pHsAch,
	pPtAch,
	pAchs,
	BonusKills,
	Proto
};
new PlayerInfo[MAX_PLAYERS][PlayerData];
enum ServerData
{
	MaxPing,
	ReadPMs,
	ReadCmds,
	MaxAdminLevel,
	NameKick,
	PartNameKick,
	AntiSpam,
	AntiSwear,
	NoCaps,
	Password[128],
	ConnectMessages,
	AdminCmdMsg,
	AutoLogin,
	MaxMuteWarnings,
	DisableChat,
	AntiBot
};
new ServerInfo[ServerData];

#define JPACK	1
#define DHEALTH	2
#define DNOZ 	3
#define DAMO	4
#define DWEAP	5
#define DBOST	6
#define SWEAP	7
#define SARMOR	8
#define SHEALTH	9
#define SAMO	10
#define MAX_IDS	11
new BlockCMD[MAX_PLAYERS][MAX_IDS];

//Timers
new JailTimer[MAX_PLAYERS];
new FreezeTimer[MAX_PLAYERS];

public OnIncomingConnection( playerid, ip_address[ ], port )
{
	SendRconCommand( "reloadbans" );
}

// Menus
new Menu:LMainMenu, Menu:AdminEnable, Menu:AdminDisable,
	Menu:LVehicles, Menu:twodoor, Menu:fourdoor, Menu:fastcar, Menu:Othercars,
	Menu:bikes, Menu:boats, Menu:planes, Menu:helicopters,
	Menu:XWeapons, Menu:XWeaponsBig, Menu:XWeaponsSmall, Menu:XWeaponsMore,
	Menu:LWeather,Menu:LTime,
	Menu:LTuneMenu, Menu:PaintMenu, Menu:LCars, Menu:LCars2,
	Menu:LTele, Menu:LasVenturasMenu, Menu:LosSantosMenu, Menu:SanFierroMenu,
	Menu:DesertMenu, Menu:FlintMenu, Menu:MountChiliadMenu,	Menu:InteriorsMenu;

new RandomID = -1, RandomMoney, RandomScore, NoBonusPlayer = 1, BonusTimer;
new RandomCpID = -1, RandomCpMoney, RandomCpScore, NoBonusCp = 1, BonusCpTimer;

// Forbidden Names & Words
new BadNames[100][100], // Whole Names
	BadNameCount = 0,
	BadPartNames[100][100], // Part of name
	BadPartNameCount = 0,
	ForbiddenWords[100][100],
	ForbiddenWordCount = 0;

// Report
new Reports[MAX_REPORTS][128];

new VehicleNames[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
//==============================================================================
#define GREEN      0x80FF8096
#define RED       0xFF6347AA
#define BLUE      0x0015FFAA

#define COL_WHITE "{FFFFFF}"
#define COL_RED "{F81414}"
#define COL_GREEN "{00FF22}"
#define COL_LIGHTBLUE "{00CED1}"

forward SaveStats();

forward ACH__TEXTDRAWS(playerid);
public ACH__TEXTDRAWS(playerid)
{
	TextDrawHideForPlayer(playerid, AchTD2);
	TextDrawHideForPlayer(playerid, AchTD1);
	TextDrawHideForPlayer(playerid, AchTD0);
	PlayerTextDrawHide(playerid, AchTD3);
	PlayerTextDrawHide(playerid, AchTD4);
	PlayerTextDrawHide(playerid, AchTD5);
}

new Text3D:RankLabel[MAX_PLAYERS];
new gTeam[MAX_PLAYERS], gClass[MAX_PLAYERS], gRank[MAX_PLAYERS];
new GZ_USA, GZ_EUR, GZ_AUS, GZ_RUS, GZ_ARAB;
new SOV_SHOP, EUR_SHOP, ARAB_SHOP, AUS_SHOP, USA_SHOP, DA_SHOP;
new	Text:EUR, Text:A, Text:S, Text:U, Text:A2;
new Text:Web;
new Text:E;
new Streak[MAX_PLAYERS];
new Text:Star[10];
new PlayerText:StatsTD;

new
	//oCP[MAX_CP],
	//IsPlayerHelping[MAX_PLAYERS][MAX_CP],
	//UnderHelp[MAX_CP],
	UnderAttack[MAX_CP],
	CP[MAX_CP],
	Zone[MAX_CP],
	Captured[MAX_CP],
	timer[MAX_CP],
	CountVar[MAX_CP],
	Text:CountText[MAX_PLAYERS],
	IsPlayerCapturing[MAX_PLAYERS][MAX_CP],
	tCP[MAX_CP];

new PedPM[][] =
{
	"Hi",
	"According to MW4 I am worth $0",
	"I am a real person forced to do this",
	"Ali!... Ali!...",
	"Call of Duty Modern Warfare 4 is the best TDM server",
	"I entered your house at 3 AM",
	"Where's your wife?",
	"Want to become a bonus player?",
	"Babe, you want some? come get some!",
	"Thanks to my master AliScripter for making me!"
};

new RandomPed[][] =
{
	"{80C732}[PED] {FFFFFF} %s sent me a PM about being naughty",
	"{80C732}[PED] {FFFFFF} %s is that what your mother said?",
	"{80C732}[PED] {FFFFFF} %s sent me a PM about changing teams",
	"{80C732}[PED] {FFFFFF} %s forgot her girlfriend's name",
	"{80C732}[PED] {FFFFFF} My sibling is %s",
	"{80C732}[PED] {FFFFFF} %s is so sexy",
	"{80C732}[PED] {FFFFFF} I love %s",
	"{80C732}[PED] {FFFFFF} %s is my son"
};

new RandomMessages[][] =
{
	"{80C732}[PED}{FFFFFF} Welcome to the {80C732}Call of Duty : Modern Warfare 4!",
	"{80C732}[PED]{FFFFFF} Use {80C732}/pm [ID] [TEXT] {FFFFFF}To send messages to player!",
	"{80C732}[PED]{FFFFFF} Read {80C732}/objectives {FFFFFF}to see what are your objectives!",
	"{80C732}[PED]{FFFFFF} Kill all the enemies and capture zone to earn score and money!",
	"{80C732}[PED]{FFFFFF} Use {80C732}/updates {FFFFFF}to check the latest version updates of the server!",
	"{80C732}[PED]{FFFFFF} Need help? use {80C732}/helpme [TEXT] {FFFFFF}to ask from admins!",
	"{80C732}[PED]{FFFFFF} Are you new here? use {80C732}/help /cmds /rules",
	"{80C732}[PED]{FFFFFF} See our online admins using {80C732}/admins",
	"{80C732}[PED]{FFFFFF} Interested to be an admin? apply at our forums {80C732}http://siege-gaming.tk/",
	"{80C732}[PED]{FFFFFF} Use {80C732}/st {FFFFFF}to change your team and {80C732}/sc {FFFFFF}to change your class!",
	"{80C732}[PED]{FFFFFF} Donate to the server and get cool stuffs as rewards like {80C732}Donor status!",
	"{80C732}[PED]{FFFFFF} Donate us to keep the server alive! and get cool features as a reward!",
	"{80C732}[PED]{FFFFFF} Read /nukehelp to learn how to launch the nuclear bomb",
	"{80C732}[PED]{FFFFFF} Use {80C732}/savestats {FFFFFF}to save your stats!",
	"{80C732}[PED]{FFFFFF} Capture zones to earn score and cash!",
	"{80C732}[PED]{FFFFFF} Want to see the new updates? use {80C732}/updates",
	"{80C732}[PED]{FFFFFF} Want to keep an eye on the bonus? use {80C732}/bonus",
	"{80C732}[PED]{FFFFFF} Capture bonus capture zones to earn the bonus as well as the capturing score and cash",
	"{80C732}[PED]{FFFFFF} Kill bonus player to get the bonus and become a bonus player",
	"{80C732}[PED]{FFFFFF} Found a hacker or a cheater? use {80C732}/report [ID] [TEXT]",
	"{80C732}[PED]{FFFFFF} Add the server in your favorite list!",
	"{80C732}[PED]{FFFFFF} Launch Toxic and slow poison your enemies to death!"
};
//==============================================================================
main()
{
	print("\n-----------------------------------");
	print("• C A L L  O F  D U T Y •");
	print("• M O D E R N  W A R F A R E  4 •");
	print("-----------------------------------\n");
}

forward PedMessages();
public PedMessages()
{
	new Randomm[144];
	format(Randomm, sizeof(Randomm), RandomPed[random(sizeof(RandomPed))], pName(random(ConnectedPlayers())));
	SendClientMessageToAll(-1, Randomm);
}

public OnGameModeInit()
{
	SetTimer("Callback_TabCheck", 600, true);
	SetTimer("CheatBuster", 2000, true);
	BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	BonusTimer = SetTimer("BonusPlayer", 300000, 1);
	SetTimer("RandomMessage", 180000, 1);
	SetTimer("CountDown", 1000, 1);
	SetTimer("scoretimer", 1000, true);
	SetTimer("stats0", 30000, true);
	SetTimer("PedMessages", 180000, true);

	CreateActor(304, 1493.4077, 2773.5200, 10.8203, 272.3159);
	CreateDynamic3DTextLabel("[PED] (666)", 0x80C732FF, 1493.4077, 2773.5200, 12.00, 50.0);

	nuke_time = 138;
	//==========================================================================
	SetGameModeText("COD:MW4 v3.0 [TDM]");

//	SendRconCommand("hostname "SERVER_NAME);
	SendRconCommand("rcon_password "SERVER_RCON);
	SendRconCommand("mapname "SERVER_MAP);

	NoJP = 0; //No JetPack
	NoSpy = 0; //No Spy Disguising
	NoHS = 0; //No HeadShot
	HV = 1; //Heavy Vehicles

	EnableStuntBonusForAll(0); //Disables Stunt Bonus
	DisableNameTagLOS();//Name Tag(s) Not Visible Through Objects
	EnableVehicleFriendlyFire();//Players Can't Damage Their Team Vehicles

	//------Capture Zone Fix--------
	tCP[SNAKE] = tCP[BAY] = tCP[A51] = tCP[ARMY] = tCP[PETROL] =
	tCP[OIL] = tCP[DESERT] = tCP[QUARRY] = tCP[GUEST] = tCP[EAR] =
	tCP[DA] = tCP[AMMU] = tCP[DAM] = tCP[BELL] = tCP[RUSTY] = tCP[GHOST] =
	tCP[HOSP] = tCP[VILLA] = tCP[BIOSHIP] = tCP[CERBERUS] = TEAM_NONE;

	UnderAttack[SNAKE] = UnderAttack[BAY] = UnderAttack[A51] = UnderAttack[ARMY] =
	UnderAttack[PETROL] = UnderAttack[OIL] = UnderAttack[DESERT] = UnderAttack[QUARRY] =
	UnderAttack[GUEST] = UnderAttack[EAR] = UnderAttack[DA] = UnderAttack[AMMU] =
	UnderAttack[DAM] = UnderAttack[BELL] = UnderAttack[RUSTY] = UnderAttack[GHOST] =
	UnderAttack[HOSP] = UnderAttack[VILLA] = UnderAttack[BIOSHIP] = UnderAttack[CERBERUS] = 0;
	
	CountVar[SNAKE] = 25;
	CountVar[BAY] = 25;
	CountVar[A51] = 25;
	CountVar[PETROL] = 25;
	CountVar[ARMY] = 25;
	CountVar[DESERT] = 25;
	CountVar[OIL] = 25;
	CountVar[QUARRY] = 25;
	CountVar[GUEST] = 25;
	CountVar[EAR] = 25;
	CountVar[DA] = 25;
	CountVar[AMMU] = 25;
	CountVar[DAM] = 25;
	CountVar[BELL] = 25;
	CountVar[RUSTY] = 25;
	CountVar[GHOST] = 25;
	CountVar[HOSP] = 25;
	CountVar[VILLA] = 25;
	CountVar[BIOSHIP] = 25;
	CountVar[CERBERUS] = 25;

	//UnderHelp[SNAKE] = 0;

	AddPlayerClass(73,1110.1959,1909.0803,10.8203,5.0747,0,0,0,0,0,0); // EUR
	AddPlayerClass(179,-794.9099,1610.2480,29.7032,78.7860,0,0,0,0,0,0); // Arab
	AddPlayerClass(285,-136.0029,1115.9038,20.1966,3.7893,0,0,0,0,0,0); // Soviet
	AddPlayerClass(287,245.0012,1859.0973,14.0840,74.5591,0,0,0,0,0,0); //USA
	AddPlayerClass(206,405.5110,2451.0649,16.5000,0.2366,0,0,0,0,0,0); // AUSTRALIA

	USApro = AddStaticVehicleEx(609, -265.5686, 2763.1890, 62.1100, 201.9698, 125, 125, 20, 0);
	EURpro = AddStaticVehicleEx(609, 1007.1574, 2080.1897, 10.7385, 1.0432, 243, 243, 20, 0);
	ARBpro = AddStaticVehicleEx(609, -767.6420, 1590.0304, 27.1558, 180.9541, 221, 221, 20, 0);
	SOVpro = AddStaticVehicleEx(609, -103.2125, 1140.5035, 19.5315, 89.5123, 181, 181, 20, 0);
	AUSpro = AddStaticVehicleEx(609, -1476.1321, 2691.6541, 55.7595, 179.3407, 211, 211, 20, 0);

	CreateDynamic3DTextLabel("USA's prototype", TEAM_USA_COLOR, 0.0, 0.0, 2.0, 50.0, INVALID_PLAYER_ID, USApro);
	CreateDynamic3DTextLabel("Australia's prototype", TEAM_AUS_COLOR, 0.0, 0.0, 2.0, 50.0, INVALID_PLAYER_ID, AUSpro);
	CreateDynamic3DTextLabel("Arabia's protoype", TEAM_ARAB_COLOR, 0.0, 0.0, 2.0, 50.0, INVALID_PLAYER_ID, ARBpro);
	CreateDynamic3DTextLabel("Soviet's Prototype", TEAM_SOVIET_COLOR, 0.0, 0.0, 2.0, 50.0, INVALID_PLAYER_ID, SOVpro);
	CreateDynamic3DTextLabel("Europe's Prototype", TEAM_EUROPE_COLOR, 0.0, 0.0, 2.0, 50.0, INVALID_PLAYER_ID, EURpro);

	//Mapping Of Places
	//USA Spawn Point 3D Text Labels
	CreateDynamic3DTextLabel("Spawn Point", TEAM_USA_COLOR, -250.4555, 2595.8433, 62.8582, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_USA_COLOR, -231.0395, 2651.1475, 62.8003, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_USA_COLOR, -282.5961, 2729.2774, 62.1439, 15.0);
	//Australia Spawn Point 3D Text Labels
	CreateDynamic3DTextLabel("Spawn Point", TEAM_AUS_COLOR, -1466.3636, 2613.2705, 56.0449, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_AUS_COLOR, -1531.18,2536.12,55.700000762939, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_AUS_COLOR, -1413.17,2613.4,55.799999237061, 15.0);
	//Soviet Spawn Point 3D Text Labels
	CreateDynamic3DTextLabel("Spawn Point", TEAM_SOVIET_COLOR, -136.1105, 1116.5667, 20.1966, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_SOVIET_COLOR, -168.05872, 1140.72095, 19.78535, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_SOVIET_COLOR, -20.9232, 1120.6238, 19.8900, 15.0);
	//Arab Spawn Point 3D Text Labels
	CreateDynamic3DTextLabel("Spawn Point", TEAM_ARAB_COLOR, -754.8708, 1590.7395, 26.9609, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_ARAB_COLOR, -729.4348, 1538.6104, 40.4290, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_ARAB_COLOR, -799.0009, 1551.8523, 27.1172, 15.0);
	//Europe Spawn Point 3D Text Labels
	CreateDynamic3DTextLabel("Spawn Point", TEAM_EUROPE_COLOR, 981.1255, 2096.9294, 11.5718, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_EUROPE_COLOR, 862.3610, 2139.2190, 11.0434, 15.0);
	CreateDynamic3DTextLabel("Spawn Point", TEAM_EUROPE_COLOR, 936.8976, 2222.6548, 10.2274, 15.0);
	//Snake Farm Capture Point
	CreateDynamic3DTextLabel("Snake Farm", 0xFF0000FF, -36.5458, 2347.6582, 24.1406, 15.0);
	CreateDynamicPickup(1313, 1, -36.5458, 2347.6426, 24.1406, -1);
	//Area 51 Capture Point
	CreateDynamic3DTextLabel("Area 51", 0xFF0000FF, 268.2260, 1840.4688, 6.6811, 15.0);
	CreateDynamicPickup(1313, 1, 268.2260, 1840.4688, 6.6811, -1);
	//Army Petrol Bunk Station
	CreateDynamic3DTextLabel("Army Petrol Bunk Station", 0xFF0000FF, 670.6852, 1705.2517, 7.1875, 15.0);
	CreateDynamicPickup(1313, 1, 670.6852, 1705.2517, 7.1875, -1);
	//Big Ear
	CreateDynamic3DTextLabel("Big Ear", 0xFF0000FF, -310.9840, 1542.7245, 75.5625, 15.0);
	CreateDynamicPickup(1313, 1, -310.9840,1542.7245,75.5625, -1);
	//Quarry
	CreateDynamic3DTextLabel("Quarry", 0xFF0000FF, 588.2737, 875.7513, -42.4973, 15.0);
	CreateDynamicPickup(1313, 1, 588.2737, 875.7513, -42.4973, -1);
	//Army Restaurant
	CreateDynamic3DTextLabel("Army Restaurant", 0xFF0000FF, -551.8180, 2592.9917, 53.9348, 15.0);
	CreateDynamicPickup(1313, 1, -551.8180, 2592.9917, 53.9348, -1);
	//Army Guest House
	CreateDynamic3DTextLabel("Army Guest House", 0xFF0000FF, -314.8788, 1774.1290, 43.6406, 15.0);
	CreateDynamicPickup(1313, 1, -314.8788, 1774.1290, 43.6406, -1);
	//Bay
	CreateDynamic3DTextLabel("Bay", 0xFF0000FF, 259.8966, 2889.2363, 11.2749, 15.0);
	CreateDynamicPickup(1313, 1, 259.8966,2889.2363,11.2749, -1);
	//Oil Factory
	CreateDynamic3DTextLabel("Oil Factory", 0xFF0000FF, 221.0622, 1422.8483, 10.5859, 15.0);
	CreateDynamicPickup(1313, 1, 221.0622, 1422.8483, 10.5859, -1);
	//Gas Factory
	CreateDynamic3DTextLabel("Gas Factory", 0xFF0000FF, 558.7666, 1222.0099, 11.7188, 15.0);
	CreateDynamicPickup(1313, 1, 558.7666, 1222.0099, 11.7188, -1);
	//Sherman Dam
	CreateDynamic3DTextLabel("Sherman Dam", 0xFF0000FF, -734.4286, 2046.0637, 60.3906, 15.0);
	CreateDynamicPickup(1313, 1, -734.4286, 2046.0637, 60.3906, -1);
	//Clucking Bell
	CreateDynamic3DTextLabel("Clucking Bell", 0xFF0000FF, -1196.2545, 1812.6115, 41.8603, 15.0);
	CreateDynamicPickup(1313, 1, -1196.2545, 1812.6115, 41.8603, -1);
	//Rusty Bridge
	CreateDynamic3DTextLabel("Rusty Bridge", 0xFF0000FF, -913.6018, 2685.6521, 42.3703, 15.0);
	CreateDynamicPickup(1313, 1, -913.6018, 2685.6521, 42.3703, -1);
	//Ghost Town
	CreateDynamic3DTextLabel("Ghost Town", 0xFF0000FF, -379.5280,2218.7539,42.0938, 15.0);
	CreateDynamicPickup(1313, 1, -379.5280,2218.7539,42.0938, -1);
	//Hospital Capture Point
	CreateDynamic3DTextLabel("Hospital", 0xFF0000FF, 1048.2388,1009.2777,11.0000, 15.0);
	CreateDynamicPickup(1313, 1, 1048.2388,1009.2777,11.0000, -1);
	//Ammunation
	CreateDynamic3DTextLabel("Ammunation", 0xFF0000FF, 796.8186,1684.1398,5.2813, 15.0);
	CreateDynamicPickup(1313, 1, 796.8186,1684.1398,5.2813, -1);
	//Desert Airport
	CreateDynamic3DTextLabel("Desert Airport", 0xFF0000FF, 406.2509, 2460.2515, 15.9202, 15.0);
	CreateDynamicPickup(1313, 1, 406.2509, 2460.2515, 15.9202);
//================================================================================================
	//Cerberus Island
	CreateDynamicObject(5176, -2369.20361, 1754.78711, 15.70468,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(5146, -2392.65283, 1951.50464, -0.03295,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(5145, -2174.24927, 1911.64429, 0.31585,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(17001, -2309.52759, 1988.06372, 10.48938,   0.00000, 0.00000, -44.28001);
	CreateDynamicObject(9587, -2457.75024, 1928.65710, 17.82823,   0.00000, 0.00000, 45.00002);
	CreateDynamicObject(16613, -2353.99292, 1924.97498, 15.71807,   0.00000, 0.00000, 134.87996);
	CreateDynamicObject(9245, -2396.92725, 1677.20935, 22.07589,   0.00000, 0.00000, -179.27995);
	CreateDynamicObject(3491, -2461.30005, 1837.79822, 18.03796,   0.00000, 0.00000, 1.02000);
	CreateDynamicObject(10763, -2123.41016, 1828.24561, 42.06064,   0.00000, 0.00000, -404.03986);
	CreateDynamicObject(17013, -2239.30713, 1997.03662, 19.71762,   0.00000, 0.00000, 90.17999);
	CreateDynamicObject(17013, -2191.97437, 1997.65527, 19.71762,   0.00000, 0.00000, 90.17999);
	CreateDynamicObject(3643, -2206.85498, 1979.61304, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2179.55786, 1980.13245, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2186.85962, 1980.01355, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2193.63745, 1980.18726, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2200.31470, 1979.56775, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2222.89063, 1979.28772, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2230.55151, 1979.20740, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2238.25244, 1979.04944, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2244.87109, 1979.39172, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, -2252.15332, 1979.25610, 16.49170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(17014, -2106.74072, 1952.12939, 21.51491,   0.00000, 0.00000, -271.91995);
	CreateDynamicObject(3267, -2378.73267, 1697.97302, 23.54340,   0.00000, 0.00000, 27.24000);
	CreateDynamicObject(3267, -2374.35815, 1701.27124, 23.54340,   0.00000, 0.00000, 47.04000);
	CreateDynamicObject(3267, -2373.57544, 1706.43103, 23.54340,   0.00000, 0.00000, 95.64001);
	CreateDynamicObject(3267, -2375.48560, 1711.14746, 23.54340,   0.00000, 0.00000, 125.21999);
	CreateDynamicObject(3267, -2380.10156, 1713.56274, 23.54340,   0.00000, 0.00000, 164.88000);
	CreateDynamicObject(3267, -2385.35303, 1712.56274, 23.54340,   0.00000, 0.00000, 210.11986);
	CreateDynamicObject(3267, -2389.01123, 1708.74438, 23.54340,   0.00000, 0.00000, 244.31975);
	CreateDynamicObject(3267, -2389.53320, 1704.20117, 23.54340,   0.00000, 0.00000, 269.51978);
	CreateDynamicObject(3267, -2387.53760, 1699.99353, 23.54340,   0.00000, 0.00000, 310.43951);
	CreateDynamicObject(3267, -2383.51782, 1697.67603, 23.54340,   0.00000, 0.00000, 339.41956);
	CreateDynamicObject(3277, -2381.39868, 1705.48352, 24.27414,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3884, -2381.05151, 1705.55786, 24.33851,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18450, -2556.63965, 1698.25500, 10.29185,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18805, -2666.86816, 1698.13037, -13.89014,   2.69999, -18.54000, 1.08000);
	CreateVehicle(476, -2446.0701, 1843.2094, 12.5323, -204.9600, -1, -1, 100);
	CreateVehicle(476, -2460.5146, 1848.9165, 12.5323, -184.4401, -1, -1, 100);
	CreateVehicle(476, -2475.0994, 1840.7445, 12.5323, -157.7401, -1, -1, 100);
	CreateVehicle(487, -2380.1274, 1734.3696, 11.7843, 87.9000, -1, -1, 100);
	CreateVehicle(487, -2379.9358, 1756.7943, 11.7843, 87.9000, -1, -1, 100);
	CreateVehicle(432, -2350.2095, 1802.9780, 11.4517, 90.6000, -1, -1, 100);
	CreateVehicle(432, -2350.8013, 1814.8828, 11.4517, 90.6000, -1, -1, 100);
	CreateVehicle(432, -2351.2703, 1826.7139, 11.4517, 90.6000, -1, -1, 100);
	CreateVehicle(425, -2206.2927, 1824.3674, 12.3144, 0.0000, -1, -1, 100);
	CreateVehicle(425, -2183.9021, 1824.7830, 12.4530, 0.0000, -1, -1, 100);
	CreateVehicle(520, -2428.7822, 1698.8672, 12.2871, 91.3200, -1, -1, 100);
	CreateVehicle(520, -2460.6890, 1698.6013, 12.2871, 89.7600, -1, -1, 100);
	CreateVehicle(520, -2490.1377, 1698.7437, 12.2871, 89.0400, -1, -1, 100);
	//Biological Ship
	CreateDynamicObject(10793, -594.80383, 784.89392, 33.36267,   0.00000, 0.00000, 70.43999);
	CreateDynamicObject(10794, -569.17340, 855.73889, 4.75376,   0.00000, 0.00000, 70.38000);
	CreateDynamicObject(10795, -569.80286, 853.35065, 14.89623,   0.00000, 0.00000, -289.80002);
	CreateDynamicObject(5710, -575.78912, 826.14331, 17.76789,   0.00000, 0.00000, 161.52002);
	CreateDynamicObject(3277, -577.19275, 809.40607, 20.19106,   0.00000, 0.00000, 52.86000);
	CreateDynamicObject(3277, -566.80658, 840.39984, 20.19106,   0.00000, 0.00000, 52.86000);
	CreateDynamicObject(3277, -572.06140, 824.96802, 23.93769,   0.00000, 0.00000, 52.86000);
	CreateDynamicObject(3884, -572.34039, 825.12500, 23.93153,   0.00000, 0.00000, 74.99998);
	CreateDynamicObject(3884, -577.27692, 809.55499, 20.26288,   0.00000, 0.00000, 74.99998);
	CreateDynamicObject(3884, -566.58557, 840.68707, 20.26288,   0.00000, 0.00000, 74.99998);
	CreateDynamicObject(2977, -571.91437, 846.91022, 13.98220,   0.00000, 0.00000, -18.84000);
	CreateDynamicObject(2977, -572.18335, 845.73651, 13.98220,   0.00000, 0.00000, -18.84000);
	CreateDynamicObject(2977, -572.55951, 844.55518, 13.98220,   0.00000, 0.00000, -18.84000);
	CreateDynamicObject(2977, -573.67999, 845.58362, 13.98220,   0.00000, 0.00000, 7.91999);
	CreateDynamicObject(2977, -573.27435, 846.92346, 13.98220,   0.00000, 0.00000, 7.91999);
	CreateDynamicObject(4261, -2286.26123, 1884.93127, -83.25000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9818, -568.13208, 821.98083, 15.51628,   0.00000, 0.00000, -18.72001);
	CreateDynamicObject(9819, -570.93390, 830.66638, 15.10566,   0.00000, 0.00000, 71.82000);
	CreateDynamicObject(9822, -570.55853, 829.96356, 14.85785,   0.00000, 0.00000, 68.99999);
	CreateDynamicObject(3383, -575.41650, 814.39453, 14.12177,   0.00000, 0.00000, -18.53999);
	// Nuke Town - Ghost Town
	CreateDynamicObject(3790, -376.57916, 2232.76270, 41.62875,   -183.00000, -4.00000, 254.15894);
	CreateDynamicObject(12912, -366.49802, 2238.53174, 51.79762,   0.00000, 0.00000, 337.09381);
	CreateDynamicObject(3790, -374.71259, 2232.62524, 41.62875,   -183.00000, -4.00000, 231.92529);
	CreateDynamicObject(3786, -380.90567, 2249.69629, 41.45154,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3786, -391.63730, 2244.36768, 41.55618,   0.00000, 0.00000, 98.49622);
	CreateDynamicObject(3885, -394.20905, 2236.08105, 41.41748,   0.00000, 0.00000, 79.36277);
	CreateVehicle(470, -391.0247, 2221.0498, 42.2482, 283.6963, -1, -1, 100);
	CreateVehicle(468, -390.7603, 2252.1926, 41.8770, 254.3734, -1, -1, 100);
	CreateVehicle(468, -390.3630, 2250.1436, 41.8770, 254.3734, -1, -1, 100);
	CreateVehicle(468, -388.0593, 2250.9055, 41.8770, 254.3734, -1, -1, 100);
	// Guest House :P
	CreateVehicle(468, -320.7497, 1775.7352, 42.9918, 184.5445, -1, -1, 100);
	CreateVehicle(468, -320.0461, 1746.8706, 42.9918, 184.5445, -1, -1, 100);
	CreateVehicle(468, -314.7135, 1760.7920, 42.9918, 211.0014, -1, -1, 100);
	CreateVehicle(468, -322.2974, 1751.5924, 42.9918, 184.5445, -1, -1, 100);
	CreateVehicle(470, -293.7844, 1773.3519, 42.5877, 179.7492, -1, -1, 100);
	CreateVehicle(470, -299.8454, 1761.7089, 42.5877, 179.7492, -1, -1, 100);
	CreateVehicle(470, -294.4633, 1750.9353, 42.5877, 179.7492, -1, -1, 100);
	//Big Ear :P ( of an asshole)
	CreateVehicle(520, -300.6631, 1567.1815, 77.0025, 227.5027, -1, -1, 100);
	CreateVehicle(468, -336.7701, 1514.0211, 75.1638, 0.0000, -1, -1, 100);
	CreateVehicle(468, -330.0928, 1514.0988, 75.1638, 0.0000, -1, -1, 100);
	CreateVehicle(468, -323.8885, 1513.8309, 75.1638, 0.0000, -1, -1, 100);
	CreateVehicle(468, -317.8167, 1513.2708, 75.1638, 0.0000, -1, -1, 100);
	CreateVehicle(470, -286.2921, 1520.0803, 75.4926, 313.5168, -1, -1, 100);
	CreateVehicle(470, -266.1744, 1541.5217, 75.4926, 313.5168, -1, -1, 100);
	//OIL station
	CreateVehicle(470, 284.8827, 1373.0686, 11.9390, 0.0000, -1, -1, 100);
	CreateVehicle(470, 284.8084, 1364.9218, 11.9390, 0.0000, -1, -1, 100);
	CreateVehicle(470, 284.7234, 1357.9043, 11.9390, 0.0000, -1, -1, 100);
	CreateVehicle(470, 284.7233, 1351.0990, 11.9390, 0.0000, -1, -1, 100);
	CreateVehicle(468, 285.4933, 1469.9810, 10.6622, 0.0000, -1, -1, 100);
	CreateVehicle(468, 285.5680, 1464.4160, 10.6622, 0.0000, -1, -1, 100);
	CreateVehicle(468, 285.8524, 1459.7058, 10.6622, 0.0000, -1, -1, 100);
	CreateVehicle(468, 285.8455, 1455.1455, 10.6622, 0.0000, -1, -1, 100);
	//Stadium - make CP here
	CreateDynamicObject(3885, 1394.06885, 2175.69531, 13.24051,   0.00000, 0.00000, 199.79330);
	CreateDynamicObject(3885, 1393.98364, 2160.73926, 13.24051,   0.00000, 0.00000, 312.53333);
	CreateDynamicObject(648, 1374.67017, 2091.75659, 7.40140,   0.00000, 0.00000, 273.31625);
	CreateDynamicObject(647, 1364.62805, 2086.49731, 14.09375,   356.85840, 0.00000, -1.57080);
	CreateDynamicObject(648, 1365.99561, 2084.71606, 1.07346,   0.00000, 0.00000, 0.00000);
	CreateVehicle(417, 1318.4817, 2179.4961, 12.1105, 0.0000, -1, -1, 100);
	CreateVehicle(417, 1375.9703, 2120.1199, 12.1105, 0.0000, -1, -1, 100);
	// army bunk station
	CreateVehicle(487, 664.7897, 1711.3900, 11.4782, 310.0412, -1, -1, 100);
	CreateVehicle(468, 669.3885, 1729.0461, 6.8951, 38.3221, -1, -1, 100);
	CreateVehicle(468, 664.8236, 1725.5425, 7.2032, 39.1383, -1, -1, 100);
	CreateVehicle(468, 660.4525, 1722.2104, 7.2032, 39.1383, -1, -1, 100);
	CreateVehicle(470, 656.1017, 1719.2048, 6.8959, 40.3775, -1, -1, 100);
	CreateVehicle(433, 649.7375, 1701.2573, 7.4924, 42.5829, -1, -1, 100);
	// gas station
	CreateVehicle(470, 566.7261, 1215.3635, 11.8037, 122.1726, -1, -1, 100);
	CreateVehicle(468, 561.7738, 1210.7732, 12.2646, 203.8622, -1, -1, 100);
	CreateVehicle(468, 560.6862, 1208.8762, 12.2646, 203.8622, -1, -1, 100);
	CreateVehicle(468, 557.1527, 1206.7543, 12.2646, 203.8622, -1, -1, 100);
	CreateVehicle(468, 554.8898, 1207.8569, 12.2646, 203.8622, -1, -1, 100);
	CreateVehicle(470, 542.2739, 1216.3276, 11.8037, 122.1726, -1, -1, 100);
	// Bay
	CreateVehicle(468, 260.9373, 2888.8894, 11.2945, 0.0000, -1, -1, 100);
	CreateVehicle(468, 262.2087, 2887.0876, 11.2945, 0.0000, -1, -1, 100);
	CreateVehicle(468, 259.8027, 2890.7195, 11.2945, 0.0000, -1, -1, 100);
	CreateVehicle(470, 266.5404, 2887.3628, 11.3912, 160.4489, -1, -1, 100);
	// snake farms
	CreateVehicle(470, -15.4302, 2349.7231, 23.7664, 356.1345, -1, -1, 100);
	CreateVehicle(468, -27.1876, 2326.5630, 23.9238, 0.0000, -1, -1, 100);
	CreateVehicle(468, -25.6551, 2326.9099, 23.9238, 0.0000, -1, -1, 100);
	CreateVehicle(468, -24.2954, 2326.7109, 23.9238, 0.0000, -1, -1, 100);
	CreateVehicle(468, -22.6145, 2326.8674, 23.9238, 0.0000, -1, -1, 100);
	CreateVehicle(470, -45.5655, 2351.7100, 23.7664, 356.1345, -1, -1, 100);
	// army restaurant
	CreateVehicle(468, -520.0598, 2603.9929, 53.4211, 91.8998, -1, -1, 100);
	CreateVehicle(468, -520.0768, 2606.5547, 53.6324, 91.8998, -1, -1, 100);
	CreateVehicle(468, -527.1131, 2605.7522, 53.2078, 91.8998, -1, -1, 100);
	CreateVehicle(468, -527.0217, 2603.6023, 53.3139, 91.8998, -1, -1, 100);
	CreateVehicle(470, -520.4738, 2581.1450, 53.4151, 359.3848, -1, -1, 100);
	CreateVehicle(470, -527.3320, 2580.9165, 53.4151, 359.3848, -1, -1, 100);
	CreateVehicle(470, -527.5049, 2572.9612, 53.4151, 359.3848, -1, -1, 100);
	CreateVehicle(470, -520.9061, 2572.4055, 53.4151, 359.3848, -1, -1, 100);
	//quarry
	CreateVehicle(470, 595.8420, 862.0395, -43.1711, 0.0000, -1, -1, 100);
	CreateVehicle(470, 588.9088, 842.5851, -42.9692, 0.0000, -1, -1, 100);
	CreateVehicle(469, 593.8835, 889.5137, -43.9164, 252.4333, -1, -1, 100);
	CreateVehicle(468, 608.0418, 875.4783, -43.2833, 0.0000, -1, -1, 100);
	CreateVehicle(468, 609.0245, 876.8594, -43.2833, 0.0000, -1, -1, 100);
	CreateVehicle(468, 607.0766, 877.9346, -42.9803, 0.0000, -1, -1, 100);
	//sherman dam
	CreateVehicle(468, -728.6404, 2059.7983, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -726.6606, 2059.7341, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -724.2715, 2060.2502, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -721.6778, 2060.3462, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -680.8513, 2062.0872, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -678.0120, 2062.1025, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -675.4951, 2061.8188, 60.8058, 0.9369, -1, -1, 100);
	CreateVehicle(468, -672.3016, 2061.8445, 60.8058, 0.9369, -1, -1, 100);
	//===================Maze Event Map===
	CreateDynamicObject(7996, 878.68817, 1419.35388, 1019.01624,   180.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 858.17200, 1440.96997, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 868.66431, 1421.70471, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 858.17200, 1421.70471, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 826.67712, 1421.70471, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 847.67780, 1431.33606, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 847.67780, 1402.43970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 837.17688, 1421.70471, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 837.17688, 1440.96997, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 847.67780, 1440.96997, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 826.67712, 1440.96997, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 868.66431, 1440.96997, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 847.67780, 1421.70471, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 847.67780, 1412.06970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 837.17688, 1402.43970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 826.67712, 1402.43970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 858.17200, 1402.43970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 868.66431, 1402.43970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 826.67712, 1412.06970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 826.67712, 1431.33606, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 868.66431, 1431.33606, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 868.66431, 1412.06970, 1013.68079,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1399.22876, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1444.18115, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1434.54736, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 842.33752, 1402.43494, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1437.75720, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1428.12585, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 842.33752, 1440.96814, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1424.91479, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1418.49231, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1415.28101, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1408.85925, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 842.33752, 1421.70276, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1408.85925, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1405.64856, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 853.01752, 1402.43494, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1399.23279, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1415.28101, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1418.49231, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 853.01752, 1421.70276, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1424.91479, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1428.12585, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1434.54736, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1437.75720, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 853.01752, 1440.96814, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1444.18115, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 853.01752, 1399.22876, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1405.64856, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1408.85925, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1415.28101, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1418.49231, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1424.91479, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1428.12585, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1434.54736, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1437.75720, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 874.00269, 1444.18115, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1399.22876, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1405.64856, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1408.85925, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1415.28101, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1418.49231, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1424.91479, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1428.12585, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1434.54736, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1437.75720, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 821.33643, 1444.18115, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1405.64856, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 842.33752, 1408.85925, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1405.64856, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 832.01593, 1402.45496, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1399.22876, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1415.28101, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1418.49231, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1424.91479, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1428.12585, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1434.54736, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1437.75720, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 832.01691, 1440.96814, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 832.01691, 1444.18115, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 832.01691, 1421.70276, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 832.01691, 1431.33704, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 868.62311, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 853.01752, 1408.85925, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1399.22876, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 863.32428, 1402.43494, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1405.64856, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 863.32428, 1412.07043, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1415.28101, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1418.49231, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 863.32428, 1421.70276, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1424.91479, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1428.12585, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1434.54736, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1437.75720, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 863.32428, 1440.96814, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 863.32428, 1444.18115, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 863.32428, 1431.33704, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 832.01691, 1412.07043, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 820.21649, 1407.34717, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 875.04163, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 834.20801, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 829.38483, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 826.63623, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 823.42621, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 830.99847, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 837.42188, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 845.03168, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 844.00659, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 850.94690, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 847.73291, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 855.24060, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 854.14429, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 861.66132, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 865.94427, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 858.45068, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 863.80298, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 871.82928, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 840.63409, 1407.35120, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 837.42188, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 834.20801, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 830.99847, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 829.38483, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 826.63623, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 823.42621, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 820.21649, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 844.00659, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 845.03168, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 847.73291, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 850.94690, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 854.14429, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 855.24060, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 858.45068, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 861.66132, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 863.80298, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 865.94427, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 868.62311, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 871.82928, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 875.04163, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 840.63409, 1416.81067, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 837.42188, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 834.20801, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 830.99847, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 829.38483, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 826.63623, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 823.42621, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 820.21649, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 847.73291, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 844.00659, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 845.03168, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 850.94690, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 854.14429, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 855.24060, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 858.45068, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 861.66132, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 863.80298, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 865.94427, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 868.62311, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 871.82928, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 875.04163, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 840.63409, 1426.59473, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 837.42188, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 834.20801, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 840.63409, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 844.00659, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 845.03168, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 847.73291, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 850.94690, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 830.99847, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 829.38483, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 826.63623, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 823.42621, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 820.21649, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 854.14429, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 858.45068, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 855.24060, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 861.66132, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 863.80298, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 865.94427, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 868.62311, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 871.82928, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 875.04163, 1436.07898, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 821.33643, 1421.70276, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 821.33643, 1412.07043, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 821.33643, 1402.43494, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 821.33643, 1431.33704, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 821.33643, 1440.96814, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 874.00269, 1421.70276, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 874.00269, 1440.96814, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 874.00269, 1431.33704, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 874.00269, 1412.07043, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 874.00269, 1402.43494, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 842.33752, 1431.33704, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 842.33752, 1412.07043, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 853.01752, 1412.07043, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 853.01752, 1431.33704, 1015.47412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 836.64130, 1407.35168, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 846.95068, 1407.35168, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 857.68372, 1407.35168, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 867.83447, 1407.35168, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 825.85242, 1407.35168, 1013.71948,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 825.85242, 1416.81458, 1013.71948,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 825.85242, 1426.59119, 1013.71948,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 825.85242, 1436.08264, 1013.71948,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 836.64130, 1416.81458, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 846.95068, 1416.81458, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 857.68372, 1416.81458, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 867.83447, 1416.81458, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 836.64130, 1426.59119, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 846.95068, 1426.59119, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 857.68372, 1426.59119, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 867.83447, 1426.59119, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 836.64130, 1436.08264, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 846.95068, 1436.08264, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 857.68372, 1436.08264, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 867.83447, 1436.08264, 1013.74353,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 821.34222, 1403.21973, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 873.97467, 1441.74780, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 873.97467, 1432.11646, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 873.97467, 1422.47705, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 873.97467, 1412.85596, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 873.97467, 1403.21973, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 863.29669, 1403.21973, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 852.98853, 1403.21973, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 842.30780, 1403.21973, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 831.98767, 1403.21973, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 863.29669, 1412.85596, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 863.29669, 1422.47705, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 863.29669, 1432.11646, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 863.29669, 1441.74780, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 852.98853, 1412.85596, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 852.98853, 1422.47705, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 852.98853, 1432.11646, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 852.98853, 1441.74780, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 842.30780, 1412.85596, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 842.30780, 1422.47705, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 842.30780, 1432.11646, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 842.30780, 1441.74780, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 831.98767, 1412.85596, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 831.98767, 1422.47705, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 831.98767, 1432.11646, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 831.98767, 1441.74780, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 821.34222, 1412.85596, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 821.34222, 1422.47705, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 821.34222, 1432.11646, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1491, 821.34222, 1441.74780, 1013.74353,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(8553, 818.66980, 1417.33923, 1023.54407,   -90.00000, 0.00000, 268.05807);
	CreateDynamicObject(8553, 848.01184, 1395.08997, 1023.92102,   -90.00000, 0.00000, 0.00000);
	CreateDynamicObject(8553, 849.29877, 1447.35193, 1023.65369,   -90.00000, 0.00000, 180.00000);
	CreateDynamicObject(8553, 876.45947, 1423.69397, 1023.44312,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(7416, 851.25385, 1437.46472, 1004.39014,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11458, 829.83630, 1438.57239, 1004.38531,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11457, 829.13367, 1421.00867, 1004.38959,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11445, 828.51532, 1399.04822, 1004.38739,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11443, 851.79163, 1440.12634, 1004.38184,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11442, 866.30493, 1431.71765, 1004.38647,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11441, 837.72632, 1424.91028, 1004.38593,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11440, 866.04749, 1411.96887, 1004.38727,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11426, 862.00922, 1442.84216, 1004.38367,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11445, 864.47882, 1401.48035, 1004.38739,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11442, 841.01550, 1437.06152, 1004.38647,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11457, 849.13306, 1425.62109, 1004.38959,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11442, 842.72784, 1404.00549, 1004.38647,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19446, 869.20734, 1445.77393, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 859.58270, 1445.77942, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 849.94873, 1445.77686, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 840.30908, 1445.78259, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 830.68561, 1445.78442, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 821.04358, 1445.83643, 1015.47412,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 826.17957, 1397.58826, 1015.51031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 835.80035, 1397.58850, 1015.51031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 845.43488, 1397.59351, 1015.51031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 855.04047, 1397.59424, 1015.51031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 864.67993, 1397.58411, 1015.51031,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19446, 874.28406, 1397.58594, 1015.51031,   0.00000, 0.00000, 90.00000);
	//===================Minigun Map===
	CreateDynamicObject(12814, 3077.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8149, 3091.60010, -5209.20020, 21.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8149, 3163.39990, -5130.20020, 21.90000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(8149, 3170.60010, -5281.00000, 21.90000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8149, 3242.39990, -5202.00000, 21.90000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3107.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3137.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3167.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3197.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3227.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3257.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3107.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3107.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3107.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3107.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3137.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3167.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3197.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3227.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3257.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3167.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3197.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3227.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3257.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3137.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3167.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3197.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3227.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3257.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3137.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3167.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3197.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3227.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3257.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16113, 3248.00000, -5098.70020, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16113, 3214.39990, -5091.20020, 17.20000,   0.00000, 0.00000, 212.00000);
	CreateDynamicObject(16113, 3305.80005, -5250.70020, 25.30000,   0.00000, 0.00000, 122.00000);
	CreateDynamicObject(16113, 3159.00000, -5093.10010, 17.20000,   0.00000, 0.00000, 212.00000);
	CreateDynamicObject(16113, 3119.30005, -5100.00000, 17.20000,   0.00000, 0.00000, 22.00000);
	CreateDynamicObject(16113, 3079.20010, -5107.00000, 17.20000,   0.00000, 0.00000, 63.99000);
	CreateDynamicObject(16113, 3061.19995, -5131.70020, 17.20000,   0.00000, 0.00000, 309.98999);
	CreateDynamicObject(16116, 3062.80005, -5178.70020, 17.70000,   0.00000, 0.00000, 312.00000);
	CreateDynamicObject(16116, 3059.30005, -5221.00000, 17.70000,   0.00000, 0.00000, 312.00000);
	CreateDynamicObject(16116, 3071.80005, -5271.29980, 12.70000,   0.00000, 0.00000, 130.00000);
	CreateDynamicObject(16116, 3075.89990, -5301.10010, 17.70000,   0.00000, 0.00000, 355.98999);
	CreateDynamicObject(866, 3088.10010, -5243.00000, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(866, 3087.80005, -5240.29980, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16206, 3102.10010, -5398.79980, 65.10000,   0.00000, 0.00000, 248.00000);
	CreateDynamicObject(16206, 3182.69995, -5396.60010, 78.40000,   0.00000, 0.00000, 248.00000);
	CreateDynamicObject(16116, 3106.10010, -5313.10010, 17.70000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(16116, 3146.89990, -5309.00000, 17.70000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(16116, 3180.19995, -5305.20020, 17.70000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(16116, 3222.60010, -5306.50000, 17.70000,   0.00000, 0.00000, 43.99000);
	CreateDynamicObject(16258, 3285.50000, -5240.70020, 61.00000,   0.00000, 0.00000, 96.00000);
	CreateDynamicObject(16097, 3336.00000, -5134.89990, 36.40000,   0.00000, 0.00000, 40.00000);
	CreateDynamicObject(16113, 3259.60010, -5115.79980, 18.90000,   0.00000, 0.00000, 94.00000);
	CreateDynamicObject(16113, 3195.69995, -5093.70020, 17.20000,   0.00000, 0.00000, 212.00000);
	CreateDynamicObject(16113, 3309.00000, -5219.50000, 25.30000,   0.00000, 0.00000, 121.99000);
	CreateDynamicObject(3279, 3227.00000, -5267.39990, 18.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 3227.00000, -5140.50000, 18.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 3102.30005, -5140.50000, 18.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 3102.30005, -5269.39990, 18.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16093, 3227.19995, -5166.70020, 23.10000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16638, 3226.22998, -5166.79004, 21.30000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16093, 3227.19995, -5244.79980, 23.10000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16638, 3226.21997, -5244.89014, 21.30000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(16093, 3103.00000, -5166.70020, 23.10000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16638, 3103.97998, -5166.62012, 21.30000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(11292, 3121.50000, -5144.50000, 20.30000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11292, 3132.50000, -5144.50000, 20.30000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11292, 3143.50000, -5144.50000, 20.30000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11292, 3121.50000, -5153.60010, 20.30000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(11292, 3132.50000, -5153.60010, 20.30000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(11292, 3143.50000, -5153.60010, 20.30000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(12919, 3166.89990, -5148.00000, 18.80000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3866, 3203.60010, -5156.60010, 26.60000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3887, 3222.10010, -5207.60010, 27.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11088, 3180.69995, -5212.39990, 24.32002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(12814, 3156.39990, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3117.39990, -5205.60010, 18.89000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12814, 3133.69995, -5214.20020, 18.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3095, 3136.89990, -5193.08008, 13.77000,   20.00000, 0.00000, 0.00000);
	CreateDynamicObject(3095, 3136.89990, -5184.64014, 16.85000,   20.00000, 0.00000, 0.00000);
	CreateDynamicObject(3095, 3141.80005, -5185.10010, 15.10000,   0.00000, 270.00000, 0.00000);
	CreateDynamicObject(3095, 3132.10010, -5185.10010, 15.10000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(3095, 3141.80005, -5193.10010, 14.37000,   0.00000, 270.00000, 0.00000);
	CreateDynamicObject(3095, 3132.10010, -5193.10010, 14.37000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(3095, 3136.89990, -5193.70020, 18.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8661, 3137.00000, -5207.39990, 12.77000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8661, 3137.00000, -5207.39990, 18.40000,   180.00000, 0.00000, 0.00000);
	CreateDynamicObject(16665, 3162.51001, -5215.22998, 12.76000,   0.00000, 0.00000, 179.99001);
	CreateDynamicObject(8661, 3117.10010, -5207.39990, -1.50000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(8661, 3137.00000, -5217.37012, 8.41000,   270.00000, 0.00000, 0.00000);
	CreateDynamicObject(8661, 3157.00000, -5202.89990, -1.50000,   0.00000, 270.00000, 0.00000);
	CreateDynamicObject(3117, 3156.39990, -5215.60010, 17.80000,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(3117, 3156.39990, -5215.60010, 16.20000,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(3117, 3156.69995, -5212.89990, 16.90000,   0.00000, 90.00000, 343.00000);
	CreateDynamicObject(8661, 3122.19995, -5197.60010, -1.50000,   0.00000, 90.00000, 270.00000);
	CreateDynamicObject(8661, 3151.50000, -5197.60010, -1.50000,   0.00000, 90.00000, 270.00000);
	CreateDynamicObject(2917, 3134.80005, -5216.39990, 17.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16641, 3125.69995, -5207.89990, 14.50000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2917, 3139.39990, -5216.39990, 17.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16666, 3134.30005, -5211.70020, 7.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 3152.69995, -5203.60010, 13.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2974, 3149.29995, -5199.50000, 12.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2974, 3146.80005, -5199.50000, 12.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2974, 3144.39990, -5199.50000, 12.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2974, 3144.39990, -5203.39990, 12.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2974, 3146.80005, -5203.39990, 12.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2974, 3149.29995, -5203.39990, 12.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(925, 3146.00000, -5216.10010, 13.80000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(930, 3146.10010, -5216.00000, 15.30000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3576, 3149.69995, -5215.79980, 14.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, 3144.19995, -5216.10010, 13.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3786, 3139.60010, -5216.50000, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3786, 3134.89990, -5216.39990, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3787, 3139.69995, -5216.70020, 13.30000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3787, 3134.69995, -5216.70020, 13.30000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3795, 3139.80005, -5214.50000, 13.10000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3795, 3134.39990, -5214.39990, 13.10000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16662, 3173.89990, -5215.60010, 13.00000,   0.00000, 0.00000, 244.00000);
	CreateDynamicObject(16782, 3175.69995, -5215.00000, 14.10000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3384, 3171.50000, -5221.50000, 13.20000,   0.00000, 0.00000, 312.00000);
	CreateDynamicObject(3383, 3166.10010, -5219.70020, 11.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3393, 3165.30005, -5211.10986, 11.75000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2934, 3154.68994, -5164.31982, 20.32000,   0.00000, 0.00000, -10.32000);
	CreateDynamicObject(3887, 3184.16919, -5264.73584, 27.70000,   0.00000, 0.00000, -109.61999);
	CreateDynamicObject(8075, 3105.93408, -5190.02783, 22.82673,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7561, 3109.89844, -5233.28418, 24.67392,   0.00000, 0.00000, -179.64006);
	CreateDynamicObject(12919, 3137.30664, -5245.42285, 18.80000,   0.00000, 0.00000, 119.03999);
	//soviet
	CreateDynamicObject(3359, -102.61022, 1141.66687, 18.72543,   0.00000, 0.00000, 269.90701);//PROTOTYPE
	CreateDynamicObject(8172, -40.27420, 1111.54626, 18.91519,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8172, -0.45653, 1111.60779, 18.94485,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8209, -10.06830, 1032.20313, 18.31880,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, -66.07137, 1032.68140, 23.93957,   0.00000, 0.00000, 4.44000);
	CreateDynamicObject(8209, -186.34782, 1028.43665, 21.27822,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, -109.25232, 1029.87402, 21.23886,   0.00000, 0.00000, 2.76000);
	CreateDynamicObject(8210, -100.16937, 1030.33801, 21.23886,   0.00000, 0.00000, 2.76000);
	CreateDynamicObject(16121, -176.83090, 1038.75928, 16.57744,   0.00000, 0.00000, 332.87418);
	CreateDynamicObject(3749, 20.69169, 1196.65881, 23.81727,   0.00000, 0.00000, -90.29998);
	CreateDynamicObject(8209, 19.69461, 1138.07288, 17.98367,   0.00000, 0.00000, -90.05993);
	CreateDynamicObject(8209, -30.96627, 1204.03955, 21.68273,   0.00000, 0.00000, -179.75996);
	CreateDynamicObject(8210, -79.57275, 1203.93469, 21.59238,   0.00000, 0.00000, -179.94000);
	CreateDynamicObject(3749, -115.05249, 1206.11133, 23.91111,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8209, -173.24931, 1203.92603, 21.29875,   0.00000, 0.00000, -179.93997);
	CreateDynamicObject(3749, -232.83684, 1196.49426, 23.71352,   0.00000, 0.00000, -90.12000);
	CreateDynamicObject(8209, -233.26808, 1137.63953, 21.68273,   0.00000, 0.00000, -89.63991);
	CreateDynamicObject(8209, -232.92203, 1077.46948, 21.68273,   0.00000, 0.00000, -89.63991);
	CreateDynamicObject(987, -223.02654, 1204.11035, 18.73171,   0.00000, 0.00000, -179.45998);
	CreateDynamicObject(3268, -173.05397, 1173.02917, 18.72537,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(18850, -166.35793, 1125.43665, 6.59313,   0.00000, 0.00000, 90.60000);
	CreateDynamicObject(18850, -90.49215, 1174.05627, 6.66110,   0.00000, 0.00000, -90.00002);
	CreateDynamicObject(3268, -133.93747, 1078.36584, 18.72537,   0.00000, 0.00000, -89.81998);
	CreateDynamicObject(10810, -140.47986, 1038.96484, 23.61010,   0.00000, 0.00000, -158.46005);
	CreateDynamicObject(1682, -137.29375, 1039.09656, 34.99579,   0.00000, 0.00000, 64.67999);
	CreateDynamicObject(3279, -222.20535, 1171.25720, 18.20622,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, -226.02304, 1069.00293, 18.20622,   0.00000, 0.00000, 0.60000);
	CreateDynamicObject(3279, -157.41745, 1082.57068, 18.20622,   0.00000, 0.00000, 88.68000);
	CreateDynamicObject(3279, -111.18757, 1111.03857, 18.20622,   0.00000, 0.00000, -88.73998);
	CreateDynamicObject(3279, -99.84187, 1155.27979, 18.20622,   0.00000, 0.00000, 89.39999);
	CreateDynamicObject(8209, 19.61760, 1080.89868, 17.98036,   0.00000, 0.00000, -90.05993);
	CreateDynamicObject(16098, -20.31074, 1176.30554, 23.71669,   0.00000, 0.00000, -89.28000);
	CreateDynamicObject(19905, -143.76854, 1174.64771, 18.51191,   0.00000, 0.00000, -179.52003);
	CreateDynamicObject(10763, -101.42706, 1069.34204, 45.51353,   0.00000, 0.00000, 44.64000);
	CreateDynamicObject(3578, -107.14304, 1088.26636, 19.36604,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, -96.99447, 1088.25708, 19.36604,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(3578, -86.80572, 1088.25012, 19.36604,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(3578, -80.43080, 1088.27271, 19.36604,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(16093, -113.40158, 1123.25122, 22.71858,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16638, -113.28833, 1122.27954, 20.85383,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, -99.28194, 1079.91016, 18.20622,   0.00000, 0.00000, 89.22000);
	CreateDynamicObject(19909, -140.86720, 1122.14868, 18.65125,   0.00000, 0.00000, 1.08000);
	CreateDynamicObject(16782, -143.84805, 1116.72815, 20.78177,   0.00000, 0.00000, 87.36000);
	CreateDynamicObject(3396, -135.08821, 1118.40771, 18.73540,   0.00000, 0.00000, 2.46000);
	CreateDynamicObject(3395, -135.18332, 1121.97522, 18.73605,   0.00000, 0.00000, 2.10000);
	CreateDynamicObject(3388, -135.07837, 1126.99915, 18.73693,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3388, -135.07124, 1125.98694, 18.73693,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3384, -145.44925, 1127.69702, 20.03681,   0.00000, 0.00000, 91.80003);
	CreateDynamicObject(700, -180.59538, 1088.14099, 19.01563,   356.85840, 0.00000, 3.14159);
	CreateVehicle(522, -145.8577, 1109.6205, 19.2357, 179.3302, -1, -1, 100);
	CreateVehicle(522, -144.1190, 1109.5852, 19.2357, 179.3302, -1, -1, 100);
	CreateVehicle(522, -142.4990, 1109.5981, 19.2357, 179.3302, -1, -1, 100);
	CreateVehicle(522, -141.1526, 1109.5269, 19.2357, 179.3302, -1, -1, 100);
	CreateVehicle(522, -139.5798, 1109.5208, 19.2357, 179.3302, -1, -1, 100);
	CreateVehicle(520, -166.2534, 1124.7729, 20.5506, 0.0000, -1, -1, 100);
	CreateVehicle(476, -37.5020, 1184.7666, 20.9415, 180.9182, -1, -1, 100);
	CreateVehicle(476, -37.9619, 1165.9742, 20.9415, 180.9182, -1, -1, 100);
	CreateVehicle(476, -1.7760, 1166.1361, 20.9415, 180.9182, -1, -1, 100);
	CreateVehicle(476, -1.7158, 1181.9727, 20.9415, 180.9182, -1, -1, 100);
	CreateVehicle(425, -90.5235, 1174.9132, 20.5340, 0.0000, -1, -1, 100);
	CreateVehicle(469, -155.6725, 1176.7168, 25.3064, 0.6276, -1, -1, 100);
	CreateVehicle(487, -131.6708, 1175.7338, 25.4266, 3.3217, -1, -1, 100);
	CreateVehicle(447, -143.5571, 1175.6628, 25.1202, 0.0000, -1, -1, 100);
	CreateVehicle(432, -175.0099, 1180.4652, 19.8420, 89.6727, -1, -1, 100);
	CreateVehicle(432, -174.9968, 1167.6494, 19.8420, 89.6727, -1, -1, 100);
	CreateVehicle(432, -174.9955, 1173.9165, 19.8420, 89.6727, -1, -1, 100);
	CreateVehicle(470, -123.2378, 1115.6608, 19.5212, 0.0000, -1, -1, 100);
	CreateVehicle(470, -129.6258, 1115.5420, 19.5212, 0.0000, -1, -1, 100);
	CreateVehicle(470, -129.5152, 1125.1038, 19.5212, 0.0000, -1, -1, 100);
	CreateVehicle(470, -123.1885, 1125.1848, 19.5212, 0.0000, -1, -1, 100);
	CreateVehicle(470, -123.1207, 1134.0880, 19.5212, 0.0000, -1, -1, 100);
	CreateVehicle(470, -129.2426, 1134.1395, 19.5212, 0.0000, -1, -1, 100);
	CreateVehicle(433, -126.8907, 1079.1210, 20.0760, 1.4121, -1, -1, 100);
	CreateVehicle(433, -133.1042, 1079.1832, 20.0760, 2.4110, -1, -1, 100);
	CreateVehicle(433, -139.6148, 1079.2881, 20.0760, 359.5939, -1, -1, 100);
	CreateVehicle(468, -215.3725, 1100.4414, 19.3967, 267.3496, -1, -1, 100);
	CreateVehicle(468, -215.3036, 1098.4271, 19.3967, 267.3496, -1, -1, 100);
	CreateVehicle(468, -215.4356, 1096.4697, 19.3967, 267.3496, -1, -1, 100);
	CreateVehicle(447, -137.8001, 1061.1246, 20.0110, 356.6116, -1, -1, 100);
	CreateVehicle(487, -150.0612, 1054.9937, 20.0100, 0.0000, -1, -1, 100);
	CreateVehicle(469, -128.9697, 1055.4691, 20.1924, 356.0932, -1, -1, 100);
	CreateVehicle(468, -215.1902, 1102.3842, 19.3967, 267.3496, -1, -1, 100);
	CreateVehicle(468, -215.6200, 1093.9235, 19.3967, 267.3496, -1, -1, 100);
	CreateVehicle(470, -225.8038, 1096.0675, 19.4070, 268.8917, -1, -1, 100);
	CreateVehicle(548, -80.8956, 1080.6993, 21.4528, 269.5830, -1, -1, 100);
	//Europe
	CreateDynamicObject(3359, 1007.75128, 2081.47705, 9.55202,   0.00000, 0.00000, 180.86353); // PROTOTYPE PLACE
	CreateDynamicObject(3268, 927.54425, 2167.72021, 9.77974,   0.00000, 0.00000, -179.88005);
	CreateDynamicObject(3268, 927.47748, 2128.16992, 9.77974,   0.00000, 0.00000, -180.30000);
	CreateDynamicObject(18850, 975.69092, 2170.26978, -2.38771,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18850, 975.70441, 2144.44092, -2.38771,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18850, 975.73676, 2118.76050, -2.38771,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19905, 972.88580, 2223.02100, 9.58470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19909, 936.81543, 2223.01587, 9.76756,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8171, 878.97644, 2171.67261, 9.91262,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8251, 878.45239, 2115.75415, 13.29563,   0.00000, 0.00000, 89.94000);
	CreateDynamicObject(8210, 870.72644, 2241.19214, 12.74653,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 939.22083, 2241.17896, 12.74653,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 988.23486, 2241.19067, 12.74653,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 1016.01001, 2213.29980, 12.74653,   0.00000, 0.00000, -90.35999);
	CreateDynamicObject(8210, 1015.74689, 2157.86963, 12.74653,   0.00000, 0.00000, -90.35999);
	CreateDynamicObject(8210, 1015.33856, 2102.45728, 12.74653,   0.00000, 0.00000, -90.35999);
	CreateDynamicObject(8210, 987.24585, 2074.94385, 12.74653,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 944.32068, 2074.92725, 12.74653,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 874.59314, 2074.93408, 12.74653,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 847.57764, 2102.29858, 12.74653,   0.00000, 0.00000, -90.35999);
	CreateDynamicObject(8210, 847.98444, 2157.66528, 12.74653,   0.00000, 0.00000, -90.35999);
	CreateDynamicObject(8210, 848.39172, 2213.11963, 12.74653,   0.00000, 0.00000, -90.35999);
	CreateDynamicObject(3279, 856.46124, 2231.48926, 9.52300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 855.48956, 2092.45801, 9.52300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 982.71936, 2087.04492, 9.52300,   0.00000, 0.00000, 87.66000);
	CreateDynamicObject(3279, 995.27802, 2207.22754, 9.52300,   0.00000, 0.00000, 178.19992);
	CreateDynamicObject(3577, 964.93927, 2092.10620, 10.47431,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3577, 962.18604, 2092.26074, 10.47431,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10763, 954.06183, 2080.63916, 22.98405,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10763, 900.82605, 2080.37573, 22.98405,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 919.92188, 2087.91138, 10.69469,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 919.77612, 2101.79053, 10.69469,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 954.12067, 2091.25562, 10.69469,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 957.46497, 2091.58716, 10.69469,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 917.38098, 2212.33179, 10.69469,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3066, 949.26659, 2208.03442, 10.69469,   0.00000, 0.00000, -87.89999);
	CreateDynamicObject(3066, 993.36353, 2200.22363, 10.69469,   0.00000, 0.00000, -89.81999);
	CreateDynamicObject(3066, 1000.35870, 2176.51025, 10.69469,   0.00000, 0.00000, -181.80000);
	CreateVehicle(520, 975.0375, 2118.4612, 11.4457, 94.5110, -1, -1, 100);
	CreateVehicle(468, 954.8021, 2099.7258, 11.7968, 0.0000, -1, -1, 100);
	CreateVehicle(468, 956.7390, 2099.6721, 11.7968, 0.0000, -1, -1, 100);
	CreateVehicle(468, 952.6873, 2099.7388, 11.7968, 0.0000, -1, -1, 100);
	CreateVehicle(425, 975.6943, 2169.5193, 11.8447, 89.2139, -1, -1, 100);
	CreateVehicle(432, 929.2280, 2134.5581, 10.7321, 268.2280, -1, -1, 100);
	CreateVehicle(432, 928.7322, 2122.0754, 10.7321, 268.2280, -1, -1, 100);
	CreateVehicle(470, 959.8206, 2219.2247, 10.5234, 178.2805, -1, -1, 100);
	CreateVehicle(470, 894.6498, 2081.2883, 11.2970, 0.0000, -1, -1, 100);
	CreateVehicle(476, 878.9420, 2125.4478, 12.4402, 0.0000, -1, -1, 100);
	CreateVehicle(490, 928.9221, 2173.7520, 10.9149, -91.9200, -1, -1, 100);
	CreateVehicle(490, 928.9158, 2167.8110, 10.9149, -91.9200, -1, -1, 100);
	CreateVehicle(490, 928.8921, 2161.6499, 10.9149, -91.3200, -1, -1, 100);
	CreateVehicle(470, 968.7120, 2218.8845, 10.5234, 178.2805, -1, -1, 100);
	CreateVehicle(470, 977.6907, 2218.8621, 10.5234, 178.2805, -1, -1, 100);
	CreateVehicle(470, 986.3965, 2218.8926, 10.5234, 178.2805, -1, -1, 100);
	CreateVehicle(447, 979.0040, 2150.8467, 10.6325, 90.4800, -1, -1, 100);
	CreateVehicle(447, 970.6539, 2141.0088, 10.6325, 90.4800, -1, -1, 100);
	CreateVehicle(487, 930.1419, 2208.9136, 10.8644, 87.6600, -1, -1, 100);
	//USA Base
	CreateDynamicObject(3359, -266.95221, 2764.22144, 60.62140,   0.00000, 0.00000, 19.47850); // PROTOTYPE
	CreateDynamicObject(3749, -142.43765, 2635.84351, 68.27500,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -245.01259, 2591.01636, 61.68751,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -233.06387, 2591.02759, 61.68751,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -221.15372, 2591.02661, 61.68751,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -209.20119, 2591.03613, 61.68751,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -195.82814, 2590.90747, 61.68750,   0.00000, 0.00000, 88.84332);
	CreateDynamicObject(987, -207.70120, 2591.03613, 61.68750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -195.82809, 2602.90747, 61.68750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -195.82809, 2614.90747, 61.68750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -195.82809, 2616.40747, 61.68750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -195.84439, 2628.44751, 61.68750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -183.84441, 2628.44751, 61.68750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -171.84441, 2628.44751, 61.68750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -159.84441, 2628.44751, 61.68750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -152.34441, 2628.44751, 61.68750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -143.05359, 2645.27441, 61.68750,   0.00000, 0.00000, 84.89712);
	CreateDynamicObject(987, -141.98283, 2657.15942, 61.68750,   0.00000, 0.00000, 76.17964);
	CreateDynamicObject(987, -139.20263, 2668.74854, 61.38449,   0.00000, 0.00000, 85.85188);
	CreateDynamicObject(987, -138.22897, 2680.64429, 61.38449,   0.00000, 0.00000, 85.85188);
	CreateDynamicObject(987, -137.39395, 2692.55493, 61.38449,   0.00000, 0.00000, 85.85188);
	CreateDynamicObject(987, -136.54744, 2704.45654, 61.38449,   0.00000, 0.00000, 85.85188);
	CreateDynamicObject(987, -135.69476, 2716.35986, 61.38449,   0.00000, 0.00000, 98.24071);
	CreateDynamicObject(987, -137.38300, 2728.15405, 61.38450,   0.00000, 0.00000, 114.93855);
	CreateDynamicObject(987, -142.37666, 2738.98560, 61.38450,   0.00000, 0.00000, 114.73750);
	CreateDynamicObject(987, -147.46452, 2749.71826, 61.38450,   0.00000, 0.00000, 114.73750);
	CreateDynamicObject(987, -152.47798, 2760.54541, 61.38450,   0.00000, 0.00000, 98.22231);
	CreateDynamicObject(987, -154.18361, 2772.35645, 61.38450,   0.00000, 0.00000, 140.30002);
	CreateDynamicObject(1886, -143.59433, 2638.66357, 68.37880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1886, -143.57030, 2633.92358, 68.37880,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, -163.35977, 2779.96704, 61.38450,   0.00000, 0.00000, 167.28487);
	CreateDynamicObject(987, -175.11517, 2782.76929, 61.38450,   0.00000, 0.00000, 172.62468);
	CreateDynamicObject(987, -186.93880, 2784.24805, 61.38450,   0.00000, 0.00000, 161.32245);
	CreateDynamicObject(987, -198.23219, 2788.19189, 61.38450,   0.00000, 0.00000, 172.61729);
	CreateDynamicObject(987, -210.05594, 2789.79688, 61.38450,   0.00000, 0.00000, 175.04913);
	CreateDynamicObject(987, -222.01157, 2790.94141, 61.38450,   0.00000, 0.00000, 182.27568);
	CreateDynamicObject(987, -233.83015, 2790.38452, 61.16538,   0.00000, 0.00000, 177.59509);
	CreateDynamicObject(987, -257.66916, 2791.84351, 61.14674,   0.00000, 0.00000, 356.57877);
	CreateDynamicObject(987, -269.92874, 2791.30371, 61.26739,   0.00000, 0.00000, 3.93254);
	CreateDynamicObject(987, -278.38593, 2785.89819, 61.46839,   0.00000, 0.00000, 208.12737);
	CreateDynamicObject(987, -288.88226, 2780.27319, 61.97240,   0.00000, 0.00000, 215.76009);
	CreateDynamicObject(987, -299.26790, 2773.28735, 61.97240,   0.00000, 0.00000, 215.76009);
	CreateDynamicObject(987, -308.23190, 2766.28198, 61.97240,   0.00000, 0.00000, 215.76009);
	CreateDynamicObject(987, -317.91852, 2759.32544, 61.97240,   0.00000, 0.00000, 211.02216);
	CreateDynamicObject(987, -328.13492, 2753.16260, 61.87039,   0.00000, 0.00000, 232.69937);
	CreateDynamicObject(987, -335.34149, 2743.66943, 61.66535,   0.00000, 0.00000, 232.69937);
	CreateDynamicObject(987, -342.49146, 2734.13135, 61.66535,   0.00000, 0.00000, 232.69937);
	CreateDynamicObject(987, -349.52625, 2724.62964, 61.66535,   0.00000, 0.00000, 218.43910);
	CreateDynamicObject(987, -358.90097, 2717.19238, 61.66535,   0.00000, 0.00000, 203.46059);
	CreateDynamicObject(987, -369.78040, 2712.58887, 61.53453,   0.00000, 0.00000, 223.63588);
	CreateDynamicObject(3749, -385.30872, 2700.06006, 67.91050,   0.00000, 0.00000, 41.37893);
	CreateDynamicObject(987, -389.35840, 2694.02393, 63.24654,   0.00000, 0.00000, 305.80658);
	CreateDynamicObject(987, -382.35294, 2684.34082, 63.24654,   0.00000, 0.00000, 298.21826);
	CreateDynamicObject(987, -376.71814, 2673.82153, 63.24654,   0.00000, 0.00000, 298.21826);
	CreateDynamicObject(987, -371.08307, 2663.31006, 63.24654,   0.00000, 0.00000, 305.94751);
	CreateDynamicObject(987, -364.12961, 2653.62256, 63.14655,   0.00000, 0.00000, 313.93466);
	CreateDynamicObject(987, -355.86740, 2645.02612, 62.84354,   0.00000, 0.00000, 327.00198);
	CreateDynamicObject(987, -345.83640, 2639.23003, 62.74253,   0.00000, 0.00000, 331.30969);
	CreateDynamicObject(987, -335.43161, 2632.77661, 62.44154,   0.00000, 0.00000, 343.09448);
	CreateDynamicObject(987, -324.01096, 2629.33911, 62.39256,   0.00000, 0.00000, 351.73026);
	CreateDynamicObject(987, -312.20737, 2627.63159, 62.09156,   0.00000, 0.00000, 353.87549);
	CreateDynamicObject(987, -300.32147, 2626.35571, 61.73267,   0.00000, 0.00000, 358.81131);
	CreateDynamicObject(987, -288.39050, 2626.13794, 61.73270,   0.00000, 0.00000, 280.06769);
	CreateDynamicObject(987, -286.27747, 2614.37500, 61.73270,   0.00000, 0.00000, 271.82889);
	CreateDynamicObject(987, -285.83972, 2584.67896, 61.73270,   0.00000, 0.00000, 350.80856);
	CreateDynamicObject(987, -285.77460, 2596.59766, 61.73270,   0.00000, 0.00000, 270.07458);
	CreateDynamicObject(987, -285.85699, 2596.56689, 61.73270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -274.05487, 2582.79736, 61.73270,   0.00000, 0.00000, 350.60754);
	CreateDynamicObject(987, -262.30304, 2580.82739, 61.73270,   0.00000, 0.00000, 350.50754);
	CreateDynamicObject(987, -259.02554, 2580.28857, 60.61349,   0.00000, 0.00000, 350.50754);
	CreateDynamicObject(3279, -248.27028, 2581.63110, 62.56710,   0.00000, 0.00000, 117.18961);
	CreateDynamicObject(3279, -148.17072, 2650.17407, 63.31900,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3279, -369.80435, 2705.31128, 62.51181,   0.00000, 0.00000, 306.87534);
	CreateDynamicObject(1886, -382.12729, 2700.59741, 67.71710,   0.00000, 0.00000, 38.25610);
	CreateDynamicObject(1886, -387.63510, 2698.28687, 67.71710,   0.00000, 0.00000, 213.56073);
	CreateDynamicObject(18850, -210.28439, 2726.89063, 49.51310,   0.00000, 0.00000, 270.54947);
	CreateDynamicObject(18850, -235.88911, 2726.71118, 49.51310,   0.00000, 0.00000, 270.54947);
	CreateDynamicObject(3279, -256.05991, 2777.04907, 61.41298,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, -163.23972, 2768.88281, 61.41298,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -278.34302, 2785.73169, 61.33066,   0.00000, 0.00000, 33.94172);
	CreateDynamicObject(8251, -162.24358, 2708.37646, 65.17059,   0.00000, 0.00000, -180.96007);
	CreateDynamicObject(3866, -161.74036, 2675.47998, 68.40696,   0.00000, 0.00000, -179.04001);
	CreateDynamicObject(3866, -164.27336, 2739.24722, 68.40696,   0.00000, 0.00000, -75.36001);
	CreateDynamicObject(8251, -222.46695, 2774.84302, 65.21020,   0.00000, 0.00000, -89.99999);
	CreateDynamicObject(19907, -281.95938, 2682.49609, 61.46279,   0.00000, 0.00000, -89.76002);
	CreateDynamicObject(10763, -303.95807, 2668.13525, 94.32055,   0.00000, 0.00000, 45.00001);
	CreateDynamicObject(19905, -222.09146, 2661.70020, 61.38864,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3887, -299.39932, 2747.33350, 68.76125,   0.00000, 0.00000, -46.56000);
	CreateDynamicObject(3887, -290.57333, 2738.00269, 68.60484,   0.00000, 0.00000, -226.14003);
	CreateVehicle(432, -217.7632, 2774.1472, 62.4583, 179.2046, -1, -1, 100);
	CreateVehicle(432, -226.1013, 2774.9563, 62.4098, 179.2046, -1, -1, 100);
	CreateVehicle(468, -199.3553, 2610.4543, 63.1747, 0.0000, -1, -1, 100);
	CreateVehicle(468, -199.2921, 2597.7810, 63.1747, 182.6807, -1, -1, 100);
	CreateVehicle(468, -204.6520, 2597.4827, 63.1747, 182.6807, -1, -1, 100);
	CreateVehicle(468, -210.3022, 2597.5967, 63.1747, 182.6807, -1, -1, 100);
	CreateVehicle(470, -228.8195, 2597.2825, 62.5018, 0.4060, -1, -1, 100);
	CreateVehicle(470, -234.7830, 2597.1404, 62.5018, 0.4060, -1, -1, 100);
	CreateVehicle(470, -240.5851, 2596.4922, 62.5018, 0.4060, -1, -1, 100);
	CreateVehicle(433, -313.5850, 2676.6150, 63.1218, 0.0000, -1, -1, 100);
	CreateVehicle(433, -318.0229, 2676.7329, 63.1218, 0.0000, -1, -1, 100);
	CreateVehicle(520, -211.0262, 2727.6238, 64.3373, 179.0844, -1, -1, 100);
	CreateVehicle(520, -236.1500, 2727.5981, 64.3373, 179.0844, -1, -1, 100);
	CreateVehicle(447, -279.2965, 2715.3953, 64.0494, 181.4893, -1, -1, 100);
	CreateVehicle(470, -226.2985, 2658.4385, 62.5133, 0.0000, -1, -1, 100);
	CreateVehicle(470, -216.9291, 2659.2178, 62.5133, 0.0000, -1, -1, 100);
	CreateVehicle(476, -165.6592, 2710.9622, 63.6662, 94.6800, -1, -1, 100);
	CreateVehicle(490, -281.5771, 2684.9487, 62.7326, 0.0000, -1, -1, 100);
	CreateVehicle(490, -275.0214, 2684.0398, 62.7326, 0.0000, -1, -1, 100);
	//Arab
	CreateDynamicObject(3359, -769.10297, 1590.94238, 26.07327,   0.00000, 0.00000, 1.37329);// PROTOTYPE
	CreateDynamicObject(8251, -788.79578, 1598.02576, 29.69272,   0.00000, 0.00000, -89.28003);
	CreateDynamicObject(19905, -782.94543, 1555.14221, 25.11592,   0.00000, 0.00000, -180.66005);
	CreateDynamicObject(19909, -788.47955, 1520.84546, 25.32257,   0.00000, 0.00000, 1.26000);
	CreateDynamicObject(3887, -784.45264, 1510.93555, 24.81501,   0.00000, 0.00000, 90.96000);
	CreateDynamicObject(3866, -822.12830, 1512.14966, 25.53502,   0.00000, 0.00000, -30.96000);
	CreateDynamicObject(16375, -719.63385, 1626.99329, 26.37065,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16375, -731.30829, 1627.73267, 26.31785,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, -851.40002, 1414.00000, 15.70000,   0.00000, 0.00000, 112.00000);
	CreateDynamicObject(16113, -864.90002, 1456.00000, 12.60000,   0.00000, 0.00000, 138.00000);
	CreateDynamicObject(3749, -884.90002, 1480.19995, 28.40000,   0.00000, 0.00000, 348.00000);
	CreateDynamicObject(987, -911.79999, 1513.90002, 24.50000,   0.00000, 0.00000, 288.00000);
	CreateDynamicObject(987, -908.20001, 1502.50000, 24.90000,   0.00000, 0.00000, 297.99585);
	CreateDynamicObject(987, -902.70001, 1492.00000, 23.80000,   0.00000, 0.00000, 317.99219);
	CreateDynamicObject(987, -911.29999, 1525.50000, 24.90000,   0.00000, 0.00000, 267.99561);
	CreateDynamicObject(987, -910.70001, 1537.40002, 24.90000,   0.00000, 0.00000, 267.99500);
	CreateDynamicObject(987, -909.79999, 1549.30005, 24.90000,   0.00000, 0.00000, 265.99500);
	CreateDynamicObject(987, -878.70001, 1631.90002, 26.10000,   0.00000, 0.00000, 301.98999);
	CreateDynamicObject(987, -872.59998, 1621.90002, 26.00000,   0.00000, 0.00000, 297.98718);
	CreateDynamicObject(987, -867.40002, 1611.30005, 26.10000,   0.00000, 0.00000, 249.98718);
	CreateDynamicObject(987, -871.59998, 1600.40002, 26.20000,   0.00000, 0.00000, 233.98376);
	CreateDynamicObject(987, -878.70001, 1590.80005, 26.10000,   0.00000, 0.00000, 229.98132);
	CreateDynamicObject(987, -886.40002, 1581.90002, 25.70000,   0.00000, 0.00000, 215.97681);
	CreateDynamicObject(987, -896.20001, 1575.00000, 24.90000,   0.00000, 0.00000, 235.97473);
	CreateDynamicObject(2990, -909.79999, 1554.09998, 28.80000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2990, -905.09998, 1560.90002, 28.70000,   0.00000, 0.00000, 61.99902);
	CreateDynamicObject(3749, -870.29999, 1634.80005, 31.80000,   0.00000, 0.00000, 31.99744);
	CreateDynamicObject(3749, -832.40002, 1392.00000, 19.20000,   0.00000, 0.00000, 25.99744);
	CreateDynamicObject(3279, -817.29999, 1404.00000, 12.70000,   0.00000, 0.00000, 198.00000);
	CreateVehicle(432, -794.5414, 1593.9197, 27.0479, -179.2200, -1, -1, 100);
	CreateVehicle(432, -783.5308, 1594.0774, 27.0479, -179.2200, -1, -1, 100);
	CreateVehicle(470, -768.7748, 1558.3557, 26.7941, 0.0000, -1, -1, 100);
	CreateVehicle(470, -778.1835, 1558.1492, 26.7941, -0.2400, -1, -1, 100);
	CreateVehicle(470, -787.5005, 1558.3230, 26.7941, -0.6600, -1, -1, 100);
	CreateVehicle(470, -796.2882, 1558.7908, 26.7941, -1.0800, -1, -1, 100);
	CreateVehicle(487, -741.8405, 1638.7909, 27.2885, 0.0000, -1, -1, 100);
	CreateVehicle(447, -753.7342, 1639.3226, 27.1390, 0.0000, -1, -1, 100);
	CreateVehicle(468, -812.2896, 1525.9552, 26.2099, 0.0000, -1, -1, 100);
	CreateVehicle(468, -814.1228, 1526.2283, 26.2099, -0.1200, -1, -1, 100);
	CreateVehicle(468, -810.4562, 1525.9962, 26.2099, -0.1200, -1, -1, 100);
	CreateVehicle(520, -882.8234, 1520.1189, 26.5790, 0.0000, -1, -1, 100);
	CreateVehicle(425, -882.0917, 1547.9796, 26.4791, 0.0000, -1, -1, 100);
	CreateVehicle(490, -865.7166, 1551.6335, 24.2185, -87.4200, -1, -1, 100);
	CreateVehicle(490, -866.2129, 1557.3291, 24.2185, -87.4200, -1, -1, 100);
	CreateVehicle(490, -866.5558, 1563.5203, 24.7057, -87.4200, -1, -1, 100);
	CreateVehicle(468, -809.2443, 1525.9857, 26.2099, 0.1800, -1, -1, 100);
	CreateVehicle(476, -803.6756, 1411.1813, 14.4129, -92.0400, -1, -1, 100);
	CreateVehicle(476, -783.9560, 1410.8212, 14.4129, -92.0400, -1, -1, 100);
	//Australia
	CreateDynamicObject(3359, -1478.11389, 2690.57983, 54.88374,   0.00000, 0.00000, 0.20100);// PROTOTYPE
	CreateDynamicObject(987, -1381.62000, 2605.91992, 53.59000,   0.00000, 5.00000, 50.00000);
	CreateDynamicObject(987, -1373.95996, 2615.04004, 52.69000,   0.00000, 5.00000, 52.00000);
	CreateDynamicObject(987, -1366.56006, 2624.34009, 51.63000,   0.00000, 4.99000, 64.00000);
	CreateDynamicObject(987, -1361.13000, 2634.81006, 50.71000,   0.00000, 0.00000, 83.99000);
	CreateDynamicObject(987, -1359.90002, 2646.64990, 50.77000,   0.00000, 0.00000, 117.99000);
	CreateDynamicObject(987, -1365.56006, 2656.90991, 50.66000,   0.00000, 0.00000, 129.99001);
	CreateDynamicObject(987, -1373.06006, 2666.23999, 51.14000,   0.00000, 355.00000, 129.98000);
	CreateDynamicObject(987, -1380.78003, 2675.18994, 52.30000,   0.00000, 355.00000, 129.98000);
	CreateDynamicObject(987, -1388.29004, 2684.20996, 53.78000,   0.00000, 355.00000, 133.98000);
	CreateDynamicObject(987, -1396.42004, 2692.53003, 55.66000,   0.00000, 353.00000, 137.98000);
	CreateDynamicObject(987, -1405.17004, 2700.23999, 57.46000,   0.00000, 353.00000, 143.98000);
	CreateDynamicObject(987, -1414.54004, 2707.31006, 59.44000,   0.00000, 352.98999, 153.98000);
	CreateDynamicObject(987, -1424.91003, 2712.15991, 61.02000,   0.00000, 352.98999, 157.98000);
	CreateDynamicObject(987, -1435.60999, 2716.48999, 62.30000,   0.00000, 355.00000, 163.98000);
	CreateDynamicObject(987, -1446.93994, 2719.64990, 63.40000,   0.00000, 355.00000, 167.98000);
	CreateDynamicObject(987, -1459.27996, 2722.15991, 64.39000,   0.00000, 357.00000, 169.98000);
	CreateDynamicObject(987, -1469.97998, 2724.01001, 64.81000,   0.00000, 358.00000, 175.97000);
	CreateDynamicObject(987, -1481.89001, 2724.87988, 64.95000,   0.00000, 0.00000, 179.97000);
	CreateDynamicObject(987, -1493.60999, 2724.73999, 64.81000,   0.00000, 2.00000, 179.97000);
	CreateDynamicObject(987, -1505.43994, 2724.77002, 63.88000,   0.00000, 3.00000, 181.97000);
	CreateDynamicObject(987, -1516.75000, 2724.37012, 63.22000,   0.00000, 2.00000, 177.97000);
	CreateDynamicObject(987, -1529.27996, 2724.95996, 62.66000,   0.00000, 2.00000, 175.97000);
	CreateDynamicObject(987, -1540.30005, 2725.55005, 62.02000,   0.00000, 4.00000, 173.96001);
	CreateDynamicObject(987, -1552.02002, 2726.63989, 60.56000,   0.00000, 3.00000, 179.96001);
	CreateDynamicObject(987, -1563.89001, 2726.87012, 59.65000,   0.00000, 2.00000, 179.96001);
	CreateDynamicObject(987, -1575.71997, 2726.69995, 58.87000,   0.00000, 2.00000, 187.95000);
	CreateDynamicObject(987, -1587.65002, 2725.11011, 57.99000,   0.00000, 1.00000, 187.95000);
	CreateDynamicObject(987, -1599.25000, 2723.35010, 57.60000,   0.00000, 1.00000, 191.95000);
	CreateDynamicObject(987, -1610.69995, 2720.79004, 57.03000,   0.00000, 0.99000, 191.95000);
	CreateDynamicObject(3749, -1616.26001, 2670.37988, 59.43000,   0.00000, 0.00000, 112.00000);
	CreateDynamicObject(987, -1616.70996, 2719.64990, 57.04000,   0.00000, 0.99000, 191.95000);
	CreateDynamicObject(987, -1628.12000, 2717.42993, 56.14000,   0.00000, 2.00000, 265.95001);
	CreateDynamicObject(987, -1628.66003, 2706.08008, 55.50000,   0.00000, 5.00000, 269.95001);
	CreateDynamicObject(987, -1628.67004, 2694.16992, 54.45000,   0.00000, 4.00000, 291.94000);
	CreateDynamicObject(987, -1626.75000, 2688.44995, 54.28000,   0.00000, 4.00000, 297.94000);
	CreateDynamicObject(987, -1395.35999, 2580.33008, 56.81000,   0.00000, 5.00000, 62.00000);
	CreateDynamicObject(987, -1401.04004, 2570.58008, 57.64000,   0.00000, 4.99000, 60.00000);
	CreateDynamicObject(987, -1406.28003, 2560.10010, 58.70000,   0.00000, 4.99000, 64.00000);
	CreateDynamicObject(987, -1410.66003, 2549.42993, 59.74000,   0.00000, 4.99000, 68.00000);
	CreateDynamicObject(987, -1415.33997, 2539.24004, 60.51000,   0.00000, 4.99000, 68.00000);
	CreateDynamicObject(987, -1419.31995, 2528.38989, 60.63000,   0.00000, 3.00000, 67.99000);
	CreateDynamicObject(987, -1422.97998, 2517.30005, 60.90000,   0.00000, 3.00000, 71.99000);
	CreateDynamicObject(987, -1426.56995, 2506.76001, 60.87000,   0.00000, 3.00000, 71.99000);
	CreateDynamicObject(987, -1614.16003, 2661.14990, 54.20000,   0.00000, 357.00000, 297.94000);
	CreateDynamicObject(987, -1608.73999, 2650.88989, 54.96000,   0.00000, 354.00000, 311.92999);
	CreateDynamicObject(987, -1601.13000, 2641.88989, 57.08000,   0.00000, 352.00000, 311.92999);
	CreateDynamicObject(987, -1593.39001, 2633.50000, 58.47000,   0.00000, 352.00000, 315.92999);
	CreateDynamicObject(987, -1585.63000, 2625.92993, 60.67000,   0.00000, 352.00000, 311.92999);
	CreateDynamicObject(987, -1578.00000, 2616.90991, 62.86000,   0.00000, 352.00000, 299.92999);
	CreateDynamicObject(987, -1572.18005, 2606.45996, 64.58000,   0.00000, 354.00000, 283.92999);
	CreateDynamicObject(987, -1569.75000, 2595.73999, 65.61000,   0.00000, 357.00000, 277.92999);
	CreateDynamicObject(987, -1568.10999, 2584.04004, 66.63000,   0.00000, 357.00000, 275.92001);
	CreateDynamicObject(11549, 6312.70020, 1742.90002, -6154.45996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11549, 5869.91992, 1280.26001, -6843.20996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11612, 6072.79980, 1456.19995, -6534.02979,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6369, 6320.58984, 3210.90991, -6353.45996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12951, 219.83000, -6393.31006, -4106.72021,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(17019, -1453.72998, 2515.55005, 67.23000,   0.00000, 0.00000, 0.39000);
	CreateDynamicObject(17019, -1453.72998, 2515.55005, 59.28000,   0.00000, 0.00000, 0.39000);
	CreateDynamicObject(17019, -1453.72998, 2515.55005, 59.28000,   0.00000, 0.00000, 0.39000);
	CreateDynamicObject(3749, -1385.96997, 2599.82007, 60.32000,   0.00000, 5.00000, 60.00000);
	CreateDynamicObject(3749, -1490.80005, 2507.72998, 60.61000,   0.00000, 0.00000, 357.67999);
	CreateDynamicObject(987, -1566.81006, 2572.90991, 67.28000,   0.00000, 357.00000, 275.92001);
	CreateDynamicObject(987, -1565.89001, 2560.71997, 67.78000,   0.00000, 357.00000, 271.42999);
	CreateDynamicObject(987, -1565.54004, 2549.29995, 68.24000,   0.00000, 0.00000, 266.42999);
	CreateDynamicObject(987, -1566.40002, 2537.31006, 68.24000,   0.00000, 0.00000, 264.20999);
	CreateDynamicObject(987, -1567.31995, 2526.68994, 68.24000,   0.00000, 0.00000, 263.19000);
	CreateDynamicObject(987, -1569.28005, 2515.04004, 67.39000,   0.00000, 0.00000, 354.76999);
	CreateDynamicObject(987, -1557.60999, 2513.93994, 52.35000,   0.00000, 0.00000, 356.60001);
	CreateDynamicObject(987, -1569.28005, 2515.04004, 57.46000,   0.00000, 0.00000, 354.35001);
	CreateDynamicObject(987, -1546.42004, 2513.42993, 59.33000,   0.00000, 0.00000, 357.92999);
	CreateDynamicObject(987, -1569.28005, 2515.04004, 62.40000,   0.00000, 0.00000, 354.35001);
	CreateDynamicObject(987, -1557.45996, 2513.93994, 62.29000,   0.00000, 0.00000, 356.60001);
	CreateDynamicObject(987, -1557.45996, 2513.93994, 57.55000,   0.00000, 0.00000, 356.60001);
	CreateDynamicObject(987, -1510.84998, 2511.50000, 54.34000,   0.00000, 0.00000, 352.63000);
	CreateDynamicObject(987, -1545.54004, 2513.30005, 54.34000,   0.00000, 0.00000, 358.32001);
	CreateDynamicObject(987, -1533.73999, 2513.21997, 54.34000,   0.00000, 0.00000, 356.60001);
	CreateDynamicObject(987, -1521.80005, 2512.62988, 54.34000,   0.00000, 0.00000, 353.94000);
	CreateDynamicObject(17543, -1385.81995, 2642.63989, 56.64228,   0.00000, 0.00000, 359.67999);
	CreateDynamicObject(5261, -1380.55005, 2661.55005, 52.60000,   0.00000, 0.00000, 180.22000);
	CreateDynamicObject(5261, -1377.44995, 2656.91992, 52.68000,   0.00000, 0.00000, 90.82000);
	CreateDynamicObject(5261, -1382.21997, 2623.64990, 52.17000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(5261, -1377.57996, 2626.84009, 52.13000,   0.00000, 0.00000, 90.22000);
	CreateDynamicObject(5261, -1377.50000, 2636.39990, 52.13000,   0.00000, 0.00000, 89.51000);
	CreateDynamicObject(669, -1387.21997, 2672.89990, 53.02000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(669, -1622.52002, 2714.90991, 56.62000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(669, -1578.88000, 2724.45996, 58.67000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(669, -1532.72998, 2723.17993, 62.83000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(669, -1489.06995, 2723.11011, 64.46000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(669, -1450.53003, 2718.08008, 63.34000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(669, -1414.97998, 2700.84009, 59.48000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(697, -1560.18005, 2526.44995, 51.15000,   356.85999, 0.00000, 335.31000);
	CreateDynamicObject(697, -1549.63000, 2519.69995, 54.57000,   356.85999, 0.00000, 336.79999);
	CreateDynamicObject(697, -1543.01001, 2510.82007, 42.36000,   356.85999, 0.00000, 336.26999);
	CreateDynamicObject(697, -1563.43005, 2518.79004, 40.18000,   356.85999, 0.00000, 49.87000);
	CreateDynamicObject(697, -1566.14001, 2512.65991, 58.96000,   356.85999, 0.00000, 49.69000);
	CreateDynamicObject(697, -1556.73999, 2510.04004, 46.79000,   356.85999, 0.00000, 49.61000);
	CreateDynamicObject(697, -1547.27002, 2525.07007, 35.84000,   356.85999, 0.00000, 337.79999);
	CreateDynamicObject(5262, -1409.25330, 2667.02612, 57.13716,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12911, -1443.87463, 2542.33472, 54.11233,   0.00000, 0.00000, -38.76000);
	CreateDynamicObject(3268, -1515.94238, 2576.16577, 54.82121,   0.00000, 0.00000, -180.11998);
	CreateDynamicObject(8038, -1443.97083, 2579.68750, 74.90031,   0.00000, 0.00000, -91.07999);
	CreateDynamicObject(19905, -1514.02698, 2629.20815, 54.59990,   0.00000, 0.00000, 89.76003);
	CreateDynamicObject(19909, -1529.35266, 2654.70483, 54.77872,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8251, -1595.62524, 2691.72241, 58.11999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18850, -1448.68286, 2623.96631, 42.83089,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(18850, -1448.68359, 2649.60815, 42.83361,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19907, -1477.31250, 2637.20459, 54.55292,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, -1564.62854, 2645.14355, 54.78120,   0.00000, 0.00000, -0.78000);
	CreateDynamicObject(3279, -1567.05566, 2711.36914, 54.58121,   0.00000, 0.00000, -0.78000);
	CreateDynamicObject(3279, -1538.03833, 2537.45313, 54.21876,   0.00000, 0.00000, 88.80000);
	CreateDynamicObject(3279, -1478.91064, 2613.59644, 54.21876,   0.00000, 0.00000, 178.74004);
	CreateVehicle(520, -1592.7800, 2691.2466, 56.2159, -89.7000, -1, -1, 100);
	CreateVehicle(425, -1448.9124, 2650.4121, 56.6556, 0.0000, -1, -1, 100);
	CreateVehicle(447, -1448.9037, 2624.8965, 56.0209, 0.0000, -1, -1, 100);
	CreateVehicle(432, -1516.9995, 2569.2230, 55.7850, -87.8400, -1, -1, 100);
	CreateVehicle(432, -1517.1890, 2580.2471, 55.7850, -87.8400, -1, -1, 100);
	CreateVehicle(490, -1478.8057, 2638.9548, 55.8473, 90.7800, -1, -1, 100);
	CreateVehicle(490, -1478.9514, 2644.6636, 55.8473, 90.7800, -1, -1, 100);
	CreateVehicle(470, -1513.2322, 2615.6504, 55.5468, -89.7600, -1, -1, 100);
	CreateVehicle(470, -1513.6757, 2625.1409, 55.5468, -89.7600, -1, -1, 100);
	CreateVehicle(470, -1512.9706, 2634.0305, 55.5468, -89.7600, -1, -1, 100);
	CreateVehicle(470, -1513.0089, 2642.9319, 55.5468, -89.7600, -1, -1, 100);
	CreateVehicle(468, -1400.6161, 2653.1245, 55.1784, 89.7600, -1, -1, 100);
	CreateVehicle(468, -1400.3993, 2650.2214, 55.1784, 89.7600, -1, -1, 100);
	CreateVehicle(468, -1400.1859, 2647.0574, 55.1784, 89.7600, -1, -1, 100);
	CreateVehicle(487, -1525.9656, 2533.6687, 55.6939, 0.0000, -1, -1, 100);
	CreateVehicle(487, -1502.4941, 2533.6589, 55.6939, 0.0000, -1, -1, 100);
	//Broken Objects - Area 51
	CreateDynamicObject(10757, 198.80000, 2075.89990, 22.00000,   16.00000, 1.00000, 44.00000);
	CreateDynamicObject(18689, 202.00000, 2072.39990, 21.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18689, 207.20000, 2080.30005, 22.20000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18689, 204.50000, 2073.89990, 20.70000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18689, 195.30000, 2078.80005, 21.60000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18689, 192.20000, 2077.60010, 21.50000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18689, 196.70000, 2082.19995, 22.40000,   0.00000, 0.00000, 0.00000);
	//Area 51
	CreateDynamicObject(3399, 2592.39990, 2768.00000, 20.90000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2592.39990, 2756.39990, 16.20000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2592.39990, 2744.89990, 11.50000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2643.30005, 2800.00000, 33.10000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2643.30005, 2788.50000, 28.40000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2643.30005, 2777.00000, 23.70000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2606.80005, 2798.00000, 24.80000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3399, 2621.00000, 2805.00000, 29.10000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 2496.39990, 2773.39990, 15.70000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(217, 273.86768, 1879.48853, -30.44680,   82.50000, 1.00000, -157.01997);
	CreateDynamicObject(3279, 192.80000, 1803.09998, 16.60000,   0.00000, 0.00000, 179.99451);
	CreateDynamicObject(3279, 384.70001, 2076.60010, 16.60000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(3279, 351.50000, 1809.90002, 17.50000,   0.00000, 0.00000, 196.00000);
	CreateDynamicObject(1634, 844.20001, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 840.20001, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 836.09998, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 831.90002, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 827.90002, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 823.70001, -1812.19995, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 819.59998, -1812.09998, 12.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1634, 819.29999, -1806.40002, 15.00000,   0.00000, 0.00000, 2.00000);
	CreateDynamicObject(1634, 823.40002, -1806.19995, 15.00000,   0.00000, 0.00000, 2.00000);
	CreateDynamicObject(1634, 827.70001, -1806.19995, 15.00000,   0.00000, 0.00000, 1.99951);
	CreateDynamicObject(1634, 831.90002, -1806.30005, 15.00000,   0.00000, 0.00000, 1.99951);
	CreateDynamicObject(1634, 836.00000, -1805.90002, 15.00000,   0.00000, 0.00000, 1.99951);
	CreateDynamicObject(1634, 840.20001, -1805.80005, 15.00000,   0.00000, 0.00000, 1.99951);
	CreateDynamicObject(1634, 844.09998, -1805.40002, 15.00000,   0.00000, 0.00000, 1.99951);
	CreateDynamicObject(16430, 835.79999, -2064.30005, 10.40000,   1.00000, 30.00000, 90.99695);
	CreateDynamicObject(16430, 839.00000, -2178.10010, 75.90000,   0.99976, 29.99817, 90.99426);
	CreateDynamicObject(16430, 842.29999, -2297.39990, 144.89999,   0.99976, 29.99817, 90.99426);
	CreateDynamicObject(16430, 845.29999, -2405.89990, 207.70000,   0.99976, 29.99817, 90.99426);
	CreateDynamicObject(16430, 848.79999, -2532.80005, 281.00000,   0.99976, 29.99817, 90.99426);
	CreateDynamicObject(16430, 852.00000, -2655.00000, 351.89999,   0.99976, 29.99817, 90.99426);
	CreateDynamicObject(8040, 853.09998, -2763.80005, 392.79999,   0.00000, 0.00000, 92.00000);
	CreateDynamicObject(2669, 850.00000, -1818.19995, 12.50000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2669, 850.00000, -1823.69995, 12.50000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 172.85265, 1941.76819, 18.50005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 113.83569, 1939.55872, 18.01811,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 135.27260, 1940.32434, 23.78964,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 101.84984, 1939.60229, 18.01811,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 96.33510, 1939.48560, 18.01811,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16095, 292.84924, 1834.40491, 16.63281,   356.85840, 0.00000, 88.01793);
	CreateDynamicObject(3749, 292.48239, 1821.31433, 22.04897,   0.00000, 0.00000, 90.60000);
	CreateDynamicObject(987, 292.66180, 1811.48438, 16.62379,   0.00000, 0.00000, -89.58002);
	CreateDynamicObject(987, 292.54501, 1799.58508, 16.62379,   0.00000, 0.00000, -178.13991);
	CreateDynamicObject(987, 287.35394, 1799.37878, 16.62379,   0.00000, 0.00000, -178.13991);
	CreateDynamicObject(8210, 247.77823, 1799.23218, 17.67260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 192.18039, 1799.11865, 17.67260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 155.84813, 1800.68628, 22.15975,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8210, 121.86629, 1799.89392, 17.67260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8150, 94.35233, 1862.64795, 18.55104,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3749, 95.78629, 1932.30286, 22.65409,   0.00000, 0.00000, -88.31999);
	CreateDynamicObject(964, 202.01649, 2092.12476, 22.15580,   90.44230, 180.42300, -38.04000);
	CreateDynamicObject(964, 198.46405, 2094.48779, 21.63377,   0.00000, 0.00000, -30.66000);
	CreateDynamicObject(964, 199.16664, 2090.68555, 21.63377,   0.00000, 0.00000, -83.34001);
	CreateDynamicObject(964, 202.04845, 2092.17896, 22.15415,   90.53840, 0.00000, -42.53997);
	CreateDynamicObject(964, 198.70660, 2097.12988, 22.15420,   59.57740, 0.00000, -39.12000);
	CreateDynamicObject(964, 201.88986, 2089.35156, 21.63377,   0.00000, 0.00000, -133.80000);
	CreateDynamicObject(964, 196.27501, 2094.87671, 21.63377,   0.00000, 0.00000, -23.34002);
	CreateDynamicObject(964, 196.71974, 2092.24414, 21.63377,   0.00000, 0.00000, -83.34001);
	CreateDynamicObject(3279, 192.80000, 1803.09998, 16.60000,   0.00000, 0.00000, 179.99451);
	CreateDynamicObject(3268, 214.54852, 1885.25781, 16.37097,   0.00000, 0.00000, -90.00001);
	CreateDynamicObject(3279, 203.11537, 1942.84387, 16.61527,   356.85840, 0.00000, -90.75838);
	CreateDynamicObject(761, 93.20936, 1924.95459, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 93.57256, 1938.96545, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 90.54373, 1925.93738, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 88.92388, 1929.04382, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 93.18880, 1923.02246, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 93.39738, 1918.46155, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 87.87412, 1925.15991, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 90.88823, 1937.95862, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 87.84280, 1938.04321, 16.92006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 102.11880, 1924.25024, 17.23750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 105.69989, 1936.96594, 17.23750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 94.21889, 1914.07410, 17.23750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 119.93790, 1927.88367, 17.58910,   0.00000, 0.00000, -84.84001);
	CreateDynamicObject(760, 106.13095, 1923.41077, 17.23750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 112.28378, 1930.68652, 17.23750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 107.03032, 1901.54578, 16.84497,   0.00000, 0.00000, -13.25999);
	CreateDynamicObject(761, 178.96431, 1925.24255, 16.98474,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 179.38377, 1929.52783, 16.98474,   0.00000, 0.00000, 45.60000);
	CreateDynamicObject(761, 188.55331, 1924.41443, 16.98474,   0.00000, 0.00000, 45.60000);
	CreateDynamicObject(761, 186.26491, 1925.46619, 16.98474,   0.00000, 0.00000, 45.60000);
	CreateDynamicObject(760, 184.32347, 1929.81506, 16.29784,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(873, 179.70956, 1932.76624, 16.98996,   0.00000, 0.00000, -5.34000);
	CreateDynamicObject(761, 159.89935, 1925.23108, 17.68205,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 156.59145, 1924.86108, 17.68205,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 110.67006, 1916.24695, 17.18007,   0.00000, 0.00000, -69.84000);
	CreateDynamicObject(874, 98.95346, 1881.75830, 16.85804,   0.00000, 0.00000, -24.11999);
	CreateDynamicObject(874, 106.34457, 1875.80054, 16.44260,   0.00000, 0.00000, -24.11999);
	CreateDynamicObject(874, 99.78128, 1856.98779, 16.86123,   0.00000, 0.00000, -35.63998);
	CreateDynamicObject(873, 102.19542, 1847.63867, 16.85721,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 102.54782, 1867.41064, 16.86123,   0.00000, 0.00000, -89.45998);
	CreateDynamicObject(760, 101.21680, 1824.28040, 16.62110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 99.29213, 1813.08374, 16.62110,   0.00000, 0.00000, -1.68000);
	CreateDynamicObject(760, 108.76413, 1829.21216, 16.62110,   0.00000, 0.00000, -1.68000);
	CreateDynamicObject(760, 110.55595, 1831.82324, 16.62110,   0.00000, 0.00000, -1.68000);
	CreateDynamicObject(760, 101.78478, 1838.78455, 16.62110,   0.00000, 0.00000, -1.68000);
	CreateDynamicObject(874, 109.61817, 1852.17725, 16.43848,   0.00000, 0.00000, 6.06001);
	CreateDynamicObject(760, 97.26042, 1817.73291, 16.62110,   0.00000, 0.00000, -1.68000);
	CreateDynamicObject(760, 109.88895, 1810.73022, 16.62110,   0.00000, 0.00000, -1.68000);
	CreateDynamicObject(761, 202.15860, 1814.45044, 16.53272,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(761, 200.99199, 1809.76123, 16.53063,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 196.67943, 1814.68372, 16.53484,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 196.41225, 1811.05066, 16.52856,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 189.55222, 1810.89185, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 187.42821, 1799.76257, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 183.99519, 1806.33545, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 184.88324, 1815.73059, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 179.21432, 1799.37585, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 177.55734, 1806.88574, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 182.14424, 1810.99548, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 190.34758, 1807.75952, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 202.22467, 1799.20117, 16.53063,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 191.42316, 1816.33313, 16.52651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 160.19963, 1808.28833, 17.15054,   0.00000, 0.00000, 15.12000);
	CreateDynamicObject(874, 164.43642, 1800.70349, 17.15054,   0.00000, 0.00000, 15.12000);
	CreateDynamicObject(874, 190.65300, 1810.17090, 16.69436,   0.00000, 0.00000, 58.62001);
	CreateDynamicObject(760, 173.80087, 1815.17334, 16.63350,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 178.40564, 1815.56738, 16.63041,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 178.97174, 1810.86133, 16.63663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 204.12752, 1815.36279, 16.63663,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(855, 243.05045, 1861.21716, 20.52040,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(855, 245.80753, 1861.26282, 19.90520,   0.00000, 0.00000, 44.94000);
	CreateDynamicObject(855, 247.56708, 1866.44580, 19.17016,   0.00000, 0.00000, 74.40002);
	CreateDynamicObject(855, 249.95731, 1862.95740, 18.35859,   0.00000, 0.00000, 62.04002);
	CreateDynamicObject(855, 248.91983, 1858.57410, 18.35053,   0.00000, 0.00000, 62.04002);
	CreateDynamicObject(874, 119.58654, 1813.77661, 16.45519,   0.00000, 0.00000, 25.32003);
	CreateDynamicObject(874, 136.41794, 1810.81653, 16.61699,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 126.83891, 1804.06360, 16.61699,   0.00000, 0.00000, -36.30000);
	CreateDynamicObject(874, 128.57111, 1811.79846, 16.61699,   0.00000, 0.00000, -66.54001);
	CreateDynamicObject(874, 147.44781, 1810.20972, 16.61699,   0.00000, 0.00000, -66.54001);
	CreateDynamicObject(874, 138.64804, 1802.25232, 16.61699,   0.00000, 0.00000, -66.54001);
	CreateDynamicObject(874, 106.18434, 1803.51343, 16.61699,   0.00000, 0.00000, -66.54001);
	CreateDynamicObject(874, 98.95849, 1803.36182, 17.43010,   0.00000, 0.00000, -66.54001);
	CreateDynamicObject(874, 94.39678, 1814.11584, 17.43010,   0.00000, 0.00000, -15.12001);
	CreateDynamicObject(761, 222.31183, 1812.37610, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 230.83585, 1814.46619, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 230.58437, 1808.11646, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 224.09904, 1800.58765, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 222.96771, 1806.43872, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 223.57448, 1814.78162, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 226.54222, 1813.37744, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 227.14102, 1809.26733, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 235.49356, 1811.32324, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 235.48343, 1807.06274, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 260.27411, 1808.80762, 16.39135,   0.00000, 0.00000, 40.44001);
	CreateDynamicObject(874, 249.00874, 1800.99597, 16.39135,   0.00000, 0.00000, 61.32001);
	CreateDynamicObject(761, 239.15160, 1814.05469, 16.62410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 247.94452, 1810.94312, 16.39135,   0.00000, 0.00000, 29.22001);
	CreateDynamicObject(874, 255.78889, 1814.42395, 16.39135,   0.00000, 0.00000, 29.22001);
	CreateDynamicObject(874, 227.30539, 1813.30225, 15.47521,   0.00000, 0.00000, 29.22001);
	CreateDynamicObject(855, 269.83820, 1877.94214, 17.88316,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(855, 262.42441, 1883.21118, 17.89570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(855, 273.80786, 1878.03625, 18.04650,   0.00000, 0.00000, -20.58000);
	CreateDynamicObject(855, 261.80194, 1887.00403, 17.89570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(873, 162.90161, 1891.67175, 18.21942,   0.00000, 0.00000, -14.88000);
	CreateDynamicObject(761, 154.61746, 1887.16956, 19.02942,   0.00000, 0.00000, 11.04000);
	CreateDynamicObject(761, 158.66031, 1850.90063, 19.02942,   0.00000, 0.00000, 29.94000);
	CreateDynamicObject(761, 163.39484, 1857.57715, 19.02942,   0.00000, 0.00000, 29.94000);
	CreateDynamicObject(761, 178.22516, 1857.87976, 19.02942,   0.00000, 0.00000, 29.94000);
	CreateDynamicObject(873, 192.39583, 1850.66052, 17.51036,   0.00000, 0.00000, 43.14000);
	CreateDynamicObject(873, 205.46980, 1851.11047, 17.51036,   0.00000, 0.00000, 43.14000);
	CreateDynamicObject(873, 220.45929, 1851.50659, 17.51036,   0.00000, 0.00000, 43.14000);
	CreateDynamicObject(760, 183.69620, 1847.88794, 16.63638,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 182.78639, 1849.67603, 16.63638,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 201.17746, 1847.63550, 16.63638,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 212.81804, 1847.65784, 16.63638,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 256.64841, 1933.36682, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 252.70503, 1936.04810, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 240.78618, 1935.77856, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 240.24196, 1930.14282, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 243.12233, 1933.26099, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 240.77791, 1932.61511, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 250.91324, 1932.92273, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 254.70251, 1936.57239, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 253.99019, 1931.44934, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 251.40469, 1929.16101, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 256.06308, 1929.58887, 16.62360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 260.02386, 1931.56006, 16.62396,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 262.95285, 1929.58679, 16.62396,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 260.36420, 1928.41235, 16.62396,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 237.59402, 1935.38464, 16.62396,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 237.57324, 1932.07666, 16.62396,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 235.93504, 1928.39929, 16.62396,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 261.89960, 1925.12415, 16.61521,   0.00000, 0.00000, 5.16000);
	CreateDynamicObject(874, 254.65620, 1923.48608, 16.61521,   0.00000, 0.00000, -42.00000);
	CreateDynamicObject(874, 231.06357, 1928.33862, 16.61521,   0.00000, 0.00000, -42.00000);
	CreateDynamicObject(874, 237.68607, 1923.38416, 16.61521,   0.00000, 0.00000, -42.00000);
	CreateDynamicObject(874, 269.99762, 1917.49622, 16.61521,   0.00000, 0.00000, -19.50001);
	CreateDynamicObject(874, 277.01385, 1911.45203, 16.61521,   0.00000, 0.00000, -19.50001);
	CreateDynamicObject(760, 269.43118, 1873.29614, 16.30642,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 272.15689, 1871.86658, 16.30851,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 275.28177, 1871.79150, 16.31058,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 266.05463, 1870.66724, 16.30430,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 265.33752, 1873.91040, 16.31263,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(650, 287.37579, 1832.32092, 16.51833,   0.00000, 0.00000, -92.64001);
	CreateDynamicObject(650, 282.13376, 1838.40015, 16.51833,   0.00000, 0.00000, -92.64001);
	CreateDynamicObject(650, 266.94650, 1829.87231, 16.51833,   0.00000, 0.00000, -92.64001);
	CreateDynamicObject(874, 266.01025, 1812.23621, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 284.37839, 1805.42822, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 293.21518, 1804.83972, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 283.82837, 1813.63318, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 274.22617, 1815.91748, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 276.75250, 1806.68433, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(761, 269.34344, 1813.86255, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 264.95737, 1828.61377, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 259.68149, 1829.21863, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 254.15259, 1829.19275, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 269.84689, 1830.39551, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 286.14157, 1836.77002, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 273.04935, 1835.66199, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(874, 278.04623, 1841.44434, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(761, 253.09790, 1834.00122, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 256.04803, 1835.73047, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 255.96619, 1845.73059, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 254.68329, 1840.27991, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 258.46368, 1842.44543, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 260.16049, 1846.64087, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 251.85658, 1838.06506, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 258.91379, 1834.88049, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 263.38083, 1843.59082, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 251.49118, 1843.23450, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 262.39508, 1837.56140, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(761, 258.29755, 1838.22339, 16.61583,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 278.67596, 1848.79248, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 276.73596, 1834.67847, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 276.02921, 1861.26404, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 268.91699, 1842.90100, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 276.78787, 1854.98608, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 275.74683, 1850.21863, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 274.51465, 1846.13745, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(874, 263.45297, 1834.29407, 16.39135,   0.00000, 0.00000, -15.53999);
	CreateDynamicObject(874, 254.05663, 1832.32275, 16.39135,   0.00000, 0.00000, -0.41999);
	CreateDynamicObject(874, 253.21735, 1842.70984, 16.39135,   0.00000, 0.00000, -0.41999);
	CreateDynamicObject(874, 260.46124, 1846.72656, 17.20343,   0.00000, 0.00000, -0.41999);
	CreateDynamicObject(874, 248.84639, 1853.25366, 17.20343,   0.00000, 0.00000, -0.41999);
	CreateDynamicObject(874, 241.65677, 1854.49719, 17.20343,   0.00000, 0.00000, -0.41999);
	CreateDynamicObject(760, 279.49533, 1884.53955, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 285.14340, 1877.65283, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 282.39749, 1880.72607, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 288.20102, 1881.45898, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 279.60968, 1891.99951, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 282.71524, 1884.52417, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 281.02631, 1878.29236, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 286.45142, 1880.62439, 16.62573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(855, 280.04129, 1879.65259, 17.92115,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(855, 276.53488, 1869.62866, 17.92115,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(873, 171.75909, 1935.04517, 17.50006,   0.00000, 0.00000, 33.66000);
	CreateDynamicObject(874, 259.73480, 1916.18237, 16.61521,   0.00000, 0.00000, -29.76001);
	CreateDynamicObject(874, 276.56534, 1902.62646, 16.61521,   0.00000, 0.00000, -29.76001);
	CreateDynamicObject(874, 241.16864, 1931.96167, 16.61521,   0.00000, 0.00000, -42.00000);
	CreateDynamicObject(874, 253.36061, 1931.10486, 16.61521,   0.00000, 0.00000, -42.00000);
	CreateDynamicObject(964, 193.10043, 2097.60547, 21.63377,   0.00000, 0.00000, 13.07998);
	CreateDynamicObject(964, 192.70601, 2094.56567, 21.63377,   0.00000, 0.00000, -58.86000);
	CreateDynamicObject(964, 194.78654, 2090.52979, 21.63377,   0.00000, 0.00000, -58.86000);
	CreateDynamicObject(874, 274.75406, 1841.80005, 16.39135,   0.00000, 0.00000, 7.26001);
	CreateDynamicObject(4832, 376.58890, 1977.35657, 29.64418,   0.00000, 0.00000, -183.17996);
	CreateDynamicObject(874, 171.20232, 1941.11279, 18.09106,   0.00000, 0.00000, -108.24001);
	CreateDynamicObject(874, 266.41861, 1858.11951, 17.20343,   0.00000, 0.00000, -14.75999);
	CreateDynamicObject(8355, 301.53180, 1992.14502, 16.64641,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19905, 287.19009, 1858.95520, 16.47040,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(874, 102.99719, 1911.46741, 17.18007,   0.00000, 0.00000, -69.84000);
	CreateDynamicObject(10763, 224.98885, 2022.93396, 49.37661,   0.00000, 0.00000, -135.84000);
	CreateDynamicObject(8355, 301.59006, 1954.53577, 16.66124,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8251, 268.15204, 2019.32959, 20.13668,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8251, 268.29346, 1980.32275, 20.13668,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8251, 301.14304, 2048.00732, 20.13668,   0.00000, 0.00000, -89.45999);
	CreateDynamicObject(18850, 342.85770, 1922.28076, 4.46358,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18850, 341.40210, 1952.53845, 4.48893,   0.00000, 0.00000, 0.00000);
	CreateVehicle(468, 217.4133, 1920.5571, 17.6326, 0.0000, -1, -1, 100);
	CreateVehicle(468, 213.8074, 1921.2250, 17.2498, 0.0000, -1, -1, 100);
	CreateVehicle(468, 223.3235, 1921.3293, 17.2498, 0.0000, -1, -1, 100);
	CreateVehicle(468, 209.6170, 1921.2726, 17.2498, 0.0000, -1, -1, 100);
	CreateVehicle(468, 220.5784, 1921.1113, 17.2498, 0.0000, -1, -1, 100);
	CreateVehicle(470, 176.0196, 1933.3401, 17.9248, 0.0000, -1, -1, 100);
	CreateVehicle(470, 182.1155, 1933.7120, 17.9248, 0.0000, -1, -1, 100);
	CreateVehicle(468, 238.1792, 1801.9408, 17.1270, 0.0000, -1, -1, 100);
	CreateVehicle(468, 234.4668, 1801.9307, 17.1270, 0.0000, -1, -1, 100);
	CreateVehicle(468, 230.8112, 1802.0846, 17.1270, 0.0000, -1, -1, 100);
	CreateVehicle(476, 273.8920, 1980.9885, 18.4259, -91.0800, -1, -1, 100);
	CreateVehicle(476, 274.7173, 2019.1190, 18.4259, -91.0800, -1, -1, 100);
	CreateVehicle(520, 301.3505, 2043.5499, 18.2548, 0.0000, -1, -1, 100);
	CreateVehicle(447, 342.5979, 1921.4664, 17.5321, 0.0000, -1, -1, 100);
	CreateVehicle(425, 341.0448, 1951.3667, 18.9150, 0.0000, -1, -1, 100);
	//Desert Airport
	CreateDynamicObject(987, 435.26001, 2560.45996, 15.53000,   0.00000, 0.00000, 152.99001);
	CreateDynamicObject(987, 424.63000, 2565.88989, 15.53000,   0.00000, 0.00000, 158.42000);
	CreateDynamicObject(987, 413.56000, 2570.28003, 15.53000,   0.00000, 0.00000, 187.07001);
	CreateDynamicObject(987, 401.70999, 2568.81006, 15.53000,   0.00000, 0.00000, 195.25000);
	CreateDynamicObject(987, 390.20001, 2565.66992, 15.53000,   0.00000, 0.00000, 195.55000);
	CreateDynamicObject(987, 378.70999, 2562.47998, 15.53000,   0.00000, 0.00000, 195.55000);
	CreateDynamicObject(987, 367.26999, 2559.47998, 15.53000,   0.00000, 0.00000, 192.03000);
	CreateDynamicObject(987, 355.67999, 2556.97998, 15.53000,   0.00000, 0.00000, 186.14000);
	CreateDynamicObject(987, 343.81000, 2555.68994, 15.53000,   0.00000, 0.00000, 180.78999);
	CreateDynamicObject(987, 331.89999, 2555.51001, 15.53000,   0.00000, 0.00000, 179.87000);
	CreateDynamicObject(987, 319.98001, 2555.56006, 15.53000,   0.00000, 0.00000, 179.87000);
	CreateDynamicObject(987, 308.07999, 2555.63989, 15.53000,   0.00000, 0.00000, 179.87000);
	CreateDynamicObject(987, 296.14001, 2555.68994, 15.53000,   0.00000, 0.00000, 179.87000);
	CreateDynamicObject(987, 284.17999, 2555.66992, 15.53000,   0.00000, 0.00000, 177.53999);
	CreateDynamicObject(987, 272.25000, 2556.16992, 15.53000,   0.00000, 0.00000, 178.55000);
	CreateDynamicObject(987, 260.51999, 2556.41992, 15.53000,   0.00000, 0.00000, 178.55000);
	CreateDynamicObject(987, 248.58000, 2556.72998, 15.53000,   0.00000, 0.00000, 178.55000);
	CreateDynamicObject(987, 236.64000, 2557.03003, 15.53000,   0.00000, 0.00000, 178.55000);
	CreateDynamicObject(987, 224.72000, 2557.33008, 15.53000,   0.00000, 0.00000, 178.55000);
	CreateDynamicObject(987, 212.80000, 2557.62988, 15.53000,   0.00000, 0.00000, 180.16000);
	CreateDynamicObject(987, 200.92999, 2557.54004, 15.53000,   0.00000, 0.00000, 180.16000);
	CreateDynamicObject(987, 189.00000, 2557.51001, 15.53000,   0.00000, 0.00000, 180.16000);
	CreateDynamicObject(987, 177.09000, 2557.46997, 15.53000,   0.00000, 0.00000, 180.16000);
	CreateDynamicObject(987, 188.75000, 2477.47998, 15.53000,   0.00000, 0.00000, 359.10001);
	CreateDynamicObject(987, 200.70000, 2477.27002, 15.53000,   0.00000, 0.00000, 358.29001);
	CreateDynamicObject(987, 212.63000, 2476.89990, 15.53000,   0.00000, 0.00000, 358.29001);
	CreateDynamicObject(987, 224.56000, 2476.54004, 15.53000,   0.00000, 0.00000, 359.01001);
	CreateDynamicObject(987, 236.50000, 2476.33008, 15.53000,   0.00000, 0.00000, 359.01001);
	CreateDynamicObject(987, 248.39000, 2476.14990, 15.53000,   0.00000, 0.00000, 359.01001);
	CreateDynamicObject(987, 260.26001, 2475.97998, 15.53000,   0.00000, 0.00000, 359.62000);
	CreateDynamicObject(3749, 158.77000, 2478.67993, 21.06570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 272.19000, 2475.90991, 15.53000,   0.00000, 0.00000, 1.34000);
	CreateDynamicObject(987, 284.12000, 2476.19995, 15.53000,   0.00000, 0.00000, 1.34000);
	CreateDynamicObject(987, 296.04001, 2476.48999, 15.53000,   0.00000, 0.00000, 0.30000);
	CreateDynamicObject(987, 307.92999, 2476.59009, 15.53000,   0.00000, 0.00000, 359.69000);
	CreateDynamicObject(987, 319.85999, 2476.55005, 15.53000,   0.00000, 0.00000, 359.69000);
	CreateDynamicObject(987, 331.79999, 2476.51001, 15.53000,   0.00000, 0.00000, 359.69000);
	CreateDynamicObject(987, 343.73999, 2476.46997, 15.53000,   0.00000, 0.00000, 359.69000);
	CreateDynamicObject(987, 355.67999, 2476.39990, 15.53000,   0.00000, 0.00000, 359.69000);
	CreateDynamicObject(987, 367.64999, 2476.34009, 15.53000,   0.00000, 0.00000, 333.60001);
	CreateDynamicObject(987, 431.41000, 2475.80005, 15.53000,   0.00000, 0.00000, 90.02000);
	CreateDynamicObject(987, 431.45999, 2487.73999, 15.53000,   0.00000, 0.00000, 90.02000);
	CreateDynamicObject(987, 431.45999, 2499.65991, 15.53000,   0.00000, 0.00000, 90.02000);
	CreateDynamicObject(987, 431.45001, 2511.56006, 15.53000,   0.00000, 0.00000, 90.02000);
	CreateDynamicObject(987, 431.42999, 2523.48999, 15.53000,   0.00000, 0.00000, 38.68000);
	CreateDynamicObject(987, 440.75000, 2530.92993, 15.53000,   0.00000, 0.00000, 50.63000);
	CreateDynamicObject(987, 448.28000, 2540.15991, 15.53000,   0.00000, 0.00000, 83.38000);
	CreateDynamicObject(987, 440.60001, 2557.69995, 15.53000,   0.00000, 0.00000, 152.60001);
	CreateDynamicObject(987, 449.63000, 2551.98999, 15.53000,   0.00000, 0.00000, 148.49001);
	CreateDynamicObject(3749, 174.27000, 2478.67993, 21.06570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 182.75000, 2477.47998, 15.53000,   0.00000, 0.00000, 359.10001);
	CreateDynamicObject(2939, 175.01241, 2472.65088, 14.29570,   -10.50000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 175.04980, 2484.72778, 14.29570,   -10.50000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 178.04980, 2484.72778, 14.29570,   -10.50000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 178.01241, 2472.65088, 14.29570,   -10.50000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 170.51241, 2472.65088, 14.29570,   -10.50000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 165.01241, 2472.65088, 14.29570,   -10.50000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 170.54980, 2484.72778, 14.29570,   -10.50000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 166.04980, 2484.72778, 14.29570,   -10.50000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 155.54980, 2484.72778, 14.29570,   -10.50000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 160.51241, 2472.65088, 14.29570,   -10.50000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 155.01241, 2472.65088, 14.29570,   -10.50000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 160.54980, 2484.72778, 14.29570,   -10.50000, 0.00000, 180.00000);
	CreateDynamicObject(987, 165.09000, 2557.46997, 15.53000,   0.00000, 0.00000, 180.16000);
	CreateDynamicObject(987, 149.34982, 2492.46191, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 149.35277, 2504.39355, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 149.36281, 2516.32446, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 149.36847, 2528.25342, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 149.36293, 2540.18921, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 149.36290, 2552.18921, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 161.35609, 2557.45435, 15.53000,   0.00000, 0.00000, 180.16000);
	CreateDynamicObject(987, 149.36290, 2557.51929, 15.53000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(4199, 425.58255, 2503.61157, 17.43590,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(8572, 422.66956, 2520.32593, 17.65180,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(8572, 377.29907, 2476.03052, 22.58666,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(8572, 379.19778, 2479.62964, 19.18856,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1698, 382.98743, 2479.40674, 15.87860,   44.50000, 0.00000, 90.00000);
	CreateDynamicObject(1698, 382.98740, 2479.76660, 15.87860,   44.50000, 0.00000, 90.00000);
	CreateDynamicObject(3279, 380.78577, 2435.04663, 24.12630,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3279, 428.59479, 2436.42334, 24.13090,   0.00000, 0.00000, 180.00000);
	CreateVehicle(490, 416.8731, 2515.4285, 16.3857, 90.0000, -1, -1, 100);
	CreateVehicle(490, 416.8731, 2507.4285, 16.3857, 90.0000, -1, -1, 100);
	CreateVehicle(490, 416.8731, 2499.4285, 16.3857, 90.0000, -1, -1, 100);
	CreateVehicle(490, 416.8731, 2491.4285, 16.3857, 90.0000, -1, -1, 100);
	CreateVehicle(469, 423.2601, 2491.5923, 20.6382, 90.0000, -1, -1, 100);
	CreateVehicle(469, 423.2601, 2506.0923, 20.6382, 90.0000, -1, -1, 100);
	CreateVehicle(520, 267.8996, 2538.9709, 17.5529, 180.0000, -1, -1, 100);
	CreateVehicle(425, 242.1718, 2537.8000, 17.4007, 180.0000, -1, -1, 100);
	CreateVehicle(487, 201.8237, 2542.6379, 16.9183, 131.1600, -1, -1, 100);
	CreateVehicle(487, 216.8363, 2537.8296, 16.9183, 141.3000, -1, -1, 100);
	CreateVehicle(476, 290.2465, 2541.5090, 17.8492, 180.0000, -1, -1, 100);
	CreateVehicle(476, 325.2465, 2541.5090, 17.8492, 180.0000, -1, -1, 100);
	CreateVehicle(468, 420.4179, 2532.2415, 16.2194, 0.0000, -1, -1, 100);
	CreateVehicle(468, 422.9179, 2532.2415, 16.2194, 0.0000, -1, -1, 100);
	CreateVehicle(468, 424.9179, 2532.2415, 16.2194, 0.0000, -1, -1, 100);
	CreateVehicle(433, 349.1082, 2537.5024, 16.8643, 180.0000, -1, -1, 100);
	CreateVehicle(433, 356.1082, 2537.5024, 16.8643, 180.0000, -1, -1, 100);
	//Hospital
	CreateDynamicObject(1215, 1032.90625, 1180.73694, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1032.90625, 1178.23694, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1032.90625, 1175.73694, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1032.90625, 1173.23694, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1032.90625, 1170.73694, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1032.90625, 1168.23291, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1180.79688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1178.29688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1175.79688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1173.29688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1170.79688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(3749, 1027.37561, 1163.67383, 15.55970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 1027.08655, 1163.67383, 15.55970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 1027.95361, 1163.67383, 15.55970,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 1032.90625, 1165.73291, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1168.29688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(1215, 1021.89838, 1165.79688, 10.33590,   356.85840, 0.00000, 3.14160);
	CreateDynamicObject(987, 1017.35510, 1161.24988, 9.51072,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1005.35510, 1161.24988, 9.51070,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 993.35510, 1161.24988, 9.51070,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 988.35510, 1161.24988, 9.51070,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 976.48163, 1149.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1161.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1137.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1125.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1113.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1101.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1089.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 976.48163, 1077.28735, 9.51070,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(987, 1140.18384, 987.57349, 9.57765,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(615, 1144.45349, 982.46405, 9.61719,   3.14159, 0.00000, 1.98930);
	CreateDynamicObject(987, 1152.13513, 987.54877, 9.57665,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1164.07385, 987.55328, 9.67966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1175.97449, 987.57928, 9.67970,   0.00000, 0.00000, 83.71651);
	CreateDynamicObject(987, 1175.97449, 987.57928, 9.67970,   0.00000, 0.00000, 83.71651);
	CreateDynamicObject(987, 1177.27808, 999.44507, 9.67970,   0.00000, 0.00000, 85.55956);
	CreateDynamicObject(987, 1178.19751, 1011.33734, 9.67970,   0.00000, 0.00000, 89.61588);
	CreateDynamicObject(987, 1178.26672, 1023.28674, 9.67970,   0.00000, 0.00000, 90.00883);
	CreateDynamicObject(987, 1178.28430, 1035.20911, 9.67970,   0.00000, 0.00000, 90.00883);
	CreateDynamicObject(987, 1178.28430, 1047.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1059.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1071.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1083.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1095.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1107.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1119.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1131.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1143.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1155.20911, 9.67970,   0.00000, 0.00000, 90.00880);
	CreateDynamicObject(987, 1178.28430, 1035.20911, 9.67970,   0.00000, 0.00000, 90.00883);
	CreateDynamicObject(987, 1178.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1166.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1154.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1142.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1130.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1118.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1106.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1094.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1082.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1070.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1058.33386, 1167.14819, 9.57970,   0.00000, 0.00000, 180.94679);
	CreateDynamicObject(987, 1048.83386, 1167.14819, 9.57970,   0.00000, 0.00000, 188.65863);
	CreateDynamicObject(3279, 982.17352, 1157.80554, 9.80802,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, 1173.52197, 1161.49768, 9.81640,   0.00000, 0.00000, 190.00000);
	CreateDynamicObject(2939, 1024.67444, 1157.37354, 7.36260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2939, 1024.71497, 1168.72559, 7.36260,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 1029.71497, 1168.72559, 7.36260,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 1030.71497, 1168.72559, 7.36260,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2939, 1030.67444, 1157.37354, 7.36260,   0.00000, 0.00000, 0.00000);
	CreateVehicle(433, 985.9128, 1104.6724, 10.8047, 270.0000, -1, -1, 100);
	CreateVehicle(433, 985.9128, 1111.1724, 10.8047, 270.0000, -1, -1, 100);
	CreateVehicle(433, 985.9128, 1117.6724, 10.8047, 270.0000, -1, -1, 100);
	CreateVehicle(470, 984.8562, 1137.2352, 10.8278, 270.0000, -1, -1, 100);
	CreateVehicle(470, 984.8562, 1143.2352, 10.8278, 270.0000, -1, -1, 100);
	CreateVehicle(470, 984.8562, 1149.2352, 10.8278, 270.0000, -1, -1, 100);
	//Army Restuarant
	CreateDynamicObject(987, -594.16217, 2564.05518, 52.27249,   0.00000, 0.00000, 6.55143);
	CreateDynamicObject(987, -582.27399, 2565.40503, 52.27249,   0.00000, 0.00000, 2.04274);
	CreateDynamicObject(987, -570.34998, 2565.87231, 52.27249,   0.00000, 0.00000, 359.27335);
	CreateDynamicObject(987, -558.41785, 2565.72485, 52.27249,   0.00000, 0.00000, 358.04791);
	CreateDynamicObject(987, -555.09937, 2565.62085, 52.27249,   0.00000, 0.00000, 358.04791);
	CreateDynamicObject(987, -543.11932, 2565.21460, 52.27250,   0.00000, 0.00000, 267.79807);
	CreateDynamicObject(987, -543.37103, 2557.84033, 52.27250,   0.00000, 0.00000, 268.30212);
	CreateDynamicObject(987, -543.76379, 2545.95020, 52.27250,   0.00000, 0.00000, 1.00000);
	CreateDynamicObject(987, -531.85675, 2546.18481, 52.27250,   0.00000, 0.00000, 1.00000);
	CreateDynamicObject(987, -519.91888, 2546.42798, 52.27250,   0.00000, 0.00000, 359.39029);
	CreateDynamicObject(987, -518.27899, 2546.44824, 52.27250,   0.00000, 0.00000, 359.39029);
	CreateDynamicObject(987, -506.38483, 2546.25513, 52.27250,   0.00000, 0.00000, 87.91891);
	CreateDynamicObject(987, -505.92215, 2558.19531, 52.27250,   0.00000, 0.00000, 87.91891);
	CreateDynamicObject(987, -505.51862, 2570.08472, 52.27250,   0.00000, 0.00000, 87.91891);
	CreateDynamicObject(3749, -504.04010, 2593.00415, 58.09957,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -505.37695, 2572.92798, 52.27250,   0.00000, 0.00000, 87.91890);
	CreateDynamicObject(987, -504.59103, 2602.62671, 52.27250,   0.00000, 0.00000, 87.91890);
	CreateDynamicObject(987, -504.14133, 2614.56079, 52.27250,   0.00000, 0.00000, 89.07558);
	CreateDynamicObject(987, -503.96405, 2626.47632, 52.27250,   0.00000, 0.00000, 88.77258);
	CreateDynamicObject(987, -503.92618, 2628.40771, 52.27250,   0.00000, 0.00000, 88.77260);
	CreateDynamicObject(987, -503.96405, 2626.47632, 52.27250,   0.00000, 0.00000, 88.77258);
	CreateDynamicObject(987, -503.70786, 2640.29565, 52.27250,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, -515.62451, 2640.31030, 52.27250,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, -527.53284, 2640.26538, 52.27250,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, -529.94080, 2640.25195, 52.27250,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, -541.86621, 2640.34058, 52.27250,   0.00000, 0.00000, 268.85376);
	CreateDynamicObject(987, -541.99097, 2633.27002, 52.27250,   0.00000, 0.00000, 268.85376);
	CreateDynamicObject(987, -542.24805, 2621.28955, 52.27250,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, -554.18646, 2621.31934, 52.27250,   0.00000, 0.00000, 178.95477);
	CreateDynamicObject(987, -566.10297, 2621.52271, 52.17250,   0.00000, 0.00000, 180.44954);
	CreateDynamicObject(987, -578.04681, 2621.39819, 52.16019,   0.00000, 0.00000, 194.01476);
	CreateDynamicObject(3279, -508.60791, 2634.99805, 52.40310,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(3279, -511.37103, 2550.92627, 52.40640,   0.00000, 0.00000, 180.00000);
//////////////////////////////////////////////////////////////////////////////////////////

	SOV_SHOP = CreatePickup(1210, 2, -148.4453, 1110.0249, 19.7500, -1);
	ARAB_SHOP = CreatePickup(1210, 2, -797.7403, 1544.9738, 27.3755, -1);
	EUR_SHOP = CreatePickup(1210, 2, 934.1088, 2146.2542, 11.4539, -1);
	AUS_SHOP = CreatePickup(1210, 2, -1469.3948, 2620.3484, 55.8898, -1);
	USA_SHOP = CreatePickup(1210, 2, -252.4021, 2603.1230, 62.8582, -1); //usa pickup
	NUKE = CreatePickup(1254, 2, 213.98, 1822.96, 6.4, -1);// NUKE PICKUP
	DA_SHOP = CreatePickup(1210, 2, 413.5599, 2536.8650, 19.1484, -1);

	GZ_USA = GangZoneCreate(-353.515625,2574.21875,-113.28125,2796.875); //NEW USA
	GZ_EUR = GangZoneCreate(873.046875, 2068.359375, 1001.953125, 2250.0); // Europe
	GZ_AUS = GangZoneCreate(-1611.328125, 2507.8125, -1388.671875, 2707.03125); //AUSTRALIAN ARMADA
	GZ_RUS = GangZoneCreate(-309.375,1024.21875,103.125,1211.71875); //Soviet Union
	GZ_ARAB = GangZoneCreate(-875.8406, 1389.667, -607.2495, 1623.225); //Arab

	KDBox = TextDrawCreate(2.000000, 229.000000, "box");
	TextDrawBackgroundColor(KDBox, 255);
	TextDrawFont(KDBox, 1);
	TextDrawLetterSize(KDBox, 0.000000, 6.000000);
	TextDrawColor(KDBox, -1);
	TextDrawSetOutline(KDBox, 0);
	TextDrawSetProportional(KDBox, 1);
	TextDrawSetShadow(KDBox, 1);
	TextDrawUseBox(KDBox, 1);
	TextDrawBoxColor(KDBox, 35);
	TextDrawTextSize(KDBox, 637.000000, 0.000000);
	TextDrawSetSelectable(KDBox, 0);

	Intro2 = TextDrawCreate(178.000000, 120.000000, "~w~CALL OF DUTY");
	TextDrawBackgroundColor(Intro2, 255);
	TextDrawFont(Intro2, 2);
	TextDrawLetterSize(Intro2, 0.909999, 5.000000);
	TextDrawColor(Intro2, -1);
	TextDrawSetOutline(Intro2, 1);
	TextDrawSetProportional(Intro2, 1);
	TextDrawSetSelectable(Intro2, 0);

	Intro3 = TextDrawCreate(125.000000, 160.000000, "~g~MODERN WARFARE 4");
	TextDrawBackgroundColor(Intro3, 255);
	TextDrawFont(Intro3, 2);
	TextDrawLetterSize(Intro3, 0.899999, 5.000000);
	TextDrawColor(Intro3, -1);
	TextDrawSetOutline(Intro3, 1);
	TextDrawSetProportional(Intro3, 1);
	TextDrawSetSelectable(Intro3, 0);

	Intro1 = TextDrawCreate(521.000000, 124.000000, " ~n~ ");
	TextDrawBackgroundColor(Intro1, 255);
	TextDrawFont(Intro1, 1);
	TextDrawLetterSize(Intro1, 0.500000, 10.000000);
	TextDrawColor(Intro1, -1);
	TextDrawSetOutline(Intro1, 0);
	TextDrawSetProportional(Intro1, 1);
	TextDrawSetShadow(Intro1, 1);
	TextDrawUseBox(Intro1, 1);
	TextDrawBoxColor(Intro1, 102);
	TextDrawTextSize(Intro1, 106.000000, 80.000000);
	TextDrawSetSelectable(Intro1, 0);

	logo1 = TextDrawCreate(5.000000,422.000000,"CALL OF DUTY");
	TextDrawAlignment(logo1,0);
	TextDrawBackgroundColor(logo1,0x00000033);
	TextDrawFont(logo1,3);
	TextDrawColor(logo1,0xffffffff);
	TextDrawSetOutline(logo1,1);
	TextDrawSetProportional(logo1,1);
	TextDrawSetShadow(logo1,1);
	TextDrawLetterSize(logo1,0.499999,1.600000);

	logo2 = TextDrawCreate(23.000000,432.000000,"~g~MODERN WARFARE 4");
	TextDrawAlignment(logo2,0);
	TextDrawBackgroundColor(logo2,0x00000033);
	TextDrawFont(logo2,3);
	TextDrawLetterSize(logo2,0.399999,1.300000);
	TextDrawColor(logo2,0xffffffff);
	TextDrawSetOutline(logo2,1);
	TextDrawSetProportional(logo2,1);
	TextDrawSetShadow(logo2,1);

	logo3 = TextDrawCreate(5.000000, 414.000000, "Version 3.0");
	TextDrawAlignment(logo3, 0);
	TextDrawBackgroundColor(logo3, 0x00000033);
	TextDrawFont(logo3 ,3);
	TextDrawLetterSize(logo3, 0.200000, 1.000000);
	TextDrawColor(logo3, 0xffffffff);
	TextDrawSetOutline(logo3, 1);
	TextDrawSetProportional(logo3, 1);
	TextDrawSetShadow(logo3, 1);

	AchTD0 = TextDrawCreate(80.000000, 240.000000, "~n~");
	TextDrawBackgroundColor(AchTD0, 255);
	TextDrawFont(AchTD0, 1);
	TextDrawLetterSize(AchTD0, 0.529999, 7.199999);
	TextDrawColor(AchTD0, -1);
	TextDrawSetOutline(AchTD0, 0);
	TextDrawSetProportional(AchTD0, 0);
	TextDrawSetShadow(AchTD0, 0);
	TextDrawUseBox(AchTD0, 1);
	TextDrawBoxColor(AchTD0, 75);
	TextDrawTextSize(AchTD0, 273.000000, 65.000000);
	TextDrawSetSelectable(AchTD0, 0);

	AchTD2 = TextDrawCreate(11.000000, 228.000000, "ld_drv:nawtxt");
	TextDrawBackgroundColor(AchTD2, 0);
	TextDrawFont(AchTD2, 4);
	TextDrawLetterSize(AchTD2, 0.699999, 11.000000);
	TextDrawColor(AchTD2, -1);
	TextDrawSetOutline(AchTD2, 0);
	TextDrawSetProportional(AchTD2, 1);
	TextDrawSetShadow(AchTD2, 0);
	TextDrawUseBox(AchTD2, 1);
	TextDrawBoxColor(AchTD2, 255);
	TextDrawTextSize(AchTD2, 88.000000, 90.000000);
	TextDrawSetSelectable(AchTD2, 0);

	AchTD1 = TextDrawCreate(21.000000, 263.000000, "~g~COD:MW4");
	TextDrawBackgroundColor(AchTD1, 255);
	TextDrawFont(AchTD1, 2);
	TextDrawLetterSize(AchTD1, 0.369998, 2.000000);
	TextDrawColor(AchTD1, -1);
	TextDrawSetOutline(AchTD1, 1);
	TextDrawSetProportional(AchTD1, 1);
	TextDrawSetSelectable(AchTD1, 0);

	EUR = TextDrawCreate(205.000000, 250.000000, "~g~Europe");
	TextDrawBackgroundColor(EUR, 255);
	TextDrawFont(EUR, 2);
	TextDrawLetterSize(EUR, 0.500, 2.500);
	TextDrawColor(EUR, RED);
	TextDrawSetOutline(EUR, 1);
	TextDrawSetProportional(EUR, 1);
	TextDrawSetShadow(EUR,1);

	E = TextDrawCreate(204.000000, 250.000000, "Europe Alliance");
	TextDrawBackgroundColor(E, 0x00000033);
	TextDrawFont(E, 2);
	TextDrawLetterSize(E, 0.500, 2.500);
	TextDrawColor(E, TEAM_EUROPE_COLOR);
	TextDrawSetOutline(E, 1);
	TextDrawSetProportional(E, 1);
	TextDrawSetShadow(E,1);

	A = TextDrawCreate(205.000000, 250.000000, "Arabian Invasion");
	TextDrawBackgroundColor(A, 0x00000033);
	TextDrawFont(A, 2);
	TextDrawLetterSize(A, 0.500, 2.500);
	TextDrawColor(A, TEAM_ARAB_COLOR);
	TextDrawSetOutline(A, 1);
	TextDrawSetProportional(A, 1);
	TextDrawSetShadow(A,1);

	S = TextDrawCreate(205.000000, 250.000000, "Soviet Union");
	TextDrawBackgroundColor(S, 0x00000033);
	TextDrawFont(S, 2);
	TextDrawLetterSize(S, 0.500, 2.500);
	TextDrawColor(S, TEAM_SOVIET_COLOR);
	TextDrawSetOutline(S, 1);
	TextDrawSetProportional(S, 1);
	TextDrawSetShadow(S,1);

	U = TextDrawCreate(205.000000, 250.000000, "United States Of America");
	TextDrawBackgroundColor(U, 0x00000033);
	TextDrawFont(U, 2);
	TextDrawLetterSize(U, 0.500, 2.500);
	TextDrawColor(U, TEAM_USA_COLOR);
	TextDrawSetOutline(U, 1);
	TextDrawSetProportional(U, 1);
	TextDrawSetShadow(U,1);

	A2 = TextDrawCreate(205.000000, 250.000000, "Australian Armada");
	TextDrawBackgroundColor(A2, 0x00000033);
	TextDrawFont(A2, 2);
	TextDrawLetterSize(A2, 0.500, 2.500);
	TextDrawColor(A2, TEAM_AUS_COLOR);
	TextDrawSetOutline(A2, 1);
	TextDrawSetProportional(A2, 1);
	TextDrawSetShadow(A2,1);

	Web = TextDrawCreate(501.000000,8.000000,"SIEGE-GAMING.TK");
	TextDrawAlignment(Web,0);
	TextDrawBackgroundColor(Web,0x00000033);
	TextDrawFont(Web,3);
	TextDrawLetterSize(Web,0.299999,1.000000);
	TextDrawColor(Web,0xFF9900FF);
	TextDrawSetOutline(Web,1);
	TextDrawSetProportional(Web,1);
	TextDrawSetShadow(Web,1);

	UsePlayerPedAnims();
	DisableInteriorEnterExits();

	Star[0] = TextDrawCreate(485.000000, 100.000000, "]");
	TextDrawLetterSize(Star[0], 0.449999, 1.600000);
	TextDrawAlignment(Star[0], 1);
	TextDrawColor(Star[0], 0xFF9900FF);
	TextDrawSetShadow(Star[0], 0);
	TextDrawSetOutline(Star[0], 1);
	TextDrawBackgroundColor(Star[0], 51);
	TextDrawFont(Star[0], 2);
	TextDrawSetProportional(Star[0], 1);

	Star[1] = TextDrawCreate(496.000000, 100.000000, "]");
	TextDrawLetterSize(Star[1], 0.449999, 1.600000);
	TextDrawAlignment(Star[1], 1);
	TextDrawColor(Star[1], 0xFF9900FF);
	TextDrawSetShadow(Star[1], 0);
	TextDrawSetOutline(Star[1], 1);
	TextDrawBackgroundColor(Star[1], 51);
	TextDrawFont(Star[1], 2);
	TextDrawSetProportional(Star[1], 1);

	Star[2] = TextDrawCreate(507.000000, 100.000000, "]");
	TextDrawLetterSize(Star[2], 0.449999, 1.600000);
	TextDrawAlignment(Star[2], 1);
	TextDrawColor(Star[2], 0xFF9900FF);
	TextDrawSetShadow(Star[2], 0);
	TextDrawSetOutline(Star[2], 1);
	TextDrawBackgroundColor(Star[2], 51);
	TextDrawFont(Star[2], 2);
	TextDrawSetProportional(Star[2], 1);

	Star[3] = TextDrawCreate(518.000000, 100.000000, "]");
	TextDrawLetterSize(Star[3], 0.449999, 1.600000);
	TextDrawAlignment(Star[3], 1);
	TextDrawColor(Star[3], 0xFF9900FF);
	TextDrawSetShadow(Star[3], 0);
	TextDrawSetOutline(Star[3], 1);
	TextDrawBackgroundColor(Star[3], 51);
	TextDrawFont(Star[3], 2);
	TextDrawSetProportional(Star[3], 1);

	Star[4] = TextDrawCreate(529.000000, 100.000000, "]");
	TextDrawLetterSize(Star[4], 0.449999, 1.600000);
	TextDrawAlignment(Star[4], 1);
	TextDrawColor(Star[4], 0xFF9900FF);
	TextDrawSetShadow(Star[4], 0);
	TextDrawSetOutline(Star[4], 1);
	TextDrawBackgroundColor(Star[4], 51);
	TextDrawFont(Star[4], 2);
	TextDrawSetProportional(Star[4], 1);

	Star[5] = TextDrawCreate(540.000000, 100.000000, "]");
	TextDrawLetterSize(Star[5], 0.449999, 1.600000);
	TextDrawAlignment(Star[5], 1);
	TextDrawColor(Star[5], 0xFF9900FF);
	TextDrawSetShadow(Star[5], 0);
	TextDrawSetOutline(Star[5], 1);
	TextDrawBackgroundColor(Star[5], 51);
	TextDrawFont(Star[5], 2);
	TextDrawSetProportional(Star[5], 1);

	Star[6] = TextDrawCreate(551.000000, 100.000000, "]");
	TextDrawLetterSize(Star[6], 0.449999, 1.600000);
	TextDrawAlignment(Star[6], 1);
	TextDrawColor(Star[6], 0xFF9900FF);
	TextDrawSetShadow(Star[6], 0);
	TextDrawSetOutline(Star[6], 1);
	TextDrawBackgroundColor(Star[6], 51);
	TextDrawFont(Star[6], 2);
	TextDrawSetProportional(Star[6], 1);

	Star[7] = TextDrawCreate(562.000000, 100.000000, "]");
	TextDrawLetterSize(Star[7], 0.449999, 1.600000);
	TextDrawAlignment(Star[7], 1);
	TextDrawColor(Star[7], 0xFF9900FF);
	TextDrawSetShadow(Star[7], 0);
	TextDrawSetOutline(Star[7], 1);
	TextDrawBackgroundColor(Star[7], 51);
	TextDrawFont(Star[7], 2);
	TextDrawSetProportional(Star[7], 1);

	Star[8] = TextDrawCreate(573.000000, 100.000000, "]");
	TextDrawLetterSize(Star[8], 0.449999, 1.600000);
	TextDrawAlignment(Star[8], 1);
	TextDrawColor(Star[8], 0xFF9900FF);
	TextDrawSetShadow(Star[8], 0);
	TextDrawSetOutline(Star[8], 1);
	TextDrawBackgroundColor(Star[8], 51);
	TextDrawFont(Star[8], 2);
	TextDrawSetProportional(Star[8], 1);

	Star[9] = TextDrawCreate(584.000000, 100.000000, "]");
	TextDrawLetterSize(Star[9], 0.449999, 1.600000);
	TextDrawAlignment(Star[9], 1);
	TextDrawColor(Star[9], 0xFF9900FF);
	TextDrawSetShadow(Star[9], 0);
	TextDrawSetOutline(Star[9], 1);
	TextDrawBackgroundColor(Star[9], 51);
	TextDrawFont(Star[9], 2);
	TextDrawSetProportional(Star[9], 1);

	//---------
	//snakes farm
	CP[SNAKE] = CreateDynamicCP(-36.5458, 2347.6426, 24.1406,3, -1,-1,-1,100.0);
	Zone[SNAKE] = GangZoneCreate(-62.5000000000005,2318.359375,23.4375,2390.625);
	//bayside sea shore
	CP[BAY] = CreateDynamicCP(260.0900,2889.5242,11.1854,3, -1,-1,-1,100.0);
	Zone[BAY] = GangZoneCreate(236.328125,2892.578125,292.96875,2943.359375);
	//area 51
	CP[A51] = CreateDynamicCP(268.2260, 1840.4688, 6.6811,3, -1,-1,-1,100.0);
	Zone[A51] = GangZoneCreate(-46.875,1697.265625,423.828125,2115.234375);
	//army hotel
	CP[ARMY] = CreateDynamicCP(-551.6992,2593.0771,53.9348,3, -1,-1,-1,100.0);
	Zone[ARMY] = GangZoneCreate(-617.1875,2531.25,-455.078125,2658.203125);
	//army petrol bunk
	CP[PETROL] = CreateDynamicCP(670.9215,1705.4658,7.1875,3, -1,-1,-1,100.0);
	Zone[PETROL] = GangZoneCreate(609.375,1652.34375,714.84375,1767.578125);
	//Oil Factory
	CP[OIL] = CreateDynamicCP(221.0856,1422.6615,10.5859,3, -1,-1,-1,100.0);
	Zone[OIL] = GangZoneCreate(95.703125,1339.84375,287.109375,1484.375);
	//Oil Station
	CP[DESERT] = CreateDynamicCP(558.9932,1221.8896,11.7188,3, -1,-1,-1,100.0);
	Zone[DESERT] = GangZoneCreate(529.296875,1205.078125,636.71875,1267.578125);
	//Quarry
	CP[QUARRY] = CreateDynamicCP(588.3246,875.7402,-42.4973,3, -1,-1,-1,100.0);
	Zone[QUARRY] = GangZoneCreate(439.453125,748.046875,863.28125,992.1875);
	//Desert Guest House
	CP[GUEST] = CreateDynamicCP(-314.8433,1773.9176,43.6406,3, -1,-1,-1,100.0);
	Zone[GUEST] = GangZoneCreate(-357.421875,1707.03125,-253.90625,1835.9375);
	//Big Ear
	CP[EAR] = CreateDynamicCP(-311.0136,1542.9733,75.5625,3, -1,-1,-1,100.0);
	Zone[EAR] = GangZoneCreate(-437.5,1513.671875,-244.140625,1636.71875);
	//Desert Airport
	CP[DA] = CreateDynamicCP(406.2509, 2460.2515, 15.9202,3, -1,-1,-1,100.0);
	Zone[DA] = GangZoneCreate(82.03125, 2396.484375, 462.890625, 2625);
	//Ammunation
	CP[AMMU] = CreateDynamicCP(796.7874, 1684.2380, 4.5854,3, -1,-1,-1,100.0);
	Zone[AMMU] = GangZoneCreate(767.578125, 1658.203125, 849.609375, 1728.515625);
	//Sherman Dam
	CP[DAM] = CreateDynamicCP(-734.3656, 2045.9260, 59.7652,3, -1,-1,-1,100.0);
	Zone[DAM] = GangZoneCreate(-873.046875, 1839.84375, -556.640625, 2103.515625);
	//Cluckin Bell
	CP[BELL] = CreateDynamicCP(-1196.2249, 1812.6929, 41.2066,3, -1,-1,-1,100.0);
	Zone[BELL] = GangZoneCreate(-1248.046875, 1792.96875, -1160.15625, 1869.140625);
	//Rusty Bridge
	CP[RUSTY] = CreateDynamicCP(-913.5380, 2685.7407, 41.8412,3, -1,-1,-1,100.0);
	Zone[RUSTY] = GangZoneCreate(-1212.890625, 2648.4375, -878.90625, 2742.1875);
	//Ghost Town
	CP[GHOST] = CreateDynamicCP(-379.5509, 2218.6895, 41.3212,3, -1,-1,-1,100.0);
	Zone[GHOST] = GangZoneCreate(-486.328125, 2179.6875, -351.5625, 2291.015625);
	//Hospital
	CP[HOSP] = CreateDynamicCP(1048.1426, 1009.3165, 10.2530,3, -1,-1,-1,100.0);
	Zone[HOSP] = GangZoneCreate(990.234375, 960.9375, 1183.59375, 1195.3125);
	//Villa
	CP[VILLA] = CreateDynamicCP(-688.2969, 939.0715, 12.8027,3, -1,-1,-1,100.0);
	Zone[VILLA] = GangZoneCreate(-732.421875, 884.765625, -656.25, 1001.953125);
	//Biological Ship
	CP[BIOSHIP] = CreateDynamicCP(-575.1106, 824.7502, 14.4421,3, -1,-1,-1,100.0);
	Zone[BIOSHIP] = GangZoneCreate(-591.796875, 779.296875, -533.203125, 949.21875);
	//Cerberus Island
	CP[CERBERUS] = CreateDynamicCP(-2314.8601, 1984.9391, 11.2232,3, -1,-1,-1,100.0);
	Zone[CERBERUS] = GangZoneCreate(-2516.9473, 1664.7159, -2080.2209, 2029.4932);

	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
		CountText[playerid] = TextDrawCreate(244.000000,293.000000, "SECOND REMAINING : 25");
		TextDrawBackgroundColor(CountText[playerid], 0x00000033);
		TextDrawFont(CountText[playerid], 2);
		TextDrawLetterSize(CountText[playerid], 0.300000,1.800000);
		TextDrawColor(CountText[playerid], 0xff0000ff);
		TextDrawSetOutline(CountText[playerid], 1);
		TextDrawSetProportional(CountText[playerid], 1);
		//-------
		RankLabel[playerid] = Create3DTextLabel(" ", 0x008080FF, 30.0, 40.0, 50.0, 40.0, 0);
	}
	if(!fexist("ladmin/"))
	{
		print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
		SetTimerEx("PrintWarning",2500,0,"s","ladmin");
		return 1;
	}
	if(!fexist("ladmin/logs/"))
	{
		print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
		SetTimerEx("PrintWarning",2500,0,"s","ladmin/logs");
		return 1;
	}
	if(!fexist("ladmin/config/"))
	{
		print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
		SetTimerEx("PrintWarning",2500,0,"s","ladmin/config");
		return 1;
	}
	if(!fexist("ladmin/users/"))
	{
		print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
		SetTimerEx("PrintWarning",2500,0,"s","ladmin/users");
		return 1;
	}
	UpdateConfig();

	ChangeVehPlate();

	#if defined DISPLAY_CONFIG
	ConfigInConsole();
	#endif

	//===================== [ The Menus ]===========================//
	LMainMenu = CreateMenu("Main Menu", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LMainMenu, 0, "Choose an option below");
	AddMenuItem(LMainMenu, 0, "Enable");
	AddMenuItem(LMainMenu, 0, "Disable");
	AddMenuItem(LMainMenu, 0, "Server Weather");
	AddMenuItem(LMainMenu, 0, "Server Time");
	AddMenuItem(LMainMenu, 0, "All Vehicles");
	AddMenuItem(LMainMenu, 0, "Admin Cars");
	AddMenuItem(LMainMenu, 0, "Tuning Menu");
	AddMenuItem(LMainMenu, 0, "Choose Weapon");
	AddMenuItem(LMainMenu, 0, "Teleports");
	AddMenuItem(LMainMenu, 0, "Exit Menu");//

	AdminEnable = CreateMenu("~b~Configuration ~g~ Menu",2, 55.0, 200.0, 150.0, 80.0);
	SetMenuColumnHeader(AdminEnable, 0, "Enable");
	AddMenuItem(AdminEnable, 0, "Anti Swear");
	AddMenuItem(AdminEnable, 0, "Bad Name Kick");
	AddMenuItem(AdminEnable, 0, "Anti Spam");
	AddMenuItem(AdminEnable, 0, "Ping Kick");
	AddMenuItem(AdminEnable, 0, "Read Cmds");
	AddMenuItem(AdminEnable, 0, "Read PMs");
	AddMenuItem(AdminEnable, 0, "Capital Letters");
	AddMenuItem(AdminEnable, 0, "ConnectMessages");
	AddMenuItem(AdminEnable, 0, "AdminCmdMessages");
	AddMenuItem(AdminEnable, 0, "Auto Login");
	AddMenuItem(AdminEnable, 0, "Return");

	AdminDisable = CreateMenu("~b~Configuration ~g~ Menu",2, 55.0, 200.0, 150.0, 80.0);
	SetMenuColumnHeader(AdminDisable, 0, "Disable");
	AddMenuItem(AdminDisable, 0, "Anti Swear");
	AddMenuItem(AdminDisable, 0, "Bad Name Kick");
	AddMenuItem(AdminDisable, 0, "Anti Spam");
	AddMenuItem(AdminDisable, 0, "Ping Kick");
	AddMenuItem(AdminDisable, 0, "Read Cmds");
	AddMenuItem(AdminDisable, 0, "Read PMs");
	AddMenuItem(AdminDisable, 0, "Capital Letters");
	AddMenuItem(AdminDisable, 0, "ConnectMessages");
	AddMenuItem(AdminDisable, 0, "AdminCmdMessages");
	AddMenuItem(AdminDisable, 0, "Auto Login");
	AddMenuItem(AdminDisable, 0, "Return");

	LWeather = CreateMenu("~b~Weather ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LWeather, 0, "Set Weather");
	AddMenuItem(LWeather, 0, "Clear Blue Sky");
	AddMenuItem(LWeather, 0, "Sand Storm");
	AddMenuItem(LWeather, 0, "Thunderstorm");
	AddMenuItem(LWeather, 0, "Foggy");
	AddMenuItem(LWeather, 0, "Cloudy");
	AddMenuItem(LWeather, 0, "High Tide");
	AddMenuItem(LWeather, 0, "Purple Sky");
	AddMenuItem(LWeather, 0, "Black/White Sky");
	AddMenuItem(LWeather, 0, "Dark, Green Sky");
	AddMenuItem(LWeather, 0, "Heatwave");
	AddMenuItem(LWeather,0,"Return");

	LTime = CreateMenu("~b~Time ~g~ Menu", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LTime, 0, "Set Time");
	AddMenuItem(LTime, 0, "Morning");
	AddMenuItem(LTime, 0, "Mid day");
	AddMenuItem(LTime, 0, "Afternoon");
	AddMenuItem(LTime, 0, "Evening");
	AddMenuItem(LTime, 0, "Midnight");
	AddMenuItem(LTime, 0, "Return");

	LCars = CreateMenu("~b~COD:MW4 ~g~Cars", 2,  55.0, 150.0, 100.0, 80.0);
	SetMenuColumnHeader(LCars, 0, "Choose a car");
	AddMenuItem(LCars, 0, "Turismo");
	AddMenuItem(LCars, 0, "Bandito");
	AddMenuItem(LCars, 0, "Vortex");
	AddMenuItem(LCars, 0, "NRG");
	AddMenuItem(LCars, 0, "S.W.A.T");
	AddMenuItem(LCars, 0, "Hunter");
	AddMenuItem(LCars, 0, "Jetmax (boat)");
	AddMenuItem(LCars, 0, "Rhino");
	AddMenuItem(LCars, 0, "Monster Truck");
	AddMenuItem(LCars, 0, "Sea Sparrow");
	AddMenuItem(LCars, 0, "More");
	AddMenuItem(LCars, 0, "Return");

	LCars2 = CreateMenu("~b~COD:MW4 ~g~Cars", 2,  55.0, 150.0, 100.0, 80.0);
	SetMenuColumnHeader(LCars2, 0, "Choose a car");
	AddMenuItem(LCars2, 0, "Dumper");
	AddMenuItem(LCars2, 0, "RC Tank");
	AddMenuItem(LCars2, 0, "RC Bandit");
	AddMenuItem(LCars2, 0, "RC Baron");
	AddMenuItem(LCars2, 0, "RC Goblin");
	AddMenuItem(LCars2, 0, "RC Raider");
	AddMenuItem(LCars2, 0, "RC Cam");
	AddMenuItem(LCars2, 0, "Train");
	AddMenuItem(LCars2, 0, "Return");

	LTuneMenu = CreateMenu("~b~Tuning ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LTuneMenu, 0, "Add to car");
	AddMenuItem(LTuneMenu,0,"NOS");
	AddMenuItem(LTuneMenu,0,"Hydraulics");
	AddMenuItem(LTuneMenu,0,"Wire Wheels");
	AddMenuItem(LTuneMenu,0,"Twist Wheels");
	AddMenuItem(LTuneMenu,0,"Access Wheels");
	AddMenuItem(LTuneMenu,0,"Mega Wheels");
	AddMenuItem(LTuneMenu,0,"Import Wheels");
	AddMenuItem(LTuneMenu,0,"Atomic Wheels");
	AddMenuItem(LTuneMenu,0,"Offroad Wheels");
	AddMenuItem(LTuneMenu,0,"Classic Wheels");
	AddMenuItem(LTuneMenu,0,"Paint Jobs");
	AddMenuItem(LTuneMenu,0,"Return");

	PaintMenu = CreateMenu("~b~Paint Job ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(PaintMenu, 0, "Choose paint");
	AddMenuItem(PaintMenu,0,"Paint Job 1");
	AddMenuItem(PaintMenu,0,"Paint Job 2");
	AddMenuItem(PaintMenu,0,"Paint Job 3");
	AddMenuItem(PaintMenu,0,"Paint Job 4");
	AddMenuItem(PaintMenu,0,"Paint Job 5");
	AddMenuItem(PaintMenu,0,"Black");
	AddMenuItem(PaintMenu,0,"White");
	AddMenuItem(PaintMenu,0,"Blue");
	AddMenuItem(PaintMenu,0,"Pink");
	AddMenuItem(PaintMenu,0,"Return");

	LVehicles = CreateMenu("~b~Vehicles ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LVehicles, 0, "Choose a car");
	AddMenuItem(LVehicles,0,"2-door Cars");
	AddMenuItem(LVehicles,0,"4-door Cars");
	AddMenuItem(LVehicles,0,"Fast Cars");
	AddMenuItem(LVehicles,0,"Other Vehicles");
	AddMenuItem(LVehicles,0,"Bikes");
	AddMenuItem(LVehicles,0,"Boats");
	AddMenuItem(LVehicles,0,"Planes");
	AddMenuItem(LVehicles,0,"Helicopters");
	AddMenuItem(LVehicles,0,"Return");

	twodoor = CreateMenu("~b~2-door Cars",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(twodoor, 0, "Choose a car");
	AddMenuItem(twodoor,0,"Feltzer");//533
	AddMenuItem(twodoor,0,"Stallion");//139
	AddMenuItem(twodoor,0,"Windsor");//555
	AddMenuItem(twodoor,0,"Bobcat");//422
	AddMenuItem(twodoor,0,"Yosemite");//554
	AddMenuItem(twodoor,0,"Broadway");//575
	AddMenuItem(twodoor,0,"Blade");//536
	AddMenuItem(twodoor,0,"Slamvan");//535
	AddMenuItem(twodoor,0,"Tornado");//576
	AddMenuItem(twodoor,0,"Bravura");//401
	AddMenuItem(twodoor,0,"Fortune");//526
	AddMenuItem(twodoor,0,"Return");

	fourdoor = CreateMenu("~b~4-door Cars",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(fourdoor, 0, "Choose a car");
	AddMenuItem(fourdoor,0,"Perenniel");//404
	AddMenuItem(fourdoor,0,"Tahoma");//566
	AddMenuItem(fourdoor,0,"Voodoo");//412
	AddMenuItem(fourdoor,0,"Admiral");//445
	AddMenuItem(fourdoor,0,"Elegant");//507
	AddMenuItem(fourdoor,0,"Glendale");//466
	AddMenuItem(fourdoor,0,"Intruder");//546
	AddMenuItem(fourdoor,0,"Merit");//551
	AddMenuItem(fourdoor,0,"Oceanic");//467
	AddMenuItem(fourdoor,0,"Premier");//426
	AddMenuItem(fourdoor,0,"Sentinel");//405
	AddMenuItem(fourdoor,0,"Return");

	fastcar = CreateMenu("~b~Fast Cars",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(fastcar, 0, "Choose a car");
	AddMenuItem(fastcar,0,"Comet");//480
	AddMenuItem(fastcar,0,"Buffalo");//402
	AddMenuItem(fastcar,0,"Cheetah");//415
	AddMenuItem(fastcar,0,"Euros");//587
	AddMenuItem(fastcar,0,"Hotring Racer");//494
	AddMenuItem(fastcar,0,"Infernus");//411
	AddMenuItem(fastcar,0,"Phoenix");//603
	AddMenuItem(fastcar,0,"Super GT");//506
	AddMenuItem(fastcar,0,"Turismo");//451
	AddMenuItem(fastcar,0,"ZR-350");//477
	AddMenuItem(fastcar,0,"Bullet");//541
	AddMenuItem(fastcar,0,"Return");

	Othercars = CreateMenu("~b~Other Vehicles",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(Othercars, 0, "Choose a car?");
	AddMenuItem(Othercars,0,"Monster Truck");//556
	AddMenuItem(Othercars,0,"Trashmaster");//408
	AddMenuItem(Othercars,0,"Bus");//431
	AddMenuItem(Othercars,0,"Coach");//437
	AddMenuItem(Othercars,0,"Enforcer");//427
	AddMenuItem(Othercars,0,"Rhino (Tank)");//432
	AddMenuItem(Othercars,0,"S.W.A.T.Truck");//601
	AddMenuItem(Othercars,0,"Cement Truck");//524
	AddMenuItem(Othercars,0,"Flatbed");//455
	AddMenuItem(Othercars,0,"BF Injection");//424
	AddMenuItem(Othercars,0,"Dune");//573
	AddMenuItem(Othercars,0,"Return");

	bikes = CreateMenu("~b~Bikes",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(bikes, 0, "Choose a bike");
	AddMenuItem(bikes,0,"BF-400");
	AddMenuItem(bikes,0,"BMX");
	AddMenuItem(bikes,0,"Faggio");
	AddMenuItem(bikes,0,"FCR-900");
	AddMenuItem(bikes,0,"Freeway");
	AddMenuItem(bikes,0,"NRG-500");
	AddMenuItem(bikes,0,"PCJ-600");
	AddMenuItem(bikes,0,"Pizzaboy");
	AddMenuItem(bikes,0,"Quad");
	AddMenuItem(bikes,0,"Sanchez");
	AddMenuItem(bikes,0,"Wayfarer");
	AddMenuItem(bikes,0,"Return");

	boats = CreateMenu("~b~Boats",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(boats, 0, "Choose a boat");
	AddMenuItem(boats,0,"Coastguard");//472
	AddMenuItem(boats,0,"Dingy");//473
	AddMenuItem(boats,0,"Jetmax");//493
	AddMenuItem(boats,0,"Launch");//595
	AddMenuItem(boats,0,"Marquis");//484
	AddMenuItem(boats,0,"Predator");//430
	AddMenuItem(boats,0,"Reefer");//453
	AddMenuItem(boats,0,"Speeder");//452
	AddMenuItem(boats,0,"Squallo");//446
	AddMenuItem(boats,0,"Tropic");//454
	AddMenuItem(boats,0,"Return");

	planes = CreateMenu("~b~Planes",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(planes, 0, "Choose a plane");
	AddMenuItem(planes,0,"Andromada");//592
	AddMenuItem(planes,0,"AT400");//577
	AddMenuItem(planes,0,"Beagle");//511
	AddMenuItem(planes,0,"Cropduster");//512
	AddMenuItem(planes,0,"Dodo");//593
	AddMenuItem(planes,0,"Hydra");//520
	AddMenuItem(planes,0,"Nevada");//553
	AddMenuItem(planes,0,"Rustler");//476
	AddMenuItem(planes,0,"Shamal");//519
	AddMenuItem(planes,0,"Skimmer");//460
	AddMenuItem(planes,0,"Stuntplane");//513
	AddMenuItem(planes,0,"Return");

	helicopters = CreateMenu("~b~Helicopters",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(helicopters, 0, "Choose a helicopter");
	AddMenuItem(helicopters,0,"Cargobob");//
	AddMenuItem(helicopters,0,"Hunter");//
	AddMenuItem(helicopters,0,"Leviathan");//
	AddMenuItem(helicopters,0,"Maverick");//
	AddMenuItem(helicopters,0,"News Chopper");//
	AddMenuItem(helicopters,0,"Police Maverick");//
	AddMenuItem(helicopters,0,"Raindance");//
	AddMenuItem(helicopters,0,"Seasparrow");//
	AddMenuItem(helicopters,0,"Sparrow");//
	AddMenuItem(helicopters,0,"Return");

	XWeapons = CreateMenu("~b~Weapons ~g~Main Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeapons, 0, "Choose a weapon");
	AddMenuItem(XWeapons,0,"Desert Eagle");//0
	AddMenuItem(XWeapons,0,"M4");
	AddMenuItem(XWeapons,0,"Sawnoff Shotgun");
	AddMenuItem(XWeapons,0,"Combat Shotgun");
	AddMenuItem(XWeapons,0,"UZI");
	AddMenuItem(XWeapons,0,"Rocket Launcher");
	AddMenuItem(XWeapons,0,"Minigun");//6
	AddMenuItem(XWeapons,0,"Sniper Rifle");
	AddMenuItem(XWeapons,0,"Big Weapons");
	AddMenuItem(XWeapons,0,"Small Weapons");//9
	AddMenuItem(XWeapons,0,"More");
	AddMenuItem(XWeapons,0,"Return");//11

	XWeaponsBig = CreateMenu("~b~Weapons ~g~Big Weapons",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeaponsBig, 0, "Choose a weapon");
	AddMenuItem(XWeaponsBig,0,"Shotgun");
	AddMenuItem(XWeaponsBig,0,"AK-47");
	AddMenuItem(XWeaponsBig,0,"Country Rifle");
	AddMenuItem(XWeaponsBig,0,"HS Rocket Launcher");
	AddMenuItem(XWeaponsBig,0,"Flamethrower");
	AddMenuItem(XWeaponsBig,0,"SMG");
	AddMenuItem(XWeaponsBig,0,"TEC9");
	AddMenuItem(XWeaponsBig,0,"Return");

	XWeaponsSmall = CreateMenu("~b~Weapons ~g~Small Weapons",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeaponsBig, 0, "Choose a weapon");
	AddMenuItem(XWeaponsSmall,0,"9mm");
	AddMenuItem(XWeaponsSmall,0,"Silenced 9mm");
	AddMenuItem(XWeaponsSmall,0,"Molotov Cocktail");
	AddMenuItem(XWeaponsSmall,0,"Fire Extinguisher");
	AddMenuItem(XWeaponsSmall,0,"Spraycan");
	AddMenuItem(XWeaponsSmall,0,"Frag Grenades");
	AddMenuItem(XWeaponsSmall,0,"Katana");
	AddMenuItem(XWeaponsSmall,0,"Chainsaw");
	AddMenuItem(XWeaponsSmall,0,"Return");

	XWeaponsMore = CreateMenu("~b~Weapons ~g~More Weapons",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeaponsBig, 0, "Choose a weapon");
	AddMenuItem(XWeaponsMore,0,"Jetpack");
	AddMenuItem(XWeaponsMore,0,"Knife");
	AddMenuItem(XWeaponsMore,0,"Flowers");
	AddMenuItem(XWeaponsMore,0,"Camera");
	AddMenuItem(XWeaponsMore,0,"Pool Cue");
	AddMenuItem(XWeaponsMore,0,"Baseball Bat");
	AddMenuItem(XWeaponsMore,0,"Golf Club");
	AddMenuItem(XWeaponsMore,0,"MAX AMMO");
	AddMenuItem(XWeaponsMore,0,"Return");

	LTele = CreateMenu("Teleports", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LTele, 0, "Teleport to where?");
	AddMenuItem(LTele, 0, "Las Venturas");//0
	AddMenuItem(LTele, 0, "Los Santos");//1
	AddMenuItem(LTele, 0, "San Fierro");//2
	AddMenuItem(LTele, 0, "The Desert");//3
	AddMenuItem(LTele, 0, "Flint Country");//4
	AddMenuItem(LTele, 0, "Mount Chiliad");//5
	AddMenuItem(LTele, 0, "Interiors");//6
	AddMenuItem(LTele, 0, "Return");//8

	LasVenturasMenu = CreateMenu("Las Venturas", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LasVenturasMenu, 0, "Teleport to where?");
	AddMenuItem(LasVenturasMenu, 0, "The Strip");//0
	AddMenuItem(LasVenturasMenu, 0, "Come-A-Lot");//1
	AddMenuItem(LasVenturasMenu, 0, "LV Airport");//2
	AddMenuItem(LasVenturasMenu, 0, "KACC Military Fuels");//3
	AddMenuItem(LasVenturasMenu, 0, "Yellow Bell Golf Club");//4
	AddMenuItem(LasVenturasMenu, 0, "Baseball Pitch");//5
	AddMenuItem(LasVenturasMenu, 0, "Return");//6

	LosSantosMenu = CreateMenu("Los Santos", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LosSantosMenu, 0, "Teleport to where?");
	AddMenuItem(LosSantosMenu, 0, "Ganton");//0
	AddMenuItem(LosSantosMenu, 0, "LS Airport");//1
	AddMenuItem(LosSantosMenu, 0, "Ocean Docks");//2
	AddMenuItem(LosSantosMenu, 0, "Pershing Square");//3
	AddMenuItem(LosSantosMenu, 0, "Verdant Bluffs");//4
	AddMenuItem(LosSantosMenu, 0, "Santa Maria Beach");//5
	AddMenuItem(LosSantosMenu, 0, "Mulholland");//6
	AddMenuItem(LosSantosMenu, 0, "Richman");//7
	AddMenuItem(LosSantosMenu, 0, "Return");//8

	SanFierroMenu = CreateMenu("San Fierro", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(SanFierroMenu, 0, "Teleport to where?");
	AddMenuItem(SanFierroMenu, 0, "SF Station");//0
	AddMenuItem(SanFierroMenu, 0, "SF Airport");//1
	AddMenuItem(SanFierroMenu, 0, "Ocean Flats");//2
	AddMenuItem(SanFierroMenu, 0, "Avispa Country Club");//3
	AddMenuItem(SanFierroMenu, 0, "Easter Basin (docks)");//4
	AddMenuItem(SanFierroMenu, 0, "Esplanade North");//5
	AddMenuItem(SanFierroMenu, 0, "Battery Point");//6
	AddMenuItem(SanFierroMenu, 0, "Return");//7

	DesertMenu = CreateMenu("The Desert", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(DesertMenu, 0, "Teleport to where?");
	AddMenuItem(DesertMenu, 0, "Aircraft Graveyard");//0
	AddMenuItem(DesertMenu, 0, "Area 51");//1
	AddMenuItem(DesertMenu, 0, "The Big Ear");//2
	AddMenuItem(DesertMenu, 0, "The Sherman Dam");//3
	AddMenuItem(DesertMenu, 0, "Las Barrancas");//4
	AddMenuItem(DesertMenu, 0, "El Quebrados");//5
	AddMenuItem(DesertMenu, 0, "Octane Springs");//6
	AddMenuItem(DesertMenu, 0, "Return");//7

	FlintMenu = CreateMenu("Flint Country", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(FlintMenu, 0, "Teleport to where?");
	AddMenuItem(FlintMenu, 0, "The Lake");//0
	AddMenuItem(FlintMenu, 0, "Leafy Hollow");//1
	AddMenuItem(FlintMenu, 0, "The Farm");//2
	AddMenuItem(FlintMenu, 0, "Shady Cabin");//3
	AddMenuItem(FlintMenu, 0, "Flint Range");//4
	AddMenuItem(FlintMenu, 0, "Becon Hill");//5
	AddMenuItem(FlintMenu, 0, "Fallen Tree");//6
	AddMenuItem(FlintMenu, 0, "Return");//7

	MountChiliadMenu = CreateMenu("Mount Chiliad", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(MountChiliadMenu, 0, "Teleport to where?");
	AddMenuItem(MountChiliadMenu, 0, "Chiliad Jump");//0
	AddMenuItem(MountChiliadMenu, 0, "Bottom Of Chiliad");//1
	AddMenuItem(MountChiliadMenu, 0, "Highest Point");//2
	AddMenuItem(MountChiliadMenu, 0, "Chiliad Path");//3
	AddMenuItem(MountChiliadMenu, 0, "Return");//7

	InteriorsMenu = CreateMenu("Interiors", 2,  55.0, 200.0, 130.0, 80.0);
	SetMenuColumnHeader(InteriorsMenu, 0, "Teleport to where?");
	AddMenuItem(InteriorsMenu, 0, "Planning Department");//0
	AddMenuItem(InteriorsMenu, 0, "LV PD");//1
	AddMenuItem(InteriorsMenu, 0, "Pizza Stack");//2
	AddMenuItem(InteriorsMenu, 0, "RC Battlefield");//3
	AddMenuItem(InteriorsMenu, 0, "Caligula's Casino");//4
	AddMenuItem(InteriorsMenu, 0, "Big Smoke's Crack Palace");//5
	AddMenuItem(InteriorsMenu, 0, "Madd Dogg's Mansion");//6
	AddMenuItem(InteriorsMenu, 0, "Dirtbike Stadium");//7
	AddMenuItem(InteriorsMenu, 0, "Vice Stadium (duel)");//8
	AddMenuItem(InteriorsMenu, 0, "Ammu-nation");//9
	AddMenuItem(InteriorsMenu, 0, "Atrium");//7
	AddMenuItem(InteriorsMenu, 0, "Return");//8

	return 1;
}

forward EnableCMD(playerid, id);
public EnableCMD(playerid, id)
{
	BlockCMD[playerid][id] = false;
}

forward CheatBuster();
public  CheatBuster()
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i))
		{
			new animname[32], animlib[32], str1[100];
			GetAnimationName(GetPlayerAnimationIndex(i), animlib, sizeof(animlib), animname, sizeof(animname));
			/*if(GetPlayerAnimationIndex(i) = 1008 && GetPlayerWeapon(i) != 46)
			{
				if(vX <= -0.800000  || vY <= -0.800000 || vZ <= -0.800000)
				{
					GetPlayerVelocity(i, vX, vY, vZ);
					format(str1, sizeof(str1), "Cheat Buster has detected fly hack on %s(%d)", pName(i), i);
					MessageToAdmins(red, str1);
				}
			}*/
			if(GetPlayerState(i) != PLAYER_STATE_SPECTATING && GetPlayerState(i) != PLAYER_STATE_SPAWNED && GetPlayerState(i) != PLAYER_STATE_WASTED)
			{
				if(!strcmp(animlib, "PARACHUTE", true) && !strcmp(animname, "FALL_SkyDive_Accel", true))
				{
					if(GetPlayerWeapon(i) != 46 && !IsPlayerInAnyVehicle(i))
					{
						print("cheat 1");
						format(str1, sizeof(str1), "Cheat Buster has banned %s(%d) for Fly hack", pName(i), i);
						print(str1);
						SendClientMessageToAll(red, str1);
						SetTimerEx("BanTimer", 1000, false, "d", i);
						TogglePlayerControllable(i, 0);
						SendClientMessage(i, red, "* If you think this ban is wrong, take a screenshot and appeal at our forum.");
					}
				}
				if (!strcmp(animname, "SWIM_CRAWL", true) && !IsPlayerInAnyVehicle(i))
				{
					print("cheat 2");
					new Float:vX, Float:vY, Float:vZ, Float:vS;
					GetPlayerVelocity(i, vX, vY, vZ);
					vS = floatsqroot((vX * vX) + (vY * vY) + (vZ + vZ) * 100);
					if(floatround(vS, floatround_round) >= 3)
					{
						format(str1, sizeof(str1), "Cheat Buster has banned %s(%d) for Fly hack", pName(i), i);
						print(str1);
						SendClientMessageToAll(red, str1);
						SetTimerEx("BanTimer", 1000, false, "d", i);
						TogglePlayerControllable(i, 0);
						SendClientMessage(i, red, "* If you think this ban is wrong, take a screenshot and appeal at our forum.");
					}
				}
				if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK && gClass[i] != JET && !PlayerInfo[i][Level])
				{
					format(str1, sizeof(str1), "Cheat Buster has banned %s(%d) for Jetpack hack", pName(i));
					SendClientMessageToAll(red, str1);
					SetTimerEx("BanTimer", 1000, false, "d", i);
					TogglePlayerControllable(i, 0);
					SendClientMessage(i, red, "* If you think this ban is wrong, take a screenshot and appeal at our forum.");
				}
				if(PlayerInfo[i][Money] != GetPlayerMoney(i))
				{
					ResetPlayerMoney(i);
					GivePlayerMoney(i, PlayerInfo[i][Money]);
				}
				if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
				{
					if(GetPlayerSpeedSpeedo(i, true) > 400)
					{
						if(GetVehicleModel(GetPlayerVehicleID(i)) != 520)
						{
							format(str1, sizeof(str1), "Cheat Buster has detected speed hack on %s(%d)", pName(i), i);
							MessageToAdmins(red, str1);
						}
					}
				}
				if(GetPlayerWeapon(i) == 36 && PlayerInfo[i][Level] == 0)
				{
					format(str1, sizeof(str1),"Cheat Buster has banned %s(%d) for Heat Seeker RPG.", pName(i), i);
					SaveToFile("BanLog",str1);
					SendClientMessageToAll(red, str1);
					SendClientMessage(i, red, "* If you think this ban is wrong, take a screenshot and appeal at forum");
					TogglePlayerControllable(i, 0);
					SetTimerEx("BanTimer", 1000, false, "d", i);
				}
			}
		}
	}
	return 1;
}

forward OnPlayerPause(playerid);
forward OnPlayerResume(playerid, time);

forward Callback_TabCheck();
public Callback_TabCheck()
{
	for(new i = 0, l = GetPlayerPoolSize(); i <= l; i ++)
	{
		if(IsPlayerConnected(i))
		{
			switch(GetPlayerState(i))
			{
				case PLAYER_STATE_ONFOOT, PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
				{
					if(Callback_GetFlag(i, e_bUpdate))
					{
						if(Callback_GetFlag(i, e_bPaused))
						{
							CallLocalFunction("OnPlayerResume", "ii", i, GetPlayerPausedTime(i));
						}

						Callback_SetFlag(i, e_bUpdate, false);
						Callback_SetFlag(i, e_bPaused, false);
					}
					if(!Callback_GetFlag(i, e_bPaused) && (GetConnectedTime(i) - s_aPlayerTickInfo[i][e_PLAYER_LAST_UPDATE]) >= 4000)
					{
						CallLocalFunction("OnPlayerPause", "d", i);

						s_aPlayerTickInfo[i][e_PLAYER_TICK] = GetConnectedTime(i);

						Callback_SetFlag(i, e_bPaused, true);
					}
				}
			}
		}
	}
}

stock static Callback_GetFlag(playerid, e_PLAYER_FLAGS:flag)
{
	return s_aPlayerInfo[playerid][e_bFlags] & flag;
}

stock static Callback_SetFlag(playerid, e_PLAYER_FLAGS:flag, status)
{
	if(status)
		return s_aPlayerInfo[playerid][e_bFlags] |= flag;
	else
		return s_aPlayerInfo[playerid][e_bFlags] &= ~flag;
}

stock GetPlayerPausedTime(playerid)
{
	return floatround(GetConnectedTime(playerid) - s_aPlayerTickInfo[playerid][e_PLAYER_TICK]) / 1000;
//    return GetConnectedTime(playerid) - s_aPlayerTickInfo[playerid][e_PLAYER_TICK];
}

stock GetConnectedTime(playerid)
{
	return NetStats_GetConnectedTime(playerid);
}

stock IsPlayerPaused(playerid)
{
	return Callback_GetFlag(playerid, e_bPaused);
}

public OnPlayerPause(playerid)
{
	if(playerid != INVALID_PLAYER_ID)
	{
		if(Capturing{playerid} == true)
		{
			new AFKc[80];
			format(AFKc, sizeof(AFKc),"{FF9E00}[AC] Cheat Buster has busted %s for AFK capturing.", pName(playerid));
			SendClientMessageToAll(-1,AFKc);
			SetPlayerHealth(playerid, 0.0);
			Capturing{playerid} = false;
		}
	}
	return 1;
}

public OnPlayerResume(playerid, time)
{
	new str[48];
	format(str, sizeof(str), "You've been paused for %d seconds.", time);
	SendClientMessage(playerid, red, str);
	return 1;
}

stock IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	if(X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

forward BonusCP();
public  BonusCP()
{
	new oldcp;
	if(RandomCpID == -1 && NoBonusCp == 1)
	{
		new cp[200];
		NoBonusCp = 0;
		RandomCpID = random(20);
		RandomCpMoney = random(5000 - 1500) + 1500;
		RandomCpScore = random(15 - 5) + 5;
		if(oldcp == RandomCpID)
		{
			RandomCpID = random(20);
		}
		format(cp, sizeof(cp),"[PED] %s is selected as a bonus capture zone, capture it to get $%d and %d score", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, cp);
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	else if(RandomCpID != -1 && !NoBonusCp)
	{
		new strz[200];
		format(strz, sizeof(strz),"[PED] Nobody captured bonus capture zone {FFFFFF}%s", GetCpName(RandomCpID));
		SendClientMessageToAll(bCol, strz);
		SendClientMessageToAll(bCol, "New bonus capture zone selecting in 5 minutes.");
		oldcp = RandomCpID;
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	return 1;
}

forward BonusPlayer();
public	BonusPlayer()
{
	new str[200];
	if(NoBonusPlayer == 1 && RandomID == INVALID_PLAYER_ID || !IsPlayerConnected(RandomID))
	{
		new PlayersOnline;
		for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(!IsPlayerNPC(i) && !PlayerInfo[i][OnDuty])
				{
					PlayersOnline += 1;
				}
			}
		}
		if(PlayersOnline >= 1)
		{
			NoBonusPlayer = 0;
			RandomMoney = random(5000 - 1000) + 1000;
			RandomID = random(PlayersOnline);
			RandomScore = random(15 - 5) + 5;
			format(str, sizeof(str),"[PED] %s (%d) has been selected as bonus player, kill them to get $%d and %d score", pName(RandomID), RandomID, RandomMoney, RandomScore);
			SendClientMessageToAll(bCol, str);
		}
	}
	else if(!NoBonusPlayer && RandomID != INVALID_PLAYER_ID || IsPlayerConnected(RandomID))
	{
		NoBonusPlayer = 0;
		format(str, sizeof(str),"[PED] %s (%d) has not been killed yet.", pName(RandomID), RandomID);
		SendClientMessageToAll(bCol, str);
	}
	return 1;
}

forward RegisterKick(playerid);
public  RegisterKick(playerid)
{
	if(playerid == INVALID_PLAYER_ID) return KillTimer(RegKick[playerid]);
	if(PlayerInfo[playerid][LoggedIn] == 0)
	{
		new string[200];
		SendClientMessage(playerid, red, "* Kicked because you're not logged in or registered.");
		format(string,sizeof(string),"%s (%d) was auto kicked (Reason: Login time exceeded)", pName(playerid), playerid);
		SendClientMessageToAll(grey, string);  print(string);
		SaveToFile("KickLog",string);  SetTimerEx("KickTimer", 1000, false, "d", playerid);
		KillTimer(RegKick[playerid]);
	}
	else
	{
		KillTimer(RegKick[playerid]);
		return 0;
	}
	return 1;
}

forward OnPlayerConnected(playerid);
public OnPlayerConnected(playerid)
{
	TextDrawHideForPlayer(playerid,Intro2);
	TextDrawHideForPlayer(playerid,Intro3);
	TextDrawHideForPlayer(playerid,Intro1);
	if (udb_Exists(pName(playerid)))
	{
		if(PlayerInfo[playerid][LoggedIn] == 0)
		{
			SendClientMessage(playerid, -1, "{D7374C}* Log in or register in 2 minutes, or you will be kicked.");
			RegKick[playerid] = SetTimerEx("RegisterKick", 120000, 0, "d", playerid);
			new string[200];
			format(string, sizeof(string),""cwhite"Welcome "cyellow"%s "cwhite"you are already registered\nKindly enter password to login to your account", pName(playerid));
			ShowPlayerDialog(playerid, LOGIN_DIALOG, DIALOG_STYLE_PASSWORD, "Login",string,"Login","Kick");
		}
		/*if(strfind(pName(playerid), "[MW4]", true) != -1 && PlayerInfo[playerid][CTagg] == 0)
		{
			new string[200];
			SendClientMessage(playerid, red, "[PED] Kicked because you're not allowed to use the [MW4] tag.");
			format(string,sizeof(string),"%s (%d) was auto kicked. (Reason: Unauthorized tag)", pName(playerid), playerid);
			SendClientMessageToAll(grey, string);  print(string);
			SaveToFile("KickLog",string);  SetTimerEx("KickTimer", 1000, false, "d", playerid);
		}*/
	}
	if (!udb_Exists(pName(playerid)))
	{
		if(PlayerInfo[playerid][Registered] == 0)
		{
			SendClientMessage(playerid, -1, "{80C732}[PED] {D7374C}Log in or register in 2 minutes, or you will be kicked.");
			SetTimerEx("RegisterKick", 120000, 0, "d", playerid);
			new string[200];
			format(string, sizeof(string),""cwhite"Welcome "cyellow"%s "cwhite"you are not registered\nKindly enter password to register your account", pName(playerid));
			ShowPlayerDialog(playerid, REGISTER_DIALOG, DIALOG_STYLE_PASSWORD, "Register",string,"Register","Kick");
		}
		/*if(strfind(pName(playerid), "[MW4]", true) != -1)
		{
			new string[200];
			SendClientMessage(playerid, red, "[PED] Kicked because you're not allowed to use the [MW4] tag.");
			format(string,sizeof(string),"%s (%d) was auto kicked. (Reason: Unauthorized tag)", pName(playerid), playerid);
			SendClientMessageToAll(grey, string);  print(string);
			SaveToFile("KickLog",string);  SetTimerEx("KickTimer", 1000, false, "d", playerid);
		}*/
	}
	return 1;
}

RandomSpawn(playerid)
{
	new rand;
	switch(gTeam[playerid])
	{
		case TEAM_EUROPE:
		{
			EurSpawn: rand = random(sizeof(EuropeSpawn));

			if(LastSpawnID[playerid] == rand)
			{
				goto EurSpawn;
				return 1;
			}
			SetPlayerPos(playerid, EuropeSpawn[rand][0], EuropeSpawn[rand][1], EuropeSpawn[rand][2]);
			LastSpawnID[playerid] = rand;
		}
		case TEAM_SOVIET:
		{
			SovSpawn: rand = random(sizeof(SovietSpawn));

			if(LastSpawnID[playerid] == rand)
			{
				goto SovSpawn;
				return 1;
			}

			SetPlayerPos(playerid, SovietSpawn[rand][0], SovietSpawn[rand][1], SovietSpawn[rand][2]);
		}
		case TEAM_ARAB:
		{
		   ArabSpawnn: rand = random(sizeof(ArabSpawn));

		   if(LastSpawnID[playerid] == rand)
		   {
			   goto ArabSpawnn;
			   return 1;
		   }

		   SetPlayerPos(playerid, ArabSpawn[rand][0], ArabSpawn[rand][1], ArabSpawn[rand][2]);
		}
		case TEAM_AUS:
		{
		   Auspawn: rand = random(sizeof(AusSpawn));

		   if(LastSpawnID[playerid] == rand)
		   {
			   goto Auspawn;
			   return 1;
		   }

		   SetPlayerPos(playerid, AusSpawn[rand][0], AusSpawn[rand][1], AusSpawn[rand][2]);
		}
		case TEAM_USA:
		{
		   USSpawn: rand = random(sizeof(USASpawn));

		   if(LastSpawnID[playerid] == rand)
		   {
			   goto USSpawn;
			   return 1;
		   }

		   SetPlayerPos(playerid, USASpawn[rand][0], USASpawn[rand][1], USASpawn[rand][2]);
		}
	}
	return 1;
}

public OnGameModeExit()
{
	// Killing timers
	KillTimer(BonusCpTimer);
	KillTimer(BonusTimer);
	SaveStats();
	DestroyAllMenus();
	return 1;
}

public SaveStats()
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i))
		{
			SendClientMessage(i, green, "Everyone's status has been automatically saved!");
			SavePlayer(i);
		}
	}
	return 1;
}

forward RandomMessage();
public RandomMessage()
{
	SendClientMessageToAll(-1, RandomMessages[random(sizeof(RandomMessages))]);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	TextDrawShowForPlayer(playerid, logo1);
	TextDrawShowForPlayer(playerid, logo2);
	TextDrawShowForPlayer(playerid, logo3);
	Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	switch(classid)
	{
		case 0:
		{
			// Europe
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawShowForPlayer(playerid, E);
			gTeam[playerid] = TEAM_EUROPE;
			SetPlayerTeam(playerid, 0);
			SetPlayerSkin(playerid, 60);
			SetPlayerColor(playerid, TEAM_EUROPE_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 1:
		{
			// Arabian INVASION
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270);
			TextDrawShowForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, EUR);
			TextDrawHideForPlayer(playerid, S);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, E);
			SetPlayerTeam(playerid, 1);
			SetPlayerSkin(playerid, 179);
			gTeam[playerid] = TEAM_ARAB;
			SetPlayerColor(playerid, TEAM_ARAB_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 2:
		{
			// SOVIET UNION
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270);
			TextDrawShowForPlayer(playerid, S);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, EUR);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, E);
			SetPlayerSkin(playerid, 206);
			SetPlayerTeam(playerid, 2);
			gTeam[playerid] = TEAM_SOVIET;
			SetPlayerColor(playerid, TEAM_SOVIET_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 3:
		{
			// USA
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270);
			TextDrawShowForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, S);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, EUR);
			TextDrawHideForPlayer(playerid, E);
			SetPlayerTeam(playerid, 5);
			SetPlayerSkin(playerid, 287);
			gTeam[playerid] = TEAM_USA;
			SetPlayerColor(playerid, TEAM_USA_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 4:
		{
			// AUS
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270);
			TextDrawShowForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, EUR);
			TextDrawHideForPlayer(playerid, E);
			SetPlayerTeam(playerid, 4);
			SetPlayerSkin(playerid, 73);
			gTeam[playerid] = TEAM_AUS;
			SetPlayerColor(playerid, TEAM_AUS_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	for(new i = 0; i < e_PLAYER_TICK_ENUM; i ++)
	{
		s_aPlayerTickInfo[playerid][i] = 0;
	}
	TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid, playerid);
	//-------------------------------------//
	TextDrawShowForPlayer(playerid,Intro1);
	TextDrawShowForPlayer(playerid,Intro2);
	TextDrawShowForPlayer(playerid,Intro3);
	TextDrawHideForPlayer(playerid,Intro2);
	TextDrawHideForPlayer(playerid,Intro3);
	TextDrawShowForPlayer(playerid,Intro2);
	TextDrawShowForPlayer(playerid,Intro3);
	IsPlayerUsingAnims[playerid] = 0;
	IsPlayerAnimsPreloaded[playerid] = 0;
	seconds[playerid] = 0;
	new online[128];
	format(online, sizeof(online), "Total players online: %d", ConnectedPlayers());
	SendClientMessageToAll(0xA3E5D4FF, online);
	//-----
	SetPlayerWorldBounds(playerid, 9999.9, -9999.9, 9999.9, -9999.9 );
	//-----
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid,-1,"Welcome To {009900}Siege Gaming");
	SendClientMessage(playerid,-1,"Welcome To Call of Duty {FFFFFF}- {009900}Modern Warfare 4");
	SendClientMessage(playerid,-1,"{009900}Siege Gaming! - Where real gaming exists!");
	//-------
	SetTimerEx("OnPlayerConnected", 5000, 0, "d", playerid);
	//-------
	LastPM[playerid] = INVALID_PLAYER_ID;
	Spectating[playerid] = 0;
	FirstSpawn[playerid] = 1;
	rconAttempts[playerid] = 0;
	PlayerInfo[playerid][Hide] = 0;
//==============================================================================

	IsPlayerCapturing[playerid][SNAKE] = 0;
	IsPlayerCapturing[playerid][BAY] = 0;
	IsPlayerCapturing[playerid][A51] = 0;
	IsPlayerCapturing[playerid][ARMY] = 0;
	IsPlayerCapturing[playerid][PETROL] = 0;
	IsPlayerCapturing[playerid][OIL] = 0;
	IsPlayerCapturing[playerid][DESERT] = 0;
	IsPlayerCapturing[playerid][QUARRY] = 0;
	IsPlayerCapturing[playerid][GUEST] = 0;
	IsPlayerCapturing[playerid][EAR] = 0;
	IsPlayerCapturing[playerid][DA] = 0;
	IsPlayerCapturing[playerid][AMMU] = 0;
	IsPlayerCapturing[playerid][DAM] = 0;
	IsPlayerCapturing[playerid][BELL] = 0;
	IsPlayerCapturing[playerid][RUSTY] = 0;
	IsPlayerCapturing[playerid][GHOST] = 0;
	IsPlayerCapturing[playerid][HOSP] = 0;
	IsPlayerCapturing[playerid][VILLA] = 0;
	IsPlayerCapturing[playerid][BIOSHIP] = 0;
	IsPlayerCapturing[playerid][CERBERUS] = 0;
//==============================================================================
	DND[playerid] = 0;
//==============================================================================
	StatsTD = CreatePlayerTextDraw(playerid, 633.000000, 420.000000, "~p~Name: ~w~Desiigner - ~g~Rank: ~w~Private - ~g~Class: ~w~Soldier~n~~p~Team: ~w~Europe - ~r~Kills: ~w~0 - ~b~Deaths: ~w~0 - ~y~Score: ~w~0");
	PlayerTextDrawAlignment(playerid, StatsTD, 3);
	PlayerTextDrawBackgroundColor(playerid, StatsTD, 255);
	PlayerTextDrawFont(playerid, StatsTD, 3);
	PlayerTextDrawLetterSize(playerid, StatsTD, 0.280000, 1.200000);
	PlayerTextDrawColor(playerid, StatsTD, -1);
	PlayerTextDrawSetOutline(playerid, StatsTD, 1);
	PlayerTextDrawSetProportional(playerid, StatsTD, 1);
	PlayerTextDrawSetSelectable(playerid, StatsTD, 0);

	AchTD3 = CreatePlayerTextDraw(playerid, 100.000000, 241.000000, "~y~Achievement name:");
	PlayerTextDrawBackgroundColor(playerid, AchTD3, 255);
	PlayerTextDrawFont(playerid, AchTD3, 2);
	PlayerTextDrawLetterSize(playerid, AchTD3, 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, AchTD3, -1);
	PlayerTextDrawSetOutline(playerid, AchTD3, 1);
	PlayerTextDrawSetProportional(playerid, AchTD3, 1);
	PlayerTextDrawSetSelectable(playerid, AchTD3, 0);

	AchTD4 = CreatePlayerTextDraw(playerid, 100.000000, 254.000000, "~y~Reward:");
	PlayerTextDrawBackgroundColor(playerid, AchTD4, 255);
	PlayerTextDrawFont(playerid, AchTD4, 2);
	PlayerTextDrawLetterSize(playerid, AchTD4, 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, AchTD4, -1);
	PlayerTextDrawSetOutline(playerid, AchTD4, 1);
	PlayerTextDrawSetProportional(playerid, AchTD4, 1);
	PlayerTextDrawSetSelectable(playerid, AchTD4, 0);

	AchTD5 = CreatePlayerTextDraw(playerid, 100.000000, 266.000000, "~y~Achievement Info:");
	PlayerTextDrawBackgroundColor(playerid, AchTD5, 255);
	PlayerTextDrawFont(playerid, AchTD5, 2);
	PlayerTextDrawLetterSize(playerid, AchTD5, 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, AchTD5, -1);
	PlayerTextDrawSetOutline(playerid, AchTD5, 1);
	PlayerTextDrawSetProportional(playerid, AchTD5, 1);
	PlayerTextDrawSetSelectable(playerid, AchTD5, 0);

	PlayerTD = CreatePlayerTextDraw(playerid, /*202.00000, 370.00000*/142.000000, 335.000000, " ");
	PlayerTextDrawBackgroundColor(playerid, PlayerTD, 255);
	PlayerTextDrawFont(playerid, PlayerTD, 2);
	PlayerTextDrawColor(playerid, PlayerTD, -1);
	PlayerTextDrawSetOutline(playerid, PlayerTD, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD, 0);
	PlayerTextDrawLetterSize(playerid, PlayerTD, /*0.240001, 1.499999*/0.199999, 1.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerTD, 0);

	IssuerTD = CreatePlayerTextDraw(playerid, /*440.00000, 370.00000*/142.000000, 375.000000, " ");
	PlayerTextDrawFont(playerid, IssuerTD, 2);
	PlayerTextDrawColor(playerid, IssuerTD, 0x00FF00FF);
	PlayerTextDrawBackgroundColor(playerid, IssuerTD, 255);
	PlayerTextDrawSetOutline(playerid, IssuerTD, 1);
	PlayerTextDrawLetterSize(playerid, IssuerTD, /*0.240001, 1.499999*/0.199999, 1.000000);
	PlayerTextDrawSetShadow(playerid, IssuerTD, 0);
	PlayerTextDrawSetSelectable(playerid, IssuerTD, 0);

	Death = CreatePlayerTextDraw(playerid, 170.000000, 240.000000, "KILLED BY ~r~(TWO)eXposed");
	PlayerTextDrawBackgroundColor(playerid, Death, 255);
	PlayerTextDrawFont(playerid, Death, 2);
	PlayerTextDrawLetterSize(playerid, Death, 0.500000, 3.000000);
	PlayerTextDrawColor(playerid, Death, -1);
	PlayerTextDrawSetOutline(playerid, Death, 1);
	PlayerTextDrawSetProportional(playerid, Death, 1);
	PlayerTextDrawSetSelectable(playerid, Death, 0);

	Kill = CreatePlayerTextDraw(playerid, 187.000000, 240.000000, "KILLED ~g~(TWO)eXposed");
	PlayerTextDrawBackgroundColor(playerid, Kill, 255);
	PlayerTextDrawFont(playerid, Kill, 2);
	PlayerTextDrawLetterSize(playerid, Kill, 0.500000, 3.000000);
	PlayerTextDrawColor(playerid, Kill, -1);
	PlayerTextDrawSetOutline(playerid, Kill, 1);
	PlayerTextDrawSetProportional(playerid, Kill, 1);
	PlayerTextDrawSetSelectable(playerid, Kill, 0);
	//==============================================================================
	//Useless Object Remover
	RemoveBuildingForPlayer(playerid, 3853, -2651.7813, 227.8672, 3.3281, 9999);
	RemoveBuildingForPlayer(playerid, 3854, -2651.7813, 227.8672, 3.3281, 9999);
	RemoveBuildingForPlayer(playerid, 3855, -2651.7813, 227.8672, 3.3281, 9999);
	//Stadium
	RemoveBuildingForPlayer(playerid, 3509, 1363.8828, 2077.3672, 9.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1351.3906, 2079.4766, 9.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1375.4297, 2079.8828, 11.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1362.2031, 2087.7813, 12.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1323.4766, 2094.1797, 10.8750, 0.25);
	//Unknown
	RemoveBuildingForPlayer(playerid, 669, 551.1016, 1221.3594, 10.7578, 0.25);
	//Aus
	RemoveBuildingForPlayer(playerid, 3297, -1568.1016, 2709.6484, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -1493.8359, 2688.9922, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3298, -1568.9609, 2633.5156, 55.3281, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -1518.0313, 2699.2938, 55.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -1534.4453, 2689.2734, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -1464.3438, 2656.5000, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -1574.5469, 2691.6875, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3301, -1566.1719, 2653.8828, 56.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -1584.0547, 2652.4609, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 11599, -1512.1563, 2514.4453, 54.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 11600, -1520.9766, 2620.0938, 57.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 11601, -1385.7578, 2640.8594, 54.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1606.2969, 2689.8281, 53.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1482.3672, 2704.8047, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1446.4531, 2639.3516, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1477.5859, 2549.2344, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1589.7188, 2708.6016, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1510.3516, 2646.6563, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1448.1328, 2690.7813, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1476.0391, 2565.3984, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1548.3359, 2699.6172, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1463.7656, 2692.8594, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1447.2344, 2653.3047, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -1448.8594, 2560.5703, 54.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 3357, -1523.8047, 2656.6563, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 3365, -1425.2344, 2581.2656, 54.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 11671, -1459.9375, 2583.1563, 57.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 11672, -1520.9609, 2577.1641, 58.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 11673, -1461.1563, 2627.6797, 62.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1579.5547, 2640.3750, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -1584.0547, 2652.4609, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1611.1250, 2680.4688, 53.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1579.9141, 2676.8594, 55.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1606.2969, 2689.8281, 53.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -1574.5469, 2691.6875, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1611.2109, 2701.8281, 55.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1602.9219, 2703.7734, 54.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1584.7891, 2695.7188, 54.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 11480, -1596.2656, 2695.9453, 56.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1589.7188, 2708.6016, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1548.3906, 2495.7344, 55.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 703, -1554.9922, 2510.0703, 57.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1530.5547, 2493.4609, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1535.4766, 2505.7578, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 11454, -1512.1563, 2514.4453, 54.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1492.7813, 2519.2938, 55.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 11625, -1430.5781, 2303.7578, 62.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 3241, -1568.9609, 2633.5156, 55.3281, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1560.2266, 2617.7031, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1559.2891, 2530.0156, 60.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1551.2734, 2610.6172, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1555.6875, 2636.5234, 55.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1544.5781, 2524.6328, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1540.1563, 2590.8125, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1534.1406, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1534.1406, 2605.4219, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 11456, -1520.9609, 2577.1641, 58.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 11455, -1505.4609, 2539.4922, 56.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1500.1172, 2563.4766, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1500.1172, 2589.3359, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1515.5547, 2595.2969, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1507.9922, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1520.8906, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1508.0000, 2605.4219, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1520.8906, 2605.4219, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -1509.6563, 2611.1172, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 11449, -1520.9766, 2620.0938, 57.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 11460, -1523.2891, 2619.2938, 65.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1500.1172, 2612.8594, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1515.2578, 2635.2188, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1500.1172, 2628.4531, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1510.3516, 2646.6563, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1476.0391, 2565.3984, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1477.5859, 2549.2344, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1470.7891, 2553.7109, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1462.4063, 2527.0078, 54.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1458.9531, 2565.6641, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1459.3203, 2552.8281, 55.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1464.2500, 2556.2344, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1476.7813, 2573.4141, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1491.7344, 2573.8438, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 11450, -1459.9375, 2583.1563, 57.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1491.7344, 2589.3359, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1467.9531, 2595.4297, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1458.3828, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1483.9531, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1486.0000, 2607.6406, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1479.8359, 2605.4219, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1479.6953, 2611.3984, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1483.6484, 2611.3984, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1460.7891, 2611.2422, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1458.3828, 2605.4219, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 11479, -1460.9141, 2613.7813, 54.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1491.7344, 2612.8672, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2613.5938, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2617.6250, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2621.6250, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1491.7344, 2628.4609, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 11543, -1461.1563, 2627.6797, 62.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2625.6094, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2629.4688, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1490.3203, 2632.8828, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2633.3281, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1454.2734, 2640.1406, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 11461, -1466.0313, 2637.5938, 54.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2637.1797, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2641.0391, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1457.8672, 2648.9922, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 11544, -1483.2813, 2642.3828, 56.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -1448.8594, 2560.5703, 54.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1437.4141, 2558.0859, 54.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 3292, -1425.2344, 2581.2656, 54.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3293, -1420.5469, 2583.9453, 58.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 3294, -1420.5469, 2591.1563, 57.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -1450.6406, 2591.4688, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1437.5859, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1437.5859, 2605.4219, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1436.1094, 2607.3906, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1409.7656, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1403.4766, 2611.8047, 55.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1393.0625, 2616.0859, 54.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 11611, -1383.5547, 2616.5234, 56.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1446.4531, 2639.3516, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1438.6719, 2630.0234, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1375.3594, 2630.2734, 53.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1369.2938, 2635.2422, 51.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1441.7891, 2647.3281, 55.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 11451, -1385.7578, 2640.8594, 54.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 11452, -1382.4531, 2648.0859, 55.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 11453, -1414.5078, 2650.4844, 57.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 3284, -1566.1719, 2653.8828, 56.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -1568.1016, 2709.6484, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1553.0156, 2680.6563, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1536.2891, 2661.4688, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1548.3359, 2699.6172, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1538.3906, 2683.9609, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1506, -1532.1328, 2657.4063, 55.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 3355, -1523.8047, 2656.6563, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1517.7422, 2677.1484, 55.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -1518.0313, 2699.2938, 55.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -1534.4453, 2689.2734, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1504.0859, 2704.5859, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1521.6094, 2707.5781, 55.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1486.3359, 2657.2578, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1447.2344, 2653.3047, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -1464.3438, 2656.5000, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1461.2344, 2678.8359, 55.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1485.8516, 2680.7422, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1448.1328, 2690.7813, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -1493.8359, 2688.9922, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1463.7656, 2692.8594, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1454.8906, 2698.2031, 55.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1482.3672, 2704.8047, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1449.5234, 2705.4766, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1466.9922, 2705.9453, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1436.1016, 2655.4766, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1391.0469, 2667.0781, 54.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1437.5234, 2691.8984, 55.2422, 0.25);
	//Europe
	RemoveBuildingForPlayer(playerid, 7628, 997.1641, 2143.2734, 13.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 7672, 969.6250, 2082.1406, 14.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 7673, 966.3594, 2140.9688, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1268, 1003.4844, 2178.4922, 25.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 7627, 969.6250, 2082.1406, 14.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 7926, 969.6250, 2082.1406, 14.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 3474, 978.2891, 2094.9922, 16.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 7647, 1005.2891, 2105.4531, 21.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 7493, 966.3594, 2140.9688, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1497, 965.8047, 2159.2406, 9.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1497, 965.7891, 2162.1484, 9.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 7915, 1005.1641, 2178.3984, 31.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1259, 1003.4844, 2178.4922, 25.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3459, 997.5078, 2183.0469, 17.3203, 0.25);
	//Arab
	RemoveBuildingForPlayer(playerid, 11570, -805.3984, 1510.7188, 24.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -880.9219, 1540.3203, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -885.4375, 1512.2578, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -882.8984, 1551.1875, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -881.1641, 1529.9375, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3344, -881.4375, 1564.3203, 25.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3344, -831.4375, 1587.5313, 25.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 11668, -816.6719, 1602.3516, 27.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 11670, -793.1563, 1557.0391, 33.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -885.4375, 1512.2578, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -881.1641, 1529.9375, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -882.8984, 1551.1875, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3171, -881.4375, 1564.3203, 25.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -880.9219, 1540.3203, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -832.3281, 1525.5391, 20.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -816.4922, 1526.7734, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -818.7656, 1546.9922, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11475, -805.3984, 1510.7188, 24.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -795.8906, 1501.7656, 20.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 11426, -800.8438, 1525.2734, 25.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -808.8906, 1523.3594, 26.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 11427, -793.1563, 1557.0391, 33.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -811.4063, 1532.0625, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11433, -788.0391, 1522.6250, 28.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -790.6250, 1552.3828, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -790.2031, 1547.3906, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11437, -775.5938, 1555.6797, 26.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -768.4844, 1502.9141, 24.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -832.1250, 1565.8438, 25.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 11476, -825.7891, 1564.1641, 30.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -826.8438, 1575.6484, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -835.4766, 1574.8594, 24.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 3171, -831.4375, 1587.5313, 25.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -828.8672, 1595.0078, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -823.7031, 1593.9922, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -826.3984, 1594.5781, 25.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -818.6016, 1591.2266, 26.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 11425, -816.6719, 1602.3516, 27.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -798.3984, 1566.7578, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -776.6406, 1586.2813, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11477, -778.9063, 1585.0313, 0.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -781.1016, 1594.1172, 25.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 11566, -792.3984, 1610.1719, 27.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -783.1875, 1601.2266, 26.2031, 0.25);
	//USA
	RemoveBuildingForPlayer(playerid, 3301, -216.8750, 2770.1484, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 3301, -282.2266, 2719.2578, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -264.0234, 2766.4063, 62.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -166.1328, 2731.0859, 63.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -195.6016, 2768.7578, 61.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -314.1875, 2720.6406, 62.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3298, -258.8438, 2786.1484, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3298, -165.3906, 2708.1016, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -229.2500, 2809.9453, 62.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -147.7891, 2684.8125, 63.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -167.6797, 2767.1328, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -154.5547, 2761.0078, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -275.1797, 2738.4844, 61.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -289.7422, 2758.2344, 61.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 16761, -312.2422, 2646.3750, 62.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16762, -327.6094, 2679.2469, 61.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 16763, -279.7188, 2650.2109, 61.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 16764, -288.8359, 2682.4297, 61.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 16765, -227.4531, 2716.3516, 62.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 16399, -312.2422, 2646.3750, 62.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16398, -279.7188, 2650.2109, 61.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 16402, -318.2891, 2650.2422, 69.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 16401, -271.9688, 2662.1953, 61.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 16776, -237.0234, 2662.8359, 62.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1340, -197.4922, 2659.9141, 62.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 16062, -222.6641, 2663.3047, 66.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 16063, -222.3438, 2663.4531, 71.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -206.6328, 2672.2422, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -278.9688, 2679.0234, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 16400, -327.6094, 2679.2469, 61.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 16396, -288.8359, 2682.4297, 61.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -156.0234, 2675.2031, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -333.5000, 2694.3672, 62.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -283.9453, 2695.3203, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -243.0313, 2688.3047, 62.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -307.9922, 2707.6563, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -263.1563, 2711.1250, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 16013, -286.2266, 2709.7266, 73.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 3284, -282.2266, 2719.2578, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -333.5703, 2719.3516, 61.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -314.1875, 2720.6406, 62.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -240.8359, 2737.1484, 62.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -267.9453, 2732.0469, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -275.1797, 2738.4844, 61.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -249.9141, 2744.0859, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -269.6953, 2750.4609, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -291.6094, 2752.6563, 59.2875, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -289.7422, 2758.2344, 61.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -297.8047, 2755.1875, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -267.1719, 2758.3594, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -264.0234, 2766.4063, 62.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3241, -258.8438, 2786.1484, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -245.3125, 2781.4922, 62.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -242.0313, 2789.3438, 61.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -232.1641, 2685.2734, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -202.5703, 2687.9688, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -215.6328, 2695.3125, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -193.6406, 2708.7188, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 16622, -190.8359, 2707.5859, 73.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 16011, -227.4531, 2716.3516, 62.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -209.7734, 2745.3906, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -231.2813, 2757.4297, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 16014, -228.8359, 2751.6094, 72.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 3284, -216.8750, 2770.1484, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -195.6016, 2768.7578, 61.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -230.4531, 2775.3359, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -213.2891, 2787.9297, 61.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 16015, -235.7891, 2782.9375, 73.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -229.2500, 2809.9453, 62.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -211.9609, 2805.6641, 61.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 3241, -165.3906, 2708.1016, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -155.0938, 2711.2344, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -177.5078, 2687.7188, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -166.1328, 2731.0859, 63.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -181.1953, 2728.2109, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -164.1641, 2754.7656, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -168.4844, 2740.5547, 61.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -186.6563, 2753.1406, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -167.6797, 2767.1328, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -174.5547, 2769.4609, 61.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -154.5547, 2761.0078, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -147.7891, 2684.8125, 63.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -150.2734, 2700.0781, 61.1484, 0.25);
	//Soviet
	RemoveBuildingForPlayer(playerid, 16413, -174.2109, 1120.4531, 24.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16433, -177.4375, 1056.3906, 22.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 16441, -32.5234, 1185.1875, 22.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 16443, -161.1719, 1179.5313, 22.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 16476, -98.1953, 1180.0703, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 3371, -18.0547, 1120.8594, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3371, 6.9453, 1075.8828, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3373, -38.0313, 1075.8828, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 3373, -43.0547, 1120.8594, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 16617, -122.7422, 1122.7500, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16618, -117.7656, 1079.4609, 22.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3372, 6.9531, 1120.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3372, -38.0469, 1045.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 16672, 86.9063, 1182.6641, 21.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 16738, -217.4922, 1026.8203, 27.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 16061, -193.3750, 1055.2891, 18.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 16007, -177.4375, 1056.3906, 22.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -233.1172, 1061.6563, 18.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -179.8984, 1069.4297, 19.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -169.3594, 1077.4766, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 774, -82.9688, 1022.7813, 18.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -127.8750, 1058.6641, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 780, -147.2500, 1055.5156, 18.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -120.4766, 1061.2109, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -82.2969, 1060.2734, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 769, -96.9453, 1054.9297, 18.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1071.1641, 19.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -139.3984, 1067.3516, 19.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -164.3750, 1078.3906, 17.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1076.4453, 19.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -30.1719, 1028.4141, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3304, -38.0469, 1045.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -51.6875, 1042.5938, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -55.5078, 1035.3828, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -51.1484, 1052.1094, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -20.2266, 1057.6406, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3303, -38.0313, 1075.8828, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -51.1406, 1064.8125, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 11.8594, 1009.8125, 17.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 780, 26.6094, 1030.3281, 16.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 773, 4.9453, 1052.8906, 14.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 3305, 6.9453, 1075.8828, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 44.5469, 1003.7813, 15.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 769, 53.2188, 1039.1484, 13.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 75.7500, 1067.0469, 11.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -228.3828, 1111.8750, 18.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 16434, -180.7109, 1081.0781, 27.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -146.9297, 1108.2344, 20.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -166.7500, 1107.9688, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -146.8438, 1093.6953, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -225.3125, 1127.2109, 18.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 16070, -174.2109, 1120.4531, 24.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -160.2656, 1122.5391, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1692, -161.7656, 1115.8516, 27.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 16760, -178.2031, 1122.3203, 28.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -154.8281, 1137.1406, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -160.0703, 1137.1406, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -149.8516, 1133.7656, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -162.1953, 1136.2266, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16740, -152.3203, 1144.0703, 30.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 16787, -152.3203, 1144.0703, 30.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 16060, -192.0469, 1147.3906, 17.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -161.9297, 1162.0781, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -164.1719, 1153.3125, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -170.1719, 1169.0547, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -149.8203, 1164.1094, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -186.4609, 1173.5625, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -162.0938, 1175.1406, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 16064, -161.1719, 1179.5313, 22.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 1692, -174.2422, 1177.8984, 22.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 3286, -230.2031, 1185.7734, 23.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -159.8594, 1187.8281, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16386, -117.7656, 1079.4609, 22.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -123.8125, 1079.3984, 19.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1081.7188, 19.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1352, -59.7813, 1088.1094, 18.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -86.8438, 1088.4141, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -50.1797, 1093.6953, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -136.5391, 1108.2344, 20.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -141.7344, 1108.2344, 20.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1352, -54.9063, 1103.9922, 18.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -133.9844, 1111.0781, 20.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -120.8750, 1110.4219, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -45.7344, 1109.0234, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 3303, -43.0547, 1120.8594, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 16385, -122.7422, 1122.7500, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -53.2656, 1135.5781, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -45.2031, 1130.4141, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -133.8516, 1134.4141, 20.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -133.3594, 1137.5938, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -106.6719, 1140.0234, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 16788, -49.2422, 1137.7031, 28.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -50.1797, 1144.1094, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -50.5078, 1160.9141, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -41.8125, 1160.0781, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -126.1719, 1159.0703, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -88.8594, 1165.3828, 19.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -47.7031, 1162.3672, 19.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -52.9766, 1162.3672, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -42.4219, 1162.3672, 19.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -96.7188, 1164.3516, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -127.0000, 1173.4219, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -44.3047, 1179.2734, 19.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 16475, -98.1953, 1180.0703, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -46.6953, 1179.5703, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -53.1016, 1188.3281, 18.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -132.0703, 1187.4609, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -76.5313, 1187.6406, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -26.7422, 1080.1719, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -26.4766, 1087.5859, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -3.7813, 1093.6953, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -5.2188, 1112.5703, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -13.2969, 1112.2656, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -4.3125, 1108.9453, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -30.1719, 1102.9375, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3304, 6.9531, 1120.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3305, -18.0547, 1120.8594, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -31.8672, 1118.8359, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -36.4922, 1136.0703, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 1.5000, 1133.8984, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 773, -18.3906, 1136.8203, 18.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 1.1484, 1137.7578, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -3.7813, 1144.1094, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 761, 12.0156, 1159.5703, 18.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 3.8281, 1159.2969, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 11.4063, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 6.1328, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 0.8594, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -26.4141, 1159.4844, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -30.1719, 1153.3516, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -31.3203, 1160.6875, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -24.8203, 1165.4063, 19.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -37.1484, 1162.3672, 19.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -31.8359, 1162.3672, 19.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 16069, 12.1172, 1178.5391, 20.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 16442, -18.4688, 1178.8828, 29.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 955, -14.7031, 1175.3594, 18.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -13.6953, 1187.4063, 18.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 16068, -32.5234, 1185.1875, 22.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -13.7891, 1185.4922, 18.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -25.7813, 1188.0313, 18.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -0.1484, 1193.6406, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -25.7813, 1193.6406, 22.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 19.8281, 1085.3984, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 774, 39.5547, 1087.0938, 18.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 19.5781, 1102.9375, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 17.1406, 1136.5938, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 33.6094, 1152.6953, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 24.2969, 1127.8516, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 30.4922, 1157.7891, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 22.2578, 1158.4766, 18.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 35.9922, 1157.1875, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 16.6875, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 21.9609, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 19.5781, 1153.3516, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 761, 27.6719, 1186.5547, 18.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 761, 25.3594, 1187.5859, 18.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 65.0313, 1148.2344, 18.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 59.0391, 1181.6797, 16.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 68.7969, 1117.5781, 17.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 71.1797, 1182.1719, 16.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 773, 72.9063, 1137.3281, 14.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 92.4141, 1099.5313, 12.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 79.3359, 1099.9453, 11.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 90.0859, 1147.8828, 16.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 16673, 86.9063, 1182.6641, 21.5391, 0.25);
	//Area51
	RemoveBuildingForPlayer(playerid, 3366, 276.6563, 2023.7578, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3366, 276.6563, 1989.5469, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3366, 276.6563, 1955.7656, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 16094, 191.1406, 1870.0391, 21.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3268, 276.6563, 2023.7578, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3268, 276.6563, 1989.5469, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3268, 276.6563, 1955.7656, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3267, 354.4297, 2028.4922, 22.4141, 0.25);
	//Desert Airport
	RemoveBuildingForPlayer(playerid, 3368, 161.7891, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3368, 323.0078, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 349.8750, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 269.2656, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 242.3984, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 188.6563, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 108.0469, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3367, 296.1406, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3367, 215.5313, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3367, 134.9141, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 108.0469, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3270, 161.7891, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 188.6563, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3271, 134.9141, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3271, 215.5313, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 242.3984, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 269.2656, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3271, 296.1406, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3270, 323.0078, 2411.3828, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 349.8750, 2438.2500, 15.4766, 0.25);
//==============================================================================
	PlayerInfo[playerid][VIP] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Headshots] = 0;
	PlayerInfo[playerid][Kills] = 0;
//	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Frozen] = 0;
	PlayerInfo[playerid][BonusKills] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][OnDuty] = 0;
	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Registered] = 0;
	PlayerInfo[playerid][God] = 0;
	PlayerInfo[playerid][GodCar] = 0;
	PlayerInfo[playerid][TimesSpawned] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][MuteWarnings] = 0;
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Caps] = 0;
	PlayerInfo[playerid][DoorsLocked] = 0;
	PlayerInfo[playerid][pCar] = -1;
	PlayerInfo[playerid][SpamCount] = 0;
	PlayerInfo[playerid][SpamTime] = 0;
	PlayerInfo[playerid][PingCount] = 0;
	PlayerInfo[playerid][PingTime] = 0;
	PlayerInfo[playerid][FailLogin] = 0;
	PlayerInfo[playerid][Tag] = 0;
	PlayerInfo[playerid][ConnectTime] = gettime();
	AntiSK[playerid] = 0;
	gTeam[playerid] = gClass[playerid] = -1;
	gRank[playerid] = 0;
	//------------------------------------------------------
	Attach3DTextLabelToPlayer(RankLabel[playerid], playerid, 0.0, 0.0, 0.5);
	//------------------------------------------------------
	new string[128]; //file[256];
	new tmp3[50]; GetPlayerIp(playerid,tmp3,50);
	//-----------------------------------------------------
	//-----------------------------------------------------
	if (dUserINT(pName(playerid)).("banned") == 1)
	{
		SendClientMessage(playerid, red, "Account Banned In Game, Appeal At Forum");
		format(string,sizeof(string),"%s (%d) was auto kicked. (Reason: Banned)",pName(playerid),playerid);
		SendClientMessageToAll(grey, string);  print(string);
		SaveToFile("KickLog",string);  SetTimerEx("KickTimer", 1000, false, "d", playerid);
	}
	//-----------------------------------------------------
	if(ServerInfo[NameKick] == 1) {
		for(new s = 0; s < BadNameCount; s++) {
			if(!strcmp(BadNames[s],pName(playerid),true)) {
				SendClientMessage(playerid,red, "Your name is on our black list, you have been kicked.");
				format(string,sizeof(string),"%s (%d) was auto kicked. (Reason: Forbidden name)",pName(playerid),playerid);
				SendClientMessageToAll(grey, string);  print(string);
				SaveToFile("KickLog",string);  SetTimerEx("KickTimer", 1000, false, "d", playerid);
				return 1;
			}
		}
	}
	//-----------------------------------------------------
	/*if(ServerInfo[PartNameKick] == 1) {
		for(new s = 0; s < BadPartNameCount; s++) {
			new pos;
			while((pos = strfind(pName(playerid),BadPartNames[s],true)) != -1) for(new i = pos, j = pos + strlen(BadPartNames[s]); i < j; i++)
			{
				SendClientMessage(playerid,red, "Your name is not allowed on this server, you have been kicked.");
				format(string,sizeof(string),"%s (%d) was auto kicked. (Reason: Forbidden name)",pName(playerid),playerid);
				SendClientMessageToAll(grey, string);  print(string);
				SaveToFile("KickLog",string);  SetTimerEx("KickTimer", 1000, false, "d", playerid);
				return 1;
			}
		}
	}*/
	//-----------------------------------------------------
	if(strlen(dini_Get("ladmin/config/aka.txt", tmp3)) == 0) dini_Set("ladmin/config/aka.txt", tmp3, pName(playerid));
	else
	{
		if( strfind( dini_Get("ladmin/config/aka.txt", tmp3), pName(playerid), true) == -1 )
		{
			format(string,sizeof(string),"%s,%s", dini_Get("ladmin/config/aka.txt",tmp3), pName(playerid));
			dini_Set("ladmin/config/aka.txt", tmp3, string);
		}
	}
	//-----------------------------------------------------
	Streak[playerid] = 0;
	//------
	switch(tCP[SNAKE])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[SNAKE], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[BAY])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[BAY], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[BAY], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[BAY], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[BAY], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[BAY], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[BAY], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[A51])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[A51], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[A51], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[A51], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[A51], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[A51], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[A51], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[ARMY])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[ARMY], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[PETROL])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[PETROL], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[OIL])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[OIL], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[OIL], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[OIL], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[OIL], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[OIL], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[OIL], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[DESERT])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[DESERT], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[QUARRY])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[QUARRY], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[GUEST])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[GUEST], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[EAR])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[EAR], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[EAR], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[EAR], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[EAR], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[EAR], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[EAR], TEAM_ZONE_SOVIET_COLOR);
	}
	//------
	switch(tCP[DA])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[DA], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[DA], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[DA], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[DA], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[DA], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[DA], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[AMMU])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[AMMU], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[DAM])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[DAM], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[DAM], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[DAM], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[DAM], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[DAM], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[DAM], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[BELL])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[BELL], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[BELL], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[BELL], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[BELL], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[BELL], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[BELL], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[RUSTY])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[RUSTY], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[GHOST])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[GHOST], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[HOSP])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[HOSP], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[VILLA])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[VILLA], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[BIOSHIP])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[BIOSHIP], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_SOVIET_COLOR);
	}
	//--------
	switch(tCP[CERBERUS])
	{
		case TEAM_NONE: GangZoneShowForAll(Zone[CERBERUS], -66);
		case TEAM_EUROPE: GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_ARAB_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_AUS_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_SOVIET_COLOR);
	}
	return 1;
}

UpdateLabelText(playerid)
{
	new string[120];
	format(string, sizeof(string),"%s - %s\n %s", GetRankName(playerid), GetTeamName(playerid), GetClass(playerid));
	if(gTeam[playerid] == TEAM_EUROPE)
	{
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], 0x15FF00FF, string);
	}
	if(gTeam[playerid] == TEAM_SOVIET)
	{
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], 0xFF0000FF, string);
	}
	if(gTeam[playerid] == TEAM_AUS)
	{
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], 0x690069FF, string);
	}
	if(gTeam[playerid] == TEAM_ARAB)
	{
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], 0xFFAF02FF, string);
	}
	if(gTeam[playerid] == TEAM_USA)
	{
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], 0x0080FFFF, string);
	}
	if(gTeam[playerid] == TEAM_NONE)
	{
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < e_PLAYER_TICK_ENUM; i++) s_aPlayerTickInfo[i][e_PLAYER_TICK] = 0;
	s_aPlayerInfo[playerid][e_bFlags] = e_PLAYER_FLAGS:0;
	
	KillTimer(RegKick[playerid]);
	if(PlayerInfo[playerid][LoggedIn] == 1)	SavePlayer(playerid);
	if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
	if(PlayerInfo[playerid][Jailed] == 1) KillTimer(JailTimer[playerid]);
	if(PlayerInfo[playerid][Frozen] == 1) KillTimer(FreezeTimer[playerid]);

	if(RandomID == playerid)
	{
		new str[200];
		format(str, sizeof(str), "[PED] Bonus player %s (%d) has disconnected.", pName(RandomID), RandomID);
		SendClientMessageToAll(bCol, str);
		SendClientMessageToAll(bCol, "New bonus player getting selected in next 5 minutes");
		RandomID = -1;
		RandomMoney = RandomScore = 0;
		NoBonusPlayer = 1;
		KillTimer(BonusTimer);
		BonusTimer = SetTimer("BonusPlayer", 300000, 1);
	}
	PlayerTextDrawDestroy(playerid, PlayerTD);
	PlayerTextDrawDestroy(playerid, IssuerTD);

	if(!Captured[SNAKE] && IsPlayerCapturing[playerid][SNAKE] == 1) LeavingSnakeFarm(playerid);
	if(!Captured[BAY] && IsPlayerCapturing[playerid][BAY] == 1) LeavingBay(playerid);
	if(!Captured[A51] && IsPlayerCapturing[playerid][A51] == 1)	LeavingArea51(playerid);
	if(!Captured[ARMY] && IsPlayerCapturing[playerid][ARMY] == 1) LeavingArmy(playerid);
	if(!Captured[PETROL] && IsPlayerCapturing[playerid][PETROL] == 1) LeavingPetrol(playerid);
	if(!Captured[OIL] && IsPlayerCapturing[playerid][OIL] == 1)	LeavingOil(playerid);
	if(!Captured[DESERT] && IsPlayerCapturing[playerid][DESERT] == 1) LeavingDesert(playerid);
	if(!Captured[QUARRY] && IsPlayerCapturing[playerid][QUARRY] == 1) LeavingQuarry(playerid);
	if(!Captured[GUEST] && IsPlayerCapturing[playerid][GUEST] == 1) LeavingGuest(playerid);
	if(!Captured[EAR] && IsPlayerCapturing[playerid][EAR] == 1) LeavingEar(playerid);
	if(!Captured[DA] && IsPlayerCapturing[playerid][DA] == 1) LeavingAirport(playerid);
	if(!Captured[AMMU] && IsPlayerCapturing[playerid][AMMU] == 1) LeavingAmmunation(playerid);
	if(!Captured[DAM] && IsPlayerCapturing[playerid][DAM] == 1) LeavingDam(playerid);
	if(!Captured[BELL] && IsPlayerCapturing[playerid][BELL] == 1) LeavingBell(playerid);
	if(!Captured[RUSTY] && IsPlayerCapturing[playerid][RUSTY] == 1) LeavingRusty(playerid);
	if(!Captured[GHOST] && IsPlayerCapturing[playerid][GHOST] == 1) LeavingGhost(playerid);
	if(!Captured[HOSP] && IsPlayerCapturing[playerid][HOSP] == 1) LeavingHospital(playerid);
	if(!Captured[VILLA] && IsPlayerCapturing[playerid][VILLA] == 1) LeavingVilla(playerid);
	if(!Captured[BIOSHIP] && IsPlayerCapturing[playerid][BIOSHIP] == 1) LeavingBioShip(playerid);
	if(!Captured[CERBERUS] && IsPlayerCapturing[playerid][CERBERUS] == 1) LeavingCerberus(playerid);
	//if(UnderHelp[SNAKE] && IsPlayerHelping[playerid][SNAKE]) LeavingHSnakeFarm(playerid);

	for(new x = 0, ps = GetPlayerPoolSize(); x <= ps; x++)
	{
		if(IsPlayerConnected(x))
		{
			if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
			{
				AdvanceSpectate(x);
			}
		}
	}
	return 1;
}

/*public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerInfo[playerid][LoggedIn] == 1)	SavePlayer(playerid);
	if(IsPlayerConnected(playerid))
	{
		KillTimer(RegKick[playerid]);
		if(PlayerInfo[playerid][Jailed] == 1) KillTimer( JailTimer[playerid] );
		if(PlayerInfo[playerid][Frozen] == 1) KillTimer( FreezeTimer[playerid] );
	}
	new str[200];
	if(RandomID == playerid)
	{
		format(str, sizeof(str), "[PED] Bonus player %s (%d) has disconnected.", pName(RandomID), RandomID);
		SendClientMessageToAll(bCol, "New Bonus player selecting in 5 minutes.");
		SendClientMessageToAll(bCol, str);
		RandomID = -1;
		RandomMoney = 0;
		RandomScore = 0;
		NoBonusPlayer = 1;
		KillTimer(BonusTimer);
		BonusTimer = SetTimer("BonusPlayer", 300000, 1);
	}
	PlayerTextDrawDestroy(playerid, PlayerTD);
	PlayerTextDrawDestroy(playerid, IssuerTD);

	TextDrawHideForPlayer(playerid, CountText[playerid]);
	TextDrawHideForPlayer(playerid, logo1);
	TextDrawHideForPlayer(playerid, logo2);
	TextDrawHideForPlayer(playerid, logo3);
	Streak[playerid] = 0;
	rconAttempts[playerid] = 0;
	PlayerInfo[playerid][Hide] = 0;
	LastPM[playerid] = INVALID_PLAYER_ID;
	Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
	TextDrawHideForPlayer(playerid, Web);
	TextDrawHideForPlayer(playerid, EUR);
	TextDrawHideForPlayer(playerid, A);
	TextDrawHideForPlayer(playerid, A2);
	TextDrawHideForPlayer(playerid, U);
	TextDrawHideForPlayer(playerid, S);

	if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
	//==========================================================================
	if(!Captured[SNAKE] && IsPlayerCapturing[playerid][SNAKE] == 1) LeavingSnakeFarm(playerid);
	if(!Captured[BAY] && IsPlayerCapturing[playerid][BAY] == 1) LeavingBay(playerid);
	if(!Captured[A51] && IsPlayerCapturing[playerid][A51] == 1)	LeavingArea51(playerid);
	if(!Captured[ARMY] && IsPlayerCapturing[playerid][ARMY] == 1) LeavingArmy(playerid);
	if(!Captured[PETROL] && IsPlayerCapturing[playerid][PETROL] == 1) LeavingPetrol(playerid);
	if(!Captured[OIL] && IsPlayerCapturing[playerid][OIL] == 1)	LeavingOil(playerid);
	if(!Captured[DESERT] && IsPlayerCapturing[playerid][DESERT] == 1) LeavingDesert(playerid);
	if(!Captured[QUARRY] && IsPlayerCapturing[playerid][QUARRY] == 1) LeavingQuarry(playerid);
	if(!Captured[GUEST] && IsPlayerCapturing[playerid][GUEST] == 1) LeavingGuest(playerid);
	if(!Captured[EAR] && IsPlayerCapturing[playerid][EAR] == 1) LeavingEar(playerid);
	if(!Captured[DA] && IsPlayerCapturing[playerid][DA] == 1) LeavingAirport(playerid);
	if(!Captured[AMMU] && IsPlayerCapturing[playerid][AMMU] == 1) LeavingAmmunation(playerid);
	if(!Captured[DAM] && IsPlayerCapturing[playerid][DAM] == 1) LeavingDam(playerid);
	if(!Captured[BELL] && IsPlayerCapturing[playerid][BELL] == 1) LeavingBell(playerid);
	if(!Captured[RUSTY] && IsPlayerCapturing[playerid][RUSTY] == 1) LeavingRusty(playerid);
	if(!Captured[GHOST] && IsPlayerCapturing[playerid][GHOST] == 1) LeavingGhost(playerid);
	if(!Captured[HOSP] && IsPlayerCapturing[playerid][HOSP] == 1) LeavingHospital(playerid);
	if(!Captured[VILLA] && IsPlayerCapturing[playerid][VILLA] == 1) LeavingVilla(playerid);
	if(!Captured[BIOSHIP] && IsPlayerCapturing[playerid][BIOSHIP] == 1) LeavingBioShip(playerid);
	if(!Captured[CERBERUS] && IsPlayerCapturing[playerid][CERBERUS] == 1) LeavingCerberus(playerid);

	//if(UnderHelp[SNAKE] && IsPlayerHelping[playerid][SNAKE]) LeavingHSnakeFarm(playerid);
	//==========================================================================
	for(new x = 0, ps = GetPlayerPoolSize(); x <= ps; x++)
	{
		if(IsPlayerConnected(x))
		{
			if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
			{
				AdvanceSpectate(x);
			}
		}
	}
	return 1;
}*/

forward SpawnProtect(playerid);
public	SpawnProtect(playerid)
{
	if(PlayerInfo[playerid][Frozen]) return 0;
	SetPlayerHealth(playerid, FLOAT_INFINITY);
	switch(random(3))
	{
		case 0:
		{
			AntiSKa[playerid] = 10*1000; // 10 multiplied by 1000 mili-secs = 10 seconds.
			SendClientMessage(playerid, red, "* You have spawn protection for 10 seconds.");
		}
		case 1:
		{
			AntiSKa[playerid] = 15*1000; // 15 multiplied by 1000 mili-secs = 15 seconds.
			SendClientMessage(playerid, red, "* You have spawn protection for 15 seconds.");
		}
		case 2:
		{
			AntiSKa[playerid] = 20*1000; // 20 multiplied by 1000 mili-secs = 20 seconds.
			SendClientMessage(playerid, red, "* You have spawn protection for 20 seconds.");
		}
	}
	AntiSK[playerid] = 1;
	AntiSKt[playerid] = SetTimerEx("SpawnProtection", AntiSKa[playerid], false, "d", playerid);
	SendClientMessage(playerid, grey, "* Press key 'N' to end spawn protection.");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	gRank[playerid] = GetRankID(playerid);
	if(PlayerInfo[playerid][Jailed] == 1)
	{
		KillTimer(JailTimer[playerid]);
		SetPlayerPos(playerid, 197.6661, 173.8179, 1003.0234);
		SetPlayerInterior(playerid, 3);
		SetCameraBehindPlayer(playerid);
		SendClientMessage(playerid, red, "{BA0000} You haven't served your jail time yet!");
		ResetPlayerWeapons(playerid);
		GameTextForPlayer(playerid, "~r~Jailed", 2500, 0);
		JailTimer[playerid] = SetTimerEx("JailRelease", 1000, true, "d", playerid);
		return 1;
	}
	if(!IsPlayerAnimsPreloaded[playerid])
	{
		AnimPreloadForPlayer(playerid,
		   "BOMBER");
		AnimPreloadForPlayer(playerid,
		   "RAPPING");
		AnimPreloadForPlayer(playerid,
			"SHOP");
		AnimPreloadForPlayer(playerid,
		   "BEACH");
		AnimPreloadForPlayer(playerid,
		   "SMOKING");
		AnimPreloadForPlayer(playerid,
			"FOOD");
		AnimPreloadForPlayer(playerid,
			"ON_LOOKERS");
		AnimPreloadForPlayer(playerid,
			"DEALER");
		AnimPreloadForPlayer(playerid,
			"CRACK");
		AnimPreloadForPlayer(playerid,
			"CARRY");
		AnimPreloadForPlayer(playerid,
			"COP_AMBIENT");
		AnimPreloadForPlayer(playerid,
			"PARK");
		AnimPreloadForPlayer(playerid,
			"INT_HOUSE");
		AnimPreloadForPlayer(playerid,
			"FOOD");
		IsPlayerAnimsPreloaded[playerid] = 1;
	}
	SpawnProtect(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	ResetPlayerWeapons(playerid);
	UpdateLabelText(playerid);

	TextDrawHideForPlayer(playerid, CountText[playerid]);
	RandomSpawn(playerid);

	if(Captured[SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1)
	{
		LeavingSnakeFarm(playerid);
	}
	if(Captured[BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1)
	{
		LeavingBay(playerid);
	}
	if(Captured[A51] == 0 && IsPlayerCapturing[playerid][A51] == 1)
	{
		LeavingEar(playerid);
	}
	if(Captured[ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1)
	{
		LeavingArmy(playerid);
	}
	if(Captured[PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1)
	{
		LeavingPetrol(playerid);
	}
	if(Captured[OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1)
	{
		LeavingOil(playerid);
	}
	if(Captured[DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1)
	{
		LeavingDesert(playerid);
	}
	if(Captured[QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1)
	{
		LeavingQuarry(playerid);
	}
	if(Captured[GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1)
	{
		LeavingGuest(playerid);
	}
	if(Captured[EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1)
	{
		LeavingEar(playerid);
	}
	if(Captured[DA] == 0 && IsPlayerCapturing[playerid][DA] == 1)
	{
		LeavingAirport(playerid);
	}
	if(Captured[AMMU] == 0 && IsPlayerCapturing[playerid][AMMU] == 1)
	{
		LeavingAmmunation(playerid);
	}
	if(Captured[DAM] == 0 && IsPlayerCapturing[playerid][DAM] == 1)
	{
		LeavingDam(playerid);
	}
	if(Captured[BELL] == 0 && IsPlayerCapturing[playerid][BELL] == 1)
	{
		LeavingBell(playerid);
	}
	if(Captured[RUSTY] == 0 && IsPlayerCapturing[playerid][RUSTY] == 1)
	{
		LeavingRusty(playerid);
	}
	if(Captured[GHOST] == 0 && IsPlayerCapturing[playerid][GHOST] == 1)
	{
		LeavingGhost(playerid);
	}
	if(Captured[HOSP] == 0 && IsPlayerCapturing[playerid][HOSP] == 1)
	{
		LeavingHospital(playerid);
	}
	if(Captured[VILLA] == 0 && IsPlayerCapturing[playerid][VILLA] == 1)
	{
		LeavingVilla(playerid);
	}
	if(Captured[BIOSHIP] == 0 && IsPlayerCapturing[playerid][BIOSHIP] == 1)
	{
		LeavingBioShip(playerid);
	}
	if(Captured[CERBERUS] == 0 && IsPlayerCapturing[playerid][CERBERUS] == 1)
	{
		LeavingCerberus(playerid);
	}
	//====================================================================================================//
	new str[150];
	format(str, sizeof(str),"~p~NAME: ~w~%s - ~g~RANK: ~w~%s - ~g~CLASS:~w~ %s~n~~p~TEAM: ~w~%s - ~r~KILLS: ~w~%d - ~b~DEATHS: ~w~%d - ~y~Score: ~w~%d",
	pName(playerid), GetRankName(playerid), GetClass(playerid), GetTeamName(playerid), PlayerInfo[playerid][Kills], PlayerInfo[playerid][Deaths], GetPlayerScore(playerid));
	PlayerTextDrawSetString(playerid, StatsTD, str);
	PlayerTextDrawShow(playerid, StatsTD);

	if(GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 49)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawHideForPlayer(playerid, Star[1]);
		TextDrawHideForPlayer(playerid, Star[2]);
		TextDrawHideForPlayer(playerid, Star[3]);
		TextDrawHideForPlayer(playerid, Star[4]);
		TextDrawHideForPlayer(playerid, Star[5]);
		TextDrawHideForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 50 && GetPlayerScore(playerid) <= 149)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawHideForPlayer(playerid, Star[2]);
		TextDrawHideForPlayer(playerid, Star[3]);
		TextDrawHideForPlayer(playerid, Star[4]);
		TextDrawHideForPlayer(playerid, Star[5]);
		TextDrawHideForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 150 && GetPlayerScore(playerid) <= 299)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawHideForPlayer(playerid, Star[3]);
		TextDrawHideForPlayer(playerid, Star[4]);
		TextDrawHideForPlayer(playerid, Star[5]);
		TextDrawHideForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 499)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawHideForPlayer(playerid, Star[4]);
		TextDrawHideForPlayer(playerid, Star[5]);
		TextDrawHideForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 799)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawShowForPlayer(playerid, Star[4]);
		TextDrawHideForPlayer(playerid, Star[5]);
		TextDrawHideForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 800 && GetPlayerScore(playerid) <= 1499)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawShowForPlayer(playerid, Star[4]);
		TextDrawShowForPlayer(playerid, Star[5]);
		TextDrawHideForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawShowForPlayer(playerid, Star[4]);
		TextDrawShowForPlayer(playerid, Star[5]);
		TextDrawShowForPlayer(playerid, Star[6]);
		TextDrawHideForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 4499)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawShowForPlayer(playerid, Star[4]);
		TextDrawShowForPlayer(playerid, Star[5]);
		TextDrawShowForPlayer(playerid, Star[6]);
		TextDrawShowForPlayer(playerid, Star[7]);
		TextDrawHideForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 4500 && GetPlayerScore(playerid) <= 7999)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawShowForPlayer(playerid, Star[4]);
		TextDrawShowForPlayer(playerid, Star[5]);
		TextDrawShowForPlayer(playerid, Star[6]);
		TextDrawShowForPlayer(playerid, Star[7]);
		TextDrawShowForPlayer(playerid, Star[8]);
		TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 10000)
	{
		TextDrawShowForPlayer(playerid, Star[0]);
		TextDrawShowForPlayer(playerid, Star[1]);
		TextDrawShowForPlayer(playerid, Star[2]);
		TextDrawShowForPlayer(playerid, Star[3]);
		TextDrawShowForPlayer(playerid, Star[4]);
		TextDrawShowForPlayer(playerid, Star[5]);
		TextDrawShowForPlayer(playerid, Star[6]);
		TextDrawShowForPlayer(playerid, Star[7]);
		TextDrawShowForPlayer(playerid, Star[8]);
		TextDrawShowForPlayer(playerid, Star[9]);
	}
	switch(gTeam[playerid])
	{
		case TEAM_NONE:
		{
			SetPlayerHealth(playerid, FLOAT_INFINITY);
			SetPlayerColor(playerid, 0xF600F6FF);
			GivePlayerWeapon(playerid, 38, 999999);
			SetPlayerSkin(playerid, 217);
		}
		case TEAM_EUROPE:
		{
			SetPlayerTeam(playerid, TEAM_EUROPE);
			SetPlayerColor(playerid, TEAM_EUROPE_COLOR);
		}
		case TEAM_ARAB:
		{
			SetPlayerTeam(playerid, TEAM_ARAB);
			SetPlayerColor(playerid, TEAM_ARAB_COLOR);
		}
		case TEAM_SOVIET:
		{
			SetPlayerTeam(playerid, TEAM_SOVIET);
			SetPlayerColor(playerid, TEAM_SOVIET_COLOR);
		}
		case TEAM_USA:
		{
			SetPlayerTeam(playerid, TEAM_USA);
			SetPlayerColor(playerid, TEAM_USA_COLOR);
		}
		case TEAM_AUS:
		{
			SetPlayerTeam(playerid, TEAM_AUS);
			SetPlayerColor(playerid, TEAM_AUS_COLOR);
		}
	}

	if(PlayerInfo[playerid][Frozen] == 1)
	{
		TogglePlayerControllable(playerid,false);
		SendClientMessage(playerid,red,"You cant escape your punishment. You Are Still Frozen");
	}

	if(PlayerInfo[playerid][Jailed] == 1)
	{
		JailPlayer(playerid);
		SendClientMessage(playerid,red,"You cant escape your punishment. You Are Still In Jail");
	}

	GangZoneShowForAll(GZ_USA, TEAM_ZONE_USA_COLOR); //USA
	GangZoneShowForAll(GZ_AUS, TEAM_ZONE_AUS_COLOR); // Australian Armada
	GangZoneShowForAll(GZ_EUR, TEAM_ZONE_EUROPE_COLOR); //Europe
	GangZoneShowForAll(GZ_RUS, TEAM_ZONE_SOVIET_COLOR); //Soviet
	GangZoneShowForAll(GZ_ARAB, TEAM_ZONE_ARAB_COLOR); //Arab

	SetPlayerMapIcon(playerid, 5, -36.5458, 2347.6426, 24.1406, 19,2,MAPICON_LOCAL); //SNakes farm

	SetPlayerMapIcon(playerid, 6, 260.0900,2889.5242,11.1854, 19,2,MAPICON_LOCAL); //Bay

	SetPlayerMapIcon(playerid, 7, 268.2260, 1840.4688, 6.6811, 19,2,MAPICON_LOCAL); //Area 51

	SetPlayerMapIcon(playerid, 8, -551.6992,2593.0771,53.9348, 19,2,MAPICON_LOCAL); //Army hotel

	SetPlayerMapIcon(playerid, 9, 670.9215,1705.4658,7.1875, 19,2,MAPICON_LOCAL); //Army petrol bunk

	SetPlayerMapIcon(playerid, 10, 221.0856,1422.6615,10.5859, 19,2,MAPICON_LOCAL); //Oil Factory

	SetPlayerMapIcon(playerid, 11, 558.9932,1221.8896,11.7188, 19,2,MAPICON_LOCAL); //Oil Station

	SetPlayerMapIcon(playerid, 12, 588.3246,875.7402,-42.4973, 19,2,MAPICON_LOCAL); //Quarry

	SetPlayerMapIcon(playerid, 13, -314.8433,1773.9176,43.6406, 19,2,MAPICON_LOCAL); //Desert Guest house

	SetPlayerMapIcon(playerid, 14, -311.0136,1542.9733,75.5625, 19,2,MAPICON_LOCAL); //Big Ear

	SetPlayerMapIcon(playerid, 19, 406.2509, 2460.2515, 15.9202, 19,2,MAPICON_LOCAL); //Desert Airport

	SetPlayerMapIcon(playerid, 20, 796.7874, 1684.2380, 4.5854, 19,2,MAPICON_LOCAL); //Ammunation

	SetPlayerMapIcon(playerid, 21, -734.3656, 2045.9260, 59.7652, 19,2,MAPICON_LOCAL); //Dam

	SetPlayerMapIcon(playerid, 22, -1196.2249, 1812.6929, 41.2066, 19,2,MAPICON_LOCAL); //Cluckin Bell

	SetPlayerMapIcon(playerid, 23, -913.5380, 2685.7407, 41.8412, 19,2,MAPICON_LOCAL); //Rusty

	SetPlayerMapIcon(playerid, 24, -379.5509, 2218.6895, 41.3212, 19,2,MAPICON_LOCAL); //Ghost

	SetPlayerMapIcon(playerid, 25, 1048.1426, 1009.3165, 10.2530, 19,2,MAPICON_LOCAL); //Hospital

	SetPlayerMapIcon(playerid, 26, -688.2969, 939.0715, 12.8027, 19,2,MAPICON_LOCAL); //Villa

	SetPlayerMapIcon(playerid, 27, -575.1106, 824.7502, 14.4421, 19,2,MAPICON_LOCAL); //BioShip

	SetPlayerMapIcon(playerid, 28, -2314.8601, 1984.9391, 11.2232, 19,2,MAPICON_LOCAL); //Cerberus

	SetPlayerMapIcon(playerid, 29, 213.9211, 1822.7339, 6.4141, 23,2,MAPICON_LOCAL); //Nuke

	TextDrawHideForPlayer(playerid, EUR);
	TextDrawHideForPlayer(playerid, E);
	TextDrawHideForPlayer(playerid, A);
	TextDrawHideForPlayer(playerid, S);
	TextDrawHideForPlayer(playerid, U);
	TextDrawHideForPlayer(playerid, A2);
	TextDrawShowForPlayer(playerid, Web);
	return 1;
}

forward SpawnProtection(playerid);
public	SpawnProtection(playerid)
{
	SendClientMessage(playerid, red,"* Anti-Spawn kill protection ended!");
	AntiSK[playerid] = 0;
	SendClientMessage(playerid, -1,"* You are ready to go now.");
	GivePlayerWeapons(playerid);
	SetPlayerHealth( playerid, 99 );
	if(gClass[playerid] == SNIPER)
	{
		switch(gTeam[playerid])
		{
			case TEAM_EUROPE: SetPlayerColor(playerid, SNIPER_EUROPE_COLOR);
			case TEAM_ARAB: SetPlayerColor(playerid, SNIPER_ARAB_COLOR);
			case TEAM_SOVIET: SetPlayerColor(playerid, SNIPER_SOVIET_COLOR);
			case TEAM_USA: SetPlayerColor(playerid, SNIPER_USA_COLOR);
			case TEAM_AUS: SetPlayerColor(playerid, SNIPER_AUS_COLOR);
		}
	}
	return 1;
}
stock GivePlayerWeapons(playerid)
{
	if(PlayerInfo[playerid][OnDuty] == 1)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 38, 999999); //Minigun
		return 1;
	}
	if(gClass[playerid] == SOLDIER)//Rank 1
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 24, 50); //Deagle
		GivePlayerWeapon(playerid, 27, 200); //Spaz
		GivePlayerWeapon(playerid, 30, 300); //M4
	}
	else if(gClass[playerid] == SNIPER)//Rank 2
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 27, 100); //M4
		GivePlayerWeapon(playerid, 34, 200); //Sniper
		GivePlayerWeapon(playerid, 23, 200); //Silenced.
		GivePlayerWeapon(playerid, 4, 1); //Knife
	}
	else if(gClass[playerid] == ENGINEER)//Rank 4
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 300); //M4
		GivePlayerWeapon(playerid, 25, 300); //Shotgun
		GivePlayerWeapon(playerid, 24, 50); //Deagle
		GivePlayerWeapon(playerid, 16, 3); //Grenades
	}
	else if(gClass[playerid] == JET)//Rank 6
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 32, 500); //M4
		GivePlayerWeapon(playerid, 8, 2);
		GivePlayerWeapon(playerid, 22, 100); //Colt
		GivePlayerWeapon(playerid, 16, 2); //Grenades
	}
	else if(gClass[playerid] == PILOT)//Rank 6
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 30, 400); //M4
		GivePlayerWeapon(playerid, 25, 300); //Shotgun
		GivePlayerWeapon(playerid, 22, 150); //Deagle
	}
	else if(gClass[playerid] == SUPPORT)//Rank 7
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 8, 1);// Katana
		GivePlayerWeapon(playerid, 24, 100);// Deagle
		GivePlayerWeapon(playerid, 27, 200);// Spaz
		GivePlayerWeapon(playerid, 30, 1000);//Ak 47
		GivePlayerWeapon(playerid, 34, 50); //Sniper
	}
	else if(gClass[playerid] == SPY)//Rank 7
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 4, 1);//Knife
		GivePlayerWeapon(playerid, 29, 200);//MP5
		GivePlayerWeapon(playerid, 31, 150);//M4
		GivePlayerWeapon(playerid, 23, 50);//Silenced
		GivePlayerWeapon(playerid, 25, 100); //Shotgun
		DisguiseKits[playerid] = 5;
	}
	else if(gClass[playerid] == DEMOLISHER)//Rank 8
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 9, 1); //Chainsaw.
		GivePlayerWeapon(playerid, 22, 100); //Colt 45.
		GivePlayerWeapon(playerid, 30, 100); //Ak 47.
		GivePlayerWeapon(playerid, 35, 5); //RPG.
		GivePlayerWeapon(playerid, 16, 10); //Grenade.
	}
	else if(gClass[playerid] == HEAVY)//Rank 13
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 4, 1); //Knife.
		GivePlayerWeapon(playerid, 24, 400); //Deagle
		GivePlayerWeapon(playerid, 27, 300); //Combat Shotgun
		GivePlayerWeapon(playerid, 34, 200); //Sniper
		GivePlayerWeapon(playerid, 31, 500); //M4
		GivePlayerWeapon(playerid, 38, 50); //Minigun
	}
	else if(gClass[playerid] == DONOR)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 1500); //M4
		GivePlayerWeapon(playerid, 26, 1500); //Shotgun
		GivePlayerWeapon(playerid, 24, 1500); //Deagle
		GivePlayerWeapon(playerid, 31, 30); //Grenades
		GivePlayerWeapon(playerid, 34, 1500); //Sniper
		GivePlayerWeapon(playerid, 4, 1); //Knife.
	}
	return 1;
}

forward HideDeath(playerid);
public  HideDeath(playerid)
{
	TextDrawHideForPlayer(playerid, KDBox);
	PlayerTextDrawHide(playerid, Death);
	return 1;
}

forward HideKill(playerid);
public  HideKill(playerid)
{
	TextDrawHideForPlayer(playerid, KDBox);
	PlayerTextDrawHide(playerid, Kill);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPrototyping{playerid})
	{
		DisablePlayerCheckpoint(playerid);
		IsPrototyping{playerid} = false;
		TogglePlayerAllDynamicCPs(playerid, 1);
		SendClientMessage(playerid, red, "ERROR: {828282}You Died While Capturing The Enemy's Prototype.");
	}
	if(gClass[playerid] == DEMOLISHER)
	{
		new Float:CX, Float:CY, Float:CZ;
		GetPlayerPos(playerid, CX, CY, CZ);
		CreateExplosion(CX,CY,CZ,7,10.0);
	}
	HHelmet{playerid} = false;
	Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
	SetPlayerColor(playerid, 0xB7B6B6FF);
	////////////////////////////////////////////////////////////
	if(killerid == INVALID_PLAYER_ID)
	{
		SendDeathMessage(INVALID_PLAYER_ID, playerid, reason);
		if(RandomID == playerid && killerid != playerid)
		{
			if(reason == 47 || reason == 51 || reason == 54 || reason == 255)
			{
				new str[200];
				RandomID = -1;
				format(str, sizeof(str),"{80C732}[PED] Bonus player {FFFFFF}%s (%d) {80C732}died mesteriously.", pName(playerid), playerid);
				SendClientMessageToAll(-1, str);
				SendClientMessageToAll(-1, "{80C732}New Bonus player selecting in 5 minutes.");
				RandomMoney = 0;
				RandomScore = 0;
				NoBonusPlayer = 1;
				KillTimer(BonusTimer);
				BonusTimer = SetTimer("BonusPlayer", 300000, 1);
			}
		}
	}
	else
	{
		SpreeCheck(playerid, killerid);
		for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(assistkill[i] == playerid && i != killerid)
				{
					new asst[150];
					format(asst, sizeof(asst), "[Assist] 500$ for assisting %s(%d) in killing %s($d)", pName(killerid), killerid, pName(playerid), playerid);
					SendClientMessage(i, -1, asst);
					GiveCODMoney(i, 500);
					assistkill[i] = INVALID_PLAYER_ID;
				}
			}
		}
		//--- \('-')/
		new KDstr[50];
		TextDrawShowForPlayer(playerid, KDBox);
		TextDrawShowForPlayer(killerid, KDBox);
		format(KDstr, sizeof(KDstr), "~r~Killed by ~w~%s", FixTdBracket(killerid));
		PlayerTextDrawSetString(playerid, Death, KDstr);
		PlayerTextDrawShow(playerid, Death);
		format(KDstr, sizeof(KDstr), "~g~Killed ~w~%s", FixTdBracket(playerid));
		PlayerTextDrawSetString(killerid, Kill, KDstr);
		PlayerTextDrawShow(killerid, Kill);

		SetTimerEx("HideKill", 4000, false, "d", killerid);
		SetTimerEx("HideDeath", 4000, false, "d", playerid);
		//---
		if(RandomID == playerid && killerid != playerid)
		{
			new str[200];
			if(reason != 50)
			{
				RandomID = killerid;
				NoBonusPlayer = 0;
				format(str, sizeof(str),"{80C732}[PED] {FFFFFF}%s (%d) {80C732}killed bonus player {FFFFFF}%s (%d) and took the bonus to themself and got {80C732}$%d {FFFFFF}and {80C732}%d score.", pName(killerid), killerid, pName(playerid), playerid, RandomMoney, RandomScore);
				SendClientMessageToAll(-1, str);
				GiveCODMoney(killerid, RandomMoney);
				GivePlayerScore(killerid, RandomScore);
				PlayerInfo[killerid][BonusKills] += 1;
				RandomMoney = random(50000 - 1000) + 1000;
				RandomScore = random(15 - 5) + 1;
				format(str, sizeof(str),"{80C732}[PED] Kill {FFFFFF}%s {80C732}to get {FFFFFF}$%d {80C732}and {FFFFFF}%d score", pName(RandomID), RandomID, RandomMoney, RandomScore);
				SendClientMessageToAll(-1, str);
				SendClientMessage(playerid, -1, "Good work killing the bonus player and taking the bonus to yourself.");
			}
		}
		if(reason == 50)
		{
			new Name[MAX_PLAYER_NAME], Message1[128];
			GetPlayerName(killerid, Name, sizeof(Name));
			format(Message1, sizeof(Message1), "{FF9E00}[AC]Cheat Buster has fined %s for {FF9E00}heli-blade/car parking", Name, playerid);
			SendClientMessageToAll(-1,Message1);
			SendClientMessage(killerid, red, "You are killed, fined $2,500 and 2 score.");
			SetPlayerHealth(killerid,0);
			GiveCODMoney(killerid,-2500);
			GivePlayerScore(killerid,-2);
		}
		if(IsPlayerInAnyVehicle(killerid))
		{
			if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
			{
				if(IsPlayerInArea(playerid, -353.515625,2574.21875,-113.28125,2796.875))
				{
					if(gTeam[playerid] == TEAM_USA)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[80];
						format(str, sizeof(str),"%s has been killed for spawn killing!", pName(killerid));
						SendClientMessageToAll(red, str);
					}
				}
				else if(IsPlayerInArea(playerid, 873.046875, 2068.359375, 1001.953125, 2250.0))
				{
					if(gTeam[playerid] == TEAM_EUROPE)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", pName(killerid));
						SendClientMessageToAll(red, str);
					}
				}
				else if(IsPlayerInArea(playerid, 89.0625000000005,2418.75,466.40625,2617.96875))
				{
					if(gTeam[playerid] == TEAM_AUS)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", pName(killerid));
						SendClientMessageToAll(red, str);
					}
				}
				else if(IsPlayerInArea(playerid, -309.375,1024.21875,103.125,1211.71875))
				{
					if(gTeam[playerid] == TEAM_SOVIET)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", pName(killerid));
						SendClientMessageToAll(red, str);
					}
				}
				else if(IsPlayerInArea(playerid, -875.8406, 1389.667, -607.2495, 1623.225))
				{
					if(gTeam[playerid] == TEAM_ARAB)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", pName(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(PlayerInfo[killerid][pKillAch] == 0)
		{
			PlayerInfo[killerid][pAchs] += 1;
			PlayerInfo[killerid][pKillAch] = 1;
			GivePlayerScore(killerid,5);
			PlayerTextDrawSetString(killerid, AchTD3, "~y~Achievement Name: ~w~FIRST BLOOD.");
			PlayerTextDrawSetString(killerid, AchTD4, "~y~Reward: ~w~5 SCORE.");
			PlayerTextDrawSetString(killerid, AchTD5, "~y~Achievement Info: ~w~Do your first kill.");
			ShowAchievementTextdraws(killerid);
		}
//		SendDeathMessage(killerid, playerid, reason);
		SendClientMessage(killerid, -1, "You killed your enemy and got 2000$ and 1 score.");
		GivePlayerScore(killerid, 1);
		GiveCODMoney(killerid, 2000);
		PlayerInfo[playerid][Deaths] += 1;
		PlayerInfo[killerid][Kills] += 1;
		if(PlayerInfo[killerid][Kills] >= 100 && PlayerInfo[killerid][pAssAch] == 0)
		{
			PlayerInfo[killerid][pAchs] += 1;
			PlayerInfo[killerid][pAssAch] = 1;
			PlayerTextDrawSetString(killerid, AchTD3, "~y~Achievement Name: ~w~BORN ASSASSIN.");
			PlayerTextDrawSetString(killerid, AchTD4, "~y~Reward: ~w~10 score & 10K money.");
			PlayerTextDrawSetString(killerid, AchTD5, "~y~Achievement Info: ~w~Do 100 kills.");
			ShowAchievementTextdraws(killerid);
		}
	}
	for(new i = 0; i < MAX_CP; i++)
	{
		if(IsPlayerCapturing[playerid][i])
		{
			if(killerid != INVALID_PLAYER_ID)
			{
				new killcp[100], killcp1[100];
				format(killcp,sizeof(killcp),"{80C732}You stopped %s from capturing a zone and got +1 score.", pName(playerid));
				SendClientMessage(killerid,-1,killcp);
				format(killcp1,sizeof(killcp1),"{D7374C}%s has stopped you from capturing a zone", pName(killerid));
				SendClientMessage(playerid,-1,killcp1);
				GivePlayerScore(killerid, 1);
			}
		}
	}
	if(!Captured[SNAKE] && IsPlayerCapturing[playerid][SNAKE] == 1) LeavingSnakeFarm(playerid);
	if(!Captured[BAY] && IsPlayerCapturing[playerid][BAY] == 1) LeavingBay(playerid);
	if(!Captured[A51] && IsPlayerCapturing[playerid][A51] == 1)	LeavingArea51(playerid);
	if(!Captured[ARMY] && IsPlayerCapturing[playerid][ARMY] == 1) LeavingArmy(playerid);
	if(!Captured[PETROL] && IsPlayerCapturing[playerid][PETROL] == 1) LeavingPetrol(playerid);
	if(!Captured[OIL] && IsPlayerCapturing[playerid][OIL] == 1)	LeavingOil(playerid);
	if(!Captured[DESERT] && IsPlayerCapturing[playerid][DESERT] == 1) LeavingDesert(playerid);
	if(!Captured[QUARRY] && IsPlayerCapturing[playerid][QUARRY] == 1) LeavingQuarry(playerid);
	if(!Captured[GUEST] && IsPlayerCapturing[playerid][GUEST] == 1) LeavingGuest(playerid);
	if(!Captured[EAR] && IsPlayerCapturing[playerid][EAR] == 1) LeavingEar(playerid);
	if(!Captured[DA] && IsPlayerCapturing[playerid][DA] == 1) LeavingAirport(playerid);
	if(!Captured[AMMU] && IsPlayerCapturing[playerid][AMMU] == 1) LeavingAmmunation(playerid);
	if(!Captured[DAM] && IsPlayerCapturing[playerid][DAM] == 1) LeavingDam(playerid);
	if(!Captured[BELL] && IsPlayerCapturing[playerid][BELL] == 1) LeavingBell(playerid);
	if(!Captured[RUSTY] && IsPlayerCapturing[playerid][RUSTY] == 1) LeavingRusty(playerid);
	if(!Captured[GHOST] && IsPlayerCapturing[playerid][GHOST] == 1) LeavingGhost(playerid);
	if(!Captured[HOSP] && IsPlayerCapturing[playerid][HOSP] == 1) LeavingHospital(playerid);
	if(!Captured[VILLA] && IsPlayerCapturing[playerid][VILLA] == 1) LeavingVilla(playerid);
	if(!Captured[BIOSHIP] && IsPlayerCapturing[playerid][BIOSHIP] == 1) LeavingBioShip(playerid);
	if(!Captured[CERBERUS] && IsPlayerCapturing[playerid][CERBERUS] == 1) LeavingCerberus(playerid);
	for(new x, l = GetPlayerPoolSize(); x <= l; x++)
	{
		if(IsPlayerConnected(x))
		{
			if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
			AdvanceSpectate(x);
		}
	}
	return 1;
}

SpreeCheck(killerid, playerid)
{
	new text[128];
	if(killerid != playerid)
	{
		switch(Streak[playerid])
		{
			case 3 .. 4:
			{
				SendClientMessage(killerid, lightblue, "You got +1 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 1);
				Streak[playerid] = 0;
			}
			case 5 .. 9:
			{
				SendClientMessage(killerid, lightblue, "You got +5 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 5);
				Streak[playerid] = 0;
			}
			case 10 .. 14:
			{
				SendClientMessage(killerid, lightblue, "You got +10 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 10);
				Streak[playerid] = 0;
			}
			case 15 .. 19:
			{
				SendClientMessage(killerid, lightblue, "You got +15 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 15);
				Streak[playerid] = 0;
			}
			case 20 .. 24:
			{
				SendClientMessage(killerid, lightblue, "You got +20 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 20);
				Streak[playerid] = 0;
			}
			case 25 .. 49:
			{
				SendClientMessage(killerid, lightblue, "You got +25 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 25);
				Streak[playerid] = 0;
			}
			case 50 .. 99:
			{
				SendClientMessage(killerid, lightblue, "You got +50 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 50);
				Streak[playerid] = 0;
			}
			case 100 .. 199:
			{
				SendClientMessage(killerid, lightblue, "You got +50 score! (ending killing spree bonus)");
				GivePlayerScore(killerid, 50);
				Streak[playerid] = 0;
			}
		}
		Streak[killerid] += 1;
		switch(Streak[killerid])
		{
			case 3:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(3 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $1500 and +3 score! (killing spree bonus)");
				GiveCODMoney(killerid, 1500);
				GivePlayerScore(killerid, 3);
			}
			case 5:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(5 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $2500 and +5 score! (killing spree bonus)");
				GiveCODMoney(killerid, 2500);
				GivePlayerScore(killerid, 5);
			}
			case 10:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(10 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $5000 and +10 score! (killing spree bonus)");
				GiveCODMoney(killerid, 5000);
				GivePlayerScore(killerid, 10);
				if(PlayerInfo[killerid][pOwnAch] == 0)
				{
					PlayerInfo[killerid][pAchs] += 1;
					PlayerInfo[killerid][pOwnAch] = 1;
					SetPlayerScore(killerid,GetPlayerScore(killerid)+10);
					GiveCODMoney(killerid,10000);

					PlayerTextDrawSetString(killerid, AchTD3, "~y~Achievement Name: ~w~TERMINATOR.");
					PlayerTextDrawSetString(killerid, AchTD4, "~y~Reward: ~w~10 score & 10K money.");
					PlayerTextDrawSetString(killerid, AchTD5, "~y~Achievement Info: ~w~Make a killing spree of 10.");
					ShowAchievementTextdraws(killerid);
				}
			}
			case 15:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(15 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $7500 and +15 score! (killing spree bonus)");
				GiveCODMoney(killerid, 7500);
				GivePlayerScore(killerid, 15);
			}
			case 20:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(20 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $12,500 and +20 score! (killing spree bonus)");
				GiveCODMoney(killerid, 12500);
				GivePlayerScore(killerid, 20);
			}
			case 25:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(25 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $20,000 and +25 score! (killing spree bonus)");
				GiveCODMoney(killerid, 20000);
				GivePlayerScore(killerid, 25);
			}
			case 50:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(50 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $50,000 and +50 score! (killing spree bonus)");
				GiveCODMoney(killerid, 50000);
				GivePlayerScore(killerid, 50);
			}
			case 100:
			{
				format(text, sizeof(text), "{80C732}%s {FFFFFF}is on {80C732}(100 killing spree)!", pName(killerid));
				SendClientMessageToAll(orange, text);
				SendClientMessage(killerid, lightblue, "You get $100,000 and +50 score! (killing spree bonus)");
				GiveCODMoney(killerid, 100000);
				GivePlayerScore(killerid, 50);
			}
		}
	}
	return 1;
}

stock GivePlayerScore(playerid, score)
{
	SetPlayerScore(playerid, GetPlayerScore(playerid) + score);
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if(gTeam[playerid] != gTeam[damagedid])
	{
		if(weaponid == 4 && bodypart == 9)
		{
			SetPlayerHealth(damagedid, 0.0);
		}
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerState(issuerid) == PLAYER_STATE_DRIVER)
		{
			if(weaponid == 49 || weaponid == 50)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(issuerid, x, y, z);
				SetPlayerPos(issuerid, x, y, z + 5);
				GetPlayerPos(playerid, x, y, z);
				SetPlayerPos(playerid, x, y, z + 3);
				SendClientMessage(issuerid, -1, "Car parking / car ramming is not allowed.");
			}
		}
		if(gTeam[issuerid] == gTeam[playerid])
		{
			GameTextForPlayer(issuerid,"~r~Don't attack your team mates!", 3000, 3);
		}
		else
		{
			assistkill[issuerid] = playerid;
			if(bodypart == 3)
			{
				new Float:armour, Float:hp;
				GetPlayerArmour(playerid, armour);
				GetPlayerHealth(playerid, hp);
				if(armour > 0.0)
				{
					if(armour < amount)
					{
						new Float:value = amount - armour;
						SetPlayerArmour(playerid, 0);
						SetPlayerHealth(playerid, hp - value);
					}
					else
					{
						GetPlayerArmour(playerid, armour);
						SetPlayerArmour(playerid, armour - amount);
					}
				}
				else
				{
					SetPlayerHealth(playerid, hp - amount);
				}
			}
		}
		if(NoHS == 0 && AntiSK[playerid] == 0 && weaponid == 34 && bodypart == 9 && PlayerInfo[playerid][OnDuty] == 0)
		{
			if(HHelmet{playerid} == false)
			{
				SetPlayerHealth(playerid, 0.0);
				GameTextForPlayer(playerid, "~n~~r~HEADSHOT", 3000, 3);
				GameTextForPlayer(issuerid, "~n~~g~HEADSHOT", 3000, 3);
				PlayerInfo[issuerid][Headshots] += 1;
				new Float:x, Float:y, Float:z, Float:fDistance, hsMessage[90];
				GetPlayerPos(playerid, x, y, z);
				fDistance = GetPlayerDistanceFromPoint(issuerid, x, y, z);
				format(hsMessage, sizeof(hsMessage), "%s has headshotted %s from the distance of %0.2f meters", pName(issuerid), pName(playerid), fDistance);
				SendClientMessageToAll(green, hsMessage);
				if(fDistance > 300.0 && PlayerInfo[issuerid][pHsAch] == 0)
				{
					PlayerInfo[issuerid][pHsAch] = 1;
					PlayerInfo[issuerid][pAchs] += 1;
					GivePlayerScore(issuerid, 5);
					PlayerTextDrawSetString(issuerid, AchTD3, "~y~Achievement Name: ~w~EAGLE'S EYE.");
					PlayerTextDrawSetString(issuerid, AchTD4, "~y~Reward: ~w~5 score.");
					PlayerTextDrawSetString(issuerid, AchTD5, "~y~Achievement Info: ~w~Headshot a player~n~~w~from a distance more than 300 meters.");
					ShowAchievementTextdraws(issuerid);
				}
			}
			else
			{
				HHelmet{playerid} = false;
				new issue[60], player[60];
				format(player, sizeof(player), "~n~~w~%s has destroyed your helmet", pName(issuerid));
				GameTextForPlayer(playerid, player, 3000, 3);
				format(issue, sizeof(issue), "~n~~w~You have destroyed helmet of %s", pName(playerid));
				GameTextForPlayer(issuerid, issue, 3000, 3);
				return 0;
			}
		}

		new str[500];
		KillTimer(PlayerTDt[playerid]);
		format(str,sizeof(str),"~r~%s (-%.2f) ~n~~r~%s", FixTdBracket(issuerid), amount, WeaponNames[weaponid]);
		PlayerTextDrawSetString(playerid, PlayerTD, str);
		PlayerTextDrawShow(playerid, PlayerTD);
		PlayerTDt[playerid] = SetTimerEx("PlayerTDhide", 3000, 0, "d", playerid);
		PlayerTDvar[playerid] = 1;

		KillTimer(IssuerTDt[issuerid]);
		format(str,sizeof(str),"~g~%s (%.2f) ~n~~g~%s", FixTdBracket(playerid), amount, WeaponNames[weaponid]);
		PlayerTextDrawSetString(issuerid, IssuerTD, str);
		PlayerTextDrawShow(playerid, IssuerTD);
		IssuerTDt[issuerid] = SetTimerEx("IssuerTDhide", 3000, 0, "d", issuerid);
		IssuerTDvar[issuerid] = 1;

		if(PlayerInfo[playerid][OnDuty] == 1 || PlayerInfo[playerid][God] == 1)
		{
			SetPlayerHealth(playerid, 1000.0);
			GameTextForPlayer(issuerid,"~r~Don't attack admins on-duty!", 3000, 3);
		}
	}
	return 1;
}
//================================CAPTURE ZONES=================================
stock CaptureZoneMessage(playerid, messageid)
{
	switch(messageid)
	{
		case 1:
		{
			SendClientMessage(playerid, red,"You cannot capture while in vehicle!");
		}
		case 2:
		{
			SendClientMessage(playerid, red,"This zone is already being taken over!");
		}
		case 3:
		{
			SendClientMessage(playerid, red,"You cannot capture while on-duty or spectating");
		}
	}
	return 1;
}
//===============SNAKE FARMS====================================================
stock ActiveSnakeFarm(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[SNAKE] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == SNAKE && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				CountVar[SNAKE] = 25;
				UnderAttack[SNAKE] = 1;
				Capturing{playerid} = true;
//			 	timer[SNAKE] = SetTimerEx("SnakeFarm", 25000, false,"d",playerid); // ab 1000 means 1 second
				Captured[SNAKE] = 0;
				IsPlayerCapturing[playerid][SNAKE] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				switch(gTeam[playerid])
				{
					case TEAM_EUROPE: GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_EUROPE_COLOR);
					case TEAM_ARAB: GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_ARAB_COLOR);
					case TEAM_SOVIET: GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_SOVIET_COLOR);
					case TEAM_USA: GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_USA_COLOR);
					case TEAM_AUS: GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[SNAKE] == TEAM_EUROPE) // same switch i know :D
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Snakes Farm is under attack!");
				  //oCP[SNAKE] = TEAM_EUROPE;
				}
				else if(tCP[SNAKE] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Snakes Farm is under attack!");
				  //oCP[SNAKE] = TEAM_ARAB;
				}
				else if(tCP[SNAKE] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Snakes Farm is under attack!");
				  //oCP[SNAKE] = TEAM_SOVIET;
				}
				else if(tCP[SNAKE] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Snakes Farm is under attack!");
				  //oCP[SNAKE] = TEAM_USA;
				}
				else if(tCP[SNAKE] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Snakes Farm is under attack!");
				  //oCP[SNAKE] = TEAM_AUS;
				}
				else if(tCP[SNAKE] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				  //oCP[SNAKE] = TEAM_NONE;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock SnakeFarmCaptured(playerid)
{
	if(RandomCpID == SNAKE)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[SNAKE] = 1;
	Capturing{playerid} = false;
	UnderAttack[SNAKE] = 0;
	IsPlayerCapturing[playerid][SNAKE] = 0;
	KillTimer(timer[SNAKE]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[SNAKE] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Snake Farm\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		/*if(gTeam[i] == oCP[SNAKE] && !PlayerInfo[i][OnDuty])
		{
			SendClientMessage(i, 0xFFFFFFFF, "*Your team has lost "cred"Snake farm"cwhite"! You lost -1 score for it!");
			GivePlayerScore(i, -1);
		}*/
		if(gTeam[i] == gTeam[playerid] && i != playerid && !PlayerInfo[i][OnDuty])
		{
			SendClientMessage(i, 0xFFFFFFFF, "*Your team has captured "cred"Snakes farm"cwhite"! You received +1 score for it!");
			GivePlayerScore(i, 1);
		}
		/*if(UnderHelp[SNAKE] && IsPlayerHelping[i][SNAKE])
		{
			SendClientMessage(i, 0xFFFFFFFF, "*You helped your team capture "cred"Snakes Farm"cwhite"! You received +3 score for it!");
			GivePlayerScore(i, 3);
			IsPlayerHelping[i][SNAKE] = 0;
		}*/
	}
	//UnderHelp[SNAKE] = 0;
	//==========================================================================
	tCP[SNAKE] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[SNAKE]);
	//==========================================================================
	switch(gTeam[playerid])
	{
		case TEAM_EUROPE: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_EUROPE_COLOR);
		case TEAM_ARAB: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_ARAB_COLOR);
		case TEAM_SOVIET: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_SOVIET_COLOR);
		case TEAM_USA: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_USA_COLOR);
		case TEAM_AUS: GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Snakes Farm\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingSnakeFarm(playerid)
{
	Captured[SNAKE] = 0;
	Capturing{playerid} = false;
	UnderAttack[SNAKE] = 0;
	/*if(UnderHelp[SNAKE])
	{
		UnderHelp[SNAKE] = 0;
		for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		{
			if(IsPlayerHelping[i][SNAKE])
			{
				IsPlayerHelping[playerid][SNAKE] = 0;
				SendClientMessage(i, -1, "*Assistance failed because, capturer left the checkpoint.");
			}
		}
	}*/
	IsPlayerCapturing[playerid][SNAKE] = 0;
	KillTimer(timer[SNAKE]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[SNAKE] = 25;
	GangZoneStopFlashForAll(Zone[SNAKE]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward SnakeFarm(playerid);
public SnakeFarm(playerid)
{
	SnakeFarmCaptured(playerid);
	/*
	if(CountVar[SNAKE] >= 1)
	{
		CountVar[SNAKE]--;
		new str1[124];
		TextDrawShowForPlayer(playerid, CountText[playerid]);
		format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[SNAKE]);
		TextDrawSetString(CountText[playerid], str1);
	}
	if(CountVar[SNAKE] <= 0)
	{
		SnakeFarmCaptured(playerid);
	}
	*/
	return 1;
}
/*
stock LeavingHSnakeFarm(playerid)
{
	if(UnderHelp[SNAKE] && IsPlayerHelping[playerid][SNAKE])
	{
		UnderHelp[SNAKE] = 0;
		IsPlayerHelping[playerid][SNAKE] = 0;
		SendClientMessage(playerid, -1, "*Assistance failed because, you left the checkpoint.");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerCapturing[i][SNAKE])
				{
					SendClientMessage(playerid, -1, "*Assistance failed because, assistant left the checkpoint.");
				}
			}
		}
	}
	return 1;
}*/
//===============================[BAY]==========================================
stock ActiveBay(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[BAY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == BAY && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[BAY] = 1;
				Capturing{playerid} = true;
				timer[BAY] = SetTimerEx("Bay", 25000, false,"d",playerid);
				Captured[BAY] = 0;
				IsPlayerCapturing[playerid][BAY] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[BAY] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled byteam "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock BayCaptured(playerid)
{
	if(RandomCpID == BAY)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[BAY] = 1;
	Capturing{playerid} = false;
	UnderAttack[BAY] = 0;
	IsPlayerCapturing[playerid][BAY] = 0;
	KillTimer(timer[BAY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[BAY] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Bay\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Bay"cwhite"! You received +1 score for it!");
			GivePlayerScore(i, 1);
		}
	}
	//==========================================================================
	tCP[BAY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[BAY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Bay\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingBay(playerid)
{
	Captured[BAY] = 0;
	Capturing{playerid} = false;
	UnderAttack[BAY] = 0;
	IsPlayerCapturing[playerid][BAY] = 0;
	KillTimer(timer[BAY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[BAY] = 25;
	GangZoneStopFlashForAll(Zone[BAY]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Bay(playerid);
public Bay(playerid)
{
	BayCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveArea51(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[A51] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == A51 && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[A51] = 1;
				Capturing{playerid} = true;
				timer[A51] = SetTimerEx("Area51", 25000, false,"d",playerid);
				Captured[A51] = 0;
				IsPlayerCapturing[playerid][A51] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[A51], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[A51], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[A51], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[A51], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[A51], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[A51] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Area 51 is under attack!");
				}
				else if(tCP[A51] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Area 51 is under attack!");
				}
				else if(tCP[A51] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Area 51 is under attack!");
				}
				else if(tCP[A51] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Area 51 is under attack!");
				}
				else if(tCP[A51] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Area 51 is under attack!");
				}
				else if(tCP[A51] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock Area51Captured(playerid)
{
	if(RandomCpID == A51)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[A51] = 1;
	Capturing{playerid} = false;
	UnderAttack[A51] = 0;
	IsPlayerCapturing[playerid][A51] = 0;
	KillTimer(timer[A51]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[A51] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Area51\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Area 51"cwhite"! You received +1 score for it!");
			GivePlayerScore(i, 1);
		}
	}
	//==========================================================================
	tCP[A51] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[A51]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[A51], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[A51], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[A51], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[A51], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[A51], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Area51\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingArea51(playerid)
{
	Captured[A51] = 0;
	Capturing{playerid} = false;
	UnderAttack[A51] = 0;
	IsPlayerCapturing[playerid][A51] = 0;
	KillTimer(timer[A51]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[A51] = 25;
	GangZoneStopFlashForAll(Zone[A51]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Area51(playerid);
public Area51(playerid)
{
	Area51Captured(playerid);
	return 1;
}
//==============================================================================
stock ActiveArmy(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[ARMY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == ARMY && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[ARMY] = 1;
				Capturing{playerid} = true;
				timer[ARMY] = SetTimerEx("Army", 25000, false,"d",playerid);
				Captured[ARMY] = 0;
				IsPlayerCapturing[playerid][ARMY] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[ARMY] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock ArmyCaptured(playerid)
{
	if(RandomCpID == ARMY)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[ARMY] = 1;
	Capturing{playerid} = false;
	UnderAttack[ARMY] = 0;
	IsPlayerCapturing[playerid][ARMY] = 0;
	KillTimer(timer[ARMY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[ARMY] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Army Restaurant\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
		{
			SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Army Restaurant"cwhite"! You received +1 score for it!");
			GivePlayerScore(i, 1);
		}
	}
	//==========================================================================
	tCP[ARMY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[ARMY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Army Restuarant\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingArmy(playerid)
{
	Captured[ARMY] = 0;
	Capturing{playerid} = false;
	UnderAttack[ARMY] = 0;
	IsPlayerCapturing[playerid][ARMY] = 0;
	KillTimer(timer[ARMY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[ARMY] = 25;
	GangZoneStopFlashForAll(Zone[ARMY]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Army(playerid);
public Army(playerid)
{
	ArmyCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActivePetrol(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[PETROL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == PETROL && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[PETROL] = 1;
				Capturing{playerid} = true;
				timer[PETROL] = SetTimerEx("Petrol", 25000, false,"d",playerid);
				Captured[PETROL] = 0;
				IsPlayerCapturing[playerid][PETROL] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_USA_COLOR);

				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_AUS_COLOR);

				}
				//------Message-----
				if(tCP[PETROL] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock PetrolCaptured(playerid)
{
	if(RandomCpID == PETROL)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[PETROL] = 1;
	Capturing{playerid} = false;
	UnderAttack[PETROL] = 0;
	IsPlayerCapturing[playerid][PETROL] = 0;
	KillTimer(timer[PETROL]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[PETROL] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Army Petrol Bunk\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
		{
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Army Petrol Bunk"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
		}
	}
	//==========================================================================
	tCP[PETROL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[PETROL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Army Petrol Bunk\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingPetrol(playerid)
{
	Captured[PETROL] = 0;
	Capturing{playerid} = false;
	UnderAttack[PETROL] = 0;
	IsPlayerCapturing[playerid][PETROL] = 0;
	KillTimer(timer[PETROL]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[PETROL] = 25;
	GangZoneStopFlashForAll(Zone[PETROL]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Petrol(playerid);
public Petrol(playerid)
{
	PetrolCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveOil(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[OIL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == OIL && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[OIL] = 1;
				Capturing{playerid} = true;
				timer[OIL] = SetTimerEx("Oil", 25000, false,"d",playerid);
				Captured[OIL] = 0;
				IsPlayerCapturing[playerid][OIL] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[OIL] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock OilCaptured(playerid)
{
	if(RandomCpID == OIL)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[OIL] = 1;
	Capturing{playerid} = false;
	UnderAttack[OIL] = 0;
	IsPlayerCapturing[playerid][OIL] = 0;
	KillTimer(timer[OIL]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[OIL] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Oil Factory\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Oil Factory"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[OIL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[OIL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Oil Factory\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingOil(playerid)
{
	Captured[OIL] = 0;
	Capturing{playerid} = false;
	UnderAttack[OIL] = 0;
	IsPlayerCapturing[playerid][OIL] = 0;
	KillTimer(timer[OIL]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[OIL] = 25;
	GangZoneStopFlashForAll(Zone[OIL]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Oil(playerid);
public Oil(playerid)
{
	OilCaptured(playerid);
	return 1;
}
//==============================================================================
//==============================================================================
stock ActiveDesert(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[DESERT] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == DESERT && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[DESERT] = 1;
				Capturing{playerid} = true;
				timer[DESERT] = SetTimerEx("Desert", 25000, false,"d",playerid);
				Captured[DESERT] = 0;
				IsPlayerCapturing[playerid][DESERT] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[DESERT] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock DesertCaptured(playerid)
{
	if(RandomCpID == DESERT)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[DESERT] = 1;
	Capturing{playerid} = false;
	UnderAttack[DESERT] = 0;
	IsPlayerCapturing[playerid][DESERT] = 0;
	KillTimer(timer[DESERT]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[DESERT] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Gas Factory\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Gas Factory"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[DESERT] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[DESERT]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Gas Factory\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingDesert(playerid)
{
	Captured[DESERT] = 0;
	Capturing{playerid} = false;
	UnderAttack[DESERT] = 0;
	IsPlayerCapturing[playerid][DESERT] = 0;
	KillTimer(timer[DESERT]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[DESERT] = 25;
	GangZoneStopFlashForAll(Zone[DESERT]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Desert(playerid);
public Desert(playerid)
{
	DesertCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveQuarry(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[QUARRY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == QUARRY && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[QUARRY] = 1;
				Capturing{playerid} = true;
				timer[QUARRY] = SetTimerEx("Quarry", 25000, false,"d",playerid);
				Captured[QUARRY] = 0;
				IsPlayerCapturing[playerid][QUARRY] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[QUARRY] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock QuarryCaptured(playerid)
{
	if(RandomCpID == QUARRY)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[QUARRY] = 1;
	Capturing{playerid} = false;
	UnderAttack[QUARRY] = 0;
	IsPlayerCapturing[playerid][QUARRY] = 0;
	KillTimer(timer[QUARRY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[QUARRY] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Quarry\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Quarry"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[QUARRY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[QUARRY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Quarry\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingQuarry(playerid)
{
	Captured[QUARRY] = 0;
	Capturing{playerid} = false;
	UnderAttack[QUARRY] = 0;
	IsPlayerCapturing[playerid][QUARRY] = 0;
	KillTimer(timer[QUARRY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[QUARRY] = 25;
	GangZoneStopFlashForAll(Zone[QUARRY]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Quarry(playerid);
public Quarry(playerid)
{
	QuarryCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveGuest(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[GUEST] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == GUEST && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[GUEST] = 1;
				Capturing{playerid} = true;
				timer[GUEST] = SetTimerEx("Guest", 25000, false,"d",playerid);
				Captured[GUEST] = 0;
				IsPlayerCapturing[playerid][GUEST] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[GUEST] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock GuestCaptured(playerid)
{
	if(RandomCpID == GUEST)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[GUEST] = 1;
	Capturing{playerid} = false;
	UnderAttack[GUEST] = 0;
	IsPlayerCapturing[playerid][GUEST] = 0;
	KillTimer(timer[GUEST]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[GUEST] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Army Guest House\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Army Guest House"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[GUEST] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[GUEST]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Army Guest House\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingGuest(playerid)
{
	Captured[GUEST] = 0;
	Capturing{playerid} = false;
	UnderAttack[GUEST] = 0;
	IsPlayerCapturing[playerid][GUEST] = 0;
	KillTimer(timer[GUEST]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[GUEST] = 25;
	GangZoneStopFlashForAll(Zone[GUEST]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Guest(playerid);
public Guest(playerid)
{
	GuestCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveEar(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[EAR] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == EAR && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[EAR] = 1;
				Capturing{playerid} = true;
				timer[EAR] = SetTimerEx("BigEar", 25000, false,"d",playerid);
				Captured[EAR] = 0;
				IsPlayerCapturing[playerid][EAR] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[EAR] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock EarCaptured(playerid)
{
	if(RandomCpID == EAR)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[EAR] = 1;
	Capturing{playerid} = false;
	UnderAttack[EAR] = 0;
	IsPlayerCapturing[playerid][EAR] = 0;
	KillTimer(timer[EAR]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[EAR] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Big Ear\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Big Ear"cwhite"! You received +6 score for it!");
		   GivePlayerScore(i, 6);
	   }
	}
	//==========================================================================
	tCP[EAR] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[EAR]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Big Ear\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingEar(playerid)
{
	Captured[EAR] = 0;
	Capturing{playerid} = false;
	UnderAttack[EAR] = 0;
	IsPlayerCapturing[playerid][EAR] = 0;
	KillTimer(timer[EAR]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[EAR] = 25;
	GangZoneStopFlashForAll(Zone[EAR]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward BigEar(playerid);
public BigEar(playerid)
{
	EarCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveAirport(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[DA] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == DA && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[DA] = 1;
				Capturing{playerid} = true;
				timer[DA] = SetTimerEx("Airport", 25000, false,"d",playerid);
				Captured[DA] = 0;
				IsPlayerCapturing[playerid][DA] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[DA], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[DA], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[DA], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[DA], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[DA], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[DA] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Desert Airport is under attack!");
				}
				else if(tCP[DA] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Desert Airport is under attack!");
				}
				else if(tCP[DA] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Desert Airport is under attack!");
				}
				else if(tCP[DA] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Desert Airport is under attack!");
				}
				else if(tCP[DA] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Desert Airport is under attack!");
				}
				else if(tCP[DA] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock AirportCaptured(playerid)
{
	if(RandomCpID == DA)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[DA] = 1;
	Capturing{playerid} = false;
	UnderAttack[DA] = 0;
	IsPlayerCapturing[playerid][DA] = 0;
	KillTimer(timer[DA]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[DA] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Desert Airport\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Desert Airport"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[DA] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[DA]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[DA], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[DA], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[DA], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[DA], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[DA], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Desert Airport\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingAirport(playerid)
{
	Captured[DA] = 0;
	Capturing{playerid} = false;
	UnderAttack[DA] = 0;
	IsPlayerCapturing[playerid][DA] = 0;
	KillTimer(timer[DA]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[DA] = 25;
	GangZoneStopFlashForAll(Zone[DA]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Airport(playerid);
public Airport(playerid)
{
	AirportCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveAmmunation(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[AMMU] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == AMMU && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[AMMU] = 1;
				Capturing{playerid} = true;
				timer[AMMU] = SetTimerEx("Ammunation", 25000, false,"d",playerid);
				Captured[AMMU] = 0;
				IsPlayerCapturing[playerid][AMMU] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[AMMU], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[AMMU], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[AMMU], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[AMMU], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[AMMU], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[AMMU] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Ammunation is under attack!");
				}
				else if(tCP[AMMU] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Ammunation is under attack!");
				}
				else if(tCP[AMMU] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Ammunation is under attack!");
				}
				else if(tCP[AMMU] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Ammunation is under attack!");
				}
				else if(tCP[AMMU] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Ammunation is under attack!");
				}
				else if(tCP[AMMU] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock AmmunationCaptured(playerid)
{
	if(RandomCpID == AMMU)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[AMMU] = 1;
	Capturing{playerid} = false;
	UnderAttack[AMMU] = 0;
	IsPlayerCapturing[playerid][AMMU] = 0;
	KillTimer(timer[AMMU]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[AMMU] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Ammunation\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Ammunation"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[AMMU] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[AMMU]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[AMMU], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Ammunation\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingAmmunation(playerid)
{
	Captured[AMMU] = 0;
	Capturing{playerid} = false;
	UnderAttack[AMMU] = 0;
	IsPlayerCapturing[playerid][AMMU] = 0;
	KillTimer(timer[AMMU]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[AMMU] = 25;
	GangZoneStopFlashForAll(Zone[AMMU]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Ammunation(playerid);
public Ammunation(playerid)
{
	AmmunationCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveDam(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[DAM] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == DAM && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[DAM] = 1;
				Capturing{playerid} = true;
				timer[DAM] = SetTimerEx("Dam", 25000, false,"d",playerid);
				Captured[DAM] = 0;
				IsPlayerCapturing[playerid][DAM] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[DAM], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[DAM], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[DAM], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[DAM], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[DAM], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[DAM] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Sherman Dam is under attack!");
				}
				else if(tCP[DAM] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Sherman Dam is under attack!");
				}
				else if(tCP[DAM] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Sherman Dam is under attack!");
				}
				else if(tCP[DAM] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Sherman Dam is under attack!");
				}
				else if(tCP[DAM] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Sherman Dam is under attack!");
				}
				else if(tCP[DAM] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock DamCaptured(playerid)
{
	if(RandomCpID == DAM)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[DAM] = 1;
	Capturing{playerid} = false;
	UnderAttack[DAM] = 0;
	IsPlayerCapturing[playerid][DAM] = 0;
	KillTimer(timer[DAM]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[DAM] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Sherman Dam\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Sherman Dam"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[DAM] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[DAM]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[DAM], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[DAM], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[DAM], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[DAM], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[DAM], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Sherman Dam\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingDam(playerid)
{
	Captured[DAM] = 0;
	Capturing{playerid} = false;
	UnderAttack[DAM] = 0;
	IsPlayerCapturing[playerid][DAM] = 0;
	KillTimer(timer[DAM]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[DAM] = 25;
	GangZoneStopFlashForAll(Zone[DAM]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Dam(playerid);
public Dam(playerid)
{
	DamCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveBell(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[BELL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == BELL && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[BELL] = 1;
				Capturing{playerid} = true;
				timer[BELL] = SetTimerEx("Bell", 25000, false,"d",playerid);
				Captured[BELL] = 0;
				IsPlayerCapturing[playerid][BELL] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[BELL], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[BELL], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[BELL], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[BELL], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[BELL], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[BELL] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Cluckin Bell is under attack!");
				}
				else if(tCP[BELL] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Cluckin Bell is under attack!");
				}
				else if(tCP[BELL] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Cluckin Bell is under attack!");
				}
				else if(tCP[BELL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Cluckin Bell is under attack!");
				}
				else if(tCP[BELL] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Cluckin Bell is under attack!");
				}
				else if(tCP[BELL] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock BellCaptured(playerid)
{
	if(RandomCpID == BELL)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[BELL] = 1;
	Capturing{playerid} = false;
	UnderAttack[BELL] = 0;
	IsPlayerCapturing[playerid][BELL] = 0;
	KillTimer(timer[BELL]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[BELL] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Cluckin Bell\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Cluckin Bell"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[BELL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[BELL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[BELL], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[BELL], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[BELL], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[BELL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[BELL], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Cluckin Bell\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingBell(playerid)
{
	Captured[BELL] = 0;
	Capturing{playerid} = false;
	UnderAttack[BELL] = 0;
	IsPlayerCapturing[playerid][BELL] = 0;
	KillTimer(timer[BELL]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[BELL] = 25;
	GangZoneStopFlashForAll(Zone[BELL]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Bell(playerid);
public Bell(playerid)
{
	BellCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveRusty(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[RUSTY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == RUSTY && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[RUSTY] = 1;
				Capturing{playerid} = true;
				timer[RUSTY] = SetTimerEx("Rusty", 25000, false,"d",playerid);
				Captured[RUSTY] = 0;
				IsPlayerCapturing[playerid][RUSTY] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[RUSTY], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[RUSTY], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[RUSTY], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[RUSTY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[RUSTY], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[RUSTY] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Rusty Bridge is under attack!");
				}
				else if(tCP[RUSTY] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Rusty Bridge is under attack!");
				}
				else if(tCP[RUSTY] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Rusty Bridge is under attack!");
				}
				else if(tCP[RUSTY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Rusty Bridge is under attack!");
				}
				else if(tCP[RUSTY] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Rusty Bridge is under attack!");
				}
				else if(tCP[RUSTY] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock RustyCaptured(playerid)
{
	if(RandomCpID == RUSTY)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[RUSTY] = 1;
	Capturing{playerid} = false;
	UnderAttack[RUSTY] = 0;
	IsPlayerCapturing[playerid][RUSTY] = 0;
	KillTimer(timer[RUSTY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[RUSTY] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Rusty Bridge\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Rusty Bridge"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[RUSTY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[RUSTY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[RUSTY], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Rusty Bridge\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingRusty(playerid)
{
	Captured[RUSTY] = 0;
	Capturing{playerid} = false;
	UnderAttack[RUSTY] = 0;
	IsPlayerCapturing[playerid][RUSTY] = 0;
	KillTimer(timer[RUSTY]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[RUSTY] = 25;
	GangZoneStopFlashForAll(Zone[RUSTY]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Rusty(playerid);
public Rusty(playerid)
{
	RustyCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveGhost(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[GHOST] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == GHOST && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[GHOST] = 1;
				Capturing{playerid} = true;
				timer[GHOST] = SetTimerEx("Ghost", 25000, false,"d",playerid);
				Captured[GHOST] = 0;
				IsPlayerCapturing[playerid][GHOST] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[GHOST], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[GHOST], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[GHOST], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[GHOST], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[GHOST], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[GHOST] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Ghost Town is under attack!");
				}
				else if(tCP[GHOST] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Ghost Town is under attack!");
				}
				else if(tCP[GHOST] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Ghost Town is under attack!");
				}
				else if(tCP[GHOST] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Ghost Town is under attack!");
				}
				else if(tCP[GHOST] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Ghost Town is under attack!");
				}
				else if(tCP[GHOST] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock GhostCaptured(playerid)
{
	if(RandomCpID == GHOST)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[GHOST] = 1;
	Capturing{playerid} = false;
	UnderAttack[GHOST] = 0;
	IsPlayerCapturing[playerid][GHOST] = 0;
	KillTimer(timer[GHOST]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[GHOST] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Ghost Town\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Ghost Town"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[GHOST] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[GHOST]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[GHOST], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Ghost Town\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingGhost(playerid)
{
	Captured[GHOST] = 0;
	Capturing{playerid} = false;
	UnderAttack[GHOST] = 0;
	IsPlayerCapturing[playerid][GHOST] = 0;
	KillTimer(timer[GHOST]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[GHOST] = 25;
	GangZoneStopFlashForAll(Zone[GHOST]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Ghost(playerid);
public Ghost(playerid)
{
	GhostCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveHospital(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[HOSP] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == HOSP && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[HOSP] = 1;
				Capturing{playerid} = true;
				timer[HOSP] = SetTimerEx("Hospital", 25000, false,"d",playerid);
				Captured[HOSP] = 0;
				IsPlayerCapturing[playerid][HOSP] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[HOSP], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[HOSP], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[HOSP], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[HOSP], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[HOSP], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[HOSP] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Hospital is under attack!");
				}
				else if(tCP[HOSP] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Hospital is under attack!");
				}
				else if(tCP[HOSP] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Hospital is under attack!");
				}
				else if(tCP[HOSP] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Hospital is under attack!");
				}
				else if(tCP[HOSP] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Hospital is under attack!");
				}
				else if(tCP[HOSP] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock HospitalCaptured(playerid)
{
	if(RandomCpID == HOSP)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[HOSP] = 1;
	Capturing{playerid} = false;
	UnderAttack[HOSP] = 0;
	IsPlayerCapturing[playerid][HOSP] = 0;
	KillTimer(timer[HOSP]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[HOSP] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Hospital\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Hospital"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[HOSP] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[HOSP]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[HOSP], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Hospital\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingHospital(playerid)
{
	Captured[HOSP] = 0;
	Capturing{playerid} = false;
	UnderAttack[HOSP] = 0;
	IsPlayerCapturing[playerid][HOSP] = 0;
	KillTimer(timer[HOSP]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[HOSP] = 25;
	GangZoneStopFlashForAll(Zone[HOSP]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Hospital(playerid);
public Hospital(playerid)
{
	HospitalCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveVilla(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[VILLA] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == VILLA && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[VILLA] = 1;
				Capturing{playerid} = true;
				timer[VILLA] = SetTimerEx("Villa", 25000, false,"d",playerid);
				Captured[VILLA] = 0;
				IsPlayerCapturing[playerid][VILLA] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[VILLA], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[VILLA], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[VILLA], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[VILLA], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[VILLA], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[VILLA] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Villa is under attack!");
				}
				else if(tCP[VILLA] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Villa is under attack!");
				}
				else if(tCP[VILLA] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Villa is under attack!");
				}
				else if(tCP[VILLA] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Villa is under attack!");
				}
				else if(tCP[VILLA] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Villa is under attack!");
				}
				else if(tCP[VILLA] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock VillaCaptured(playerid)
{
	if(RandomCpID == VILLA)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[VILLA] = 1;
	Capturing{playerid} = false;
	UnderAttack[VILLA] = 0;
	IsPlayerCapturing[playerid][VILLA] = 0;
	KillTimer(timer[VILLA]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[VILLA] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Villa\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Villa"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[VILLA] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[VILLA]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[VILLA], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Villa\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingVilla(playerid)
{
	Captured[VILLA] = 0;
	Capturing{playerid} = false;
	UnderAttack[VILLA] = 0;
	IsPlayerCapturing[playerid][VILLA] = 0;
	KillTimer(timer[VILLA]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[VILLA] = 25;
	GangZoneStopFlashForAll(Zone[VILLA]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Villa(playerid);
public Villa(playerid)
{
	VillaCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveBioShip(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[BIOSHIP] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == BIOSHIP && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[BIOSHIP] = 1;
				Capturing{playerid} = true;
				timer[BIOSHIP] = SetTimerEx("BioShip", 25000, false,"d",playerid);
				Captured[BIOSHIP] = 0;
				IsPlayerCapturing[playerid][BIOSHIP] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[BIOSHIP], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[BIOSHIP], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[BIOSHIP], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[BIOSHIP], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[BIOSHIP], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[BIOSHIP] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Biological Ship is under attack!");
				}
				else if(tCP[BIOSHIP] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Biological Ship is under attack!");
				}
				else if(tCP[BIOSHIP] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Biological Ship is under attack!");
				}
				else if(tCP[BIOSHIP] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Biological Ship is under attack!");
				}
				else if(tCP[BIOSHIP] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Biological Ship is under attack!");
				}
				else if(tCP[BIOSHIP] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock BioShipCaptured(playerid)
{
	if(RandomCpID == BIOSHIP)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[BIOSHIP] = 1;
	Capturing{playerid} = false;
	UnderAttack[BIOSHIP] = 0;
	IsPlayerCapturing[playerid][BIOSHIP] = 0;
	KillTimer(timer[BIOSHIP]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[BIOSHIP] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Biological Ship\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Biological Ship"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[BIOSHIP] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[BIOSHIP]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[BIOSHIP], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Biological Ship\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingBioShip(playerid)
{
	Captured[BIOSHIP] = 0;
	Capturing{playerid} = false;
	UnderAttack[BIOSHIP] = 0;
	IsPlayerCapturing[playerid][BIOSHIP] = 0;
	KillTimer(timer[BIOSHIP]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[BIOSHIP] = 25;
	GangZoneStopFlashForAll(Zone[BIOSHIP]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward BioShip(playerid);
public BioShip(playerid)
{
	BioShipCaptured(playerid);
	return 1;
}
//==============================================================================*/
stock ActiveCerberus(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[CERBERUS] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				if(RandomCpID == CERBERUS && !NoBonusCp)
				{
					new bmsg[120];
					format(bmsg, 120, "You are capturing %s and will recieve $%d and %d score as the bonus.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
					SendClientMessage(playerid, bCol, bmsg);
				}
				UnderAttack[CERBERUS] = 1;
				Capturing{playerid} = true;
				timer[CERBERUS] = SetTimerEx("Cerberus", 25000, false,"d",playerid);
				Captured[CERBERUS] = 0;
				IsPlayerCapturing[playerid][CERBERUS] = 1; // NO BUG TUT
				SendClientMessage(playerid, 0xFFFFFFFF,"Stay in this checkpoint for 25 seconds to capture!");
				if(gTeam[playerid] == TEAM_EUROPE)
				{
				  GangZoneFlashForAll(Zone[CERBERUS], TEAM_ZONE_EUROPE_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ARAB)
				{
				  GangZoneFlashForAll(Zone[CERBERUS], TEAM_ZONE_ARAB_COLOR);
				}
				else if(gTeam[playerid] == TEAM_SOVIET)
				{
				  GangZoneFlashForAll(Zone[CERBERUS], TEAM_ZONE_SOVIET_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
				  GangZoneFlashForAll(Zone[CERBERUS], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_AUS)
				{
				  GangZoneFlashForAll(Zone[CERBERUS], TEAM_ZONE_AUS_COLOR);
				}
				//------Message-----
				if(tCP[CERBERUS] == TEAM_EUROPE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Europe");
				  SendTeamMessage(TEAM_EUROPE, green,"* Cerberus Island is under attack!");
				}
				else if(tCP[CERBERUS] == TEAM_ARAB)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Arabia");
				  SendTeamMessage(TEAM_ARAB, green,"* Cerberus Island is under attack!");
				}
				else if(tCP[CERBERUS] == TEAM_SOVIET)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Soviet");
				  SendTeamMessage(TEAM_SOVIET, green,"* Cerberus Island is under attack!");
				}
				else if(tCP[CERBERUS] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"USA");
				  SendTeamMessage(TEAM_USA, green,"* Cerberus Island is under attack!");
				}
				else if(tCP[CERBERUS] == TEAM_AUS)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"Australia");
				  SendTeamMessage(TEAM_AUS, green,"* Cerberus Island is under attack!");
				}
				else if(tCP[CERBERUS] == TEAM_NONE)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock CerberusCaptured(playerid)
{
	if(RandomCpID == CERBERUS)
	{
		new str[200];
		format(str, sizeof(str),"[PED] %s has captured the bonus capture zone %s for $%d and %d score", pName(playerid), GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessageToAll(bCol, str);
		print(str);
		SendClientMessageToAll(-1, "{80C732}New bonus capture zone selecting in 5 minutes.");
		GivePlayerScore(playerid, RandomCpScore);
		GiveCODMoney(playerid, RandomCpMoney);
		RandomCpID = -1;
		NoBonusCp = 1;
		RandomCpMoney = 0;
		RandomCpScore = 0;
		KillTimer(BonusCpTimer);
		BonusCpTimer = SetTimer("BonusCP", 300000, 0);
	}
	Captured[CERBERUS] = 1;
	Capturing{playerid} = false;
	UnderAttack[CERBERUS] = 0;
	IsPlayerCapturing[playerid][CERBERUS] = 0;
	KillTimer(timer[CERBERUS]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[CERBERUS] = 25;
	GivePlayerScore(playerid, 5);
	GiveCODMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Cerberus Island\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Cerberus Island"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[CERBERUS] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[CERBERUS]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_EUROPE)
	{
	   GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_EUROPE_COLOR);
	}
	else if(gTeam[playerid] == TEAM_ARAB)
	{
	   GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_ARAB_COLOR);
	}
	else if(gTeam[playerid] == TEAM_SOVIET)
	{
	   GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_SOVIET_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_AUS)
	{
	   GangZoneShowForAll(Zone[CERBERUS], TEAM_ZONE_AUS_COLOR);
	}
	//==========================================================================
	new str[128];
	format(str, sizeof(str),"{80C732}%s {FFFFFF}has captured {80C732}\"Cerberus Island\" {FFFFFF}for team {80C732}%s", pName(playerid), GetTeamName(playerid));
	SendClientMessageToAll(-1, str);
	return 1;
}
stock LeavingCerberus(playerid)
{
	Captured[CERBERUS] = 0;
	Capturing{playerid} = false;
	UnderAttack[CERBERUS] = 0;
	IsPlayerCapturing[playerid][CERBERUS] = 0;
	KillTimer(timer[CERBERUS]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	CountVar[CERBERUS] = 25;
	GangZoneStopFlashForAll(Zone[CERBERUS]);
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Cerberus(playerid);
public Cerberus(playerid)
{
	CerberusCaptured(playerid);
	return 1;
}
//==============================================================================
//============================[ OnPlayerEnter and OnPlayerLeave Dynamic CP]=====
//==============================================================================
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == CP[SNAKE])
	{
		if(Spectating[playerid]) return 0;
		if(PlayerInfo[playerid][OnDuty]) return CaptureZoneMessage(playerid, 3);
		if(tCP[SNAKE] == gTeam[playerid]) return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
		if(UnderAttack[SNAKE]) return CaptureZoneMessage(playerid, 2);
		ActiveSnakeFarm(playerid);
		//if(UnderHelp[SNAKE] && UnderAttack[SNAKE]) return SendClientMessage(playerid, -1, "*This zone is already being assisted and captured!");
		/*if(!UnderHelp[SNAKE])
		{
			if(!UnderAttack[SNAKE])
			{
				CountVar[SNAKE] = 25;
				ActiveSnakeFarm(playerid);
			}
			else
			{
				IsPlayerHelping[playerid][SNAKE] = 1;
				UnderHelp[SNAKE] = 1;
				SendClientMessage(playerid, -1, "*You are helping your team mate to capture this zone");
			}
		}
		else
		{
			if(UnderAttack[SNAKE]) return CaptureZoneMessage(playerid, 2);
		}
		*/
	}
	else if(checkpointid == CP[BAY])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[BAY] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[BAY] != gTeam[playerid]) {
						CountVar[BAY] = 25;
						ActiveBay(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[A51])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[A51] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[A51] != gTeam[playerid]) {
						CountVar[A51] = 25;
						ActiveArea51(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[ARMY])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[ARMY] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[ARMY] != gTeam[playerid]) {
						CountVar[ARMY] = 25;
						ActiveArmy(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[PETROL])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[PETROL] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[PETROL] != gTeam[playerid]) {
						CountVar[PETROL] = 25;
						ActivePetrol(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[OIL])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[OIL] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[OIL] != gTeam[playerid]) {
						CountVar[OIL] = 25;
						ActiveOil(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[DESERT])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[DESERT] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[DESERT] != gTeam[playerid]) {
						CountVar[DESERT] = 25;
						ActiveDesert(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[QUARRY])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[QUARRY] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[QUARRY] != gTeam[playerid]) {
						CountVar[QUARRY] = 25;
						ActiveQuarry(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[GUEST])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[GUEST] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[GUEST] != gTeam[playerid]) {
						CountVar[GUEST] = 25;
						ActiveGuest(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[EAR])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[EAR] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[EAR] != gTeam[playerid]) {
						CountVar[EAR] = 25;
						ActiveEar(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[DA])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[DA] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[DA] != gTeam[playerid]) {
						CountVar[DA] = 25;
						ActiveAirport(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[AMMU])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[AMMU] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[AMMU] != gTeam[playerid]) {
						CountVar[AMMU] = 25;
						ActiveAmmunation(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[DAM])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[DAM] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[DAM] != gTeam[playerid]) {
						CountVar[DAM] = 25;
						ActiveDam(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[BELL])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[BELL] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[BELL] != gTeam[playerid]) {
						CountVar[BELL] = 25;
						ActiveBell(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[RUSTY])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[RUSTY] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[RUSTY] != gTeam[playerid]) {
						CountVar[RUSTY] = 25;
						ActiveRusty(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[GHOST])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[GHOST] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[GHOST] != gTeam[playerid]) {
						CountVar[GHOST] = 25;
						ActiveGhost(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[HOSP])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[HOSP] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[HOSP] != gTeam[playerid]) {
						CountVar[HOSP] = 25;
						ActiveHospital(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[VILLA])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[VILLA] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[VILLA] != gTeam[playerid]) {
						CountVar[VILLA] = 25;
						ActiveVilla(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[BIOSHIP])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[BIOSHIP] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[BIOSHIP] != gTeam[playerid]) {
						CountVar[BIOSHIP] = 25;
						ActiveBioShip(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[CERBERUS])
	{
		if(!Spectating[playerid]) {
			if(UnderAttack[CERBERUS] == 0) {
				if(!PlayerInfo[playerid][OnDuty]) {
					if(tCP[CERBERUS] != gTeam[playerid]) {
						CountVar[CERBERUS] = 25;
						ActiveCerberus(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	return 1;
}
public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	if(checkpointid == CP[SNAKE] && !Captured[SNAKE])
	{
		if(UnderAttack[SNAKE] && IsPlayerCapturing[playerid][SNAKE] /*&& !IsPlayerInDynamicCP(playerid, CP[SNAKE])*/)
		{
			LeavingSnakeFarm(playerid);
			/*if(UnderHelp[SNAKE])
			{
				for(new i, l = GetPlayerPoolSize(); i <= l; i++)
				{
					if(IsPlayerHelping[i][SNAKE])
					{
						IsPlayerHelping[i][SNAKE] = 0;
						SendClientMessage(i, -1, "*Assistance failed because, capturer left the checkpoint.");
					}
				}
			}*/
		}
		//LeavingHSnakeFarm(playerid);
	}
	/*if(checkpointid == CP[SNAKE] && Captured[SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1 && !IsPlayerInDynamicCP(playerid, CP[SNAKE]))
	{
		LeavingSnakeFarm(playerid);
	}*/
	if(checkpointid == CP[BAY] && Captured[BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1 && !IsPlayerInDynamicCP(playerid, CP[BAY]))
	{
		LeavingBay(playerid);
	}
	if(checkpointid == CP[A51] && Captured[A51] == 0 && IsPlayerCapturing[playerid][A51] == 1 && !IsPlayerInDynamicCP(playerid, CP[A51]))
	{
		LeavingArea51(playerid);
	}
	if(checkpointid == CP[ARMY] && Captured[ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1 && !IsPlayerInDynamicCP(playerid, CP[ARMY]))
	{
		LeavingArmy(playerid);
	}
	if(checkpointid == CP[PETROL] && Captured[PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1 && !IsPlayerInDynamicCP(playerid, CP[PETROL]))
	{
		LeavingPetrol(playerid);
	}
	if(checkpointid == CP[OIL] && Captured[OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1 && !IsPlayerInDynamicCP(playerid, CP[OIL]))
	{
		LeavingOil(playerid);
	}
	if(checkpointid == CP[DESERT] && Captured[DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1 && !IsPlayerInDynamicCP(playerid, CP[DESERT]))
	{
		LeavingDesert(playerid);
	}
	if(checkpointid == CP[QUARRY] && Captured[QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1 && !IsPlayerInDynamicCP(playerid, CP[QUARRY]))
	{
		LeavingQuarry(playerid);
	}
	if(checkpointid == CP[GUEST] && Captured[GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1 && !IsPlayerInDynamicCP(playerid, CP[GUEST]))
	{
		LeavingGuest(playerid);
	}
	if(checkpointid == CP[EAR] && Captured[EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1 && !IsPlayerInDynamicCP(playerid, CP[EAR]))
	{
		LeavingEar(playerid);
	}
	if(checkpointid == CP[DA] && Captured[DA] == 0 && IsPlayerCapturing[playerid][DA] == 1 && !IsPlayerInDynamicCP(playerid, CP[DA]))
	{
		LeavingAirport(playerid);
	}
	if(checkpointid == CP[AMMU] && Captured[AMMU] == 0 && IsPlayerCapturing[playerid][AMMU] == 1 && !IsPlayerInDynamicCP(playerid, CP[AMMU]))
	{
		LeavingAmmunation(playerid);
	}
	if(checkpointid == CP[DAM] && Captured[DAM] == 0 && IsPlayerCapturing[playerid][DAM] == 1 && !IsPlayerInDynamicCP(playerid, CP[DAM]))
	{
		LeavingDam(playerid);
	}
	if(checkpointid == CP[BELL] && Captured[BELL] == 0 && IsPlayerCapturing[playerid][BELL] == 1 && !IsPlayerInDynamicCP(playerid, CP[BELL]))
	{
		LeavingBell(playerid);
	}
	if(checkpointid == CP[RUSTY] && Captured[RUSTY] == 0 && IsPlayerCapturing[playerid][RUSTY] == 1 && !IsPlayerInDynamicCP(playerid, CP[RUSTY]))
	{
		LeavingRusty(playerid);
	}
	if(checkpointid == CP[GHOST] && Captured[GHOST] == 0 && IsPlayerCapturing[playerid][GHOST] == 1 && !IsPlayerInDynamicCP(playerid, CP[GHOST]))
	{
		LeavingGhost(playerid);
	}
	if(checkpointid == CP[HOSP] && Captured[HOSP] == 0 && IsPlayerCapturing[playerid][HOSP] == 1 && !IsPlayerInDynamicCP(playerid, CP[HOSP]))
	{
		LeavingHospital(playerid);
	}
	if(checkpointid == CP[VILLA] && Captured[VILLA] == 0 && IsPlayerCapturing[playerid][VILLA] == 1 && !IsPlayerInDynamicCP(playerid, CP[VILLA]))
	{
		LeavingVilla(playerid);
	}
	if(checkpointid == CP[BIOSHIP] && Captured[BIOSHIP] == 0 && IsPlayerCapturing[playerid][BIOSHIP] == 1 && !IsPlayerInDynamicCP(playerid, CP[BIOSHIP]))
	{
		LeavingBioShip(playerid);
	}
	if(checkpointid == CP[CERBERUS] && Captured[CERBERUS] == 0 && IsPlayerCapturing[playerid][CERBERUS] == 1 && !IsPlayerInDynamicCP(playerid, CP[CERBERUS]))
	{
		LeavingCerberus(playerid);
	}
	return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
	if(text[0] == '.' && PlayerInfo[playerid][Level] >= 1)
	{
		new string[128];
		format(string,sizeof(string),"Admin Chat: {80C732}%s: {FFFFFF}%s", pName(playerid), text[1]); MessageToAdmins(red,string);
		return 0;
	}
	if(text[0] == '$' && PlayerInfo[playerid][Level] >= 4)
	{
		new string[128];
		format(string, sizeof(string), "Level 4 Chat{00FF00}%s: {FFFFFF}%s", pName(playerid), text[1]); MessageTo4(red,string);
		return 0;
	}
	if(text[0] == '@' && PlayerInfo[playerid][Level] >= 5)
	{
		new string[128];
		format(string,sizeof(string),"Global Chat: {0000FF}%s: {FFFFFF}%s", pName(playerid),text[1]); MessageTo5(red,string);
		return 0;
	}
	if(ServerInfo[DisableChat] == 1)
	{
		SendClientMessage(playerid,red,"Chat has been disabled");
		return 0;
	}
	if(PlayerInfo[playerid][Muted] == 1)
	{
		PlayerInfo[playerid][MuteWarnings]+= 1;
		new string[128];
		if(PlayerInfo[playerid][MuteWarnings] < ServerInfo[MaxMuteWarnings]) {
			format(string, sizeof(string),"* You are muted, if you continue to speak you will be kicked. (%d/%d)", PlayerInfo[playerid][MuteWarnings], ServerInfo[MaxMuteWarnings] );
			SendClientMessage(playerid,red,string);
		} else {
			format(string, sizeof(string),"%s (%d) was auto kicked (Reason: Exceed Mute Warnings)", pName(playerid), playerid);
			SendClientMessageToAll(grey,string);
			SaveToFile("KickLog",string); SetTimerEx("KickTimer", 1000, false, "d", playerid);
		} return 0;
	}
	if(ServerInfo[AntiSpam] == 1)
	{
		if(PlayerInfo[playerid][SpamCount] == 0) PlayerInfo[playerid][SpamTime] = gettime();

		PlayerInfo[playerid][SpamCount]+= 1;
		if(gettime() - PlayerInfo[playerid][SpamTime] > SPAM_TIMELIMIT)
		{
			PlayerInfo[playerid][SpamCount] = 0;
			PlayerInfo[playerid][SpamTime] = gettime();
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS)
		{
			new string[64]; format(string,sizeof(string),"%s (%d) was auto kicked (Reason: Exceeded Spam Warnings)", pName(playerid), playerid);
			SendClientMessageToAll(red,string); print(string);
			SaveToFile("KickLog",string);
			SetTimerEx("KickTimer", 1000, false, "d", playerid);
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS-1)
		{
			SendClientMessage(playerid,red,"* Anti Spam Warning! Next is a kick.");
			return 0;
		}
	}
	/*if(ServerInfo[AntiSwear] == 1)
	{
		for(new s = 0; s < ForbiddenWordCount; s++)
		{
			new pos;
			while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
		}
	}*/

	if(PlayerInfo[playerid][Caps] == 1) UpperToLower(text);
	if(ServerInfo[NoCaps] == 1) UpperToLower(text);

	switch (PlayerInfo[playerid][OnDuty])
	{
		case 0:
		{
			new string[128];
			format(string,sizeof(string),"%s [%i]: %s", pName(playerid), playerid, text);
			SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 100.0, 10000);
			printf("%s [%i]: %s", pName(playerid),playerid,text);
			SendClientMessageToAll(GetPlayerColor(playerid),string);
			return 0;
		}
		case 1:
		{
			new string2[128];
			format(string2,sizeof(string2),"Admin %s: %s", pName(playerid), text);
			printf(string2);
			SendClientMessageToAll(COLOR_PINK,string2);
			return 0;
		}
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == SOV_SHOP)
	{
		if(gTeam[playerid] != TEAM_SOVIET) return SendClientMessage(playerid, 0xFF0000AA, "Only Soviet team can use this Shop.");
		ShowPlayerDialog(playerid, SHOPS_DIALOG, DIALOG_STYLE_LIST, "Shop", "Health - 5000$\nArmour - 5000$\n\nWeapons\nHelmet - 2000$\nDisguise Kit - 3000$", "Buy", "Cancel");
		return 1;
	}
	if(pickupid == EUR_SHOP)
	{
		if(gTeam[playerid] != TEAM_EUROPE) return SendClientMessage(playerid, 0xFF0000AA, "Only Europe team can use this Shop.");
		ShowPlayerDialog(playerid, SHOPS_DIALOG, DIALOG_STYLE_LIST, "Shop", "Health - 5000$\nArmour - 5000$\n\nWeapons\nHelmet - 2000$\nDisguise Kit - 3000$", "Buy", "Cancel");
		return 1;
	}
	if(pickupid == ARAB_SHOP)
	{
		if(gTeam[playerid] != TEAM_ARAB) return SendClientMessage(playerid, 0xFF0000AA, "Only Arabia team can use this Shop.");
		ShowPlayerDialog(playerid, SHOPS_DIALOG, DIALOG_STYLE_LIST, "Shop", "Health - 5000$\nArmour - 5000$\n\nWeapons\nHelmet - 2000$\nDisguise Kit - 3000$", "Buy", "Cancel");
		return 1;
	}
	if(pickupid == AUS_SHOP)
	{
		if(gTeam[playerid] != TEAM_AUS) return SendClientMessage(playerid, 0xFF0000AA, "Only Australia team can use this Shop.");
		ShowPlayerDialog(playerid, SHOPS_DIALOG, DIALOG_STYLE_LIST, "Shop", "Health - 5000$\nArmour - 5000$\n\nWeapons\nHelmet - 2000$\nDisguise Kit - 3000$", "Buy", "Cancel");
		return 1;
	}
	if(pickupid == USA_SHOP)
	{
		if(gTeam[playerid] != TEAM_USA) return SendClientMessage(playerid, 0xFF0000AA, "Only USA team can use this Shop.");
		ShowPlayerDialog(playerid, SHOPS_DIALOG, DIALOG_STYLE_LIST, "Shop", "Health - 5000$\nArmour - 5000$\n\nWeapons\nHelmet - 2000$\nDisguise Kit - 3000$", "Buy", "Cancel");
		return 1;
	}
	if(pickupid == DA_SHOP)
	{
		ShowPlayerDialog(playerid, SHOPS_DIALOG, DIALOG_STYLE_LIST, "Shop", "Health - 5000$\nArmour - 5000$\n\nWeapons\nHelmet - 2000$\nDisguise Kit - 3000$", "Buy", "Cancel");
		return 1;
	}
	if(pickupid == NUKE)
	{
		if(tCP[A51] == gTeam[playerid])
		{
			if(nuke_time >= 1)
			{
				new string[80];
				format(string, sizeof(string), "* Nuke is not ready to be launched, wait %d seconds", nuke_time);
				SendClientMessage(playerid, red, string);
			}
			else
			{
				ShowPlayerDialog(playerid, 991, DIALOG_STYLE_LIST, "Nuke Station (Area 51)", "USA\nEurope\nArabia\nSoviet\nAustralia", "Launch", "Abort");
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, RED, "Your team dosn't own Area 51.");
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && GetPlayerState(playerid) != PLAYER_STATE_SPAWNED && GetPlayerState(playerid) != PLAYER_STATE_WASTED)
	{
		s_aPlayerTickInfo[playerid][e_PLAYER_TICK] = GetConnectedTime(playerid);
	}
	if(IsPlayerUsingAnims[playerid])
	{
		StopAnimLoopPlayer(playerid);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		if(newkeys == KEY_JUMP) AdvanceSpectate(playerid);
		else if(newkeys == KEY_SPRINT) ReverseSpectate(playerid);
		else if(newkeys == KEY_FIRE) StopSpectate(playerid);
	}
	if(newkeys & KEY_NO)
	{
		if(AntiSK[playerid] == 1)
		{
			SendClientMessage(playerid, red, "* You have ended your spawn protection");
			KillTimer(AntiSKt[playerid]);
			SpawnProtection(playerid);
		}
	}
	if(newkeys & KEY_YES) //Key_No = N & Key_Yes = Y
	{
		new AirCraft = GetVehicleModel(GetPlayerVehicleID(playerid));
		if(AirCraft == 520 || AirCraft == 447 || AirCraft == 425 || AirCraft == 460 || AirCraft == 476 || AirCraft == 487 || AirCraft == 488 || AirCraft == 497 || AirCraft == 511 || AirCraft == 512 ||  AirCraft ==513 || AirCraft == 519 || AirCraft == 548 || AirCraft == 469 || AirCraft == 553 || AirCraft == 563 || AirCraft == 577 || AirCraft == 592 || AirCraft == 593)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new Float:x, Float:y, Float:z; // Create the variables to store the vehicle pos
			GetVehiclePos(vehicleid,x,y,z); // Gets The Vehicle Position
			SetPlayerPos(playerid,x,y,z+80); // SetPlayerPos to variables x and y and z + 80 values. (90 before)
			GivePlayerWeapon(playerid, 46 , 1); // Gives Player A Parachute
			/*GameTextForPlayer(playerid,"~r~Ejected!",2500,0);*/ // Shows A Gametext To The Player
		 }
	}
	switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case 432:
		{
			if(gClass[playerid] != ENGINEER && gClass[playerid] != DONOR && gTeam[playerid] != TEAM_NONE)
			{
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid, red, "ERROR: {828282}You need to be Engineer to Donor to drive Rhino!");
			}
		}
		case 520 || 425 || 447:
		{
			if(gClass[playerid] != DONOR && gClass[playerid] != PILOT && gTeam[playerid] != TEAM_NONE)
			{
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid, red, "ERROR: {828282}You need to be Pilot or Donor to pilot Hydra!");
			}
		}
	}
	return 1;
}

stock GetRankName(playerid)
{
	new str[64];
	switch(GetRankID(playerid))
	{
		case 0: str = "Private";
		case 1: str = "Corporal";
		case 2: str = "Sergeant";
		case 3: str = "Sergeant Major";
		case 4: str = "Officer";
		case 5: str = "Lieutenant";
		case 6: str = "Lieutenant Major";
		case 7: str = "Captain";
		case 8: str = "Major";
		case 9: str = "Colonel";
		case 10: str = "General";
		case 11: str = "Field Marshall";
		case 12: str = "Master of War";
	}
	return str;
/*	if (GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 49) str3 = ("Private");
	if (GetPlayerScore(playerid) >= 50 && GetPlayerScore(playerid) <= 149) str3 = ("Corporal");
	if (GetPlayerScore(playerid) >= 150 && GetPlayerScore(playerid) <= 299) str3 = ("Sergeant");
	if (GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 549) str3 = ("Sergeant Major");
	if (GetPlayerScore(playerid) >= 550 && GetPlayerScore(playerid) <= 799) str3 = ("Officer");
	if (GetPlayerScore(playerid) >= 800 && GetPlayerScore(playerid) <= 1499) str3 = ("Lieutenant");
	if (GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999) str3 = ("Lieutenant Major");
	if (GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 4499) str3 = ("Captain");
	if (GetPlayerScore(playerid) >= 4500 && GetPlayerScore(playerid) <= 7999) str3 = ("Major");
	if (GetPlayerScore(playerid) >= 8000 && GetPlayerScore(playerid) <= 9999) str3 = ("Colonel");
	if (GetPlayerScore(playerid) >= 10000 && GetPlayerScore(playerid) <= 14999) str3 = ("General");
	if (GetPlayerScore(playerid) >= 15000 && GetPlayerScore(playerid) <= 20000) str3 = ("Field Marshall");
	if (GetPlayerScore(playerid) >= 20000) str3 = ("Master of War");
	return str3;*/
}

stock GetRankID(playerid)
{
	new xID;
	if (GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 49) xID = 0;
	if (GetPlayerScore(playerid) >= 50 && GetPlayerScore(playerid) <= 149) xID = 1;
	if (GetPlayerScore(playerid) >= 150 && GetPlayerScore(playerid) <= 299) xID = 2;
	if (GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 549) xID = 3;
	if (GetPlayerScore(playerid) >= 550 && GetPlayerScore(playerid) <= 799) xID = 4;
	if (GetPlayerScore(playerid) >= 800 && GetPlayerScore(playerid) <= 1499) xID = 5;
	if (GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999) xID = 6;
	if (GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 4499) xID = 7;
	if (GetPlayerScore(playerid) >= 4500 && GetPlayerScore(playerid) <= 7999) xID = 8;
	if (GetPlayerScore(playerid) >= 8000 && GetPlayerScore(playerid) <= 9999) xID = 9;
	if (GetPlayerScore(playerid) >= 10000 && GetPlayerScore(playerid) <= 14999) xID = 10;
	if (GetPlayerScore(playerid) >= 15000 && GetPlayerScore(playerid) <= 19999) xID = 11;
	if (GetPlayerScore(playerid) >= 20000) xID = 12;
	return xID;
}

stock GetClass(playerid)
{
	new str[64];
	if(gClass[playerid] == SOLDIER) str = ("Soldier");
	else if(gClass[playerid] == SNIPER) str = ("Sniper");
	else if(gClass[playerid] == ENGINEER) str = ("Engineer");
	else if(gClass[playerid] == PILOT) str = ("Pilot");
	else if(gClass[playerid] == DONOR) str = ("Donor");
	else if(gClass[playerid] == SPY) str = ("Spy");
	else if(gClass[playerid] == JET) str = ("JetTrooper");
	else if(gClass[playerid] == DEMOLISHER) str = ("Demolisher");
	else if(gClass[playerid] == HEAVY) str = ("Heavy");
	else if(gClass[playerid] == SUPPORT) str = ("Support");
	return str;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	if(vehicleid == AUSpro)	SetVehicleParamsForPlayer(AUSpro, forplayerid, 1, 0); // marker can be visible only if the vehicle streamed for player
	if(vehicleid == SOVpro)	SetVehicleParamsForPlayer(SOVpro, forplayerid, 1, 0); // marker can be visible only if the vehicle streamed for player
	if(vehicleid == ARBpro)	SetVehicleParamsForPlayer(ARBpro, forplayerid, 1, 0); // marker can be visible only if the vehicle streamed for player
	if(vehicleid == EURpro)	SetVehicleParamsForPlayer(EURpro, forplayerid, 1, 0); // marker can be visible only if the vehicle streamed for player
	if(vehicleid == USApro)	SetVehicleParamsForPlayer(USApro, forplayerid, 1, 0); // marker can be visible only if the vehicle streamed for player
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case CLASS_DIALOG:
		{
			if(!response)
			{
				SendClientMessage(playerid, RED, "You have to choose a class!");
				ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
			}
			else
			{
				switch(listitem)
				{
					case 0:
					{
						gClass[playerid] = SOLDIER;
						SendClientMessage(playerid, -1,"Class:{80C732} Soldier");
						SendClientMessage(playerid, -1,"Good against {80C732}Infantry");
						SpawnPlayer(playerid);
					}
					case 1:
					{
						if(GetPlayerScore(playerid) >= 50)
						{
							gClass[playerid] = SNIPER;
							SendClientMessage(playerid, -1,"Class:{80C732} Sniper");
							SendClientMessage(playerid, -1,"Invisible in {80C732}Radar");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 2 to use this class!");
						}
					}
					case 2:
					{
						if(GetPlayerScore(playerid) >= 550)
						{
							gClass[playerid] = ENGINEER;
							SendClientMessage(playerid, -1,"Class:{80C732} Engineer");
							SendClientMessage(playerid, -1,"Can Drive {80C732}Tank");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 5 to use this class!");
						}
					}
					case 3:
					{
						if(GetPlayerScore(playerid) >= 800)
						{
							gClass[playerid] = JET;
							SendClientMessage(playerid, -1,"Class:{80C732} JetTrooper");
							SendClientMessage(playerid, -1,"Can use {80C732}/jp");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 6 to use this class!");
						}
					}
					case 4:
					{
						if(GetPlayerScore(playerid) >= 800)
						{
							gClass[playerid] = PILOT;
							SendClientMessage(playerid, -1,"Class:{80C732} Pilot");
							SendClientMessage(playerid, -1,"Can Drive {80C732}Air Vehicles");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 6 to use this class!");
						}
					}
					case 5:
					{
						if(GetPlayerScore(playerid) >= 1500)
						{
							gClass[playerid] = SUPPORT;
							SendClientMessage(playerid, -1,"Class:{80C732} Support");
							SendClientMessage(playerid, -1,"Powerful {80C732}Commands");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 7 to use this class!");
						}
					}
					case 6:
					{
						if(GetPlayerScore(playerid) >= 1500)
						{
						   gClass[playerid] = SPY;
						   SendClientMessage(playerid, -1,"Class:{80C732} Spy");
						   SendClientMessage(playerid, -1,"Disguise as {80C732}Other Teams");
						   SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 7 to use this class! & Please use /spyhelp!");
						}
					}
					case 7:
					{
						if(GetPlayerScore(playerid) >= 2000)
						{
							gClass[playerid] = DEMOLISHER;
							SendClientMessage(playerid, -1,"Class: {80C732}Demolisher");
							SendClientMessage(playerid, -1,"Can use {80C732}/suicide.");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red,"You need to have rank 8 to use this class!");
						}
					}
					case 8:
					{
						if(GetPlayerScore(playerid) >= 20000)
						{
							gClass[playerid] = HEAVY;
							SendClientMessage(playerid, -1,"Class: {80C732}Heavy");
							SendClientMessage(playerid, -1,"Greatest {80C732}Military Class");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red, "You need to have rank 13 to use this class!");
						}
					}
					case 9:
					{
						if(PlayerInfo[playerid][VIP] >= 2)
						{
							gClass[playerid] = DONOR;
							SendClientMessage(playerid, -1,"Class:{80C732} Donor");
							SendClientMessage(playerid, -1,"Welcome! {80C732}Donor");
							SpawnPlayer(playerid);
						}
						else
						{
							ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
							SendClientMessage(playerid, red, "You must atleast donor rank 2!");
						}
					}
				}
			}
		}
		case LOGIN_DIALOG:
		{
			if(!response) return SetTimerEx("KickTimer", 1000, false, "d", playerid);
			else
			{
				if(udb_Exists(pName(playerid)))
				{
					if (udb_CheckLogin(pName(playerid),inputtext))
					{
						new file[256], tmp3[100], string[128];
						format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(pName(playerid)) );
						GetPlayerIp(playerid,tmp3,100);
						dini_Set(file,"ip",tmp3);
						LoginPlayer(playerid);
						PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
						TogglePlayerSpectating(playerid, false);
						if(PlayerInfo[playerid][Level] > 0 && PlayerInfo[playerid][VIP] > 0)
						{
							format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Level %d | Donor Lv. %d)", PlayerInfo[playerid][Level], PlayerInfo[playerid][VIP]);
						}
						if(PlayerInfo[playerid][Level] > 0)
						{
							format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Level %d)", PlayerInfo[playerid][Level]);
						}
						else if(PlayerInfo[playerid][VIP] > 0)
						{
							format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Donor Lv. %d)", PlayerInfo[playerid][VIP]);
						}
						else
						{
							format(string,sizeof(string),"ACCOUNT: Successfully Logged In");
						}
						return SendClientMessage(playerid,green,string);
					}
					else
					{
						PlayerInfo[playerid][FailLogin]+= 1;
						printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", pName(playerid),inputtext, PlayerInfo[playerid][FailLogin] );
						if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
						{
							new string[128];
							format(string, sizeof(string), "%s has been kicked (Failed Logins)", pName(playerid));
							SendClientMessageToAll(red, string);
							print(string);
							SendClientMessage(playerid,red,"Contact The Management Staff, To Recover Your Password");
							SetTimerEx("KickTimer", 1000, false, "d", playerid);
						}
						new string[200];
						format(string, sizeof(string),""cwhite"Welcome "cred"%s "cwhite"you are already registered\nKindly enter password to login to your account\n"cred"Incorrect password!", pName(playerid));
						ShowPlayerDialog(playerid, LOGIN_DIALOG, DIALOG_STYLE_INPUT, "Login",string,"Login","Kick");
						return 1;
					}
				}
			}
		}
		case REGISTER_DIALOG:
		{
			if(!response) return SetTimerEx("KickTimer", 1000, false, "d", playerid);
			else
			{
				if(strlen(inputtext) < 4 || strlen(inputtext) > 20)
				{
					new string[200];
					format(string, sizeof(string),""cwhite"Welcome "cred"%s "cwhite"you are not registered\nKindly enter password to register your account\n"cred"Invalid password length", pName(playerid));
					ShowPlayerDialog(playerid, REGISTER_DIALOG, DIALOG_STYLE_INPUT, "Register",string,"Register","Kick");
					return 0;
				}
				if (!udb_Exists(pName(playerid)))
				{
					if (udb_Create(pName(playerid),inputtext))
					{
						new file[256],name[MAX_PLAYER_NAME], tmp3[100];
						new strdate[20], year,month,day;	getdate(year, month, day);
						GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(name));
						GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
						dUserSetINT(pName(playerid)).("registered",1);
						format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
						dini_Set(file,"RegisteredDate",strdate);
						dUserSetINT(pName(playerid)).("loggedin",1);
						dUserSetINT(pName(playerid)).("banned",0);
						dUserSetINT(pName(playerid)).("level",0);
						dUserSetINT(pName(playerid)).("LastOn",0);
						dUserSetINT(pName(playerid)).("money",0);
						dUserSetINT(pName(playerid)).("Score",0);
						dUserSetINT(pName(playerid)).("kills",0);
						dUserSetINT(pName(playerid)).("deaths",0);
						dUserSetINT(pName(playerid)).("hours",0);
						dUserSetINT(pName(playerid)).("minutes",0);
						dUserSetINT(pName(playerid)).("seconds",0);
						dUserSetINT(pName(playerid)).("VIP",0);
						PlayerInfo[playerid][LoggedIn] = 1;
						PlayerInfo[playerid][Registered] = 1;
						SendClientMessage(playerid, green, "ACCOUNT: You are now registered and logged in.");
						GiveCODMoney(playerid, 1000);
						PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
						PlayerInfo[playerid][pAchs] += 1;
						PlayerInfo[playerid][pRegAch] = 1;

						GivePlayerScore(playerid, 5);
						PlayerTextDrawSetString(playerid, AchTD3, "~y~Achievement Name: ~w~Loyal Soldier.");
						PlayerTextDrawSetString(playerid, AchTD4, "~y~Reward: ~w~5 score.");
						PlayerTextDrawSetString(playerid, AchTD5, "~y~Achievement Info: ~w~Register on MW4.");
						ShowAchievementTextdraws(playerid);
						TogglePlayerSpectating(playerid, false);
					}
					return 1;
				}
			}
		}
		case 30:
		{
			switch(listitem)
			{
				case 0:
				{
					if(GetCODMoney(playerid) < 8000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -8000);
					GivePlayerWeapon(playerid, 31, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought M4");
				}
				case 1:
				{
					if(GetCODMoney(playerid) < 8000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -8000);
					GivePlayerWeapon(playerid, 30, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought AK 47");
				}
				case 2:
				{
					if(GetCODMoney(playerid) < 6000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -6000);
					GivePlayerWeapon(playerid, 29, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought MP5");
				}
				case 3:
				{
					if(GetCODMoney(playerid) < 12000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -12000);
					GivePlayerWeapon(playerid, 28, 500);
					SendClientMessage(playerid, 0xFFFFFF, "You bought UZI");
				}
				case 4:
				{
					if(GetCODMoney(playerid) < 10000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -10000);
					GivePlayerWeapon(playerid, 27, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Combat Shotgun");
				}
				case 5:
				{
					if(GetCODMoney(playerid) < 5000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -5000);
					GivePlayerWeapon(playerid, 25, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Shotgun");
				}
				case 6:
				{
					if(GetCODMoney(playerid) < 6000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -6000);
					GivePlayerWeapon(playerid, 24, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Desert Eagle");
				}
				case 7:
				{
					if(GetCODMoney(playerid) < 3000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -3000);
					GivePlayerWeapon(playerid, 23, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Silencer");
				}
				case 8:
				{
					if(GetCODMoney(playerid) < 3000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -3000);
					GivePlayerWeapon(playerid, 22, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Pistol");
				}
			}
		}
		case SHOPS_DIALOG:
		{
			if(!response) return 1;
			switch(listitem)
			{
				case 0:
				{
					if(GetCODMoney(playerid) < 5000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -5000);
					SetPlayerHealth(playerid, 100.0);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Health");
				}
				case 1:
				{
					if(GetCODMoney(playerid) < 10000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have enough cash.");
					GiveCODMoney(playerid, -10000);
					SetPlayerArmour(playerid, 100.0);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Armour");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "Weapons", "M4 - 8000$\nAK47 - 8000$\nMP5 - 6000$\nUZI - 12000$\nCombat Shotgun - 10000$\nShotgun - 5000$\nDesert Eagle - 6000$\nSilent Pistol - 3000$\nPistol - 3000$", "Buy", "Exit");
				}
				case 3:
				{
					HHelmet{playerid} = true;
					GiveCODMoney(playerid, -2000);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Helmet");
				}
				case 4:
				{
					if(gClass[playerid] != SPY) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be Spy to buy this.");
					if(DisguiseKits[playerid] >= 5) return SendClientMessage(playerid, red, "ERROR: {828282}You have maximum disguise kits.");
					if(NoSpy) return SendClientMessage(playerid, red,"ERROR: {828282}Its No Spy Week");
					DisguiseKits[playerid] += 1;
					GiveCODMoney(playerid, 3000);
					SendClientMessage(playerid, 0xFFFFFF, "You bought a disguise kits");
				}
			}
		}
		case 11:
		{
			switch(listitem)
			{
				case 0:
				{
					if(DisguiseKits[playerid] < 1) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have any disguise kits left.");
					SetPlayerSkin(playerid, 60);
					SetPlayerColor(playerid, TEAM_EUROPE_COLOR);
					DisguiseKits[playerid] -= 1;
				}
				case 1:
				{
					if(DisguiseKits[playerid] < 1) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have any disguise kits left.");
					SetPlayerSkin(playerid, 179);
					SetPlayerColor(playerid, TEAM_ARAB_COLOR);
					DisguiseKits[playerid] -= 1;
				}
				case 2:
				{
					if(DisguiseKits[playerid] < 1) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have any disguise kits left.");
					SetPlayerSkin(playerid, 206);
					SetPlayerColor(playerid, TEAM_SOVIET_COLOR);
					DisguiseKits[playerid] -= 1;
				}
				case 3:
				{
					if(DisguiseKits[playerid] < 1) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have any disguise kits left.");
					SetPlayerSkin(playerid, 287);
					SetPlayerColor(playerid, TEAM_USA_COLOR);
					DisguiseKits[playerid] -= 1;
				}
				case 4:
				{
					if(DisguiseKits[playerid] < 1) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You don't have any disguise kits left.");
					SetPlayerSkin(playerid, 73);
					SetPlayerColor(playerid, TEAM_AUS_COLOR);
					DisguiseKits[playerid] -= 1;
				}
			}
		}
		case 991:
		{
			if(!response) return SendClientMessage(playerid, red,"You have cancelled the launch of the Nuke.");
			else
			{
				switch(listitem)
				{
					case 0:
					{
						if(GetPlayerScore(playerid) <= 1499) return SendClientMessage(playerid, RED, "ERROR {828282}You need to rank 7");
						if(GetCODMoney(playerid) <= 199999) return SendClientMessage(playerid, RED, "ERROR: {828282}You need 200,000$ to launch nuke");
						if(gTeam[playerid] == TEAM_USA) return SendClientMessage(playerid, RED, "ERROR: {828282}You can't launch nuke on your team");
						new so[100], st[100], sth[100], co;
						GiveCODMoney(playerid, -200000);
						nuke_time = 250;
						format(so, sizeof(so), "%s has launched nuke on USA.", pName(playerid));
						SendClientMessageToAll(TEAM_USA_COLOR, so);
						SendClientMessage(playerid, RED, "Charged -$200000 for nuke.");
						for(new i, l = GetPlayerPoolSize(); i <= l; i++)
						{
							if(IsPlayerInArea(i,-353.515625,2574.21875,-113.28125,2796.875))
							{
								co += 1;
								PlayerInfo[i][Deaths] += 1;
								PlayerInfo[playerid][Kills] += 1;
								SetPlayerHealth(i, 0.0);
								new Float:x, Float:y, Float:z;
								GetPlayerPos(i, x, y, z);
								CreateExplosion(x, y, z, 12, 10.0);
								GameTextForPlayer(i, "~r~NUKE", 4000, 3);
								SendDeathMessage(playerid,i,44);
								GiveCODMoney(playerid, 1000);
								GivePlayerScore(playerid, 1);
								format(st,sizeof(st),"Nuke killed %s | Earned +1 score +1000$", GetName(i));
								SendClientMessage(playerid, green, st);
							}
						}
						format(sth, sizeof(sth), "Nuke has killed %d players.", co);
						SendClientMessageToAll(TEAM_USA_COLOR, sth);
						return 1;
					}
					case 1:
					{
						if(GetPlayerScore(playerid) <= 1499) return SendClientMessage(playerid, RED, "ERROR {828282}You need to rank 7");
						if(GetCODMoney(playerid) <= 199999) return SendClientMessage(playerid, RED, "ERROR: {828282}You need 200,000$ to launch nuke");
						if(gTeam[playerid] == TEAM_EUROPE) return SendClientMessage(playerid, RED, "ERROR: {828282}You can't launch nuke on your team");
						new so[100], st[100], sth[100], co;
						GiveCODMoney(playerid, -200000);
						nuke_time = 250;
						format(so, sizeof(so), "%s has launched nuke on Europe.", pName(playerid));
						SendClientMessageToAll(TEAM_EUROPE_COLOR, so);
						SendClientMessage(playerid, RED, "Charged -$200000 for nuke.");
						for(new i, l = GetPlayerPoolSize(); i <= l; i++)
						{
							if(IsPlayerInArea(i, 873.046875, 2068.359375, 1001.953125, 2250))
							{
								co += 1;
								PlayerInfo[i][Deaths] += 1;
								PlayerInfo[playerid][Kills] += 1;
								SetPlayerHealth(i, 0.0);
								new Float:x, Float:y, Float:z;
								CreateExplosion(x, y, z, 12, 10.0);
								GameTextForPlayer(i, "~r~NUKE", 4000, 3);
								SendDeathMessage(playerid,i,44);
								GiveCODMoney(playerid, 1000);
								GivePlayerScore(playerid, 1);
								format(st,sizeof(st),"Nuke killed %s | Earned +1 score +1000$", GetName(i));
								SendClientMessage(playerid, green, st);
							}
						}
						format(sth, sizeof(sth), "Nuke has killed %d players.", co);
						SendClientMessageToAll(TEAM_EUROPE_COLOR, sth);
						return 1;
					}
					case 2:
					{
						if(GetPlayerScore(playerid) <= 1499) return SendClientMessage(playerid, RED, "ERROR {828282}You need to rank 7");
						if(GetCODMoney(playerid) <= 199999) return SendClientMessage(playerid, RED, "ERROR: {828282}You need 200,000$ to launch nuke");
						if(gTeam[playerid] == TEAM_ARAB) return SendClientMessage(playerid, RED, "ERROR: {828282}You can't launch nuke on your team");
						new so[100], st[100], sth[100], co;
						GiveCODMoney(playerid, -200000);
						nuke_time = 250;
						format(so, sizeof(so), "%s has launched nuke on Arabia.", pName(playerid));
						SendClientMessageToAll(TEAM_ARAB_COLOR, so);
						SendClientMessage(playerid, RED, "Charged -$200000 for nuke.");
						for(new i, l = GetPlayerPoolSize(); i <= l; i++)
						{
							if(IsPlayerInArea(i,-875.8406, 1389.667, -607.2495, 1623.225))
							{
								co += 1;
								PlayerInfo[i][Deaths] += 1;
								PlayerInfo[playerid][Kills] += 1;
								SetPlayerHealth(i, 0.0);
								new Float:x, Float:y, Float:z;
								CreateExplosion(x, y, z, 12, 10.0);
								GameTextForPlayer(i, "~r~NUKE", 4000, 3);
								SendDeathMessage(playerid,i,44);
								GiveCODMoney(playerid, 1000);
								GivePlayerScore(playerid, 1);
								format(st,sizeof(st),"Nuke killed %s | Earned +1 score +1000$", GetName(i));
								SendClientMessage(playerid, green, st);
							}
						}
						format(sth, sizeof(sth), "Nuke has killed %d players.", co);
						SendClientMessageToAll(TEAM_ARAB_COLOR, sth);
						return 1;
					}
					case 3:
					{
						if(GetPlayerScore(playerid) <= 1499) return SendClientMessage(playerid, RED, "ERROR {828282}You need to rank 7");
						if(GetCODMoney(playerid) <= 199999) return SendClientMessage(playerid, RED, "ERROR: {828282}You need 200,000$ to launch nuke");
						if(gTeam[playerid] == TEAM_SOVIET) return SendClientMessage(playerid, RED, "ERROR: {828282}You can't launch nuke on your team");
						new so[100], st[100], sth[100], co;
						GiveCODMoney(playerid, -200000);
						nuke_time = 250;
						format(so, sizeof(so), "%s has launched nuke on Soviet.", pName(playerid));
						SendClientMessageToAll(TEAM_SOVIET_COLOR, so);
						SendClientMessage(playerid, RED, "Charged -$200000 for nuke.");
						for(new i, l = GetPlayerPoolSize(); i <= l; i++)
						{
							if(IsPlayerInArea(i,-309.375,1024.21875,103.125,1211.71875))
							{
								co += 1;
								PlayerInfo[i][Deaths] += 1;
								PlayerInfo[playerid][Kills] += 1;
								SetPlayerHealth(i, 0.0);
								new Float:x, Float:y, Float:z;
								CreateExplosion(x, y, z, 12, 10.0);
								GameTextForPlayer(i, "~r~NUKE", 4000, 3);
								SendDeathMessage(playerid,i,44);
								GiveCODMoney(playerid, 1000);
								GivePlayerScore(playerid, 1);
								format(st,sizeof(st),"Nuke killed %s | Earned +1 score +1000$", GetName(i));
								SendClientMessage(playerid, green, st);
							}
						}
						format(sth, sizeof(sth), "Nuke has killed %d players.", co);
						SendClientMessageToAll(TEAM_SOVIET_COLOR, sth);
						return 1;
					}
					case 4:
					{
						if(GetPlayerScore(playerid) <= 1499) return SendClientMessage(playerid, RED, "ERROR {828282}You need to rank 7");
						if(GetCODMoney(playerid) <= 199999) return SendClientMessage(playerid, RED, "ERROR: {828282}You need 200,000$ to launch nuke");
						if(gTeam[playerid] == TEAM_AUS) return SendClientMessage(playerid, RED, "ERROR: {828282}You can't launch nuke on your team");
						new so[100], st[100], sth[100], co;
						GiveCODMoney(playerid, -200000);
						nuke_time = 250;
						format(so, sizeof(so), "%s has launched nuke on Australia.", pName(playerid));
						SendClientMessageToAll(TEAM_AUS_COLOR, so);
						SendClientMessage(playerid, RED, "Charged -$200000 for nuke.");
						for(new i, l = GetPlayerPoolSize(); i <= l; i++)
						{
							if(IsPlayerInArea(i, 89.0625, 2418.75, 466.40625, 2617.96875))
							{
								co += 1;
								PlayerInfo[i][Deaths] += 1;
								PlayerInfo[playerid][Kills] += 1;
								SetPlayerHealth(i, 0.0);
								new Float:x, Float:y, Float:z;
								CreateExplosion(x, y, z, 12, 10.0);
								GameTextForPlayer(i, "~r~NUKE", 4000, 3);
								SendDeathMessage(playerid,i,44);
								GiveCODMoney(playerid, 1000);
								GivePlayerScore(playerid, 1);
								format(st,sizeof(st),"Nuke killed %s | Earned +1 score +1000$", GetName(i));
								SendClientMessage(playerid, green, st);
							}
						}
						format(sth, sizeof(sth), "Nuke has killed %d players.", co);
						SendClientMessageToAll(TEAM_AUS_COLOR, sth);
						return 1;
					}
				}
			}
		}
	}
	return 1;
}

forward CountDown();
public CountDown()
{
	if(nuke_time > 1)
	{
		nuke_time -= 1;
		nuke_remind = 0;
	}
	else
	{
		nuke_time = 0;
		if(!nuke_remind)
		{
			SendClientMessageToAll(mw_green, "Nuke is ready to be launched!");
			nuke_remind = 1;
		}
	}
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInDynamicCP(i, CP[SNAKE]) && UnderAttack[SNAKE] == 1 && IsPlayerCapturing[i][SNAKE] == 1)
			{
				CountVar[SNAKE] --;
				/*if(UnderHelp[SNAKE])
				{
					CountVar[SNAKE] --;
				}*/
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[SNAKE]);
				TextDrawSetString(CountText[i], str1);
				if(CountVar[SNAKE] <= 0)
				{
					SnakeFarmCaptured(i);
				}
			}
			if(IsPlayerInDynamicCP(i, CP[BAY]) && UnderAttack[BAY] == 1 && IsPlayerCapturing[i][BAY] == 1)
			{
				CountVar[BAY]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[BAY]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[A51]) && UnderAttack[A51] == 1 && IsPlayerCapturing[i][A51] == 1)
			{
				CountVar[A51]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[A51]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[ARMY]) && UnderAttack[ARMY] == 1 && IsPlayerCapturing[i][ARMY] == 1)
			{
				CountVar[ARMY]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[ARMY]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[PETROL]) && UnderAttack[PETROL] == 1 && IsPlayerCapturing[i][PETROL] == 1)
			{
				CountVar[PETROL]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[PETROL]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[OIL]) && UnderAttack[OIL] == 1 && IsPlayerCapturing[i][OIL] == 1)
			{
				CountVar[OIL]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[OIL]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[DESERT]) && UnderAttack[DESERT] == 1 && IsPlayerCapturing[i][DESERT] == 1)
			{
				CountVar[DESERT]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[DESERT]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[QUARRY]) && UnderAttack[QUARRY] == 1 && IsPlayerCapturing[i][QUARRY] == 1)
			{
				CountVar[QUARRY]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[QUARRY]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[GUEST]) && UnderAttack[GUEST] == 1 && IsPlayerCapturing[i][GUEST] == 1)
			{
				CountVar[GUEST]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[GUEST]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[EAR]) && UnderAttack[EAR] == 1 && IsPlayerCapturing[i][EAR] == 1)
			{
				CountVar[EAR]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[EAR]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[DA]) && UnderAttack[DA] == 1 && IsPlayerCapturing[i][DA] == 1)
			{
				CountVar[DA]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[DA]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[AMMU]) && UnderAttack[AMMU] == 1 && IsPlayerCapturing[i][AMMU] == 1)
			{
				CountVar[AMMU]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[AMMU]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[DAM]) && UnderAttack[DAM] == 1 && IsPlayerCapturing[i][DAM] == 1)
			{
				CountVar[DAM]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[DAM]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[BELL]) && UnderAttack[BELL] == 1 && IsPlayerCapturing[i][BELL] == 1)
			{
				CountVar[BELL]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[BELL]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[RUSTY]) && UnderAttack[RUSTY] == 1 && IsPlayerCapturing[i][RUSTY] == 1)
			{
				CountVar[RUSTY]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[RUSTY]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[GHOST]) && UnderAttack[GHOST] == 1 && IsPlayerCapturing[i][GHOST] == 1)
			{
				CountVar[GHOST]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[GHOST]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[HOSP]) && UnderAttack[HOSP] == 1 && IsPlayerCapturing[i][HOSP] == 1)
			{
				CountVar[HOSP]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[HOSP]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[VILLA]) && UnderAttack[VILLA] == 1 && IsPlayerCapturing[i][VILLA] == 1)
			{
				CountVar[VILLA]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[VILLA]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[BIOSHIP]) && UnderAttack[BIOSHIP] == 1 && IsPlayerCapturing[i][BIOSHIP] == 1)
			{
				CountVar[BIOSHIP]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[BIOSHIP]);
				TextDrawSetString(CountText[i], str1);
			}
			if(IsPlayerInDynamicCP(i, CP[CERBERUS]) && UnderAttack[CERBERUS] == 1 && IsPlayerCapturing[i][CERBERUS] == 1)
			{
				CountVar[CERBERUS]--;
				new str1[124];
				TextDrawShowForPlayer(i, CountText[i]);
				format(str1, sizeof(str1),"~g~CAPTURING...: ~r~%d~w~/~b~25", CountVar[CERBERUS]);
				TextDrawSetString(CountText[i], str1);
			}
		}
	}
	return 1;
}

stock GetTeamName(playerid)
{
	new str[66];
	if(gTeam[playerid] == TEAM_EUROPE) str =  ("Europe");
	else if(gTeam[playerid] == TEAM_ARAB) str =  ("Arabia");
	else if(gTeam[playerid] == TEAM_SOVIET) str =  ("Soviet");
	else if(gTeam[playerid] == TEAM_USA) str =  ("USA");
	else if(gTeam[playerid] == TEAM_AUS) str =  ("Australia");
	return str;
}
//==============SendTeamMessage function by Jarnu==============================
stock SendTeamMessage(teamid, color, string[])
{
	for(new x, ps = GetPlayerPoolSize(); x < ps; x++)
	{
		if(IsPlayerConnected(x))
		{
			if(gTeam[x] == teamid)
			{
				SendClientMessage(x, color, string);
			}
		}
	}
	return 1;
}
//=======================Give Team Score by Jarnu==============================
stock GiveTeamScore(teamid, amount)
{
	for(new x, ps = GetPlayerPoolSize(); x < ps; x++)
	{
		if(IsPlayerConnected(x))
		{
			if(gTeam[x] == teamid)
			{
				SetPlayerScore(x, GetPlayerScore(x)+amount);
			}
		}
	}
	return 1;
}
//==============================================================================

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(source == 0)
	{
		if(IsPlayerConnected(playerid) && IsPlayerConnected(clickedplayerid))
		{
			ShowPlayerStats(playerid, clickedplayerid);
//			CallLocalFunction("cmd_stats", "id", playerid, clickedplayerid);
			return 1;
		}
	}
	return 1;
}

GetTeamCount(teamid)
{
	new count = 0;
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(GetPlayerState(i) == PLAYER_STATE_NONE) continue;
		if(gTeam[i] != teamid) continue;
		count+= 1;
	}
	return count;
}
////////////////////////////////////////////////////////////////////////
CMD:bonus(playerid)
{
	new string[128];
	if(!NoBonusPlayer && RandomID != -1)
	{
		format(string, sizeof(string), "{80C732}Bonus player {FFFFFF}%s (%d) {80C732}- Reward {FFFFFF}$%d {80C732}and {FFFFFF}%d {80C732}score.", pName(RandomID), RandomID, RandomMoney, RandomScore);
		SendClientMessage(playerid, -1, string);
	}
	else
	{
		SendClientMessage(playerid, -1, "{D7374C}No bonus player is selected.");
	}
	if(!NoBonusCp && RandomCpID != -1)
	{
		format(string, sizeof(string), "{80C732}Bonus zone {FFFFFF}%s {80C732}- Reward {FFFFFF}$%d {80C732}and {FFFFFF}%d {80C732}score.", GetCpName(RandomCpID), RandomCpMoney, RandomCpScore);
		SendClientMessage(playerid, -1, string);
	}
	else
	{
		SendClientMessage(playerid, -1, "{D7374C}No bonus zone is selected.");
	}
	return 1;
}

CMD:ping(playerid, params[])
{
	new str[70], count = GetTickCount();
	format(str, sizeof(str),"Took %d to execute this command!", GetTickCount() - count);
	return SendClientMessage(playerid, red,str);
}

CMD:teams(playerid)
{
	new str[90], dstr[450];
	strcat(dstr, "Team\t\tPlayers\n");
	format(str, sizeof(str), ""COLOR_EUROPE"Europe:\t\t%d players\n", GetTeamCount(TEAM_EUROPE));
	strcat(dstr, str);
	format(str, sizeof(str), ""COLOR_ARAB"Arabia:\t\t%d players\n", GetTeamCount(TEAM_ARAB));
	strcat(dstr, str);
	format(str, sizeof(str), ""COLOR_USA"USA:\t\t%d players\n", GetTeamCount(TEAM_USA));
	strcat(dstr, str);
	format(str, sizeof(str), ""COLOR_SOVIET"Soviet:\t\t%d players\n", GetTeamCount(TEAM_SOVIET));
	strcat(dstr, str);
	format(str, sizeof(str), ""COLOR_AUS"Australia:\t%d players", GetTeamCount(TEAM_AUS));
	strcat(dstr, str);
	ShowPlayerDialog(playerid, DIALOG_TEAMS, DIALOG_STYLE_MSGBOX, "Teams list", dstr, "Okay", "");
	return 1;
}
/*
CMD:teams(playerid, params[])
{
	new team1count = GetTeamCount(TEAM_EUROPE);
	new team2count = GetTeamCount(TEAM_ARAB);
	new team3count = GetTeamCount(TEAM_USA);
	new team4count = GetTeamCount(TEAM_SOVIET);
	new team5count = GetTeamCount(TEAM_AUS);
	new str[500];
	SendClientMessage(playerid, orange,"|_____| Teams |_____| ");
	format(str, sizeof(str),"Europe: %d Players", team1count);
	SendClientMessage(playerid, TEAM_EUROPE_COLOR, str);
	format(str, sizeof(str),"Arab: %d Players", team2count);
	SendClientMessage(playerid, TEAM_ARAB_COLOR, str);
	format(str, sizeof(str),"USA: %d Players", team3count);
	SendClientMessage(playerid, TEAM_USA_COLOR, str);
	format(str, sizeof(str),"Soviet: %d Players", team4count);
	SendClientMessage(playerid, TEAM_SOVIET_COLOR, str);
	format(str, sizeof(str),"Australia: %d Players", team5count);
	SendClientMessage(playerid, TEAM_AUS_COLOR, str);
	return 1;
}*/
CMD:getteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100], Float:x, Float:y, Float:z, interior = GetPlayerInterior(playerid), world = GetPlayerVirtualWorld(playerid);
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /getteam [teamname USA/Europe/Arab/Soviet/Australia]");
	   GetPlayerPos(playerid, x, y, z);
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
				   SetPlayerPos(i, x+3, y, z);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has teleported team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has teleported team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has teleported team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has teleported team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has teleported team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:spawnteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /spawnteam [teamname USA/Europe/Arab/Soviet/Australia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has spawned team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has spawned team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has spawned team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has spawned team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has spawned team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:freezeteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /freezeteam [teamname USA/Europe/Arab/Soviet/Australia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has frozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has frozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has frozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has frozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has frozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:unfreezeteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /unfreezeteam [teamname USA/Europe/Arab/Soviet/Australia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has unfrozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has unfrozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has unfrozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has unfrozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has unfrozen team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:disarmteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /unfreezeteam [teamname USA/Europe/Arab/Soviet/Australia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
					ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disarmed team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disarmed team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disarmed team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disarmed team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disarmed team {80C732}%s",pName(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:gsteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100], amount;
	   if(sscanf(params,"s[100]d",team, amount)) return SendClientMessage(playerid, RED,"USAGE: /gsteam [teamname USA/Europe/Arab/Soviet/Australia] [amount]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount, team);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:givecashteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100], amount;
	   if(sscanf(params,"s[100]d",team, amount)) return SendClientMessage(playerid, RED,"USAGE: /givecashteam [teamname USA/Europe/Arab/Soviet/Australia] [amount]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   GiveCODMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Europe----------------
	   if(strfind(params,"Europe",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_EUROPE)
			   {
				   GiveCODMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Arab---------
	   if(strfind(params,"Arab",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_ARAB)
			   {
				   GiveCODMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------Soviet-------
	   if(strfind(params,"Soviet",true) != -1 || strfind(params,"Russia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_SOVIET)
			   {
				   GiveCODMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Australia---------
	   if(strfind(params,"Australia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		   {
			   if(gTeam[i] == TEAM_AUS)
			   {
				   GiveCODMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given %d score(s) to team {80C732}%s",pName(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282} You are not high enough level to use this command!");
	return 1;
}
CMD:ranks(playerid, params[])
{
	new RANKS[1000];

	strcat(RANKS,"Rank 1 - Private (0 Score)\n");
	strcat(RANKS,"Rank 2 - Corporal (50 Scores)\n");
	strcat(RANKS,"Rank 3 - Sergeant (150 Scores)\n");
	strcat(RANKS,"Rank 4 - Sergeant Major (300 Scores)\n");
	strcat(RANKS,"Rank 5 - Officer (550 Scores)\n");
	strcat(RANKS,"Rank 6 - Lieutenant (800 Scores)\n");
	strcat(RANKS,"Rank 7 - Lieutenant Major (1500 Scores)\n");
	strcat(RANKS,"Rank 8 - Captain (2000 Scores)\n");
	strcat(RANKS,"Rank 9 - Major (4500 Scores)\n");
	strcat(RANKS,"Rank 10 - Colonel(8000 Scores)\n");
	strcat(RANKS,"Rank 11 - General(10000 Scores)\n");
	strcat(RANKS,"Rank 12 - Field Marshall(15000 Scores)\n");
	strcat(RANKS,"Rank 13 - Master Of War (20000 Scores)");

	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Ranks", RANKS, "Close", "");
	return 1;
}

CMD:rcodes(playerid, params[])
{
	new RCODES[1246+200];

	strcat(RCODES, "{009E00}/r1\t  Attack!\n");
	strcat(RCODES, "{009E00}/r2\t  Sniper At Base\n");
	strcat(RCODES, "{009E00}/r3\t  Roger That\n");
	strcat(RCODES, "{009E00}/r4\t  Negative\n");
	strcat(RCODES, "{009E00}/r5\t  Tank Incoming\n");
	strcat(RCODES, "{009E00}/r6\t  Missile Incoming\n");
	strcat(RCODES, "{009E00}/r7\t  Cover Me\n");
	strcat(RCODES, "{009E00}/r8\t  Area Secure\n");
	strcat(RCODES, "{009E00}/r9\t  Grenade!\n");
	strcat(RCODES, "{009E00}/r10\t Spy In The Base");

	ShowPlayerDialog(playerid, 32, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Team Radio Codes", RCODES, "Close", "");
	return 1;
}

CMD:r1(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Attack!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r2(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Sniper At Base!",pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r3(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Roger That!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r4(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Negative!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r5(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Tank Incoming!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r6(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Missile Incoming!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r7(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Cover Me!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r8(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Area Secure!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r9(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Grenade!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:r10(playerid)
{
	if(PlayerInfo[playerid][Muted] != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[50];
	format(string, sizeof(string), "[Radio] %s(%d): Spy In The Base!", pName(playerid), playerid);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}


CMD:r(playerid,params[])
{
	if(PlayerInfo[playerid][Muted]) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[128], str[90];
	if(sscanf(params, "s[90]", str)) return SendClientMessage(playerid, -1, "USAGE: /r [text]");
	format(string, sizeof(string), "[Radio] %s(%d): %s", pName(playerid), playerid, str);
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string); SetPlayerChatBubble(playerid, params[0], 0xFF8000FF, 100.0, 2000);
	}
	return 1;
}

CMD:order(playerid,params[])
{
	if(PlayerInfo[playerid][Muted]) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new string[128], str[90];
	if(sscanf(params, "s[90]", str)) return SendClientMessage(playerid, -1, "USAGE: /order [text]");
	format(string, sizeof(string), "*%s %s: %s",GetRankName(playerid), pName(playerid), str);

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
	}
	return 1;
}

CMD:myrank(playerid, params[])
{
	new string[200];
	format(string, sizeof(string),"{FFFFFF}Your current rank status is {FFFFFF}| Scores: "cgreen"%d {FFFFFF}| Rank: "cgreen"%s", GetPlayerScore(playerid), GetRankName(playerid));
	SendClientMessage(playerid, green, string);
	return 1;
}

CMD:sync(playerid)
{
	SyncPlayer(playerid);
	return 1;
}

CMD:objectives(playerid, params[])
{
	ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "COD:MW4 Objectives", "{80C732}> Kill enemies and make killing sprees.\n{80C732}> Capture zones.\n{80C732}> Capture prototypes.", "Close", "");
	return 1;
}

CMD:helisupport(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	switch(GetVehicleModel(vehicleid))
	{
		case 417, 425, 447, 469, 487, 488, 497, 548, 563: //Helicopters
		{
			if(heliobjects[vehicleid][0] != 0) return SendClientMessage(playerid, red, "This vehicle already has objects attached to it.");
			heliobjects[vehicleid][0] = CreateObject(18756, 0, 0, -1000, 0, 0, 0, 100);
			heliobjects[vehicleid][1] = CreateObject(18756, 0, 0, -1000, 0, 0, 0, 100);
			AttachObjectToVehicle(heliobjects[vehicleid][0], vehicleid, 0.525000, 1.425000, -3.075001, -361.800292, 91.799980, -268.379852);
			AttachObjectToVehicle(heliobjects[vehicleid][1], vehicleid, -2.625000, 1.350000, -3.075001, -361.800292, 91.799980, -268.379852);
		}
		default: return SendClientMessage(playerid, -1, "You must be in a helicopter to use this command.");
	}
	return 1;
}

CMD:spyhelp(playerid, params[])
{
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be logged in to use this command");
	if(gClass[playerid] != SPY) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be Spy to use this command.");
	if(NoSpy) return SendClientMessage(playerid, red,"ERROR: {828282}Its No Spy Week");
	ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "COD:MW4 Spy Help", "You have five disguise kits per life.\n\
	You can use them to disguise as enemy team mates and kill people.\n\
	You can buy disguise kits from your base.\nCommand : /disguise", "Close", "");
	return 1;
}

CMD:disguise(playerid)
{
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be logged in to use this command");
	if(gClass[playerid] != SPY) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be Spy to use this command.");
	if(NoSpy) return SendClientMessage(playerid, red,"ERROR: {828282}Its No Spy Week");
	ShowPlayerDialog(playerid, DIS_DIALOG, DIALOG_STYLE_LIST, "COD:MW4 Disguise Menu", "Europe\nArabia\nSoviet\nUSA\nAustralia", "Select", "Cancel");
	return 1;
}

CMD:disablespy(playerid, params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
		new str[128];
		if(NoSpy == 0) {
			NoSpy = 1;
			CMDMessageToAdmins(playerid,"DISABLESPY");
			format(str, sizeof str,"Administrator %s has disabled spy features.", pName(playerid));
			SendClientMessageToAll(blue, str);
		}
		else if(NoSpy) {
			NoSpy = 0;
			CMDMessageToAdmins(playerid,"DISABLESPY");
			format(str, sizeof str,"Administrator %s has enabled spy features.", pName(playerid));
			SendClientMessageToAll(blue, str);
		}
	}
	else return SendClientMessage(playerid, red,"ERROR: {828282}You are not high enough level to use this command");
	return 1;
}

CMD:disablejp(playerid, params[])
{
	if(PlayerInfo[playerid][Level] < 5) return SendClientMessage(playerid, red,"ERROR: {828282}You are not high enough level to use this command");
	new str[128];
	if(NoJP == 0)
	{
		NoJP = 1;
		CMDMessageToAdmins(playerid,"DISABLEJP");
		format(str, sizeof str,"Administrator %s has disabled Jet Trooper features.", pName(playerid));
		SendClientMessageToAll(blue, str);
	}
	else if(NoJP == 1)
	{
		NoJP = 0;
		CMDMessageToAdmins(playerid,"DISABLEJP");
		format(str, sizeof str,"Administrator %s has enabled Jet Trooper features.", pName(playerid));
		SendClientMessageToAll(blue, str);
	}
	return 1;
}

CMD:disablehv(playerid, params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
		new str[128];
		if(HV == 1) {
			HV = 0;
			CMDMessageToAdmins(playerid,"DISABLEHV");
			format(str, sizeof str,"Administrator %s has disabled Heavy Vehicles feature.", pName(playerid));
			SendClientMessageToAll(blue, str);
		}
		else if(HV == 0) {
			HV = 1;
			CMDMessageToAdmins(playerid,"DISABLEHV");
			format(str, sizeof str,"Administrator %s has enabled Heavy Vehicles feature.", pName(playerid));
			SendClientMessageToAll(blue, str);
		}
	}
	else return SendClientMessage(playerid, red,"ERROR: {828282}You are not high enough level to use this command");
	return 1;
}

CMD:disablehs(playerid, params[]) {
	if(PlayerInfo[playerid][Level] < 5) return SendClientMessage(playerid, red,"ERROR: {828282}You are not high enough level to use this command");
	new str[128];
	if(NoHS == 1)
	{
		NoHS = 0;
		CMDMessageToAdmins(playerid,"DISABLEHS");
		format(str, sizeof str,"Administrator %s has disabled Headshot feature.", pName(playerid));
		SendClientMessageToAll(blue, str);
	}
	else if(NoHS == 0)
	{
		NoHS = 1;
		CMDMessageToAdmins(playerid,"DISABLEHS");
		format(str, sizeof str,"Administrator %s has enabled Headshot feature.", pName(playerid));
		SendClientMessageToAll(blue, str);
	}
	return 1;
}

CMD:kill(playerid, params[])
{
	if(AntiSK[playerid] == 0)
	{
		SetPlayerHealth(playerid, 0.0);
		SendClientMessage(playerid, -1, "You Have Killed Yourself!");
	}
	else return SendClientMessage(playerid, red,"You are not allowed to suicide in Anti-SK Protection");
	return true;
}
CMD:exitdm(playerid, params[])
{
	SpawnPlayer(playerid);
	SendClientMessage(playerid, 0x33FF33AA, "You Left DM!");
	return true;
}
stock IsEnemyInRange(playerid) {
	for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
		new Float:x, Float:y, Float:z;
		GetPlayerPos(i, x, y, z);
		if(IsPlayerInRangeOfPoint(playerid, 50.0 , x, y, z) && gTeam[playerid] != gTeam[i] && PlayerInfo[playerid][OnDuty] == 0 && PlayerInfo[i][OnDuty] == 0) {
			return 1;
		}
		else return 0;
	}
	return 1;
}
CMD:suicide(playerid,params[])
{
	if(PlayerInfo[playerid][VIP] >= 2 || gClass[playerid] == DEMOLISHER)
	{
		SetPlayerHealth(playerid,0);
		new Float:PPos[3];
		GetPlayerPos(playerid,PPos[0],PPos[1],PPos[2]);
		CreateExplosion(PPos[0],PPos[1],PPos[2],7,10.0);
	}
	else return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}You Need To Be Demolisher or Donor");
	return 1;
}
CMD:shelp(playerid,params[]) {
 if(gClass[playerid] == SUPPORT) {
		SetPlayerHealth(playerid,100);
		SendClientMessage(playerid,yellow,"Supporter Commands:");
		SendClientMessage(playerid,blue,"/SHeal - Support Your Team Mate In Range A Health Pack.");
		SendClientMessage(playerid,blue,"/SAmmo - Support Your Team Mate In Range A Large Ammo Pack.");
		SendClientMessage(playerid,blue,"/SArmour - Support Your Team Mate In Range A Armour Pack.");
		SendClientMessage(playerid,blue,"/SWeaps - Support Your team mate in Range Weapons.");

   } else return SendClientMessage(playerid,red,"ERROR: {828282}Your Must Be Supporter");
   return 1;
}

CMD:times(playerid, params[])
{
	new String[100];
	format(String,sizeof(String), "Time left for nuke: %d Seconds", nuke_time);
	ShowPlayerDialog(playerid, TIMES_DIALOG, DIALOG_STYLE_MSGBOX, "Time left", String, "Close", "");
	return 1;
}

CMD:achs(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0x00B9FFFF, "Use /achs [player name/id] to view another player's achievements info!"),
	ShowPlayerAchievements(playerid, playerid);
	if(!IsPlayerConnected(id)) return  SendClientMessage(playerid, red, "ERROR: {828282}{828282}You have entered an invalid player name/id!");
	ShowPlayerAchievements(playerid, id);
	return 1;
}

stock ShowPlayerAchievements(playerid, targetid)
{
	new TempStr[611], complete[11], incomplete[11];
	complete = "{05E200}•", incomplete = "{FF0000}•";
	strcat(TempStr, "%s {FFFFFF}Loyal Soldier - Register on MW4! (Reward: 5 score)\n");
	strcat(TempStr, "%s {FFFFFF}First Blood   - Do your first kill! (Reward: 5 score)\n");
	strcat(TempStr, "%s {FFFFFF}Born Assassin - Do 100 kills! (Reward: none)\n");
	strcat(TempStr, "%s {FFFFFF}Terminator    - Make a killing spree of 10! (Reward: 10k$ and 10 score)\n");
	strcat(TempStr, "%s {FFFFFF}Eagle's Eye   - Headshot a player, from a distance more than 300 meters (Reward: 5 score)\n");
	strcat(TempStr, "%s {FFFFFF}Prototype     - Capture 10 prototypes! (Reward: 10 score)\n");
	strcat(TempStr, "%s (%i) has completed %i/6 achievements!\n\n");
	strcat(TempStr, "%s {FFFFFF}- Completed Achievement | %s {FFFFFF}- Incomplete Achievement");
	format(TempStr, sizeof TempStr, TempStr, (PlayerInfo[targetid][pRegAch] == 1) ? (complete) : (incomplete), (PlayerInfo[targetid][pKillAch] == 1) ? (complete) : (incomplete),
	(PlayerInfo[targetid][pAssAch] == 1) ? (complete) : (incomplete), (PlayerInfo[targetid][pOwnAch] == 1) ? (complete) : (incomplete), (PlayerInfo[targetid][pHsAch] == 1) ? (complete) : (incomplete),
	(PlayerInfo[playerid][pPtAch] == 1) ? (complete) : (incomplete), pName(targetid), targetid, PlayerInfo[targetid][pAchs], complete, incomplete);
	ShowPlayerDialog(playerid, DIALOG_MULT, DIALOG_STYLE_MSGBOX, "Player Achievements", TempStr, "Okay", "");
	return 1;
}

stock ShowAchievementTextdraws(playerid)
{
	TextDrawShowForPlayer(playerid, AchTD0);
	TextDrawShowForPlayer(playerid, AchTD2);
	TextDrawShowForPlayer(playerid, AchTD1);
	TextDrawHideForPlayer(playerid, AchTD2);
	TextDrawHideForPlayer(playerid, AchTD1);
	TextDrawShowForPlayer(playerid, AchTD2);
	TextDrawShowForPlayer(playerid, AchTD1);
	PlayerTextDrawShow(playerid, AchTD3);
	PlayerTextDrawShow(playerid, AchTD4);
	PlayerTextDrawShow(playerid, AchTD5);
	SetTimerEx("ACH__TEXTDRAWS",7000,false,"d",playerid);
}

CMD:codea(playerid)
{
	//---
	new KDstr[50];
	TextDrawShowForPlayer(playerid, KDBox);
	format(KDstr, sizeof(KDstr), "~r~Killed by ~w~%s", FixTdBracket(playerid));
	PlayerTextDrawSetString(playerid, Death, KDstr);
	PlayerTextDrawShow(playerid, Death);
	//---
	PlayerTextDrawSetString(playerid, PlayerTD, "~r~ Test (-99.0) ~n~~r~Combat Shotgun");
	PlayerTextDrawShow(playerid, PlayerTD);
	PlayerTextDrawSetString(playerid, IssuerTD, "~g~ Test (+99.0) ~n~~g~Combat Shotgun");
	PlayerTextDrawShow(playerid, IssuerTD);
	return 1;
}

CMD:codeb(playerid)
{
	PlayerTextDrawSetString(playerid, AchTD3, "~y~Achievement Name: ~w~EAGLE'S EYE.");
	PlayerTextDrawSetString(playerid, AchTD4, "~y~Reward: ~w~5 score.");
	PlayerTextDrawSetString(playerid, AchTD5, "~y~Achievement Info: ~w~Headshot a player~n~~w~from a distance more than 300 meters.");
	ShowAchievementTextdraws(playerid);
	return 1;
}

CMD:jp(playerid)
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(gClass[playerid] != JET) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be JetTrooper Class.");
	if(NoJP) return SendClientMessage(playerid,red,"ERROR: {828282}Jetpack feature is disabled.");
	if(BlockCMD[playerid][JPACK]) return SendClientMessage(playerid,red,"ERROR: {828282}You have to wait 2 minutes!");
	SetPlayerSpecialAction(playerid, 2);
	SendClientMessage(playerid,blue,"* Jetpack spawned.");
	BlockCMD[playerid][JPACK] = true;
	SetTimerEx("EnableCMD", 120000, false, "dd", playerid, JPACK);
	return 1;
}

CMD:dnos(playerid)
{
	if(PlayerInfo[playerid][VIP] < 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 1 in order to use this command");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: {828282}You Need be In Vehicle!");
	if(GetCODMoney(playerid) < 5000) return SendClientMessage(playerid,red,"ERROR: {828282}You Need $10000!");
	if(BlockCMD[playerid][DNOZ]) return SendClientMessage(playerid, red, "ERROR: {828282}You have to wait 2 minutes!");
	AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	GiveCODMoney(playerid, -5000);
	SendClientMessage(playerid, green, "* x10 NOS for $5000");
	BlockCMD[playerid][DNOZ] = true;
	SetTimerEx("EnableCMD", 120000, false, "dd", playerid, DNOZ);
	return 1;
}

CMD:dweather(playerid, params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][VIP] < 2) return SendClientMessage(playerid, red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
	new weather;
	if(sscanf(params, "d", weather)) return SendClientMessage(playerid, red, "USAGE: /Dweather (Weather-Id)");
	if(weather > 45 || weather < 0) return SendClientMessage(playerid, red, "ERROR: {828282}Invalid Weather-Id.");
	SendClientMessage(playerid, -1, "Weather changed successfully.");
	SetPlayerWeather(playerid, weather);
	return 1;
}

CMD:dcc(playerid, params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][VIP] < 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 1 in order to use this command");
	new col[2];
	if(sscanf(params, "ii",col[0],col[1])) return SendClientMessage(playerid, red, "USAGE: /dcc (Col-1) (Col-2)");
	ChangeVehicleColor(GetPlayerVehicleID(playerid), col[0],col[1]);
	SendClientMessage(playerid,blue, "Vehicle Color changed.");
	return 1;
}

CMD:dammo(playerid)
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][VIP] >= 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 1 in order to use this command");
	if(BlockCMD[playerid][DAMO]) return SendClientMessage(playerid,red,"ERROR: {828282}You have to wait 2 minutes!");
	if(GetCODMoney(playerid) < 5000) return SendClientMessage(playerid,red,"ERROR: {828282}You Need $30000 to refill your ammo!");
	GiveAmmo(playerid);
	GiveCODMoney(playerid, -5000);
	SendClientMessage(playerid,yellow,"Ammo Restored!");
	BlockCMD[playerid][DAMO] = true;
	SetTimerEx("EnableCMD",120000,false,"dd",playerid,DAMO);
	return 1;
}

CMD:dweaps(playerid)
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][VIP] < 2) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
	if(BlockCMD[playerid][DWEAP]) return SendClientMessage(playerid,red,"ERROR: {828282}You have to wait 5 minutes!");
	GivePlayerWeapon(playerid, 26,500);
	GivePlayerWeapon(playerid, 24,500);
	GivePlayerWeapon(playerid, 32,500);
	GivePlayerWeapon(playerid, 35,1);
	GivePlayerWeapon(playerid, 16,2);
	SendClientMessage(playerid,blue,"* Donor Weapons.");
	BlockCMD[playerid][DWEAP] = true;
	SendCMDMessge(playerid,"DWEAPS");
	SetTimerEx("EnableCMD", 300000, false, "dd", playerid, DWEAP);
	return 1;
}

CMD:dbt(playerid) return cmd_dboost(playerid);

CMD:dboost(playerid)
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][VIP] < 3 || gClass[playerid] != DONOR) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
	if(BlockCMD[playerid][DBOST]) return SendClientMessage(playerid,red,"ERROR: {828282}You have to wait 5 minutes!");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid,blue,"* Donor Boost.");
	BlockCMD[playerid][DBOST] = true;
	SendCMDMessge(playerid,"DBOOST");
	SetTimerEx("EnableCMD", 300000, false, "dd", playerid, DBOST);
	new string[128];
	format(string,sizeof(string),"*%s Has Boosted you an RPG.", pName(playerid));
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[playerid] == gTeam[i])
		{
			if(IsPlayerInRangeOfPoint(i,10.0, x, y, z))
			{
				GivePlayerWeapon(i,35,1) && SendClientMessage(i,0xF8EA73FF,string);
			}
		}
	}
	return 1;
}

CMD:dheal(playerid,params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][VIP] >= 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 1 in order to use this command");
	if(BlockCMD[playerid][DHEALTH]) return SendClientMessage(playerid,red,"ERROR: {828282}You have to wait 5 minutes!");
	if(IsEnemyInRange(playerid) != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command when enemy is in-range.");
	SetPlayerHealth(playerid,100);
	SendClientMessage(playerid,yellow,"* Health Restored!");
	BlockCMD[playerid][DHEALTH] = true;
	SetTimerEx("EnableCMD",300000,false,"dd",playerid,DHEALTH); // gogo
	return 1;
}

CMD:sweaps(playerid,params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(gClass[playerid] != SUPPORT) return SendClientMessage(playerid,red,"ERROR: {828282}You Need To Be Support Class.");
	if(BlockCMD[playerid][SWEAP]) return SendClientMessage(playerid,red,"ERROR: {828282}You need to wait 5 minutes.");
	if(IsEnemyInRange(playerid) != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command this command when enemy is in range.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid, green, "* Supported Weapons.");
	BlockCMD[playerid][SWEAP] = true;
	new string[128];
	format(string,sizeof(string),"*%s Has Supported You Weapons Pack.", GetName(playerid));
	SetTimerEx("EnableCMD",300000,false,"dd",playerid, SWEAP);
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid])
		{
			if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,10.0, x, y, z))
			{
				GivePlayerWeapon(i, 24,50) && GivePlayerWeapon(i, 27,50) && GivePlayerWeapon(i, 32,50) && GivePlayerWeapon(i, 7,2) && SendClientMessage(i,0xF8EA73FF,string);
			}
		}
	}
	return 1;
}

CMD:sarmour(playerid,params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid, red,"ERROR: {828282}You must be logged in to use this command.");
	if(gClass[playerid] != SUPPORT) return SendClientMessage(playerid, red, "ERROR: {828282}You Need To Be Support Class.");
	if(BlockCMD[playerid][SARMOR]) return SendClientMessage(playerid, red, "ERROR: {828282}You Need Wait 5 Minutes.");
	if(IsEnemyInRange(playerid) != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command this command when enemy is in range.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid, green, "* Support Armour Package.");
	BlockCMD[playerid][SARMOR] = true;
	new string[128];
	format(string,sizeof(string),"*%s Has Supported You an Armour Package.", GetName(playerid));
	SetTimerEx("EnableCMD",300000,false,"dd",playerid,SARMOR);
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid])
		{
			if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,10.0, x, y, z))
			{
				SetPlayerArmour(i,100) && SendClientMessage(i,0xF8EA73FF,string);
			}
		}
	}
	return 1;
}

CMD:sheal(playerid,params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(gClass[playerid] != SUPPORT) return SendClientMessage(playerid,red,"ERROR: {828282}You Need To Be Support Class.");
	if(BlockCMD[playerid][SHEALTH]) return SendClientMessage(playerid,red,"ERROR: {828282}You need to wait 5 minutes.");
	if(IsEnemyInRange(playerid) != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command this command when enemy is in range.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid, green, "* Support Health Package.");
	BlockCMD[playerid][SHEALTH] = true;
	new string[128];
	format(string,sizeof(string),"*%s Has Supported You an Health Package.", GetName(playerid));
	SetTimerEx("EnableCMD",300000,false,"dd",playerid,SHEALTH);
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid])
		{
			if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,10.0, x, y, z) ) SetPlayerHealth(i,100) && SendClientMessage(i,0xF8EA73FF,string);
		}
	}
	return 1;
}

CMD:sammo(playerid,params[])
{
	if(!PlayerInfo[playerid][LoggedIn]) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(gClass[playerid] != SUPPORT) return SendClientMessage(playerid,red,"ERROR: {828282}You Need To Be Support Class.");
	if(BlockCMD[playerid][SAMO]) return SendClientMessage(playerid,red,"ERROR: {828282}You need to wait 5 minutes to use this command.");
	if(IsEnemyInRange(playerid) != 0) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command this command when enemy is in range.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid, green, "* Support Ammo Package.");
	BlockCMD[playerid][SAMO] = true;
	new string[128];
	format(string,sizeof(string),"*%s Has Supported You an Ammo Package.", pName(playerid));
	SetTimerEx("EnableCMD",300000,false,"dd",playerid, SAMO);
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(gTeam[i] == gTeam[playerid])
		{
			if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,10.0, x, y, z) ) GiveAmmo(i) && SendClientMessage(i,0xF8EA73FF,string);
		}
	}
	return 1;
}

CMD:cmds(playerid, params[])
{
	new COMMAND[500];

	strcat(COMMAND, "{FFFFFF}/chelp, /ranks, /helisupport, /clock, /ep, /rules, /s [text]\n");
	strcat(COMMAND, "{FFFFFF}/anims, /sc, /st, /savestat, /myrank, /order [text], /pm, /teams, /r [text]\n");
	strcat(COMMAND, "{FFFFFF}/rules, /anims, /nukehelp, /times, /locate [id]\n, /sync, /bonus");
	strcat(COMMAND, "{FFFFFF}/admins, /objectives, /help, /credits, /updates, /topscores, /richlist\n");
	strcat(COMMAND, "{FFFFFF}/kill, /dhelp, /dcmds, /changename, /changepass, /rcodes, /dnd, /vips\n");
	strcat(COMMAND, "{FFFFFF}/credits, /suicide, /shelp, /helpme, /spyhelp, /achs\n");

	ShowPlayerDialog(playerid, CMDS_DIALOG, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Commands", COMMAND, "Close", "");
	return 1;
}

CMD:sc(playerid, params[])
{
	if(AntiSK[playerid] != 0) return SendClientMessage(playerid, RED,"You cannot change team while in AntiSK protection! Try again later");
	GameTextForPlayer(playerid, "~g~Class Selection ~w~On Next Death", 3000, 3);
	SendClientMessage(playerid, -1, "{80C732}[PED] "COL_WHITE"You can switch class instantly now by /kill.");
	FirstSpawn[playerid] = 1;
	return 1;
}
CMD:st(playerid, params[])
{
	if(AntiSK[playerid] != 0) return SendClientMessage(playerid, RED,"You cannot change team while in AntiSK protection! Try again later");
	ForceClassSelection(playerid);
	GameTextForPlayer(playerid, "~g~Team Selection ~w~On Next Death", 3000, 3);
	SendClientMessage(playerid, -1, "{80C732}[PED] "COL_WHITE"You can switch team instantly now by /kill Or Press F4 + /Kill.");
	FirstSpawn[playerid] = 1;
	return 1;
}

CMD:forceclass(playerid,params[])
{
	new player1;
	if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	if(!IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	if(sscanf(params, "u", player1)) return SendClientMessage(playerid, red, "USAGE: /forceclass [playerid]");
	if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
	CMDMessageToAdmins(playerid,"FORCECLASS");
	FirstSpawn[player1] = 1;
	ForceClassSelection(playerid);
	return 1;
}

CMD:forceteam(playerid,params[])
{
	new player1;
	if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	if(!IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	if(sscanf(params, "u", player1)) return SendClientMessage(playerid, red, "USAGE: /forceteam [playerid]");
	if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
	CMDMessageToAdmins(playerid,"FORCETEAM");
	ForceClassSelection(player1);
	TogglePlayerSpectating(player1, true);
	TogglePlayerSpectating(player1, false);
	FirstSpawn[player1] = 1;
	return 1;
}

CMD:ep(playerid, params[])
{
	GivePlayerWeapon(playerid, 46,1);
	GiveCODMoney(playerid, -1000);
	SendClientMessage(playerid, -1, "You Have Bought A Emergency Parachute!");
	return 1;
}

CMD:nukehelp(playerid, params[])
{
	ShowPlayerDialog(playerid, NUKEH_DIALOG, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Nuke Help",
	"{009E00}• {FFFFFF}You need to be Rank 6 & have $200,000\n\
	{009E00}• {FFFFFF}You need to Capture Area 51\n\
	{009E00}• {FFFFFF}You need to pickup Skull icon in Area 51's Control Room", "Close", "");
	return 1;
}

CMD:help(playerid, params[])
{
	new HELPP[400];
	strcat(HELPP, "{009E00}• {FFFFFF}This Mode is based on TEAM DEATH MATCH.\n");
	strcat(HELPP, "{009E00}• {FFFFFF}Kill as many enemies as possible to rank up.\n");
	strcat(HELPP, "{009E00}• {FFFFFF}Capture Prototypes and take it to your base.\n");
	strcat(HELPP, "{009E00}• {FFFFFF}Capture Zones to earn SCORE/CASH, also for a constant income.\n");
	strcat(HELPP, "{009E00}• {FFFFFF}If you have any Question use /helpme and ask an admin for help.\n");

	ShowPlayerDialog(playerid, DIALOG_MULT, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Help", HELPP, "Close", "");
	return 1;

}
CMD:rules(playerid, params[])
{
	new RULES[500];

	strcat(RULES, "{009E00}• {FFFFFF}Don't Use Any Kind Of Hacks/Cheats\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Insult/Spam/Flood/Advertise\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Kill People Using Heli-blade/Car Park or Car Ram\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Spawn Kill or Base Rape\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Ask For Score/Cash From Admins\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Capture While AFK/Pausing\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Abuse Any Bug (C-Bug, Slide Bug etc)\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Provoke/Insult Players/Admins\n");
	strcat(RULES, "{009E00}• {FFFFFF}No Score Farming and Money Farming\n");
	strcat(RULES, "{FFFFFF}Not Following These Rules Leads To Punishment");

	ShowPlayerDialog(playerid, DIALOG_MULT, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Rules", RULES, "Close", "");
	return 1;
}

CMD:chelp(playerid, params[])
{
	new CHELP[600];

	strcat(CHELP, "{009E00}Soldier {FFFFFF}- No special command, good fight on foot.\n");
	strcat(CHELP, "{009E00}Sniper {FFFFFF}- Weak fight on foot, hidden on radar.\n");
	strcat(CHELP, "{009E00}Engineer {FFFFFF}- Good fight on foot and through vehicles.\n");
	strcat(CHELP, "{009E00}JetTrooper {FFFFFF}- Weak fight, can use jetpack using /jp.\n");
	strcat(CHELP, "{009E00}Pilot {FFFFFF}- Good fight through heavy air vehicles only.\n");
	strcat(CHELP, "{009E00}Support {FFFFFF}- Supporter class, use /shelp for more info.\n");
	strcat(CHELP, "{009E00}Spy {FFFFFF}- Can disguise as enemies, use /spyhelp for more info.\n");
	strcat(CHELP, "{009E00}Demolisher {FFFFFF}- Have good weapons but weaker than Heavy.\n");
	strcat(CHELP, "{009E00}Heavy {FFFFFF}- Strongest class but no special commands.\n");
	strcat(CHELP, "{009E00}Donor {FFFFFF}- God of the classes, use /dhelp for more info.\n");

	ShowPlayerDialog(playerid, DIALOG_MULT, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Class Help", CHELP, "Close", "");
	return 1;
}

CMD:updates(playerid)
{
	new DIALOG[1100];

	strcat(DIALOG, "{7DD8CB}October Update (v3)\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Specialty for some capture zones.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}A total of 20 capture zones with mappings.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Features toggle-able by admins\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Updated how the class selection worked and new classes\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Advanced anti cheat system 'Cheat Buster' version 3\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Advanced prototype system\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}New headshot system with helmet, distance counter.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}New commands for players and admins.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Lots of new textdraws!.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Donor system. Use (/dhelp) and (/dinfo) for information.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Radio codes, use (/rcodes) for information.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Fixed major bugs with capture zones, nukes etc.\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Automatic AFK system with anti-AFK capturing system\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Bonus Player System! Kill Bonus Player To Get The Bonus\n");
	strcat(DIALOG, "{009E00}• {FFFFFF}Bonus Zone System! Capture Bonus Zone to get the Bonus\n");
	strcat(DIALOG, "\n{009E00}• {FFFFFF}= Added\t\t|\t\t{D7374C}• {FFFFFF}= Removed");

	ShowPlayerDialog(playerid, UPDATES_DIALOG, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty : Modern Warfare 4 Update Notes", DIALOG, "Close", "");
	return 1;
}

CMD:credits(playerid)
{
	return ShowPlayerDialog(playerid, CREDITS_DIALOG, DIALOG_STYLE_MSGBOX, "{00C5B6}Credits", "{009E00}• {FFFFFF}eXposed {80C732} (Coding)\n{009E00}• {FFFFFF}Jarnu {80C732} (Main GM)", "Close", "");
}

CMD:clock(playerid,params[])
{
	if(!PlayerInfo[playerid][Clock])
	{
		PlayerInfo[playerid][Clock] = 1;
		TogglePlayerClock(playerid, 1);
		GameTextForPlayer(playerid, "~r~Clock Turned On", 1000, 0);
	}
	else
	{
		PlayerInfo[playerid][Clock] = 0;
		TogglePlayerClock(playerid, 0);
		GameTextForPlayer(playerid, "~r~Clock Turned Off", 1000, 0);
	}
	return 1;
}

CMD:dnd(playerid, params[])
{
	if(!DND[playerid])
	{
		DND[playerid] = 1;
		SendClientMessage(playerid, green,"Do not disturb mode/No PM mode enabled!");
	}
	else
	{
		DND[playerid] = 0;
		SendClientMessage(playerid, red,"Do not disturb mode/No PM mode disabled!");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
	if(PlayerInfo[playerid][Muted]) return SendClientMessage(playerid, red, "ERROR: {828282}You are muted.");
	new str[128], str2[128], id, adminstr[128];
	if(sscanf(params, "us[128]", id, str)) return SendClientMessage(playerid, red, "USAGE: {828282}/pm [id] [message]");
	if(id != 666 && !IsPlayerConnected(id)) return SendClientMessage(playerid, red, "ERROR: {828282}That player isn't connected.");
	if(id == playerid) return SendClientMessage(playerid, red, "ERROR: {828282}You can't PM yourself.");
	if(DND[id]) return SendClientMessage(playerid, red, "ERROR: {828282}That player has DND (Do not Disturb) mode on");
	if(id != 666)
	{
		format(str2, sizeof(str2), "PM to %s (%d): %s", id, pName(id), str);
		SendClientMessage(playerid, yellow, str2);
		format(str2, sizeof(str2), "PM from %s (%d): %s", playerid, pName(playerid), str);
		SendClientMessage(id, yellow, str2);
		SendClientMessage(id, yellow, "You may use /rpm [text] to reply back");
		format(str2, sizeof(str2), "PM from %s (%d) to %s (%d): %s", pName(playerid), playerid, pName(id), id, str);
		MessageTo4(grey, adminstr);
		LastPM[id] = playerid;
	}
	else
	{
		format(str2, sizeof(str2), "PM to Ped (666): %s", str);
		SendClientMessage(playerid, yellow, str2);
		format(str2, sizeof(str2), "PM from Ped (666): %s", PedPM[random(sizeof(PedPM))]);
		SendClientMessage(playerid, yellow, str2);
	}
	return 1;
}

CMD:rpm(playerid, params[])
{
	if(PlayerInfo[playerid][Muted]) return SendClientMessage(playerid, red, "ERROR: {828282}You are muted.");
	new str[128], str2[128], adminstr[128];
	if(sscanf(params, "s[128]", str)) return SendClientMessage(playerid, red, "USAGE: {828282}/pm [id] [message]");
	if(LastPM[playerid] != 666 || !IsPlayerConnected(LastPM[playerid])) return SendClientMessage(playerid, red, "ERROR: {828282}That player isn't connected.");
	if(LastPM[playerid] == playerid) return SendClientMessage(playerid, red, "ERROR: {828282}You can't PM yourself.");
	if(DND[LastPM[playerid]]) return SendClientMessage(playerid, red, "ERROR: {828282}That player has DND (Do not Disturb) mode on");
	format(str2, sizeof(str2), "PM to %s (%d): %s", LastPM[playerid], pName(LastPM[playerid]), str);
	SendClientMessage(playerid, yellow, str2);
	format(str2, sizeof(str2), "PM from %s (%d): %s", playerid, pName(playerid), str);
	SendClientMessage(LastPM[playerid], yellow, str2);
	SendClientMessage(LastPM[playerid], yellow, "You may use /rpm [text] to reply back");
	format(str2, sizeof(str2), "PM from %s (%d) to %s (%d): %s", pName(playerid), playerid, pName(LastPM[playerid]), LastPM[playerid], str);
	MessageTo4(grey, adminstr);
	LastPM[LastPM[playerid]] = playerid;
	return 1;
}

/*CMD:pm(playerid, params[])
{
	if(PlayerInfo[playerid][Muted]) return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	new str[128], str2[128], id, adminstr[128];
	if(sscanf(params,"ds[128]", id, str2)) return SendClientMessage(playerid, red,"USAGE: /pm [id] [message]");
	if(IsPlayerConnected(id))
	{
		if(id != playerid)
		{
			if(DND[id] == 0)
			{
				format(str, sizeof(str),"PM to [%d]%s: %s", id, pName(id), str2);
				SendClientMessage(playerid, yellow, str);
				format(str, sizeof(str),"PM from [%d]%s: %s", playerid, pName(playerid), str2);
				SendClientMessage(id, yellow, str);
				SendClientMessage(id, -1,"Use "cblue"/rpm [message] "cwhite"to reply to this PM");
				format(adminstr, sizeof(adminstr),"PM from %s[%d] to %s[%d]: %s", pName(playerid), playerid, pName(id), id, str2);
				MessageTo4(grey, adminstr);
				LastPM[id] = playerid;
		   }
		   else return SendClientMessage(playerid, red,"That player is in do not disturb mode!");
	   }
	   else return SendClientMessage(playerid, red,"You cannot PM yourself");
   }
   else return SendClientMessage(playerid, red,"Player is not connected.");
   return 1;
}

CMD:rpm(playerid, params[])
{
	if(PlayerInfo[playerid][Muted] == 0)
	{
		new str[128], str2[128], adminstr[128];
		if(sscanf(params,"s[128]", str2)) return SendClientMessage(playerid, red,"USAGE: /rpm [message]");
		new id = LastPM[playerid];
		if(IsPlayerConnected(id))
		{
			if(!DND[id])
			{
				format(str, sizeof(str),"PM to [%d]%s: %s", id, pName(id), str2);
				SendClientMessage(playerid, yellow, str);
				format(str, sizeof(str),"PM from [%d]%s: %s", playerid, pName(playerid), str2);
				SendClientMessage(id, yellow, str);
				SendClientMessage(id, -1,"Use "cblue"/rpm [message] "cwhite"to reply to this PM");
				format(adminstr, sizeof(adminstr),"PM from %s[%d] to %s[%d]: %s", pName(playerid), playerid, pName(id), id, str2);
				MessageToAdmins(grey, adminstr);
				LastPM[LastPM[playerid]] = playerid;
			}
			else return SendClientMessage(playerid, red,"This Player Is Not Accepting PMs In The Moment");
		}
		else return SendClientMessage(playerid, red,"Player is not connected");
	}
	else return SendClientMessage(playerid,red,"ERROR: {828282}You are muted.");
	return 1;
}
*/

CMD:helpme(playerid, params[])
{
	new str[128], Name1[MAX_PLAYER_NAME];
	if(sscanf(params,"s[128]", str)) return SendClientMessage(playerid, red,"CORRECT USAGE: /helpme [text]");
	GetPlayerName(playerid, Name1, sizeof(Name1));
	format(str, sizeof(str),"{00FFFF}[HELP MSG From %s]:{00FFF0} %s",Name1, str);
	MessageToAdmins(red, str);
	SendClientMessage(playerid, yellow,"Your Request has been sent to online Administrators.");
	return 1;
}
CMD:giveweapon(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /giveweapon [playerid] [weapon id/weapon name] [ammo]");
		new player1 = strval(tmp), weap, ammo, WeapName[32], string[128];
		if(!strlen(tmp3) || !IsNumeric(tmp3) || strval(tmp3) <= 0 || strval(tmp3) > 99999) ammo = 500; else ammo = strval(tmp3);
		if(!IsNumeric(tmp2)) weap = GetWeaponIDFromName(tmp2); else weap = strval(tmp2);
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: {828282}Invalid weapon ID");
			CMDMessageToAdmins(playerid,"GIVEWEAPON");
			GetWeaponName(weap,WeapName,32);
			format(string, sizeof(string), "You have given \"%s\" a %s (%d) with %d rounds of ammo", pName(player1), WeapName, weap, ammo); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has given you a %s (%d) with %d rounds of ammo", pName(playerid), WeapName, weap, ammo); SendClientMessage(player1,blue,string); }
			return GivePlayerWeapon(player1, weap, ammo);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:sethealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /sethealth [playerid] [amount]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERROR: {828282}Invaild health amount");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETHEALTH");
			format(string, sizeof(string), "You have set \"%s's\" health to '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your health to '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
			return SetPlayerHealth(player1, health);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setarmour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setarmour [playerid] [amount]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERROR: {828282}Invaild health amount");
		new player1 = strval(tmp), armour = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETARMOUR");
			format(string, sizeof(string), "You have set \"%s's\" armour to '%d", pName(player1), armour); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your armour to '%d'", pName(playerid), armour); SendClientMessage(player1,blue,string); }
			return SetPlayerArmour(player1, armour);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setcash [playerid] [amount]");
		new player1 = strval(tmp), cash = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETCASH");
			format(string, sizeof(string), "You have set \"%s's\" cash to '$%d", pName(player1), cash); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your cash to '$%d'", pName(playerid), cash); SendClientMessage(player1,blue,string); }
			ResetPlayerMoney(player1);
			return GiveCODMoney(player1, cash);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setscore [playerid] [score]");
		new player1 = strval(tmp), score = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSCORE");
			format(string, sizeof(string), "You have set \"%s's\" score to '%d' ", pName(player1), score); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your score to '%d'", pName(playerid), score); SendClientMessage(player1,blue,string); }
			return SetPlayerScore(player1, score);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setskin(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setskin [playerid] [skin id]");
		new player1 = strval(tmp), skin = strval(tmp2), string[128];
		if(!IsValidSkin(skin)) return SendClientMessage(playerid, red, "ERROR: {828282}Invaild Skin ID");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSKIN");
			format(string, sizeof(string), "You have set \"%s's\" skin to '%d", pName(player1), skin); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your skin to '%d'", pName(playerid), skin); SendClientMessage(player1,blue,string); }
			return SetPlayerSkin(player1, skin);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

//======================== [ TAG SYSTEM ] ======================================

// TAG SYSTEM VERSION 2 = ADDED NOTE MESSAGES FOR PLAYERS!
/*
CMD:settag(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /settag [playerid]");
		new player1 = strval(tmp),string[128], AdminN[24], Mname[24];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		GetPlayerName(playerid, AdminN,sizeof( AdminN ));
		GetPlayerName(player1, Mname,sizeof( Mname ));
		new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);
		PlayerInfo[player1][CTagg] = 1;
		format(string, sizeof(string), "Administrator %s Has Allowed You To Use Tag", AdminN);
		SendClientMessage(player1,yellow,string);
		SendClientMessage(player1,red,"NOTE: KEEP PATIENCE FOR NAME CHANGE OR REQUEST A ADMIN TO ADD [MW4] TO YOUR NAME");
		format(string, sizeof(string), "You Have Allowed %s To Use Tag", Mname);
		SendClientMessage(playerid,yellow,string);
		format(string,sizeof(string),"Admin %s has allowed %s to use tag on %d/%d/%d at %d:%d:%d",AdminN, Mname, day, month, year, hour, minute, second);
		SaveToFile("AdminLog",string);
		CMDMessageToAdmins(playerid,"SETTAG");
		return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,WHITE,"ERROR: {828282}You are not high enough level to use this command");
		}
		return 1;
}

CMD:unsettag(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /unsettag [playerid]");
		new player1 = strval(tmp),string[128], AdminN[24], Mname[24];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		GetPlayerName(playerid, AdminN,sizeof( AdminN ));
		GetPlayerName(player1, Mname,sizeof( Mname ));
		new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);
		PlayerInfo[player1][CTagg] = 0;
		format(string, sizeof(string), "An Administrator Has Dis-Allowed You To Use Tag", AdminN);
		SendClientMessage(player1,yellow,string);
		SendClientMessage(player1,red,"NOTE: PLEASE WAIT FOR NAME CHANGE OR YOU WILL NOT BE ABLE TO LOGIN");
		format(string, sizeof(string), "You Have Dis-Allowed %s To Use Tag", Mname);
		SendClientMessage(playerid,yellow,string);
		format(string,sizeof(string),"An Admin has dis-allowed %s to use tag on %d/%d/%d at %d:%d:%d",AdminN, Mname, day, month, year, hour, minute, second);
		SaveToFile("AdminLog",string);
		CMDMessageToAdmins(playerid,"UNSETTAG");
		return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,WHITE,"ERROR: {828282}You are not high enough level to use this command");
		}
		return 1;
}
*/

//CMD Sound Which Speaks Basic Words Of English In Voice Of A Female
CMD:sound(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1)) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /sound [text]");
	new string[128]; format(string, sizeof(string), "http://soundoftext.com/static/sounds/en/%s.mp3", params[0] );
	for(new i=0;i<MAX_PLAYERS;i++) PlayAudioStreamForPlayer(i,string);
	CMDMessageToAdmins(playerid,"SOUND");
	return 1;
}

CMD:setweather(playerid,params[]) {
		 if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setweather [playerid] [weather id]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWEATHER");
			format(string, sizeof(string), "You have set \"%s's\" weather to '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your weather to '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			SetPlayerWeather(player1,weather); PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setkills(playerid,params[]) {
		 if(PlayerInfo[playerid][Level] >= 5) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setkills [playerid] [kills]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETKILLS");
			format(string, sizeof(string), "You have set \"%s's\" Kills to '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your Kills to '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			PlayerInfo[player1][Kills] = weather;
			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setdeaths(playerid,params[]) {
		 if(PlayerInfo[playerid][Level] >= 5) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setdeaths [playerid] [deaths]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETDEATHS");
			format(string, sizeof(string), "You have set \"%s's\" Deaths to '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your Deaths to '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			PlayerInfo[player1][Deaths] = weather;
			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:async(playerid,params[])
{
	new id;
	if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	if(sscanf(params, "r", id)) return SendClientMessage(playerid, red, "USAGE: /async [playerid]");
	if(!IsPlayerConnected(id) && id == INVALID_PLAYER_ID) return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	CMDMessageToAdmins(playerid,"ASYNC");
	SyncPlayer(id);
	return 1;
}

stock SyncPlayer(playerid)
{
	new world, interior;
	world = GetPlayerVirtualWorld(playerid);
	interior = GetPlayerInterior(playerid);

	SetPlayerInterior(playerid, interior + 1);
	SetPlayerVirtualWorld(playerid, world + 1);

	SetPlayerInterior(playerid, interior);
	SetPlayerVirtualWorld(playerid, world);
	return 1;
}

CMD:settime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /settime [playerid] [hour]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETTIME");
			format(string, sizeof(string), "You have set \"%s's\" time to %d:00", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your time to %d:00", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			return SetPlayerTime(player1, time, 0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setworld [playerid] [virtual world]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		CMDMessageToAdmins(playerid,"SETWORLD");
			format(string, sizeof(string), "You have set \"%s's\" virtual world to '%d'", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your virtual world to '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			return SetPlayerVirtualWorld(player1, time);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setinterior(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setinterior [playerid] [interior]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETINTERIOR");
			format(string, sizeof(string), "You have set \"%s's\" interior to '%d' ", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your interior to '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			return SetPlayerInterior(player1, time);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:givecar(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new carid, player1;
		if(sscanf(params,"dd", player1, carid)) return SendClientMessage(playerid,red,"USAGE: /givecar [playerid] [car id]");
		new playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerInAnyVehicle(player1)) return SendClientMessage(playerid,red,"ERROR: {828282}Player already has a vehicle");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GIVECAR");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
			CarSpawner(player1,carid);
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"Administrator %s has given you a car",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have given %s a car", playername); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setmytime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setmytime [hour]");
		new time = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETMYTIME");
		format(string,sizeof(string),"You have set your time to %d:00", time); SendClientMessage(playerid,blue,string);
		return SetPlayerTime(playerid, time, 0);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:eject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /eject [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
				CMDMessageToAdmins(playerid,"EJECT");
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has ejected you from your vehicle", pName(playerid) ); SendClientMessage(player1,blue,string); }
				format(string,sizeof(string),"You have ejected \"%s\" from their vehicle", pName(player1)); SendClientMessage(playerid,blue,string);
				GetPlayerPos(player1,x,y,z);
				return SetPlayerPos(player1,x,y,z+3);
			} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not in a vehicle");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:leject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /leject [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
				CMDMessageToAdmins(playerid,"LEJECT");
				format(string,sizeof(string),"You have ejected \"%s\" from their vehicle.", pName(player1)); SendClientMessage(playerid,blue,string);
				GetPlayerPos(player1,x,y,z);
				return SetPlayerPos(player1,x,y,z+3);
			} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not in a vehicle");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:linject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /linject [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(!IsPlayerInAnyVehicle(player1)) {
			 if(IsPlayerInAnyVehicle(playerid)) {
				CMDMessageToAdmins(playerid,"LINJECT");
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has injected you in his vehicle", pName(playerid) ); SendClientMessage(player1,blue,string); }
				format(string,sizeof(string),"You have injected \"%s\" into your vehicle", pName(player1)); SendClientMessage(playerid,blue,string);
				new vehicleid = GetPlayerVehicleID(playerid);
				return PutPlayerInVehicle(player1, vehicleid, 1);
				} else return SendClientMessage(playerid,red,"ERROR: {828282}You need in enter an vehicle.");
			} else return SendClientMessage(playerid,red,"ERROR: {828282}Player already has a vehicle.");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:givemoney(playerid, params[])
{
	new id, money, string[128], string2[128],plName[24],aName[24];
	GetPlayerName(playerid,aName,sizeof(aName));
	GetPlayerName(id,plName,sizeof(plName));
	if(PlayerInfo[playerid][Level] >= 3)
	{
		if(sscanf(params,"ii",id,money)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /givemoney [ID] [amount]");
		else
		GiveCODMoney(id,money);
		format(string, sizeof(string),"You have give player %s %d$!", plName, money);
		SendClientMessage(playerid, yellow, string);
		format(string2 ,sizeof(string2),"Administrator %s has given you %d$!", aName, money);
		SendClientMessage(id, blue, string2);
	}
	return 1;
}

CMD:afix(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) {
			if(IsPlayerInAnyVehicle(playerid)) {
			RepairVehicle(GetPlayerVehicleID(playerid));
			SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
			CMDMessageToAdmins(playerid,"AFIX"); return SendClientMessage(playerid, blue,"Vehicle Fixed. You can also do /afix [playerid]");
			} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not in a vehicle. You can also do /afix [playerid]");
		}
		new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);

		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			if (IsPlayerInAnyVehicle(player1)) {
				RepairVehicle(GetPlayerVehicleID(player1));
				SetVehicleHealth(GetPlayerVehicleID(player1), 1000);
				CMDMessageToAdmins(playerid,"AFIX");
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator %s Fixed your vehicle.",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have fixed %s's vehicle.", playername);
				return SendClientMessage(playerid, blue,string);
			} else return SendClientMessage(playerid,red,"ERROR: {828282}This player isn't in a vehicle");
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be on adminduty to use this command");
}

CMD:lockcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(IsPlayerInAnyVehicle(playerid)) {
			for(new i, l = GetPlayerPoolSize(); i <= l; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,true);
			CMDMessageToAdmins(playerid,"LOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 1;
			new string[128]; format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has locked his car", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be in a vehicle to lock the doors");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:unlockcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(IsPlayerInAnyVehicle(playerid)) {
			for(new i, l = GetPlayerPoolSize(); i <= l; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,false);
			CMDMessageToAdmins(playerid,"UNLOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 0;
			new string[128]; format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has unlocked his car", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be in a vehicle to lock the doors");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:burn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /burn [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BURN");
			format(string, sizeof(string), "You have burnt \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has burned you", pName(playerid)); SendClientMessage(player1,blue,string); }
			GetPlayerPos(player1, x, y, z);
			return CreateExplosion(x, y , z + 3, 1, 10);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:spawn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /spawn [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SPAWN");
			format(string, sizeof(string), "You have spawned \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has spawned you", pName(playerid)); SendClientMessage(player1,blue,string); }
			SetPlayerPos(player1, 0.0, 0.0, 0.0);
			return SpawnPlayer(player1);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:disarm(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /disarm [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"DISARM");  PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			format(string, sizeof(string), "You have disarmed \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disarm you", pName(playerid)); SendClientMessage(player1,blue,string); }
			ResetPlayerWeapons(player1);
			return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:d(playerid,params[]) {
	 return cmd_disarm(playerid, params);
}
//-----------------------------------------Commands-----------------------------
CMD:crash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /crash [playerid]");
		new player1 = strval(params), string[128], Float:X,Float:Y,Float:Z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"CRASH");
			GetPlayerPos(player1,X,Y,Z);
			new objectcrash = CreatePlayerObject(player1,189298743,X,Y,Z,0,0,0);
			DestroyObject(objectcrash);
			format(string, sizeof(string), "You have crashed \"%s's\" game", pName(player1) );
			return SendClientMessage(playerid,blue, string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

//GameTextForPlayer(player1, "~~r~~C~~g~~R~~y~~A~~b~~S~~b~~H~~", 5000, 1);

CMD:crash2(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /crash2 [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"CRASH2");
			GameTextForPlayer(player1, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 1);
			GameTextForPlayer(player1, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 2);
			GameTextForPlayer(player1, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 3);
			GameTextForPlayer(player1, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
			GameTextForPlayer(player1, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 5);
			GameTextForPlayer(player1, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 6);
			format(string, sizeof(string), "You have crashed \"%s's\" game", pName(player1) );
			return SendClientMessage(playerid,blue, string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:ip(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /ip [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"IP");
			new tmp3[50]; GetPlayerIp(player1,tmp3,50);
			format(string,sizeof(string),"\"%s's\" ip is '%s'", pName(player1), tmp3);
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:ipcheck(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		new found, string[128], ip[50], playername[MAX_PLAYER_NAME];
		if(sscanf(params,"s[50]",ip)) return SendClientMessage(playerid,RED,"Correct Usage: /rangecheck [ip]");
		CMDMessageToAdmins(playerid,"IPCHECK");
		format(string,sizeof(string),"Ip checked for: \"%s\" ",params);
		SendClientMessage(playerid,blue,string);
		for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerIp(i, ip, 50);
				GetPlayerName(i, playername, sizeof(playername));
				new namelen = strlen(ip);
				new bool:searched=false;
				for(new pos=0; pos <= namelen; pos++)
				{
					if(searched != true)
					{
						  if(strfind(ip,params,true) == pos)
						  {
								found+= 1;
								format(string,sizeof(string),"%d. %s - %s(ID %d)",found,ip, playername, i);
								SendClientMessage(playerid, lightblue ,string);
								searched = true;
						  }
					}
				}
			}
		}
		if(found == 0) SendClientMessage(playerid, blue, "No players have this ip");
	}
	else return SendClientMessage(playerid, RED,"ERROR: {828282}You need to be level 2 to use this command!");
	return 1;
}
CMD:oban(playerid,params[]) {
   if(PlayerInfo[playerid][Level] >= 3) {
	 if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /oban [name]");
	 if(udb_Exists(params)) {
	 if(1 == dUserINT(params).("banned")) return SendClientMessage(playerid,red,"ERROR: {828282}Player is already banned");
	 dUserSetINT(params).("banned",1);
	 new string[128];
	 PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	 format(string,sizeof(string),"You have Successfully banned {80C732}%s",params);
	 return SendClientMessage(playerid, 0x00FFFFAA, string);
	 } else return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}File doesnt exist, player isn't registered");
   } else return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You need to be RCON to use this command");
}
CMD:unban(playerid,params[]) {
   if(PlayerInfo[playerid][Level] >= 3) {
	 if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /unban [name]");
	 if(udb_Exists(params)) {
	 if(0 == dUserINT(params).("banned")) return SendClientMessage(playerid,red,"ERROR: {828282}Player is already unbanned");
	 dUserSetINT(params).("banned",0);
	 new string[128];
	 PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	 format(string,sizeof(string),"You have Successfully unbanned {80C732}%s",params);
	 return SendClientMessage(playerid, 0x00FFFFAA, string);
	 } else return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}File doesnt exist, player isnt registered");
   } else return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}You need to be RCON to use this command");
}

CMD:unbanip(playerid, params[])
{

		if(PlayerInfo[playerid][Level] >= 3) {
		new
			ip[48],string[64],String[27];
		if(sscanf(params, "s[48]",ip)) return SendClientMessage(playerid, red, "USAGE: /unbanip [ip]");
		format(string,sizeof(string),"unbanip %s",ip);
		SendRconCommand(string);
		SendRconCommand("reloadbans");
		format(String, sizeof(String),"You Have Unbanned IP: %s", ip);
		SendClientMessage(playerid, -1, String);
		return 1;
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:rban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4) {
			new ip[128], tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /rban [playerid] [reason]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "ERROR: {828282}You must give a reason");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"RBAN");
				format(string,sizeof(string),"%s has been range banned by Administrator %s [Reason: %s] [Date: %d/%d/%d] [Time: %d:%d]",playername,adminname,params[2],day,month,year,hour,minuite);
				SendClientMessageToAll(grey,string);
				SaveToFile("BanLog",string);
				print(string);
				if(udb_Exists(pName(player1)) && PlayerInfo[player1][LoggedIn] == 1) dUserSetINT(pName(player1)).("banned",1);
				GetPlayerIp(player1,ip,sizeof(ip));
				strdel(ip,strlen(ip)-2,strlen(ip));
				format(ip,128,"%s**",ip);
				format(ip,128,"banip %s",ip);
				SendRconCommand(ip);
				return 1;
			} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:ban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE:{FFFFFF} /Ban [playerid] [reason]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE:{FFFFFF} /Ban [playerid] [reason]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"BAN");
				format(string,sizeof(string),"Player %s has been banned by Administrator %s.",playername,adminname);
				SendClientMessageToAll(red,string);
				format(string,sizeof(string),"[Reason: %s]",params[2]);
				SendClientMessageToAll(red,string);
				SaveToFile("BanLog",string);
				print(string);
				if(udb_Exists(pName(player1)) && PlayerInfo[player1][LoggedIn] == 1) dUserSetINT(pName(player1)).("banned",1);
				format(string,sizeof(string),"banned by Administrator %s. Reason: %s", adminname, params[2] );
				format(string,sizeof(string),"Appeal At gaming-samp.tk");
				//return BanEx(player1,params[2]);
				return SetTimerEx("BanTimer", 1000, false, "d", player1);
			} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR:{80C732} You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR:{80C732} You must be logged in to use this command.");
}

CMD:sbankrupt(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /sbankrupt [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SBANKRUPT");
			format(string, sizeof(string), "You have silently reset \"%s's\" cash", pName(player1)); SendClientMessage(playerid,blue,string);
			return ResetPlayerMoney(player1);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:ubound(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /ubound [playerid]");
		new string[128], player1 = strval(params);

		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"UBOUND");
			SetPlayerWorldBounds(player1, 9999.9, -9999.9, 9999.9, -9999.9 );
			format(string, sizeof(string), "Administrator %s has removed your world boundaries", pName(playerid)); if(player1 != playerid) SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have removed %s's world boundaries", pName(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:acmds(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1)
	{

	new DIALOG[1246+500];

		strcat(DIALOG, "{7DD8CB}Admin Level 1 Commands\n");
		strcat(DIALOG, "{FFFFFF}FLIP, AFIX, CARCOLOUR, LTUNE, SETMYTIME, ADMINAREA, TIME\n");
		strcat(DIALOG, "{FFFFFF}GETID, LINKCAR, LNOS, LHY, SOUND, REPORTS, LP, LINK, ADMINDUTY\n");
		strcat(DIALOG, "{FFFFFF}JETPACK, RJETPACK - CAR CMDS: LTC[1-13]\n\n");
		strcat(DIALOG, "{7DD8CB}Admin Level 2 Commands\n");
		strcat(DIALOG, "{FFFFFF}GIVEWEAPON, LOCKCAR, UNLOCKCAR, BURN, SPAWN, DISARM, LCAR, LBIKE, BASE\n");
		strcat(DIALOG, "{FFFFFF}LHELI, LBOAT, LPLANE, ANNOUNCE, ANNOUNCE2, SCREEN, FLIP, GOTO, BAN\n");
		strcat(DIALOG, "{FFFFFF}VGOTO, LGOTO, KICK, WARN, SLAP, JAILED, FROZEN, MUTE, UNMUTE, MUTED, LASTON\n");
		strcat(DIALOG, "{FFFFFF}LS, LSOF, LSV, CLEARCHAT, LMENU, LTELE, CM, LTMENU, EXPLODE, ASYNC\n\n");
		strcat(DIALOG, "{7DD8CB}Admin Level 3 Commands\n");
		strcat(DIALOG, "{FFFFFF}SETHEALTH, SETARMOUR, SETCASH, SETSKIN, SETWANTED, SETWEATHER, UBOUND, SETTIME\n");
		strcat(DIALOG, "{FFFFFF}SETWORLD, SETINTERIOR, FORCECLASS, FORCETEAM, EJECT, SBANKRUPT, LWEAPS\n");
		strcat(DIALOG, "{FFFFFF}LAMMO, CAR, CARHEALTH, CARCOLOR, TELEPLAYER, VGET, GIVECAR, HEALALL, SETPASS\n");
		strcat(DIALOG, "{FFFFFF}JAIL, UNJAIL, FREEZE, DESTROYCAR, UNFREEZE, AKILL, AKA, DISABLECHAT, CLEARCHAT, CAPS\n");
		strcat(DIALOG, "{FFFFFF}MOVE, ASTREAM, ASTOP, SETALLWEATHER, SETALLTIME, SETALLWORLD, UNFREEZEALL, FREEZEALL\n");
		strcat(DIALOG, "{FFFFFF}LWEATHER, LTIME, LWEAPONS\n\n");
		strcat(DIALOG, "{7DD8CB}Admin Level 4 Commands\n");
		strcat(DIALOG, "{FFFFFF}ENABLE, DISABLE, CRASH, SPAM, GOD, GODCAR, DIE, UCONFIG, MAZE, KICKALL, SLAPALL\n");
		strcat(DIALOG, "{FFFFFF}BOTCHECK, FORBIDNAME, FORBIDWORD, ARMOURALL, SETALLCASH, SETALLSCORE, EXPLODEALL\n");
		strcat(DIALOG, "{FFFFFF}SPAWNALL, MUTEALL, UNMUTEALL, GETALL, KILLALL, GIVEWEAPON, UNDERCOVER\n");
		strcat(DIALOG, "{FFFFFF}$ to chat with level4+\n\n");
		strcat(DIALOG, "{7DD8CB}Admin Level 5 Commands\n");
		strcat(DIALOG, "{FFFFFF}SGOD, PICKUP, SETALLSCORE, SETDEATHS, SETOP, UNSETOP, SETLEVEL, SETTEMPLEVEL, SETKILLS\n");
		strcat(DIALOG, "{FFFFFF}OBJECT CREATER COMMANDS: CREATEOBJECT , DELETEOBJECT , EDITOBJECT\n");
		strcat(DIALOG, "{FFFFFF}FEATURE DISABLATION COMMANDS:  DISABLEJP, DISABLESPY, DISABLEHS (HS = Headshot)\n");
		strcat(DIALOG, "{FFFFFF}@ to chat with level5+");

		ShowPlayerDialog(playerid, ACMDS_DIALOG, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty : Modern Warfare 4 Admin System Help", DIALOG, "Close", "");

	  } else return SendClientMessage(playerid,red,"ERROR: {828282}You Need To Be Atleast Level 1 To Use This Command");
	return 1;
}

CMD:lconfig(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		new string[128];
		SendClientMessage(playerid,blue,"    ---=== LAdmin Configuration ===---");
		format(string, sizeof(string), "Max Ping: %dms | ReadPms %d | ReadCmds %d | Max Admin Level %d ", ServerInfo[MaxPing],  ServerInfo[ReadPMs],  ServerInfo[ReadCmds],  ServerInfo[MaxAdminLevel]);
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "NameKick %d | AntiSpam %d | AntiSwear %d |", ServerInfo[NameKick], ServerInfo[AntiSpam], ServerInfo[AntiSwear]);
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "NoCaps %d | Pass %s | ConnectMessages %d | AdminCmdMsgs %d", ServerInfo[NoCaps], ServerInfo[Password], ServerInfo[ConnectMessages], ServerInfo[AdminCmdMsg] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "AutoLogin %d | MaxMuteWarnings %d | ChatDisabled %d", ServerInfo[AutoLogin], ServerInfo[MaxMuteWarnings], ServerInfo[DisableChat]);
		SendClientMessage(playerid,blue,string);
	}
	return 1;
}

CMD:getinfo(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /getinfo [playerid]");
		new player1, string[128];
		player1 = strval(params);

		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			new Float:player1health, Float:player1armour, playerip[128], Float:x, Float:y, Float:z, tmp2[256], file[256],
				year, month, day, P1Jailed[4], P1Frozen[4], P1Logged[4], P1Register[4], RegDate[256], TimesOn;

			GetPlayerHealth(player1,player1health);
			GetPlayerArmour(player1,player1armour);
			GetPlayerIp(player1, playerip, sizeof(playerip));
			GetPlayerPos(player1,x,y,z);
			getdate(year, month, day);
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(pName(player1)));

			if(PlayerInfo[player1][Jailed] == 1) P1Jailed = "Yes"; else P1Jailed = "No";
			if(PlayerInfo[player1][Frozen] == 1) P1Frozen = "Yes"; else P1Frozen = "No";
			if(PlayerInfo[player1][LoggedIn] == 1) P1Logged = "Yes"; else P1Logged = "No";
			if(fexist(file)) P1Register = "Yes"; else P1Register = "No";
			if(dUserINT(pName(player1)).("LastOn")==0) tmp2 = "Never"; else tmp2 = dini_Get(file,"LastOn");
			if(strlen(dini_Get(file,"RegisteredDate")) < 3) RegDate = "n/a"; else RegDate = dini_Get(file,"RegisteredDate");
			TimesOn = dUserINT(pName(player1)).("TimesOnServer");

			format(string, sizeof(string),"(Player Info)  ---====> Name: %s  ID: %d <====---", pName(player1), player1);
			SendClientMessage(playerid,lightblue,string);
			format(string, sizeof(string),"Health: %d  Armour: %d  Score: %d  Cash: %d  Skin: %d  IP: %s Ping: %d",floatround(player1health),floatround(player1armour),
			GetPlayerScore(player1),GetCODMoney(player1),GetPlayerSkin(player1),playerip,GetPlayerPing(player1));
			SendClientMessage(playerid,red,string);
			format(string, sizeof(string),"Interior: %d  Virtual World: %d  Wanted Level: %d  X %0.1f  Y %0.1f  Z %0.1f", GetPlayerInterior(player1), GetPlayerVirtualWorld(player1), GetPlayerWantedLevel(player1), Float:x,Float:y,Float:z);
			SendClientMessage(playerid,orange,string);
			format(string, sizeof(string),"Times On Server: %d  Kills: %d  Deaths: %d  Ratio: %0.2f  AdminLevel: %d", TimesOn, PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:PlayerInfo[player1][Deaths], PlayerInfo[player1][Level] );
			SendClientMessage(playerid,yellow,string);
			format(string, sizeof(string),"Registered: %s  Logged In: %s  In Jail: %s  Frozen: %s", P1Register, P1Logged, P1Jailed, P1Frozen );
			SendClientMessage(playerid,green,string);
			format(string, sizeof(string),"Last On Server: %s  Register Date: %s  Todays Date: %d/%d/%d", tmp2, RegDate, day,month,year );
			SendClientMessage(playerid,COLOR_GREEN,string);

			if(IsPlayerInAnyVehicle(player1)) {
				new Float:VHealth, carid = GetPlayerVehicleID(playerid); GetVehicleHealth(carid,VHealth);
				format(string, sizeof(string),"VehicleID: %d  Model: %d  Vehicle Name: %s  Vehicle Health: %d",carid, GetVehicleModel(carid), VehicleNames[GetVehicleModel(carid)-400], floatround(VHealth) );
				SendClientMessage(playerid,COLOR_BLUE,string);
			}

			new slot, ammo, weap, cnt, WeapName[24], WeapSTR[128], p; WeapSTR = "Weaps: ";
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) cnt+= 1; }
			if(cnt < 1) return SendClientMessage(playerid,lightblue,"Player has no weapons");
			else {
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if (ammo > 0 && weap > 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if (ammo == 65535 || ammo == 1) format(WeapSTR,sizeof(WeapSTR),"%s%s (1)",WeapSTR, WeapName);
						else format(WeapSTR,sizeof(WeapSTR),"%s%s (%d)",WeapSTR, WeapName, ammo);
						p+= 1;
						if(p >= 5) { SendClientMessage(playerid, lightblue, WeapSTR); format(WeapSTR, sizeof(WeapSTR), "Weaps: "); p = 0;
						} else format(WeapSTR, sizeof(WeapSTR), "%s,  ", WeapSTR);
					}
				}
				if(p <= 4 && p > 0) {
					string[strlen(string)-3] = '.';
					SendClientMessage(playerid, lightblue, WeapSTR);
				}
			}
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be administrator level 2 to use this command");
}

CMD:disable(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) {
			SendClientMessage(playerid,red,"USAGE: /disable [antiswear / namekick / antispam / ping / readcmds / readpms /caps / admincmdmsgs");
			return SendClientMessage(playerid,red,"       /connectmsgs / autologin ]");
		}
		new string[128], file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		if(strcmp(params,"antiswear",true) == 0) {
			ServerInfo[AntiSwear] = 0;
			dini_IntSet(file,"AntiSwear",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}antiswear", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"namekick",true) == 0) {
			ServerInfo[NameKick] = 0;
			dini_IntSet(file,"NameKick",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}namekick", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"antispam",true) == 0)	{
			ServerInfo[AntiSpam] = 0;
			dini_IntSet(file,"AntiSpam",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}antispam", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"ping",true) == 0)	{
			ServerInfo[MaxPing] = 0;
			dini_IntSet(file,"MaxPing",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}maxping", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"readcmds",true) == 0) {
			ServerInfo[ReadCmds] = 0;
			dini_IntSet(file,"ReadCMDs",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}readcmds", pName(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"readpms",true) == 0) {
			ServerInfo[ReadPMs] = 0;
			dini_IntSet(file,"ReadPMs",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}readpms", pName(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"caps",true) == 0)	{
			ServerInfo[NoCaps] = 1;
			dini_IntSet(file,"NoCaps",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}nocaps", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"admincmdmsgs",true) == 0) {
			ServerInfo[AdminCmdMsg] = 0;
			dini_IntSet(file,"AdminCMDMessages",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}AdminCMDMessages", pName(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"connectmsgs",true) == 0)	{
			ServerInfo[ConnectMessages] = 0;
			dini_IntSet(file,"ConnectMessages",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}connectmessages", pName(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"autologin",true) == 0)	{
			ServerInfo[AutoLogin] = 0;
			dini_IntSet(file,"AutoLogin",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has disabled {80C732}autologin", pName(playerid));
			MessageToAdmins(green,string);
		} else {
			SendClientMessage(playerid,red,"USAGE: /disable [antiswear / namekick / antispam / ping / readcmds / readpms /caps /cmdmsg ]");
		} return 1;
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:enable(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) {
			SendClientMessage(playerid,red,"USAGE: /enable [antiswear / namekick / antispam / ping / readcmds / readpms /caps / admincmdmsgs");
			return SendClientMessage(playerid,red,"       /connectmsgs / autologin ]");
		}
		new string[128], file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		if(strcmp(params,"antiswear",true) == 0) {
			ServerInfo[AntiSwear] = 1;
			dini_IntSet(file,"AntiSwear",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}antiswear", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"namekick",true) == 0)	{
			ServerInfo[NameKick] = 1;
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}namekick", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"antispam",true) == 0)	{
			ServerInfo[AntiSpam] = 1;
			dini_IntSet(file,"AntiSpam",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}antispam", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"ping",true) == 0)	{
			ServerInfo[MaxPing] = 800;
			dini_IntSet(file,"MaxPing",800);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}maxping", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"readcmds",true) == 0)	{
			ServerInfo[ReadCmds] = 1;
			dini_IntSet(file,"ReadCMDs",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}readcmds", pName(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"readpms",true) == 0) {
			ServerInfo[ReadPMs] = 1;
			dini_IntSet(file,"ReadPMs",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}readpms", pName(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"caps",true) == 0)	{
			ServerInfo[NoCaps] = 0;
			dini_IntSet(file,"NoCaps",0);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}Caps", pName(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"admincmdmsgs",true) == 0)	{
			ServerInfo[AdminCmdMsg] = 1;
			dini_IntSet(file,"AdminCmdMessages",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}AdminCMDMessages", pName(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"connectmsgs",true) == 0) {
			ServerInfo[ConnectMessages] = 1;
			dini_IntSet(file,"ConnectMessages",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}connectmessages", pName(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"autologin",true) == 0) {
			ServerInfo[AutoLogin] = 1;
			dini_IntSet(file,"AutoLogin",1);
			format(string,sizeof(string),"{FFFFFF}Administrator {80C732}%s {FFFFFF}has enabled {80C732}autologin", pName(playerid));
			MessageToAdmins(green,string);
		} else {
			SendClientMessage(playerid,red,"USAGE: /enable [antiswear / namekick / antispam / ping / readcmds / readpms /caps /cmdmsg ]");
		} return 1;
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:lweaps(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		GivePlayerWeapon(playerid,28,1000); GivePlayerWeapon(playerid,31,1000); GivePlayerWeapon(playerid,34,1000);
		GivePlayerWeapon(playerid,38,1000); GivePlayerWeapon(playerid,16,1000);	GivePlayerWeapon(playerid,42,1000);
		GivePlayerWeapon(playerid,14,1000); GivePlayerWeapon(playerid,46,1000);	GivePlayerWeapon(playerid,9,1);
		GivePlayerWeapon(playerid,24,1000); GivePlayerWeapon(playerid,26,1000); return 1;
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 3 to use this command");
}

CMD:lammo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5) {
		MaxAmmo(playerid);
		return CMDMessageToAdmins(playerid,"LAMMO");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 3 to use this command");
}
CMD:savestats(playerid)
{
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be logged in to use this command");
	SavePlayer(playerid);
	SendClientMessage(playerid, green, "Stats Saved!");
	return 1;
}
CMD:ltune(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
		switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERROR: {828282}You can not tune this vehicle");
		}
		CMDMessageToAdmins(playerid,"LTUNE");
		SetVehicleHealth(LVehicleID,2000.0);
		TuneLCar(LVehicleID);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not in a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:lhy(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
		switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERROR: {828282}You can not tune this vehicle!");
		}
		AddVehicleComponent(LVehicleID, 1087);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not in a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:lcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,415);
			CMDMessageToAdmins(playerid,"LCAR");
			return SendClientMessage(playerid,blue,"Enjoy your new car");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 2 to use this command");
}

CMD:gas(playerid,params[])
{
	if(PlayerInfo[playerid][Level] >= 4) {
	  new tmp[256], Index; tmp = strtok(params,Index);
	  if(isnull(tmp) || !IsNumeric(tmp)) return SendClientMessage(playerid, red, "USAGE: /gas [score]");
		new score = strval(tmp), string[128];
		CMDMessageToAdmins(playerid,"GIVEALLSCORE");
		for(new i;i<GetMaxPlayers();i++)
		{
		SetPlayerScore(i,GetPlayerScore(i)+score);
		PlayerPlaySound(i, 1057,0.0,0.0,0.0);
		}
		format(string,128,"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given all players {80C732}%d Score",pName(playerid),score);
		SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	return 1;
}
CMD:givescore(playerid, params[])
{
	if(PlayerInfo[playerid][Level] < 4) return SendClientMessage(playerid, red, "ERROR: {828282}You are not high enough level to use this command");
	new giveplayerid, amount;
	if(sscanf(params, "ud", giveplayerid, amount)) return SendClientMessage(playerid, 0xFF0000AA, "USAGE: /givescore [playerid/partname] [amount]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: {828282}Player not found");
	SetPlayerScore(giveplayerid,GetPlayerScore(giveplayerid) + amount);
	SendClientMessage(playerid, green, "Score Sent!");
	SendClientMessage(giveplayerid, 0x00FF00AA, "You Recieved Scores From an admin");
	return 1;
}
CMD:giveallscore(playerid,params[])
{
	if(PlayerInfo[playerid][Level] >= 4) {
		new score;
		if(sscanf(params,"d",score)) return SendClientMessage(playerid, red, "USAGE: /giveallscore [score]");
		new string[128];
		CMDMessageToAdmins(playerid,"GIVEALLSCORE");
		for(new i;i<GetMaxPlayers();i++)
		{
			SetPlayerScore(i,GetPlayerScore(i)+score);
			PlayerPlaySound(i, 1057,0.0,0.0,0.0);
		}
		format(string,128,"{FFFFFF}Administrator {80C732}%s {FFFFFF}has given all players {80C732}%d Score",pName(playerid),score);
		SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	return 1;
}
CMD:lbike(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,522);
			CMDMessageToAdmins(playerid,"LBIKE");
			return SendClientMessage(playerid,blue,"Enjoy your new bike");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 2 to use this command");
}

CMD:lheli(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,487);
			CMDMessageToAdmins(playerid,"LHELI");
			return SendClientMessage(playerid,blue,"Enjoy your new helicopter");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 2 to use this command");
}

CMD:lboat(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,493);
			CMDMessageToAdmins(playerid,"LBOAT");
			return SendClientMessage(playerid,blue,"Enjoy your new boat");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 2 to use this command");
}

CMD:lplane(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,513);
			CMDMessageToAdmins(playerid,"LPLANE");
			return SendClientMessage(playerid,blue,"Enjoy your new plane");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 2 to use this command");
}

CMD:lnos(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
			switch(GetVehicleModel( GetPlayerVehicleID(playerid) )) {
				case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
				return SendClientMessage(playerid,red,"ERROR: {828282}You can not tune this vehicle!");
			}
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
			return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be in a vehicle.");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:linkcar(playerid,params[]) {
	#pragma unused params
	if(IsPlayerInAnyVehicle(playerid)) {
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(playerid));
		return SendClientMessage(playerid,lightblue, "Your vehicle is now in your virtual world and interior");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be in a vehicle.");
 }
/*=====[ BASE COMMAND ]=====*/
CMD:base(playerid, params[]) {
	if(PlayerInfo[playerid][Level] >= 2)
	{
		new loc[30];
		if(sscanf(params,"s[30]",loc)) return SendClientMessage(playerid, red,"USAGE: /Base [USA, Europe, Arab, Australia, Soviet]");
		if(strfind(loc,"Eur",true) != -1)
		{
			SetPlayerPos(playerid,981.1255, 2096.9294, 11.5718);
			CMDMessageToAdmins(playerid,"BASE");
		}
		if(strfind(loc,"Sov",true) != -1)
		{
			SetPlayerPos(playerid,-150.0795,1147.2764,19.5938);
			CMDMessageToAdmins(playerid,"BASE");
		}
		if(strfind(loc,"Arab", true) != -1)
		{
			SetPlayerPos(playerid,-814.9322,1572.2279,27.1172);
			CMDMessageToAdmins(playerid,"BASE");
		}
		if(strfind(loc,"Aus",true) != -1)
		{
			SetPlayerPos(playerid,-1466.3636, 2613.2705, 56.0449);
			CMDMessageToAdmins(playerid,"BASE");
		}
		if(strfind(loc,"USA", true) != -1)
		{
			SetPlayerPos(playerid,-250.4555,2595.8433,62.8582);
			CMDMessageToAdmins(playerid,"BASE");
		}
	}

	return 1;
}
/*=====[ BASE COMMAND ]=====*/
CMD:car(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
		if(isnull(tmp)) return SendClientMessage(playerid, red, "USAGE: /car [Modelid/Name] [colour1] [colour2]");
		new car, colour1, colour2, string[128];
		if(!IsNumeric(tmp)) car = GetVehicleModelIDFromName(tmp); else car = strval(tmp);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, red, "ERROR: {828282}Invalid Vehicle Model");
		if(isnull(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;	GetPlayerPos(playerid, X,Y,Z);	GetPlayerFacingAngle(playerid,Angle);   int1 = GetPlayerInterior(playerid);
		LVehicleID = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1); LinkVehicleToInterior(LVehicleID,int1); PutPlayerInVehicle(playerid, LVehicleID, 0);
		PlayerInfo[playerid][pCar] = LVehicleID;
		CMDMessageToAdmins(playerid,"CAR");
		format(string, sizeof(string), "%s spawned a \"%s\" (Model:%d) colour (%d, %d), at %0.2f, %0.2f, %0.2f", pName(playerid), VehicleNames[car-400], car, colour1, colour2, X, Y, Z);
		SaveToFile("CarSpawns",string);
		format(string, sizeof(string), "You have spawned a \"%s\" (Model:%d) colour (%d, %d)", VehicleNames[car-400], car, colour1, colour2);
		return SendClientMessage(playerid,lightblue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 3 to use this command");
}

CMD:carhealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /carhealth [playerid] [amount]");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
				CMDMessageToAdmins(playerid,"CARHEALTH");
				format(string, sizeof(string), "You have set \"%s's\" vehicle health to '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your vehicle's health to '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
				return SetVehicleHealth(GetPlayerVehicleID(player1), health);
			} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not in a vehicle");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:carcolour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !strlen(tmp3) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /carcolour [playerid] [colour1] [colour2]");
		new player1 = strval(tmp), colour1, colour2, string[128];
		if(isnull(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
				CMDMessageToAdmins(playerid,"CARCOLOUR");
				format(string, sizeof(string), "You have changed the colour of \"%s's\" %s to '%d,%d'", pName(player1), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has changed the colour of your %s to '%d,%d''", pName(playerid), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(player1,blue,string); }
				return ChangeVehicleColor(GetPlayerVehicleID(player1), colour1, colour2);
			} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not in a vehicle");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:god(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(PlayerInfo[playerid][God] == 0)	{
			PlayerInfo[playerid][God] = 1;
			SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
			SendClientMessage(playerid, green, "GODMODE ON");
			return CMDMessageToAdmins(playerid,"GOD");
		} else {
			PlayerInfo[playerid][God] = 0;
			SendClientMessage(playerid,red,"GODMODE OFF");
			SetPlayerHealth(playerid, 99);
		} return GivePlayerWeapon(playerid,35,0);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:sgod(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5) {
		if(PlayerInfo[playerid][God] == 0)	{
			PlayerInfo[playerid][God] = 1;
			SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
			return SendClientMessage(playerid, green, "GODMODE ON");
		} else	{
			PlayerInfo[playerid][God] = 0;
			SendClientMessage(playerid,red,"GODMODE OFF");
			SetPlayerHealth(playerid, 99); return GivePlayerWeapon(playerid,35,0);	}
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 5 to use this command");
}

CMD:godcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
			if(PlayerInfo[playerid][GodCar] == 0) {
				PlayerInfo[playerid][GodCar] = 1;
				CMDMessageToAdmins(playerid,"GODCAR");
				  //SetVehicleHealth(VID[playerid], 1410065407);
				  SetVehicleHealth(VID[playerid], 141006540);
				return SendClientMessage(playerid, green, "GODCARMODE ON");
			} else {
				PlayerInfo[playerid][GodCar] = 0;
				SetVehicleHealth(VID[playerid], 1000.0);
				return SendClientMessage(playerid,red,"GODCARMODE OFF"); }
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be in a car to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:die(playerid)
{
	if(PlayerInfo[playerid][Level] >= 4) {
		new Float:x, Float:y, Float:z ;
		GetPlayerPos( playerid, Float:x, Float:y, Float:z );
		CreateExplosion(Float:x+10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y-10, Float:z, 8,10.0);
		CreateExplosion(Float:x+10, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y+10, Float:z, 8,10.0);
		return CreateExplosion(Float:x-10, Float:y-10, Float:z, 8,10.0);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:getid(playerid, params[])
{
	new name[MAX_PLAYER_NAME];
	if(sscanf(params, "s", name)) return SendClientMessage(playerid, red, "USAGE: /getid [part of nick]");
	new found, string[100];
	format(string, sizeof(string), "You searched for \"%s\"", name);
	SendClientMessage(playerid, mw_green, string);
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i))
		{
			new namelen = strlen(pName(i));
			for(new pos; pos <= namelen; pos++)
			{
				if(strfind(pName(i), name, true) == pos)
				{
					found += 1;
					format(string, sizeof(string), "%s (%d)", pName(i), i);
					if(found > 1)
					{
						format(string, sizeof(string), "ERROR: More than one player has \"%s\" in their nick, be more specific.", name);
						SendClientMessage(playerid, red, string);
						break;
					}
					else
					{
						SendClientMessage(playerid, green, string);
					}
				}

			}
		}
	}
	if(!found)
	{
		format(string, sizeof(string), "ERROR: No players have \"%s\" in their nick", name);
		SendClientMessage(playerid, red, string);
	}
	return 1;
}

CMD:asay(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /asay [text]");
		new string[128]; format(string, sizeof(string), "***Admin %s: %s", pName(playerid), params[0] );
		return SendClientMessageToAll(COLOR_PINK,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:setgravity(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,red,"USAGE: /setgravity <-50.0 - 50.0>");
		CMDMessageToAdmins(playerid,"SETGRAVITY");
		new string[128],adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname)); new Float:Gravity = floatstr(params);format(string,sizeof(string),"Admnistrator %s has set the gravity to %f",adminname,Gravity);
		SetGravity(Gravity); return SendClientMessageToAll(blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:serverinfo(playerid,params[]) {
	#pragma unused params
	new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
	new numo = CreateDynamicObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
	new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
	new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

	new model[250], nummodel;
	for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]+= 1;
	for(new i=0;i<250;i++)	if(model[i]!=0)	nummodel+= 1;

	new string[256];
	format(string,sizeof(string),"Server Info: [ Players Connected: %d || Maximum Players: %d ] [Ratio %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Vehicles: %d || Models %d || Players In Vehicle: %d || InCar %d / OnBike %d ]",TotalVehicles-1,nummodel, InVehCount(),InCarCount(),OnBikeCount() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Objects: %d || Pickups %d || Gangzones %d ]",numo-1, nump, gz);
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Players In Jail %d || Players Frozen %d || Muted %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	return SendClientMessage(playerid,green,string);
}

CMD:announce(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /announce <text>");
		CMDMessageToAdmins(playerid,"ANNOUNCE");
		return GameTextForAll(params,4000,3);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:site(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		CMDMessageToAdmins(playerid,"SITE");
		SendClientMessageToAll(0xFF8DCC55,".::Visit our Website: Siege-Gaming.TK !::.");
		return GameTextForAll("~n~~b~~h~      serverwebsite:~n~~g~~h~~>~Siege-Gaming.TK~<~",5000,5);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:announce2(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index) ,tmp3 = strtok(params,Index);
		if(isnull(tmp)||isnull(tmp2)||!strlen(tmp3)) return SendClientMessage(playerid,red,"USAGE: /announce <style> <time> <text>");
		if(!(strval(tmp) >= 0 && strval(tmp) <= 6) || strval(tmp) == 2)	return SendClientMessage(playerid,red,"ERROR: {828282}Invalid gametext style. Range: 0 - 6");
		CMDMessageToAdmins(playerid,"ANNOUNCE2");
		return GameTextForAll(params[(strlen(tmp)+strlen(tmp2)+2)], strval(tmp2), strval(tmp));
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:ann(playerid,params[]) {
	return cmd_announce(playerid, params);
}

CMD:ann2(playerid,params[]) {
	return cmd_announce2(playerid, params);
}
CMD:lslowmo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5) {
		new Float:x, Float:y, Float:z; GetPlayerPos(playerid, x, y, z); CreatePickup(1241, 4, x, y, z);
		return CMDMessageToAdmins(playerid,"LSLOWMO");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:jetpack(playerid,params[]) {
		if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
			SendClientMessage(playerid,blue,"Jetpack Spawned.");
			CMDMessageToAdmins(playerid,"JETPACK");
			return SetPlayerSpecialAction(playerid, 2);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	}

CMD:rjetpack(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
		SendClientMessage(playerid,blue,"Jetpack Removed.");
		CMDMessageToAdmins(playerid,"RJETPACK");
		return SetPlayerSpecialAction(playerid, 0);
} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not using a Jetpack");
} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:flip(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) {
			if(IsPlayerInAnyVehicle(playerid)) {
			new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(playerid, X, Y, Z); VehicleID = GetPlayerVehicleID(playerid);
			GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
			CMDMessageToAdmins(playerid,"FLIP"); return SendClientMessage(playerid, blue,"Vehicle Flipped. You can also do /flip [playerid]");
			} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not in a vehicle. You can also do /flip [playerid]");
		}
		new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);

		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"FLIP");
			if (IsPlayerInAnyVehicle(player1)) {
				new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(player1, X, Y, Z); VehicleID = GetPlayerVehicleID(player1);
				GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
				CMDMessageToAdmins(playerid,"FLIP");
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator %s flipped your vehicle",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have flipped %s's vehicle", playername);
				return SendClientMessage(playerid, blue,string);
			} else return SendClientMessage(playerid,red,"ERROR: {828282}This player isn't in a vehicle");
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:destroycar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) return EraseVehicle(GetPlayerVehicleID(playerid));
	else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:ltc(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(!IsPlayerInAnyVehicle(playerid)) {
			if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
			new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
			LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);
			AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
			AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
			AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,0);
			SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
			return PlayerInfo[playerid][pCar] = LVehicleIDt;
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:warp(playerid, params[]) {
	return cmd_teleplayer(playerid, params);
}

CMD:teleplayer(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /teleplayer [playerid] to [playerid]");
		new player1 = strval(tmp), player2 = strval(tmp2), string[128], Float:plocx,Float:plocy,Float:plocz;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerConnected(player2) && player2 != INVALID_PLAYER_ID) {
				CMDMessageToAdmins(playerid,"TELEPLAYER");
				GetPlayerPos(player2, plocx, plocy, plocz);
				new intid = GetPlayerInterior(player2);	SetPlayerInterior(player1,intid);
				SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(player2));
				if (GetPlayerState(player1) == PLAYER_STATE_DRIVER)
				{
					new VehicleID = GetPlayerVehicleID(player1);
					SetVehiclePos(VehicleID, plocx, plocy+4, plocz); LinkVehicleToInterior(VehicleID,intid);
					SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(player2) );
				}
				else SetPlayerPos(player1,plocx,plocy+2, plocz);
				format(string,sizeof(string),"Administrator \"%s\" has teleported \"%s\" to \"%s's\" location", pName(playerid), pName(player1), pName(player2) );
				SendClientMessage(player1,blue,string); SendClientMessage(player2,blue,string);
				format(string,sizeof(string),"You have teleported \"%s\" to \"%s's\" location", pName(player1), pName(player2) );
				return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "Player2 is not connected");
		} else return SendClientMessage(playerid, red, "Player1 is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:maze(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	SetPlayerPos(playerid,847.4455, 1421.0322, 1014.7667);
	CMDMessageToAdmins(playerid,"MAZE");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
return 1;
}

CMD:goto(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /goto [playerid]");
		new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
		else player1 = strval(params);
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GOTO");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z); SetPlayerInterior(playerid,GetPlayerInterior(player1));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(player1));
			if(GetPlayerState(playerid) == 2) {
				SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(player1));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(player1));
			} else SetPlayerPos(playerid,x+2,y,z);
			format(string,sizeof(string),"You have teleported to \"%s\"", pName(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:vgoto(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /vgoto [vehicleid]");
		new player1, string[128];
		player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGOTO");
		new Float:x, Float:y, Float:z;	GetVehiclePos(player1,x,y,z);
		SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(player1));
		if(GetPlayerState(playerid) == 2) {
			SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetVehicleVirtualWorld(player1) );
		} else SetPlayerPos(playerid,x+2,y,z);
		format(string,sizeof(string),"You have teleported to vehicle id %d", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:vget(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /vget [vehicleid]");
		new player1, string[128];
		player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGET");
		new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(player1,x+3,y,z);
		SetVehicleVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
		format(string,sizeof(string),"You have brough vehicle id %d to your location", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:lgoto(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z;
		new tmp[256], tmp2[256], tmp3[256];
		new string[128], Index;	tmp = strtok(params,Index); tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid,red,"USAGE: /lgoto [x] [y] [z]");
		x = strval(tmp);		y = strval(tmp2);		z = strval(tmp3);
		CMDMessageToAdmins(playerid,"LGOTO");
		if(GetPlayerState(playerid) == 2) SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
		else SetPlayerPos(playerid,x,y,z);
		format(string,sizeof(string),"You have teleported to %f, %f, %f", x,y,z); return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}


CMD:get(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2|| IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /get [playerid]");
		new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
		else player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GET");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
				new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			format(string,sizeof(string),"You have been teleported to Administrator \"%s's\" location", pName(playerid) );	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have teleported \"%s\" to your location", pName(player1) );
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:eget(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2|| IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /get [playerid]");
		new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
		else player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GET");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
				new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			format(string,sizeof(string),"You have been teleported to Administrator \"%s's\" location", pName(playerid) );	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have teleported \"%s\" to your location", pName(player1) );
			TogglePlayerControllable(player1, false);
			PlayerInfo[player1][Frozen] = 1;
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:warn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
		new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /warn [playerid] [reason]");
		new warned = strval(tmp), str[128];
		if(PlayerInfo[warned][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(warned) && warned != INVALID_PLAYER_ID) {
			if(warned != playerid) {
			if(Anti_Warn[warned] == 1) return SendClientMessage(playerid, orange,"Player Already Warned");
				CMDMessageToAdmins(playerid,"WARN");
				PlayerInfo[warned][Warnings]+= 1;
				if(PlayerInfo[playerid][Level] >= 1) {
				if( PlayerInfo[warned][Warnings] == MAX_WARNINGS) {
					format(str, sizeof (str), "Administrator \"%s\" has kicked \"%s\".  ( Warning: %d/%d )", pName(playerid), pName(warned),  PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(red, str);
					format(str, sizeof (str), "[Reason: %s]",params[1+strlen(tmp)]);
					SendClientMessageToAll(red, str);
					SaveToFile("KickLog",str);	SetTimerEx("KickTimer", 1000, false, "d", warned);
					return PlayerInfo[warned][Warnings] = 0;
				} else {
					format(str, sizeof (str), "*Administrator \"%s\" has given \"%s\" a warning ( Warning: %d/%d )", pName(playerid), pName(warned), PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(yellow, str);
					format(str, sizeof (str), "[Reason: %s]",  params[1+strlen(tmp)]);
					SendClientMessageToAll(yellow, str);
					GameTextForPlayer(warned, "You have been ~n~ ~r~ WARNED!", 2500, 3);
					Anti_Warn[warned] = 1;
					Warn[playerid] = warned;
					}
				}
				SetTimerEx("AntiWarn", 30000, true, "d", playerid);
				return 1;
			} else return SendClientMessage(playerid, red, "ERROR: {828282}You cannot warn yourself");
		} else return SendClientMessage(playerid, red, "ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

forward AntiWarn(playerid);
public AntiWarn(playerid)
	Anti_Warn[Warn[playerid]] = 0;

CMD:forcerules(playerid,params[])
{
	new player1, string[100];
	if(PlayerInfo[playerid][Level] < 1) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	if(sscanf(params, "u", player1)) return SendClientMessage(playerid, red,"USAGE: /forcerules [playerid]");
	if(!IsPlayerConnected(player1)) return SendClientMessage(playerid, 0xFF0000FF, "ERROR: {828282}Player Is Not Connected!");

	CMDMessageToAdmins(playerid,"FORCERULES");

	new RULES[500];
	strcat(RULES, "{009E00}• {FFFFFF}Don't Use Any Kind Of Hacks/Cheats\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Insult/Spam/Flood/Advertise\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Kill People Using Heli-blade/Car Park or Car Ram\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Spawn Kill or Base Rape\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Ask For Score/Cash From Admins\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Capture While AFK/Pausing\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Abuse Any Bug (C-Bug, Slide Bug etc)\n");
	strcat(RULES, "{009E00}• {FFFFFF}Don't Provoke/Insult Players/Admins\n");
	strcat(RULES, "{009E00}• {FFFFFF}No Score Farming and Money Farming\n");
	strcat(RULES, "{FFFFFF}Not Following These Rules Leads To Punishment");

	ShowPlayerDialog(player1, 31, DIALOG_STYLE_MSGBOX, "{00C5B6}Call Of Duty - Modern Warfare 4 Rules", RULES, "Close", "");
	format(string, sizeof(string),"Administrator %s has forced %s to read the rules", pName(playerid), pName(player1));
	SendClientMessageToAll(red,string);
	return 1;
}

CMD:kick(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
		if(!(PlayerInfo[playerid][Level] >= 1)) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /kick [playerid] [reason]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel])) return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"KICK");
				if(isnull(tmp2)) {
					format(string,sizeof(string),"%s has been kicked by Administrator %s ",playername,adminname,params[2]); SendClientMessageToAll(red,string);
					format(string,sizeof(string),"[ No Reason Given ]",params[2]); SendClientMessageToAll(red,string);
					SaveToFile("KickLog",string); print(string); return SetTimerEx("KickTimer", 1000, 0, "d", player1);
				} else {
					format(string,sizeof(string),"%s has been kicked by Administrator %s ",playername,adminname,params[2]); SendClientMessageToAll(red,string);
					format(string,sizeof(string),"[ Reason: %s ]",params[2]); SendClientMessageToAll(red,string);
					SaveToFile("KickLog",string); print(string); return SetTimerEx("KickTimer", 1000, 0, "d", player1); }
				}

CMD:dbike(playerid,params[])
{
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
		if(PlayerInfo[playerid][VIP] >= 2)
		{
			   if(IsEnemyInRange(playerid) == 0) {
				CarSpawner(playerid,522);
				SendClientMessage(playerid,blue,"Bike Spawned.");
				SendCMDMessge(playerid,"DBIKE");
				 }
				else return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command when enemy is in range.");
		 }
	  else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
	}
	else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	return 1;
}
CMD:dtime(playerid,params[]) {
	if(PlayerInfo[playerid][VIP] >= 2) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /dtime [hour]");
		new time = strval(params), string[128];
		format(string,sizeof(string),"Time change to %d:00", time); SendClientMessage(playerid,blue,string);
		return SetPlayerTime(playerid, time, 0);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
}

CMD:dcar(playerid,params[]) // can i show u something? soACthing what?
{
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
		if(PlayerInfo[playerid][VIP] >= 2)
		{
				if(IsEnemyInRange(playerid) == 0) {
				CarSpawner(playerid,411);
				SendClientMessage(playerid,blue,"Car Spawned.");
				SendCMDMessge(playerid,"DCAR");
				 }
			else return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command this command when enemy is in range.");
			}
	  else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
	}
	else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	return 1;
}

CMD:dheli(playerid,params[]) // can i show u something? soACthing what?
{
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
		if(PlayerInfo[playerid][VIP] >= 2)
		{
				if(IsEnemyInRange(playerid) == 0) {
				CarSpawner(playerid,487);
				SendClientMessage(playerid,blue,"Heli Spawned.");
				SendCMDMessge(playerid,"DHELI");
				 }
			else return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use command this command when enemy is in range.");
			}
	  else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be DONOR rank 2 in order to use this command");
	}
	else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	return 1;
}

CMD:dskin(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][VIP] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /dskin [skinid]");
		new var = strval(params);
		if(!IsValidSkin(var)) return SendClientMessage(playerid, red, "ERROR: {828282}Invaild Skin ID");
		SetPlayerSkin(playerid, var);
		if(var == 217) return SendClientMessage(playerid, red, "ERROR: {828282}You Can't Use Admin Skin!");
	  } else return SendClientMessage(playerid,red,"ERROR: {828282}You Need Atleast Donor Rank 3 To Use This Command");
   } else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
   return 1;
}

CMD:dchat(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][VIP] >= 1 || PlayerInfo[playerid][Level] >= 1) {
		if(isnull(params)) return SendClientMessage(playerid, -1, "USAGE: /dchat [text] To Talk in VIP/Donor Chat");
		new string[250]; format(string, sizeof(string), ""cred"VIP Chat:"cgreen"[%i]"cblue"%s:"cwhite" %s",playerid, pName(playerid), params[0]);
		return SendClientMessageToAll(-1,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be Donor rank 1 to use this command");
}

CMD:dhelp(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		SendClientMessage(playerid,blue,"----== Donor Help ==----");
		SendClientMessage(playerid,lightblue,"To Become A Donor Visit Our Exchange Shop");
		SendClientMessage(playerid,lightblue,"Donor Status Can Be Removed On Abuse");
		SendClientMessage(playerid,lightblue,"To Check Donor Commands Use /dcmds");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
   return 1;
}

CMD:dcmds(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][VIP] == 0) return SendClientMessage(playerid,red,"ERROR: {828282}You Need Atleast Donor Rank 1 To Use This Command");
		if(PlayerInfo[playerid][VIP] == 1)
		{
		  SendClientMessage(playerid,blue,"----== Donor Rank 1 Help ==----");
		  SendClientMessage(playerid,lightblue,"dheal, dcc, dnos, dchat");
		  SendClientMessage(playerid,lightblue,"Now VIPs Can Drive All Vehicles");
		}
		else if(PlayerInfo[playerid][VIP] == 2)
		{
		  SendClientMessage(playerid,blue,"----== Donor Rank 2 Help ==----");
		  SendClientMessage(playerid,lightblue,"dheal, dcar, dbike, dweaps, dcc, dnos, dchat, dboost");
		  SendClientMessage(playerid,lightblue,"Now VIPs Can Drive All Vehicles");
		}
		else if(PlayerInfo[playerid][VIP] == 3)
		{
		  SendClientMessage(playerid,blue,"----== Donor Rank 3 Help ==----");
		  SendClientMessage(playerid,lightblue,"dheal, dcar, dbike, dskin, dweaps, dnos, dchat, dboost");
		  SendClientMessage(playerid,lightblue,"Now VIPs Can Drive All Vehicles");
		}
   } else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
   return 1;
}
CMD:setvip(playerid,params[]) {
if(PlayerInfo[playerid][Level] >= 6) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric2(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setvip [playerid] [Level] | Note : Max Levels = 3 |");
		new player1 = strval(tmp), skin = strval(tmp2), string[128];
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETVIP");
			format(string, sizeof(string), "You have set \"%s's\" VIP Level to '%d", pName(player1), skin); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your VIP Level to '%d'", pName(playerid), skin); SendClientMessage(player1,blue,string); }
			return PlayerInfo[player1][VIP] = skin;
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:locate(playerid, params[])
{
	if(tCP[EAR] != gTeam[playerid]) return SendClientMessage(playerid, red, "Your team doesn't own Big Ear.");
	new targetid;
	if(sscanf(params,"u",targetid)) return SendClientMessage(playerid, -1, "Usage: /locate [ID]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, -1, "Player is not connected!");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	SetPlayerMapIcon(playerid, 1, x, y, z, 58, MAPICON_GLOBAL);
	return 1;
}

CMD:alocate(playerid, params[])
{
	if(PlayerInfo[playerid][Level] < 1) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	new targetid;
	if(sscanf(params,"u",targetid)) return SendClientMessage(playerid, -1, "Usage: /alocate [ID]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, -1, "Player is not connected!");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	SetPlayerMapIcon(playerid, 1, x, y, z, 58, MAPICON_GLOBAL);
	return 1;
}
CMD:slap(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /slap [playerid] [reason/with]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"SLAP");
				new Float:Health, Float:x, Float:y, Float:z; GetPlayerHealth(player1,Health);
				GetPlayerPos(player1,x,y,z); SetPlayerPos(player1,x,y,z+6); PlayerPlaySound(playerid,1190,0.0,0.0,0.0); PlayerPlaySound(player1,1190,0.0,0.0,0.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"You have slapped %s %s ",playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"You have slapped %s",playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:explode(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /explode [playerid] [reason]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"EXPLODE");
				new Float:burnx, Float:burny, Float:burnz; GetPlayerPos(player1,burnx, burny, burnz); CreateExplosion(burnx, burny , burnz, 7,10.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"You have exploded %s [reason: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"You have exploded %s", playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:jail(playerid, params[])
{
	new userid, time, reason[48], jstring[128];
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command");
	if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid, red, "ERROR: {828282}You must be level 2+");
	if(sscanf(params, "uD(9999)S(No Reason)[48]", userid, time, reason)) return SendClientMessage(playerid, red, "USAGE: /jail [playerid/PartOfName] [Minutes] [Reason]");
	if(!IsPlayerConnected(userid) || userid == INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "ERROR: {828282}User is not connected or invalid.");
	if(PlayerInfo[userid][Level] > PlayerInfo[playerid][Level]) return SendClientMessage(playerid, red, "ERROR: {828282}That admin is senior than you.");
	if(PlayerInfo[userid][JailTime] > 0) return SendClientMessage(playerid, red, "ERROR: {828282}That player is already jailed.");
	else
	{
		CMDMessageToAdmins(playerid,"JAIL");
		format(jstring, sizeof(jstring), "%s has been jailed by Admin %s for %d minute(s), [Reason: %s]", GetName(userid), GetName(playerid), time, reason);
		SendClientMessageToAll(-1, jstring);
		PlayerInfo[userid][JailTime] = time*60;
		SetTimerEx("JailPlayer", 5000, false, "d", userid);
		SetTimerEx("Jail1", 1000, false, "d", userid);
	}
	return 1;
}

CMD:unjail(playerid, params[])
{
	new userid, jstring[128];
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid, red, "ERROR: {828282}You must be logged in to use this command");
	if(PlayerInfo[playerid][Level] < 2) return SendClientMessage(playerid, red, "ERROR: {828282}You must be level 2+");
	if(sscanf(params, "u", userid)) return SendClientMessage(playerid, red, "USAGE: /unjail [playerid/player name]");
	if(!IsPlayerConnected(userid) || userid == INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "ERROR: {828282}User is not connected or invalid.");
	if(PlayerInfo[userid][Level] > PlayerInfo[playerid][Level]) return SendClientMessage(playerid, red, "ERROR: {828282}That admin is senior than you.");
	if(PlayerInfo[userid][JailTime] < 0) return SendClientMessage(playerid, red, "ERROR: {828282}That player is not jailed");
	else
	{
		CMDMessageToAdmins(playerid, "UNJAIL");
		format(jstring, sizeof(jstring), "%s has been unjailed by Admin %s.", GetName(userid), GetName(playerid));
		SendClientMessageToAll(-1, jstring);
		JailRelease(userid);
	}
	return 1;
}

CMD:jailed(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new bool:First2 = false, cout, adminname[MAX_PLAYER_NAME], string[128], i;
			for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) cout+= 1;
			if(cout == 0) return SendClientMessage(playerid,red, "No players are jailed");

			for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) {
				GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Jailed Players: (%d)%s", i,adminname); First2 = true; }
				else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
			}
			return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:freeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
			new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /freeze [playerid] [minutes] [reason]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][Frozen] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new ftime = strval(tmp2);
					if(ftime == 0) ftime = 9999;

					CMDMessageToAdmins(playerid,"FREEZE");
					TogglePlayerControllable(player1,false); PlayerInfo[player1][Frozen] = 1; PlayerPlaySound(player1,1057,0.0,0.0,0.0);
					PlayerInfo[player1][FreezeTime] = ftime*1000*60;
					FreezeTimer[player1] = SetTimerEx("UnFreezeMe",PlayerInfo[player1][FreezeTime],0,"d",player1);

					if(ftime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrator %s has frozen %s ",adminname, playername);
						else format(string,sizeof(string),"Administrator %s has frozen %s [reason: %s]",adminname, playername, params[strlen(tmp)+1] );
					} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrator %s has frozen %s for %d minutes",adminname, playername, ftime);
						else format(string,sizeof(string),"Administrator %s has frozen %s for %d minutes [reason: %s]",adminname, playername, ftime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
					return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is already frozen");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:unfreeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /unfreeze [playerid]");
			new player1, string[128];
			player1 = strval(params);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][Frozen] == 1) {
					CMDMessageToAdmins(playerid,"UNFREEZE");
					UnFreezeMe(player1);
					format(string,sizeof(string),"Administrator %s has unfrozen you", pName(playerid) ); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s has unfrozen %s", pName(playerid), pName(player1));
					return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is not frozen");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:frozen(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new bool:First2 = false, cot, adminname[MAX_PLAYER_NAME], string[128], i;
			for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) cot+= 1;
			if(cot == 0) return SendClientMessage(playerid,red, "No players are frozen");

			for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) {
				GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Frozen Players: (%d)%s", i,adminname); First2 = true; }
				else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
			}
			return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:mute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /mute [playerid] [reason]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Muted] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"MUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 1; PlayerInfo[player1][MuteWarnings] = 0;

					if(strlen(tmp2)) {
						format(string,sizeof(string),"You have been muted by Administrator %s [reason: %s]",adminname,params[2]); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"You have muted %s [reason: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
					} else {
						format(string,sizeof(string),"You have been muted by Administrator %s",adminname); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"You have muted %s", playername); return SendClientMessage(playerid,blue,string); }
				} else return SendClientMessage(playerid, red, "Player is already muted");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:unmute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /unmute [playerid]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Muted] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"UNMUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 0; PlayerInfo[player1][MuteWarnings] = 0;
					format(string,sizeof(string),"You have been unmuted by Administrator %s",adminname); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"You have unmuted %s", playername); return SendClientMessage(playerid,blue,string);
				} else return SendClientMessage(playerid, red, "Player is not muted");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:muted(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
			new bool:First2 = false, cart, adminname[MAX_PLAYER_NAME], string[128], i;
			for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) cart+= 1;
			if(cart == 0) return SendClientMessage(playerid,red, "No players are muted");

			for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) {
				GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Muted Players: (%d)%s", i,adminname); First2 = true; }
				else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
			}
			return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:akill(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /akill [playerid]");
			new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if( (PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel] ) )
					return SendClientMessage(playerid, red, "You cannot akill the highest level admin");
				CMDMessageToAdmins(playerid,"AKILL");
				GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator %s has killed you",adminname);	SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have killed %s",playername); SendClientMessage(playerid,blue,string);
				return SetPlayerHealth(player1,0.0);
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:weaps(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /weaps [playerid]");
		new player1, string[128], string2[64], WeapName[24], slot, weap, ammo, wh, x;
		player1 = strval(params);

		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			format(string2,sizeof(string2),"[>> %s Weapons (id:%d) <<]", pName(player1), player1); SendClientMessage(playerid,blue,string2);
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) wh+= 1; }
			if(wh < 1) return SendClientMessage(playerid,blue,"Player has no weapons");

			if(wh >= 1)
			{
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if( ammo != 0 && weap != 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if(ammo == 65535 || ammo == 1) format(string,sizeof(string),"%s%s (1)",string, WeapName );
						else format(string,sizeof(string),"%s%s (%d)",string, WeapName, ammo );
						x+= 1;
						if(x >= 5)
						{
							SendClientMessage(playerid, blue, string);
							x = 0;
							format(string, sizeof(string), "");
						}
						else format(string, sizeof(string), "%s,  ", string);
					}
				}
				if(x <= 4 && x > 0) {
					string[strlen(string)-3] = '.';
					SendClientMessage(playerid, blue, string);
				}
			}
			return 1;
		} else return SendClientMessage(playerid, red, "Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:aka(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /aka [playerid]");
		new player1, playername[MAX_PLAYER_NAME], str[128], tmp3[50];
		player1 = strval(params);
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			GetPlayerIp(player1,tmp3,50);
			GetPlayerName(player1, playername, sizeof(playername));
			format(str,sizeof(str),"AKA: [%s id:%d] [%s] %s", playername, player1, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
			return SendClientMessage(playerid,blue,str);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:screen(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /screen [playerid] [text]");
		new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);

		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			CMDMessageToAdmins(playerid,"SCREEN");
			format(string,sizeof(string),"Administrator %s has sent you a screen message",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have sent %s a screen message (%s)", playername, params[2]); SendClientMessage(playerid,blue,string);
			return GameTextForPlayer(player1, params[2],4000,3);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:laston(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		new tmp2[256], file[256],player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], str[128];
		GetPlayerName(playerid, adminname, sizeof(adminname));

		if(isnull(params)) {
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(adminname));
			if(!fexist(file)) return SendClientMessage(playerid, red, "ERROR: {828282}File doesnt exist, player isnt registered");
			if(dUserINT(pName(playerid)).("LastOn")==0) {	format(str, sizeof(str),"Never"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"You were last on the server on %s",tmp2);
			return SendClientMessage(playerid, red, str);
		}
		player1 = strval(params);
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"LASTON");
			GetPlayerName(player1,playername,sizeof(playername)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(playername));
			if(!fexist(file)) return SendClientMessage(playerid, red, "ERROR: {828282}File doesnt exist, player isnt registered");
			if(dUserINT(pName(player1)).("LastOn")==0) { format(str, sizeof(str),"Never"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"%s was last on the server on %s",playername,tmp2);
			return SendClientMessage(playerid, red, str);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:adminduty(playerid,params[])
{
	if(PlayerInfo[playerid][Level] < 1) return 0;
	if(PlayerInfo[playerid][OnDuty] == 0)
	{
		PlayerInfo[playerid][OnDuty] = 1;
		new str[128], AdminName[28];
		GetPlayerName(playerid, AdminName, sizeof(AdminName));
		format(str, sizeof(str), "%s is now on Admin duty!", AdminName);
		SendClientMessageToAll(red, str);
		SetPlayerSkin(playerid,217);
		SetPlayerTeam(playerid, 6);
		SetPlayerColor(playerid, 0xF600F6FF);
		SetPlayerHealth(playerid, FLOAT_INFINITY);
		SetPlayerArmour(playerid, FLOAT_INFINITY);
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 38, 999999);
		Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF,"On Duty Admin\n!!Do Not Attack!!");
		gTeam[playerid] = TEAM_NONE;
	}
	else
	{
		PlayerInfo[playerid][OnDuty] = 0;
		new str[128], AdminName[28];
		GetPlayerName(playerid, AdminName, sizeof(AdminName));
		format(str, sizeof(str), "%s is now off Admin duty", AdminName);
		SendClientMessageToAll(red, str);
		PlayerInfo[playerid][Deaths]--;
		SetPlayerHealth(playerid, 0.0);
		ForceClassSelection(playerid);
//	    SetPlayerArmour(playerid, 0);
		FirstSpawn[playerid] = 1;
   }
   return 1;
}

CMD:vips(playerid)
{
	new	count, string[800];
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(PlayerInfo[i][VIP] >= 1)
		{
			format(string, sizeof(string), "%s* %s (%i) - Level: %d\n", string, pName(i), i, PlayerInfo[i][VIP]);
			//We are appending the string, so put %s before any new data is added,
			//and that parameter actually refers to the string itself.
			count+= 1;
		}
	}
	if(!count) ShowPlayerDialog(playerid, DONOR_DIALOG, DIALOG_STYLE_MSGBOX, "Online VIPs", "{00FFEE}No Donators Online", "Okay", "");
	else ShowPlayerDialog(playerid, DONOR_DIALOG, DIALOG_STYLE_MSGBOX, "Online VIPs", string, "Okay", "");
	return 1;
}

CMD:pausers(playerid)
{
	new count, string[500];
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(IsPlayerPaused(i) == 1 && (GetConnectedTime(i) - s_aPlayerTickInfo[i][e_PLAYER_LAST_UPDATE]) >= 4000)
		{
			format(string, sizeof(string), "%s* %s - %d seconds\n", string, GetName(i), GetPlayerPausedTime(playerid)/1000);
			count += 1;
		}
	}
	if(!count) ShowPlayerDialog(playerid, DIALOG_PAUSERS, DIALOG_STYLE_MSGBOX, "Pausers", "No one is pausing at the moment", "Okay", "");
	else ShowPlayerDialog(playerid, DIALOG_PAUSERS, DIALOG_STYLE_MSGBOX, "Pausers", string, "Okay", "");
	return 1;
}

CMD:admins(playerid, params[])
{
	new count, string[500], AdmDuty[16];
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		switch(PlayerInfo[i][OnDuty])
		{
			case 0: AdmDuty = "Playing";
			case 1: AdmDuty = "On Duty";
		}
		if(PlayerInfo[i][Level] > 0 && PlayerInfo[i][Hide] != 1)
		{
			format(string, sizeof(string), "%s* %s - %s\n", string, GetName(i), AdmDuty);
			count+= 1;
		}
	}
	if(!count) ShowPlayerDialog(playerid, DIALOG_ADMINS, DIALOG_STYLE_MSGBOX, "Admins", "No Admins Online", "Okay", "");
	else ShowPlayerDialog(playerid, DIALOG_ADMINS, DIALOG_STYLE_MSGBOX, "Admins", string, "Okay", "");
	return 1;
}

CMD:undercover(playerid,params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3)) return SendClientMessage(playerid, red, "You are not high enough to use this command");
	if(PlayerInfo[playerid][Hide] == 0)
	{
		PlayerInfo[playerid][Hide] = 1;
		SendClientMessage(playerid, green,"You are not invisible in the admin list.");
	}
	else
	{
		PlayerInfo[playerid][Hide] = 0;
		SendClientMessage(playerid, green, "You are now visible in the admin list.");
	}
	return 1;
}

CMD:morning(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		CMDMessageToAdmins(playerid,"MORNING");
		return SetPlayerTime(playerid,7,0);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
}

CMD:adminarea(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		CMDMessageToAdmins(playerid,"ADMINAREA");
		SetPlayerPos(playerid, AdminArea[0], AdminArea[1], AdminArea[2]);
		SetPlayerFacingAngle(playerid, AdminArea[3]);
		SetPlayerInterior(playerid, AdminArea[4]);
		SetPlayerVirtualWorld(playerid, AdminArea[5]);
		return GameTextForPlayer(playerid,"Welcome Admin",1000,3);
	} else {
		SetPlayerHealth(playerid,1.0);
		new string[100]; format(string, sizeof(string),"%s has used adminarea (non admin)", pName(playerid) );
		MessageToAdmins(red,string);
	} return SendClientMessage(playerid,red, "ERROR: {828282}You must be an administrator to use this command.");
}

CMD:godadmin(playerid,params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,red,"ERROR: {828282}You Need To Be Logged In RCON");
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You must be registered and logged in to be God admin");
	PlayerInfo[playerid][Level] = 8;
	dUserSetINT(pName(playerid)).("level",(8));
	GameTextForPlayer(playerid, "~g~GOD ADMIN! ]", 2000, 3);
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	return 1;
}

CMD:setlevel(playerid,params[]) {
		if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setlevel [playerid] [level]");
			new player1, level, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			if(isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setlevel [playerid] [level]");
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERROR: {828282}Incorrect Level");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: {828282}Player is already this level");
					CMDMessageToAdmins(playerid,"SETLEVEL");
					GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
					new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Administrator %s has set you to Administrator Status [level %d]",adminname, level);
					else format(string,sizeof(string),"Administrator %s has set you to Player Status [level %d]",adminname, level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"~g~Promoted", 2000, 3);
					else GameTextForPlayer(player1,"~r~Demoted", 2000, 3);

					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", playername, level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrator %s has made %s Level %d on %d/%d/%d at %d:%d:%d",adminname, playername, level, day, month, year, hour, minute, second);
					SaveToFile("AdminLog",string);
					dUserSetINT(pName(player1)).("level",(level));
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: {828282}Player must be registered and logged in to be admin");
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:settemplevel(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /settemplevel [playerid] [level]");
			new player1, level, string[128];
			player1 = strval(tmp);
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERROR: {828282}Incorrect Level");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: {828282}Player is already this level");
					CMDMessageToAdmins(playerid,"SETTEMPLEVEL");
					new year,month,day; getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Administrator %s has temporarily set you to Administrator Status [level %d]", pName(playerid), level);
					else format(string,sizeof(string),"Administrator %s has temporarily set you to Player Status [level %d]", pName(playerid), level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"Promoted", 2000, 3);
					else GameTextForPlayer(player1,"Demoted", 2000, 3);

					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", pName(player1), level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrator %s has made %s temp Level %d on %d/%d/%d at %d:%d:%d",pName(playerid), pName(player1), level, day, month, year, hour, minute, second);
					SaveToFile("TempAdminLog",string);
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: {828282}Player must be registered and logged in to be admin");
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
}

CMD:report(playerid,params[]) {
	new reported, tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /report [playerid] [reason]");
	reported = strval(tmp);

	if(IsPlayerConnected(reported) && reported != INVALID_PLAYER_ID) {
		if(PlayerInfo[reported][Level] == ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot report this administrator");
		if(playerid == reported) return SendClientMessage(playerid,red,"ERROR: {828282}You Cannot report yourself");
		if(strlen(params) > 3) {
			new reportedname[MAX_PLAYER_NAME], reporter[MAX_PLAYER_NAME], str[128], hour,minute,second; gettime(hour,minute,second);
			GetPlayerName(reported, reportedname, sizeof(reportedname));	GetPlayerName(playerid, reporter, sizeof(reporter));
			format(str, sizeof(str), "{00FF00}||Report|| %s(%d) reported %s(%d) Reason: %s |@%d:%d:%d|", reporter,playerid, reportedname, reported, params[strlen(tmp)+1], hour,minute,second);
			MessageToAdmins(red,str);
			SaveToFile("ReportLog",str);
			format(str, sizeof(str), "Report(%d:%d:%d): %s(%d) reported %s(%d) Reason: %s", hour,minute,second, reporter,playerid, reportedname, reported, params[strlen(tmp)+1]);
			for(new i = 1; i < MAX_REPORTS-1; i++) Reports[i] = Reports[i+1];
			Reports[MAX_REPORTS-1] = str;
			return SendClientMessage(playerid,yellow, "Your report has been sent to online administrators.");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Must be a valid reason");
	} else return SendClientMessage(playerid, red, "Player is not connected");
}

CMD:reports(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		new ReportCount;
		for(new i = 1; i < MAX_REPORTS; i++)
		{
			if(strcmp( Reports[i], "<none>", true) != 0) { ReportCount+= 1; SendClientMessage(playerid,COLOR_WHITE,Reports[i]); }
		}
		if(ReportCount == 0) SendClientMessage(playerid,COLOR_WHITE,"There have been no reports");
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;
}

CMD:richlist(playerid,params[]) {
	#pragma unused params
		new string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
		SendClientMessage(playerid,COLOR_WHITE,"Rich List:");

		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x)) if (GetCODMoney(x) >= HighestCash) {
			HighestCash = GetCODMoney(x);
			Slot1 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1) if (GetCODMoney(x) >= HighestCash) {
			HighestCash = GetCODMoney(x);
			Slot2 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2) if (GetCODMoney(x) >= HighestCash) {
			HighestCash = GetCODMoney(x);
			Slot3 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3) if (GetCODMoney(x) >= HighestCash) {
			HighestCash = GetCODMoney(x);
			Slot4 = x;
		}
		format(string, sizeof(string), "(%d) %s - $%d", Slot1,pName(Slot1),GetCODMoney(Slot1) );
		SendClientMessage(playerid,COLOR_WHITE,string);
		if(Slot2 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot2,pName(Slot2),GetCODMoney(Slot2) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot3 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot3,pName(Slot3),GetCODMoney(Slot3) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot4 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot4,pName(Slot4),GetCODMoney(Slot4) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
}
CMD:topscores(playerid,params[]) {
	#pragma unused params
		new string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
		SendClientMessage(playerid,COLOR_WHITE,"Top Scorers:");

		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x)) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot1 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot2 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot3 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot4 = x;
		}
		format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot1,pName(Slot1),GetPlayerScore(Slot1), GetRankName(Slot1) );
		SendClientMessage(playerid,COLOR_WHITE,string);
		if(Slot2 != -1)	{
			format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot2,pName(Slot2),GetPlayerScore(Slot2), GetRankName(Slot2));
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot3 != -1)	{
			format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot3,pName(Slot3),GetPlayerScore(Slot3), GetRankName(Slot3) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot4 != -1)	{
			format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot4,pName(Slot4),GetPlayerScore(Slot4), GetRankName(Slot4) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
}

CMD:botcheck(playerid)
{
	if(PlayerInfo[playerid][Level] >= 4) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		BotCheck(i);
	}
	CMDMessageToAdmins(playerid,"BOTCHECK");
	return 1;
}

CMD:uconfig(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4)
	{
		UpdateConfig();
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return CMDMessageToAdmins(playerid,"UCONFIG");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

//------------------------------------------------------------------------------
CMD:forbidname(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /forbidname [nickname]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenNames.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDNAME");
		format(string, sizeof(string), "Administrator \"%s\" has added the name \"%s\" to the forbidden name list", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:forbidword(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /forbidword [word]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenWords.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDWORD");
		format(string, sizeof(string), "Administrator \"%s\" has added the word \"%s\" to the forbidden word list", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

//==========================[ Spectate Commands ]===============================

CMD:lspec(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		if(isnull(params) || !IsNumeric(params)) return SendClientMessage(playerid, red, "USAGE: /lspec [playerid]");
		new specplayerid = strval(params);
		if(PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(specplayerid) && specplayerid != INVALID_PLAYER_ID) {
			if(specplayerid == playerid) return SendClientMessage(playerid, red, "ERROR: {828282}You cannot spectate yourself");
			if(GetPlayerState(specplayerid) == PLAYER_STATE_SPECTATING && PlayerInfo[specplayerid][SpecID] != INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "Spectate: Player spectating someone else");
			if(GetPlayerState(specplayerid) != 1 && GetPlayerState(specplayerid) != 2 && GetPlayerState(specplayerid) != 3) return SendClientMessage(playerid, red, "Spectate: Player not spawned");
			if( (PlayerInfo[specplayerid][Level] != ServerInfo[MaxAdminLevel]) || (PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] == ServerInfo[MaxAdminLevel]) )	{
				StartSpectate(playerid, specplayerid);
				Spectating[playerid] = 1;
				TextDrawHideForPlayer(playerid, CountText[playerid]);
				CMDMessageToAdmins(playerid,"LSPEC");
				return SendClientMessage(playerid,blue,"Now Spectating");
			} else return SendClientMessage(playerid,red,"ERROR: {828282}You cannot spectate the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be at least level 1 to use this command");
}
CMD:ls(playerid,params[]) {
	return cmd_lspec(playerid, params);
}
CMD:lsp(playerid,params[]) {
	return cmd_lspec(playerid, params);
}
CMD:lsof(playerid, params[]) {
	return cmd_lspecoff(playerid, params);
}
CMD:lsoff(playerid, params[]) {
	return cmd_lspecoff(playerid, params);
}
CMD:lsv(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /lsv [vehicleid]");
		new specvehicleid = strval(params);
		if(specvehicleid < MAX_VEHICLES) {
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectateVehicle(playerid, specvehicleid);
			PlayerInfo[playerid][SpecID] = specvehicleid;
			PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
			CMDMessageToAdmins(playerid,"SPEC VEHICLE");
			return SendClientMessage(playerid,blue,"Now Spectating");
		} else return SendClientMessage(playerid,red, "ERROR: {828282}Invalid Vehicle ID");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be at least level 1 to use this command");
}
CMD:lspecoff(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		if(PlayerInfo[playerid][SpecType] != ADMIN_SPEC_TYPE_NONE) {
			StopSpectate(playerid);
			return SendClientMessage(playerid,blue,"No Longer Spectating");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not spectating");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be at least level 1 to use this command");
}

//==========================[ CHAT COMMANDS ]===================================

CMD:disablechat(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"DISABLECHAT");
		new string[128];
		if(ServerInfo[DisableChat] == 0) {
			ServerInfo[DisableChat] = 1;
			format(string,sizeof(string),"Administrator \"%s\" has disabled chat", pName(playerid) );
		} else {
			ServerInfo[DisableChat] = 0;
			format(string,sizeof(string),"Administrator \"%s\" has enabled chat", pName(playerid) );
		} return SendClientMessageToAll(blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 3 to use this command");
}

CMD:clearchat(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		CMDMessageToAdmins(playerid,"CLEARCHAT");
		for(new i = 0; i < 11; i++) SendClientMessageToAll(green," "); return 1;
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 2 to use this command");
}

CMD:cc(playerid,params[]) {
	 return cmd_clearchat(playerid, params);
}
CMD:caps(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /caps [playerid] [\"on\" / \"off\"]");
		new player1 = strval(tmp), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"on",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 0;
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has allowed you to use capitals in chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"You have allowed \"%s\" to use capitals in chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else if(strcmp(tmp2,"off",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 1;
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has prevented you from using capitals in chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"You have prevented \"%s\" from using capitals in chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "USAGE: /caps [playerid] [\"on\" / \"off\"]");
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

//==================[ Object & Pickup ]=========================================
CMD:pickup(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /pickup [pickup id]");
		new pickup = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
		CMDMessageToAdmins(playerid,"PICKUP");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreatePickup(pickup, 2, x+2, y, z);
		format(string, sizeof(string), "CreatePickup(%d, 2, %0.2f, %0.2f, %0.2f);", pickup, x+2, y, z);
		SaveToFile("Pickups",string);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

/*CMD:object(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /object [object id]");
		new object = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
		CMDMessageToAdmins(playerid,"OBJECT");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreateDynamicObject(object, x, y, z, 0.0, 0.0, a);
		format(string, sizeof(string), "CreateDynamicObject(%d, %0.2f, %0.2f, %0.2f, 0.00, 0.00, %0.2f);", object, x, y, z, a);
		SaveToFile("Objects",string);
		format(string, sizeof(string), "You Have Created Object %d, at %0.2f, %0.2f, %0.2f Angle %0.2f", object, x, y, z, a);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}*/

CMD:createobject(playerid,params[]) {
	 return cmd_object(playerid, params);
}

CMD:object(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /object [object id]");
		new object = strval(params), string[128], str[128], Float:x, Float:y, Float:z, Float:a;
		CMDMessageToAdmins(playerid,"OBJECT");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		new objectid = CreateDynamicObject(object, x, y, z, 0.0, 0.0, a);
		EditObject(playerid, objectid);
		format(str, sizeof(str), "Object ID: %d, Use /DestroyObject %d to remove it.", objectid, objectid);
		format(string, sizeof(string), "CreateDynamicObject(%d, %0.2f, %0.2f, %0.2f, 0.00, 0.00, %0.2f);", object, x, y, z, a);
		SaveToFile("Objects",string);
		format(string, sizeof(string), "You Have Created Object %d, at %0.2f, %0.2f, %0.2f Angle %0.2f", object, x, y, z, a);
		SendClientMessage(playerid,yellow,str);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:dobject(playerid,params[]) {
	 return cmd_destroyobject(playerid, params);
}

CMD:destroyobject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /dobject [object id]");
		new object = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
		CMDMessageToAdmins(playerid,"DESTROYOBJECT");
		DestroyDynamicObject(object);
		format(string, sizeof(string), "You Have Destroy Object %d.", object, x, y, z, a);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:editobject(playerid, params[])
{
	if(PlayerInfo[playerid][Level] <= 4) return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 5+ to use this command.");
	new object = strval(params);
	EditObject(playerid, object);
	SendClientMessage(playerid,-1,"Select (Click) The Object You Want To Edit.");
	return 1;
}
CMD:editobj(playerid,params[]) {
	 return cmd_editobject(playerid, params);
}

//===================[ Move ]===================================================

CMD:move(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /move [up / down / +x / -x / +y / -y / off]");
		new Float:X, Float:Y, Float:Z;
		if(strcmp(params,"up",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z+5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"down",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z-5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"+x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X+5,Y,Z);	}
		else if(strcmp(params,"-x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X-5,Y,Z); }
		else if(strcmp(params,"+y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y+5,Z);	}
		else if(strcmp(params,"-y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y-5,Z);	}
		else if(strcmp(params,"off",true) == 0)	{
			TogglePlayerControllable(playerid,true);	}
		else return SendClientMessage(playerid,red,"USAGE: /move [up / down / +x / -x / +y / -y / off]");
		return 1;
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:moveplayer(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp)) return SendClientMessage(playerid, red, "USAGE: /moveplayer [playerid] [up / down / +x / -x / +y / -y / off]");
		new Float:X, Float:Y, Float:Z, player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: {828282}You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"up",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z+5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"down",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z-5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"+x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X+5,Y,Z);	}
			else if(strcmp(tmp2,"-x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X-5,Y,Z); }
			else if(strcmp(tmp2,"+y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y+5,Z);	}
			else if(strcmp(tmp2,"-y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y-5,Z);	}
			else SendClientMessage(playerid,red,"USAGE: /moveplayer [up / down / +x / -x / +y / -y / off]");
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: {828282}Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

public OnPlayerUpdate(playerid)
{
	new rank = GetRankID(playerid);
	if(gRank[playerid] > rank)
	{
		new string[144];
		format(string, sizeof(string), "* You ranked down to {FFFFFF}%s", GetRankName(playerid));
		SendClientMessage(playerid, red, string);

		gRank[playerid] = rank;
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	}
	else if(gRank[playerid] < rank)
	{
		new string[144];
		format(string, sizeof(string), "* You ranked up to {FFFFFF}%s", GetRankName(playerid));
		SendClientMessage(playerid, mw_green, string);

		gRank[playerid] = rank;
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	}
	// Pause system
	if(!Callback_GetFlag(playerid, e_bUpdate))
	{
		Callback_SetFlag(playerid, e_bUpdate, true);
	}
	s_aPlayerTickInfo[playerid][e_PLAYER_LAST_UPDATE] = GetConnectedTime(playerid);

	//Auto Ejected Made by xF[4]Life
/*	new Float:HP; // FLOAT means a not integer value, such as 1.530 or 7.1
	new veh = GetPlayerVehicleID(playerid);
	GetVehicleHealth(veh,HP);
	if(HP <= 300) // means if the vehicles health is 300 or less
	{
		new AirCraft = GetVehicleModel(GetPlayerVehicleID(playerid));
		if(AirCraft == 520 || AirCraft == 447 || AirCraft == 425 || AirCraft == 460 || AirCraft == 476 || AirCraft == 487 || AirCraft == 488 || AirCraft == 497 || AirCraft == 511 || AirCraft == 512 ||  AirCraft ==513 || AirCraft == 519 || AirCraft == 548 || AirCraft == 553 || AirCraft == 563 || AirCraft == 577 || AirCraft == 592 || AirCraft == 593)
		{
			new Float:x, Float:y, Float:z; // Create the variables to store the vehicle pos
			GetVehiclePos(veh,x,y,z);
			SetPlayerPos(playerid,x,y,z+70); // SetPlayerPos to variables x and y and z + 50 values.
			GivePlayerWeapon(playerid, 46 , 1);
		}
	}*/
	return 1;
}
//----------------------------------------------------------------------------//
// 		             	/all Commands                                         //
//----------------------------------------------------------------------------//

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		new str[256];
		format(str, sizeof(str), "Command "cyellow"'%s' {FFFFFF}doesn't exist, Please look "cyellow"/help {FFFFFF}or "cyellow"/cmds {FFFFFF}for existing commands!", cmdtext);
		SendClientMessage(playerid, -1, str);
	}
	return 1;
}

CMD:spawnall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SPAWNAll");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i, 0.0, 0.0, 0.0); SpawnPlayer(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has spawned all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:muteall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"MUTEALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 1; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has muted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:unmuteall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"UNMUTEAll");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 0; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unmuted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:getall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"GETAll");
		new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
		GetPlayerPos(playerid,x,y,z);
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i,x+(playerid/4)+1,y+(playerid/4),z); SetPlayerInterior(i,interior);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has teleported all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}
CMD:healall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"HEALALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has healed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 3 to use this command");
}

CMD:armourall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"ARMOURALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerArmour(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has restored all players armour", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 3 to use this command");
}

CMD:killall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"KILLALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,0.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has killed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:freezeall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"FREEZEALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
		if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(i,false); PlayerInfo[i][Frozen] = 1;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has frozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:unfreezeall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"UNFREEZEALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(i,true); PlayerInfo[i][Frozen] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unfrozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}


CMD:kickall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"KICKALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetTimerEx("KickTimer", 1000, false, "d", i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has kicked all players", pName(playerid) );
		SaveToFile("KickLog",string);
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:slapall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SLAPALL");
		new Float:x, Float:y, Float:z;
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	SetPlayerPos(i,x,y,z+4);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has slapped all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:explodeall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"EXPLODEALL");
		new Float:x, Float:y, Float:z;
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	CreateExplosion(x, y , z, 7, 10.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has exploded all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:disarmall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"DISARMALL");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); ResetPlayerWeapons(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has disarmed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}

CMD:ejectall(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"EJECTALL");
		new Float:x, Float:y, Float:z;
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				if(IsPlayerInAnyVehicle(i)) {
					PlayerPlaySound(i,1057,0.0,0.0,0.0); GetPlayerPos(i,x,y,z); SetPlayerPos(i,x,y,z+3);
				}
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has ejected all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 4 to use this command");
}
//-------------==== Set All Commands ====-------------//

CMD:setallwanted(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallwanted [wanted level]");
		new var = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETALLWANTED");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWantedLevel(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players wanted level to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setallweather(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallweather [weather ID]");
		new var = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETALLWEATHER");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWeather(i, var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players weather to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setalltime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setalltime [hour]");
		new var = strval(params), string[128];
		if(var > 24) return SendClientMessage(playerid, red, "ERROR: {828282}Invalid hour");
		CMDMessageToAdmins(playerid,"SETALLTIME");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerTime(i, var, 0);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players time to '%d:00'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setallworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallworld [virtual world]");
		new var = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETALLWORLD");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerVirtualWorld(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players virtual worlds to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:astream(playerid,params[])
{
 if(PlayerInfo[playerid][Level] >= 3) {
 if(isnull(params)) return SendClientMessage(playerid,  0x33CCFFAA, "Usage: /astream [Url]");
  for(new i;i<MAX_PLAYERS;i++)
  {
	PlayAudioStreamForPlayer(i, params);
	SendClientMessage(i, 0x33CCFFAA, "An Administrator Has Started Music!");
	SendClientMessage(i, 0x33CCFFAA, "To Stop The Music Use /Radiostop");
  }
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
  return 1;
}
//Admin Stop Stream
CMD:astop(playerid,params[])
{
  if(PlayerInfo[playerid][Level] >= 3) {
  for(new i;i<MAX_PLAYERS;i++)
  {
	StopAudioStreamForPlayer(i);
	SendClientMessage(i, 0xFF0000FF,"An administrator Has Stopped The Music!");
  }
  } else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
  return 1;
}

CMD:setallscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallscore [score]");
		new var = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETALLSCORE");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerScore(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players scores to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:setallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallcash [Amount]");
		new var = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETALLCASH");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				ResetPlayerMoney(i);
				GiveCODMoney(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players cash to '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:giveallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /giveallcash [Amount]");
		new var = strval(params), string[128];
		CMDMessageToAdmins(playerid,"GIVEALLCASH");
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				GiveCODMoney(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has given all players '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

CMD:givecash(playerid, params[])
{
	new
		giveplayerid,
		amount;
	if (sscanf(params, "ud", giveplayerid, amount)) SendClientMessage(playerid, 0xFF0000AA, "Usage: /givecash [playerid/partname] [amount]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, 0xFF0000AA, "Player not found");
	GiveCODMoney(giveplayerid, amount);
	GiveCODMoney(playerid, -amount);
	new string[128];
	format(string,sizeof(string),"\"%s\" has given you '$%d'", pName(playerid), amount );
	SendClientMessage(giveplayerid, blue, string);
	format(string, sizeof(string),"You have given \"%s\" $%d", pName(giveplayerid), amount );
	SendClientMessage(playerid, blue, string);
	return 1;
}


CMD:giveallweapon(playerid,params[])
{
	if(PlayerInfo[playerid][Level] < 4) return SendClientMessage(playerid, red, "ERROR: {828282}You are not high enough level to use this command");
	new weapon[32], ammo, string[128];
	if(sscanf(params, "s[32]i(250)", weapon, ammo)) return SendClientMessage(playerid, red, "Usage: /giveallweapon [weapon name] [ammo]");
	CMDMessageToAdmins(playerid,"GIVEALLWEAPON");

	new weaponid;
	GetWeaponName(weaponid, weapon, sizeof(weapon));
	weaponid = GetWeaponIDFromName(weapon);
	if (weaponid == 38 || weaponid == 36) return SendClientMessage(playerid, red, "ERROR:{828282} Minigun and Heatseeker aren't allowed");
	if (1 > weaponid > 46) return SendClientMessage(playerid, red, "ERROR:{828282} Invalid weapon id/name.");

	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		GivePlayerWeapon(i, weaponid, ammo);
	}
	format(string, sizeof(string), "Administrator %s has given all players weapon: %d with %d ammo", pName(playerid), weaponid, ammo);
	SendClientMessageToAll(blue, string);
	return 1;
}
//================================[ Menu Commands ]=============================

CMD:lmenu(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
	TogglePlayerControllable(playerid,false);
		if(IsPlayerInAnyVehicle(playerid)) {
		return ShowMenuForPlayer(LMainMenu,playerid);
		} else return ShowMenuForPlayer(LMainMenu,playerid);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:ltele(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(IsPlayerInAnyVehicle(playerid)) {
		TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LTele,playerid);
		} else return ShowMenuForPlayer(LTele,playerid);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:lweather(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		if(IsPlayerInAnyVehicle(playerid)) {
		TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LWeather,playerid);
		} else return ShowMenuForPlayer(LWeather,playerid);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:ltime(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		if(IsPlayerInAnyVehicle(playerid)) {
		TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LTime,playerid);
		} else return ShowMenuForPlayer(LTime,playerid);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:sv( playerid, params[ ] )
{
  if(PlayerInfo[playerid][Level] >= 1)
  {
	static
		vehID
	;

	if ( sscanf( params, "d",  vehID ) )
		return SendClientMessage( playerid, red, "SYNTAX: /sv < vehID >" );

	if ( vehID == INVALID_VEHICLE_ID )
		return SendClientMessage( playerid, red, "ERROR: {828282}Invalid vehicle ID." );

	SetVehicleToRespawn( vehID );

	SendClientMessage( playerid, red, "Vehicle has been respawned succesfully." );
  }
  return 1;
}
CMD:dv(playerid, params[])
{
if(PlayerInfo[playerid][Level] >= 1) {
static
vehID
;
if ( sscanf( params, "d",  vehID ) )
return SendClientMessage( playerid, red, "SYNTAX: /dv < vehID >" );

if ( vehID == INVALID_VEHICLE_ID )
return SendClientMessage( playerid, red, "ERROR: {828282}Invalid vehicle ID." );

DestroyVehicle(vehID);
}
return 1;
}
CMD:cm(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: {828282}You already have a car.");
		else { ShowMenuForPlayer(LCars,playerid); return TogglePlayerControllable(playerid,false);  }
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:ltmenu(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(IsPlayerInAnyVehicle(playerid)) {
		new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
		switch(LModel) { case 448,461,462,463,468,471,509,510,521,522,523,581,586,449: return SendClientMessage(playerid,red,"ERROR: {828282}You can not tune this vehicle!"); }
		TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LTuneMenu,playerid);
		} else return SendClientMessage(playerid,red,"ERROR: {828282}You do not have a vehicle to tune");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:lweapons(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		if(IsPlayerInAnyVehicle(playerid)) {
		TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(XWeapons,playerid);
		} else return ShowMenuForPlayer(XWeapons,playerid);
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}
CMD:lvehicle(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: {828282}You already have a car.");
		else { ShowMenuForPlayer(LVehicles,playerid); return TogglePlayerControllable(playerid,false);  }
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

stock GetName(playerid)
{
	new pnameid[24];
	GetPlayerName(playerid,pnameid,24);
	return pnameid;
}
stock SendCMDMessge(playerid,command[])
{
	if(ServerInfo[AdminCmdMsg] == 0) return 1;
	new string[128]; new str[128]; GetPlayerName(playerid,string,sizeof(string));
	new year,month,day,hour,minute,second; getdate(year, month, day); gettime(hour,minute,second);
	format(str,sizeof(str),"[DONOR] %s used command %s on %d/%d/%d at %d:%d:%d",GetName(playerid),command, day, month, year, hour, minute, second);
	SaveToFile("CMDLog",str);
	format(string,sizeof(string),""cblue"[DONOR] %s has used command "cred"%s",string,command);
	return MessageToAdmins(lightblue,string);
}

GiveAmmo(playerid)
{
	new slot, ammo;
	new weaponid = GetPlayerWeapon(playerid);
	for (slot = 0; slot < 14; slot++)
	{
		GetPlayerWeaponData(playerid, slot, weaponid, ammo);
		if(IsValidWeapon(weaponid)) //
		{
			if(weaponid == 16 || weaponid == 35 || weaponid == 18 || weaponid == 22 || weaponid == 17 || weaponid == 2 || weaponid == 46)
			{
				GivePlayerWeapon(playerid, weaponid, 1);
			}
			else GivePlayerWeapon(playerid, weaponid, random(50 - 50) + 50);
		}
	}
	return 1;
}

CMD:stats(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0x00B9FFFF, "Use /stats [player name/id] to view another player's stats!"),
	ShowPlayerStats(playerid, playerid);
	if(!IsPlayerConnected(id)) return  SendClientMessage(playerid, red, "ERROR: {828282}You have entered an invalid player name/id!");
	ShowPlayerStats(playerid, id);
	return 1;
}

stock ShowPlayerStats(playerid, targetid)
{
	new TempStr[500], h, m, s;
	TotalGameTime(playerid, h, m, s);

	strcat(TempStr, "{FFFFFF}Name: %s (%d)\n");
	strcat(TempStr, "{FFFFFF}Score: %d\n");
	strcat(TempStr, "{FFFFFF}Money: %d\n");
	strcat(TempStr, "{FFFFFF}Rank: %s\n");
	strcat(TempStr, "{FFFFFF}Team: %s\n");
	strcat(TempStr, "{FFFFFF}Kills: %d\n");
	strcat(TempStr, "{FFFFFF}Deaths: %d\n");
	strcat(TempStr, "{FFFFFF}Headshots: %d\n");
	strcat(TempStr, "{FFFFFF}Prototypes: %d\n");
	strcat(TempStr, "{FFFFFF}Bonus Kills: %d\n");
	strcat(TempStr, "{FFFFFF}K/D Ratio: %d\n");
	strcat(TempStr, "{FFFFFF}Admin: %d\n");
	strcat(TempStr, "{FFFFFF}VIP: %d\n");
	strcat(TempStr, "{FFFFFF}Total Time Playing: %d hrs %d mins %d secs\n");

	format(TempStr, sizeof TempStr, TempStr, pName(targetid), targetid, GetPlayerScore(targetid), GetCODMoney(targetid), GetRankName(targetid),GetTeamName(targetid),
	PlayerInfo[targetid][Kills], PlayerInfo[targetid][Deaths], PlayerInfo[targetid][Headshots], PlayerInfo[targetid][BonusKills], PlayerInfo[targetid][Proto],
	floatdiv(float(PlayerInfo[targetid][Kills]), float(PlayerInfo[targetid][Deaths])), PlayerInfo[targetid][Level], PlayerInfo[targetid][VIP], h, m, s);
	ShowPlayerDialog(playerid, 7182, DIALOG_STYLE_MSGBOX, "Player Stats", TempStr, "Okay", "");
	return 1;
}

/*CMD:stats(playerid,params[])
{
	new Strings[100], pDeaths, player1, playername[MAX_PLAYER_NAME], h, m, s;
	TotalGameTime(playerid, h, m, s);

	if(isnull(params)) player1 = playerid;
	else player1 = strval(params);

	if(IsPlayerConnected(player1))
	{
		GetPlayerName(player1, playername, sizeof(playername));
		if(PlayerInfo[player1][Deaths] == 0) pDeaths = 1; else pDeaths = PlayerInfo[player1][Deaths];

		new Stats[4000] = "%s";

		format(Strings, sizeof(Strings), "\n{D3D3D3}Name{5AF566}\t  :%s \n%s", GetName(player1), "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);Strings = "";

		format(Strings, sizeof(Strings), "{D3D3D3}Team\t  :%s \n\n%s",GetTeamName(player1),"%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);Strings = "";

		format(Strings, sizeof(Strings), "{D3D3D3}Score{E7EA66}\t  :%i \n%s", GetPlayerScore(player1), "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);Strings = "";

		format(Strings, sizeof(Strings), "{D3D3D3}Money{14C521}\t  :%i  \n\n%s", GetCODMoney(player1), "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);Strings = "";

		format(Strings, sizeof(Strings), "{D3D3D3}Rank{71AEF2}\t  :%s \n%s",GetRankName(player1), "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Class{8673F0}\t  :%s \n\n%s",GetClass(player1), "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Kills{50ED5B}\t  :%i \n%s",PlayerInfo[player1][Kills], "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Death{EA4313}\t  :%i \n\n%s",PlayerInfo[player1][Deaths], "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Headshots{EA4313}\t:%i \n\n%s",PlayerInfo[player1][Headshots], "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Bonus Kills{EA4313}\t:%i \n\n%s",PlayerInfo[player1][BonusKills], "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Ratio{EA4313}\t  :%0.2f \n\n%s",Float:PlayerInfo[player1][Kills]/Float:pDeaths, "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Admin{EA4313}\t  :%i \n\n%s",PlayerInfo[player1][Level], "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Donor{EA4313}\t  :%i \n\n%s",PlayerInfo[player1][VIP], "%s");
		format(Stats,   sizeof(Stats),   Stats,   Strings);

		format(Strings, sizeof(Strings), "{D3D3D3}Total Time Played{EA4313}\t  :%i \n\n%s",PlayerInfo[player1][TotalTime], "%s");

//	    format(Stats, sizeof(Stats), Stats, "");
		ShowPlayerDialog(playerid, 200, DIALOG_STYLE_MSGBOX, "{FFFF00}Stats", Stats, "Close", "");
	}
	else return SendClientMessage(playerid, red, "Player Not Connected!");
	return 1;
}*/

CMD:changepass(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /changepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		dUserSetINT(pName(playerid)).("password_hash",udb_hash(params) );
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		format(string, sizeof(string),"ACCOUNT: You have successfully changed your password to \"%s\"",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: {828282}You must have an account to use this command");
}

CMD:setname(playerid, params[])
{
		if(PlayerInfo[playerid][Level] >= 4)	{
		new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setname [playerid] [new name]");
		if (udb_Exists(tmp2)) return SendClientMessage(playerid,red,"This User Name Is Taken!");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][LoggedIn] == 0) return SendClientMessage(playerid,red,"Player Must Have Account!");
		new OldName[24],str[128];
		GetPlayerName(player1,OldName,sizeof(OldName));
		format(str,sizeof(str),"ladmin/users/%s.sav",OldName);
		udb_RenameUser(OldName,tmp2);
		format(str,sizeof(str),"ladmin/users/%s.sav",params);
		SetPlayerName(player1,tmp2);
		PlayerPlaySound(player1,1057,0.0,0.0,0.0);
		format(string, sizeof(string),"Admin ''%s'' Has Changed Your Name To '%s'",pName(playerid), tmp2);
		return SendClientMessage(player1,yellow,string);
	}   else return SendClientMessage(playerid,red, "ERROR: {828282}Only Level +4 can Use This Command");
}
CMD:changename(playerid, params[])
{
		if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /changename [new Name]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		if (udb_Exists(params)) return SendClientMessage(playerid,red,"This User Name Is Taken!");
		if(GetCODMoney(playerid) < 50000) return SendClientMessage(playerid, red,"You need to have $50000 to change name");
		new nameee[24];  GetPlayerName(playerid, nameee, 16);
		new OldName[24],str[128];
		GetPlayerName(playerid,OldName,sizeof(OldName));
		format(str,sizeof(str),"ladmin/users/%s.sav",OldName);
		udb_RenameUser(OldName,params);
		format(str,sizeof(str),"ladmin/users/%s.sav",params);
		SetPlayerName(playerid,params);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		new string[128];
		GiveCODMoney(playerid, -50000);
		format(string, sizeof(string),"ACCOUNT: You have successfully changed your Name to \"%s\"",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: {828282}You must have an account to use this command");
}
CMD:setpass(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
		new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: {828282}Incorrect password length");
		if(udb_Exists(tmp)) {
			dUserSetINT(tmp).("password_hash", udb_hash(tmp2));
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: {828282}This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
}

stock LoginPlayer(playerid)
{
	dUserSetINT(pName(playerid)).("loggedin",1);
	PlayerInfo[playerid][Deaths] = (dUserINT(pName(playerid)).("deaths"));
	PlayerInfo[playerid][Kills] = (dUserINT(pName(playerid)).("kills"));
	PlayerInfo[playerid][Level] = (dUserINT(pName(playerid)).("level"));
	PlayerInfo[playerid][hours] = dUserINT(pName(playerid)).("hours");
	PlayerInfo[playerid][mins] = dUserINT(pName(playerid)).("minutes");
	PlayerInfo[playerid][secs] = dUserINT(pName(playerid)).("seconds");
	PlayerInfo[playerid][pRegAch] = dUserINT(pName(playerid)).("RegAch");
	PlayerInfo[playerid][pKillAch] = dUserINT(pName(playerid)).("KillAch");
	PlayerInfo[playerid][pAssAch] = dUserINT(pName(playerid)).("AssAch");
	PlayerInfo[playerid][pOwnAch] = dUserINT(pName(playerid)).("OwnAch");
	PlayerInfo[playerid][pPtAch] = dUserINT(pName(playerid)).("PtAch");
	PlayerInfo[playerid][pHsAch] = dUserINT(pName(playerid)).("HsAch");
	PlayerInfo[playerid][pAchs] = dUserINT(pName(playerid)).("Achs");
	SetPlayerScore(playerid,dUserINT(pName(playerid)).("Score"));
	PlayerInfo[playerid][Money] = dUserINT(pName(playerid)).("money");
	PlayerInfo[playerid][VIP] = (dUserINT(pName(playerid)).("Donor"));
	PlayerInfo[playerid][Proto] = (dUserINT(pName(playerid)).("Proto"));
	PlayerInfo[playerid][Registered] = 1;
	PlayerInfo[playerid][LoggedIn] = 1;
	return 1;
}

//==============================================================================
public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success)
	{
		new playersIP[17], playerid;

		for(; playerid < MAX_PLAYERS; playerid++)
		{
			GetPlayerIp(playerid, playersIP, 17);
			if(!strcmp(ip, playersIP))
			{
				break;
			}
		}

		rconAttempts[playerid]+= 1;

		if(rconAttempts[playerid] >= 3)
		{
			Ban(playerid);
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][Level] < 1) return
		SendClientMessage(playerid,red,"You cannot use commands in jail");
	if(PlayerInfo[playerid][Level] < 1)
	{
		new TCount[MAX_PLAYERS], string[128];
		TCount[playerid] += 1;
		switch(TCount[playerid])
		{
			case 3:
			{
				SendClientMessage(playerid, red, "* Don't spam commands");
				return 0;
			}
			case 5:
			{
				format(string, sizeof(string), "%s (%d) was auto kicked (Reason: Exceeded Command Spam Warning)", pName(playerid), playerid);
				SendClientMessageToAll(grey, string);
				SetTimerEx("KickTimer", 1000, false, "d", playerid);
				return 0;
			}
		}
		SetTimerEx("ResetCommandCount", SpamLimit, false, "d", playerid);
	}

	new string[128];
	if(ServerInfo[ReadCmds] == 1)
	{
		format(string, sizeof(string), "*** %s (%d) typed: %s", pName(playerid),playerid,cmdtext);
		for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
			if(IsPlayerConnected(i)) {
				if( (PlayerInfo[i][Level] > PlayerInfo[playerid][Level]) && (PlayerInfo[i][Level] > 6) && (i != playerid) ) {
					SendClientMessage(i, grey, string);
				}
			}
		}
	}


//========================= [ Car Commands ]====================================

	if(strcmp(cmdtext, "/ltunedcar2", true)==0 || strcmp(cmdtext, "/ltc2", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,1);
		SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = LVehicleIDt;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar3", true)==0 || strcmp(cmdtext, "/ltc3", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,2);
		SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = LVehicleIDt;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar4", true)==0 || strcmp(cmdtext, "/ltc4", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(559,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1065);    AddVehicleComponent(carid,1067);    AddVehicleComponent(carid,1162); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073);	ChangeVehiclePaintjob(carid,1);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar5", true)==0 || strcmp(cmdtext, "/ltc5", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(565,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1046); AddVehicleComponent(carid,1049); AddVehicleComponent(carid,1053); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar6", true)==0 || strcmp(cmdtext, "/ltc6", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1088); AddVehicleComponent(carid,1092); AddVehicleComponent(carid,1139); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar7", true)==0 || strcmp(cmdtext, "/ltc7", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(561,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1055); AddVehicleComponent(carid,1058); AddVehicleComponent(carid,1064); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar8", true)==0 || strcmp(cmdtext, "/ltc8", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1034); AddVehicleComponent(carid,1038); AddVehicleComponent(carid,1147); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar9", true)==0 || strcmp(cmdtext, "/ltc9", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(567,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1102); AddVehicleComponent(carid,1129); AddVehicleComponent(carid,1133); AddVehicleComponent(carid,1186); AddVehicleComponent(carid,1188); ChangeVehiclePaintjob(carid,1); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1085); AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1086);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar10", true)==0 || strcmp(cmdtext, "/ltc10", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1092); AddVehicleComponent(carid,1166); AddVehicleComponent(carid,1165); AddVehicleComponent(carid,1090);
		AddVehicleComponent(carid,1094); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1163);//SPOILER
		AddVehicleComponent(carid,1091); ChangeVehiclePaintjob(carid,2);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar11", true)==0 || strcmp(cmdtext, "/ltc11", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(557,X,Y,Z,Angle,1,1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1081);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar12", true)==0 || strcmp(cmdtext, "/ltc12", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(535,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		ChangeVehiclePaintjob(carid,1); AddVehicleComponent(carid,1109); AddVehicleComponent(carid,1115); AddVehicleComponent(carid,1117); AddVehicleComponent(carid,1073); AddVehicleComponent(carid,1010);
		AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1114); AddVehicleComponent(carid,1081); AddVehicleComponent(carid,1119); AddVehicleComponent(carid,1121);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar13", true)==0 || strcmp(cmdtext, "/ltc13", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,red,"ERROR: {828282}You already have a vehicle");
		else {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		carid = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1034); AddVehicleComponent(carid,1038); AddVehicleComponent(carid,1147);
		AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,0);
		SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: {828282}You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
	return 1;
}

forward ResetCount(playerid);
public ResetCount(playerid)
{
	SetPVarInt(playerid, "TextSpamCount", 0);
}
forward ResetCommandCount(playerid);
public ResetCommandCount(playerid)
{
	SetPVarInt(playerid, "CommandSpamCount", 0);
}

//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	for(new x, l = GetPlayerPoolSize(); x <= l; x++)
	{
		if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
		{
			TogglePlayerSpectating(x, 1);
			PlayerSpectateVehicle(x, vehicleid);
			PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
		}
	}
	VID[playerid] = vehicleid;
	SetPlayerArmedWeapon(playerid, 0);
	if(! ispassenger)//if the player is entering as a driver
	{
		new target = INVALID_PLAYER_ID;//by default, an invalid player
		for(new i; i < MAX_PLAYERS; i++)
		{
			if( i != playerid && IsPlayerConnected(i) && GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == 0)
			{
				target = i;//store the playerid in "target" variable
				continue;//stop the loop and continue
			}
		}
		if(target != INVALID_PLAYER_ID && gTeam[playerid] == gTeam[target])
		{
			ClearAnimations(playerid);//clear all animations of player that were being runned

			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);//store player position coords
			SetPlayerPos(playerid, x, y, z+5);//a sort of eject system, simply sets player height!

			GameTextForPlayer(playerid, "~r~Don't jack your Team vehicle", 3000, 3);//a warning gametext to player
			return 0;//stop the player to take over the vehicle and the action to be taken
		}
	}
	VID[playerid] = vehicleid;
	if(PlayerInfo[playerid][OnDuty] == 1)
	{
		if(vehicleid == USApro || AUSpro || EURpro || SOVpro || ARBpro)
		{
			Slap(playerid);
			SendClientMessage(playerid, red, "ERROR: {828282}You Can't Steal Prototype Vehicles While You Are On Admin Duty");
		}
	}
	else
	{
		if(HV == 0)
		{
			if((GetVehicleModel(vehicleid) == 432 || 447 || 520 || 425))
			{
				Slap(playerid);
				SendClientMessage(playerid,red,"ERROR: {828282}Its No Heavy Vehicles Week");
			}
		}
	}
	if(Captured[SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1) LeavingSnakeFarm(playerid);
	if(Captured[BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1) LeavingBay(playerid);
	if(Captured[A51] == 0 && IsPlayerCapturing[playerid][A51] == 1)	LeavingArea51(playerid);
	if(Captured[ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1) LeavingArmy(playerid);
	if(Captured[PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1) LeavingPetrol(playerid);
	if(Captured[OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1)	LeavingOil(playerid);
	if(Captured[DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1) LeavingDesert(playerid);
	if(Captured[QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1) LeavingQuarry(playerid);
	if(Captured[GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1) LeavingGuest(playerid);
	if(Captured[EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1) LeavingEar(playerid);
	if(Captured[DA] == 0 && IsPlayerCapturing[playerid][DA] == 1) LeavingAirport(playerid);
	if(Captured[AMMU] == 0 && IsPlayerCapturing[playerid][AMMU] == 1) LeavingAmmunation(playerid);
	if(Captured[DAM] == 0 && IsPlayerCapturing[playerid][DAM] == 1) LeavingDam(playerid);
	if(Captured[BELL] == 0 && IsPlayerCapturing[playerid][BELL] == 1) LeavingBell(playerid);
	if(Captured[RUSTY] == 0 && IsPlayerCapturing[playerid][RUSTY] == 1) LeavingRusty(playerid);
	if(Captured[GHOST] == 0 && IsPlayerCapturing[playerid][GHOST] == 1) LeavingGhost(playerid);
	if(Captured[HOSP] == 0 && IsPlayerCapturing[playerid][HOSP] == 1) LeavingHospital(playerid);
	if(Captured[VILLA] == 0 && IsPlayerCapturing[playerid][VILLA] == 1) LeavingVilla(playerid);
	if(Captured[BIOSHIP] == 0 && IsPlayerCapturing[playerid][BIOSHIP] == 1) LeavingBioShip(playerid);
	if(Captured[CERBERUS] == 0 && IsPlayerCapturing[playerid][CERBERUS] == 1) LeavingCerberus(playerid);
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_VEHICLE)//if the bullet hits a vehicle
	{
		new target = INVALID_PLAYER_ID;//by default, an invalid player
		for(new i, l = GetPlayerPoolSize(); i <= l; i++)
		{
			if( i != playerid//if the loop case is not matching the playerid
			&& IsPlayerConnected(i)//if the player is connected
			&& GetPlayerVehicleID(i) == hitid//if the player is in vehicle that got hit
			&& GetPlayerVehicleSeat(i) == 0)//if is driver
			{
				target = i;//store the playerid in "target" variable
				continue;//stop the loop and continue
			}
		}
		if( target != INVALID_PLAYER_ID && GetPlayerTeam(playerid) != NO_TEAM && GetPlayerTeam(playerid) == GetPlayerTeam(target))
		{
			GameTextForPlayer(playerid, "~r~Don't attack a Team vehicle", 3000, 3);
			return 0;
		}
	}
	return 1;
}

//==============================================================================

stock Slap(playerid)
{
   new Float:x, Float:y, Float:z;
   GetPlayerPos(playerid, x, y, z); SetPlayerPos(playerid,x,y,z+1);
   return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerInfo[playerid][OnDuty] != 0)
	{
		DisablePlayerCheckpoint(playerid);
		TogglePlayerAllDynamicCPs(playerid, 1);
		return 0;
	}
	if(IsPrototyping{ playerid })
	{
		new vehicle;
		vehicle = GetPlayerVehicleID(playerid);
		SetVehicleToRespawn(vehicle);
		SendClientMessage(playerid, COLOR_GREEN, "You have Captured the Prototype and got +10 Score!");
		GivePlayerScore(playerid,10);
		IsPrototyping{ playerid } = false;
		DisablePlayerCheckpoint(playerid);
		TogglePlayerAllDynamicCPs(playerid, 1);
		PlayerInfo[playerid][Proto] += 1;
		if(PlayerInfo[playerid][Proto] > 10 && PlayerInfo[playerid][pPtAch] == 0)
		{
			PlayerInfo[playerid][pPtAch] = 1;
			PlayerInfo[playerid][pAchs] += 1;
			PlayerTextDrawSetString(playerid, AchTD3, "~y~Achievement Name: ~w~Prototype.");
			PlayerTextDrawSetString(playerid, AchTD4, "~y~Reward: ~w~10 score.");
			PlayerTextDrawSetString(playerid, AchTD5, "~y~Achievement Info: ~w~Capture ten prototypes.");
			ShowAchievementTextdraws(playerid);
			GivePlayerScore(playerid, 10);
		}
	}
	return 1;
}

//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && GetPlayerState(playerid) != PLAYER_STATE_SPAWNED && GetPlayerState(playerid) != PLAYER_STATE_WASTED)
	{
		s_aPlayerTickInfo[playerid][e_PLAYER_TICK] = GetConnectedTime(playerid);
	}
	switch(newstate)
	{
		case PLAYER_STATE_ONFOOT:
		{
			switch(oldstate)
			{
				case PLAYER_STATE_DRIVER: OnPlayerExitVehicle(playerid,255);
				case PLAYER_STATE_PASSENGER: OnPlayerExitVehicle(playerid,255);
			}
		}
	}
	new AirCraft = GetVehicleModel(GetPlayerVehicleID(playerid));
	if(AirCraft == 520 || AirCraft == 447 || AirCraft == 425 || AirCraft == 460 || AirCraft == 476 || AirCraft == 487 || AirCraft == 488 || AirCraft == 497 || AirCraft == 511 || AirCraft == 512 ||  AirCraft ==513 || AirCraft == 519 || AirCraft == 548 || AirCraft == 469 || AirCraft == 553 || AirCraft == 563 || AirCraft == 577 || AirCraft == 592 || AirCraft == 593)
	{
		SendClientMessage(playerid,-1,""cgrey"*Press 'Y' To Eject Your Self.");
	}
	new protomsg[512];
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);

	if(newstate == PLAYER_STATE_DRIVER)
	{
		SetPlayerArmedWeapon(playerid, 0);

		if(IsPlayerInVehicle(playerid, AUSpro))
		{
			switch(gTeam[playerid])
			{
				case TEAM_AUS:
				{
					SetPlayerPos(playerid,x,y,z+2.0);
					SendClientMessage(playerid, red,"ERROR: {828282}You Can Not Capture Your Team's Prototype");
					RemovePlayerFromVehicle(playerid);
				}
				case TEAM_EUROPE:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, 924.0835,2148.2048,10.8897,6.00);
					GameTextForPlayer(playerid, " ~n~ ~p~Australian Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team AUSTRALIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_USA:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-166.6327,2730.4194,61.8426,6.00);
					GameTextForPlayer(playerid, " ~n~ ~p~Australian Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team AUSTRALIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_ARAB:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-819.7584,1514.5851,20.2911,6.00);
					GameTextForPlayer(playerid, " ~n~ ~p~Australian Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team AUSTRALIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_SOVIET:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, -172.1217,1078.3591,19.7422,6.00);
					GameTextForPlayer(playerid, " ~n~ ~p~Australia Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team AUSTRALIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
			}
		}

		if(IsPlayerInVehicle(playerid, SOVpro))
		{
			switch(gTeam[playerid])
			{
				case TEAM_SOVIET:
				{
					SetPlayerPos(playerid,x,y,z+2.0);
					SendClientMessage(playerid, red,"ERROR: {828282}You Can Not Capture Your Team's Prototype");
					RemovePlayerFromVehicle(playerid);
				}
				case TEAM_EUROPE:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, 924.0835,2148.2048,10.8897,6.00);
					GameTextForPlayer(playerid, " ~n~ ~r~~h~Soviet Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team SOVIET's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_USA:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-166.6327,2730.4194,61.8426,6.00);
					GameTextForPlayer(playerid, " ~n~ ~r~~h~Soviet Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team SOVIET's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_ARAB:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-819.7584,1514.5851,20.2911,6.00);
					GameTextForPlayer(playerid, " ~n~ ~r~~h~Soviet Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team SOVIET's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_AUS:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-1515.5267,2537.0479,55.1647,6.00);
					GameTextForPlayer(playerid, " ~n~ ~r~~h~Soviet Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team SOVIET's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
			}
		}

		if(IsPlayerInVehicle(playerid, ARBpro))
		{
			switch(gTeam[playerid])
			{
				case TEAM_ARAB:
				{
					SetPlayerPos(playerid,x,y,z+2.0);
					SendClientMessage(playerid, red,"ERROR: {828282}You Can Not Capture Your Team's Prototype");
					RemovePlayerFromVehicle(playerid);
				}
				case TEAM_EUROPE:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, 924.0835,2148.2048,10.8897,6.00);
					GameTextForPlayer(playerid, " ~n~ ~y~~h~Arabia Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team ARABIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_USA:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-166.6327,2730.4194,61.8426,6.00);
					GameTextForPlayer(playerid, " ~n~ ~y~~h~Arabia Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team ARABIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_SOVIET:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, -172.1217,1078.3591,19.7422,6.00);
					GameTextForPlayer(playerid, " ~n~ ~y~~h~Arabia Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team ARABIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_AUS:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-1515.5267,2537.0479,55.1647,6.00);
					GameTextForPlayer(playerid, " ~n~ ~y~~h~Arabia Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team ARABIA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
			}
		}

		if(IsPlayerInVehicle(playerid, EURpro))
		{
			switch(gTeam[playerid])
			{
				case TEAM_EUROPE:
				{
					SetPlayerPos(playerid,x,y,z+2.0);
					SendClientMessage(playerid, red,"ERROR: {828282}You Can Not Capture Your Team's Prototype");
					RemovePlayerFromVehicle(playerid);
				}
				case TEAM_USA:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-166.6327,2730.4194,61.8426,6.00);
					GameTextForPlayer(playerid, " ~n~ ~g~~h~Europe Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team EUROPE's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_SOVIET:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, -172.1217,1078.3591,19.7422,6.00);
					GameTextForPlayer(playerid, " ~n~ ~g~~h~Europe Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team EUROPE's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_ARAB:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-819.7584,1514.5851,20.2911,6.00);
					GameTextForPlayer(playerid, " ~n~ ~g~~h~Europe Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team EUROPE's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_AUS:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-1515.5267,2537.0479,55.1647,6.00);
					GameTextForPlayer(playerid, " ~n~ ~g~~h~Europe Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team EUROPE's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
			}
		}

		if(IsPlayerInVehicle(playerid, USApro))
		{
			switch(gTeam[playerid])
			{
				case TEAM_USA:
				{
					SetPlayerPos(playerid,x,y,z+2.0);
					SendClientMessage(playerid, red,"ERROR: {828282}You Can Not Capture Your Team's Prototype");
					RemovePlayerFromVehicle(playerid);
				}
				case TEAM_EUROPE:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, 924.0835,2148.2048,10.8897,6.00);
					GameTextForPlayer(playerid, " ~n~ ~b~~h~USA Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team USA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_SOVIET:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid, -172.1217,1078.3591,19.7422,6.00);
					GameTextForPlayer(playerid, " ~n~ ~b~~h~USA Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team USA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_ARAB:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-819.7584,1514.5851,20.2911,6.00);
					GameTextForPlayer(playerid, " ~n~ ~b~~h~USA Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team USA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
				case TEAM_AUS:
				{
					TogglePlayerAllDynamicCPs(playerid, 0);
					SetPlayerCheckpoint(playerid,-1515.5267,2537.0479,55.1647,6.00);
					GameTextForPlayer(playerid, " ~n~ ~b~~h~USA Prototype~n~~w~Go To Your Base", 3000, 6);
					IsPrototyping{playerid } = true;
					format(protomsg, sizeof(protomsg),"%s Is Trying To Capture Team USA's Prototype! Stop Him", pName(playerid));
					SendClientMessageToAll(0x9B4520FF,protomsg);
				}
			}
		}
	}
	return 1;
}

//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerInfo[playerid][DoorsLocked] == 1) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,false,false);

	if(IsPrototyping{ playerid })
	{
		DisablePlayerCheckpoint(playerid);
		TogglePlayerAllDynamicCPs(playerid, 1);
		IsPrototyping{playerid } = false;
		SendClientMessage(playerid, red, "ERROR: {828282}You have failed to capture the prototype.");
	}

	for(new x=0; x<MAX_PLAYERS; x++) {
		if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_VEHICLE) {
			TogglePlayerSpectating(x, 1);
			PlayerSpectatePlayer(x, playerid);
			PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
		}
	}

	return 1;
}

stock StartSpectate(playerid, specplayerid)
{
	for(new x=0; x<MAX_PLAYERS; x++) {
		if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
		   AdvanceSpectate(x);
		}
	}
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	TogglePlayerSpectating(playerid, 1);

	if(IsPlayerInAnyVehicle(specplayerid)) {
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	else {
		PlayerSpectatePlayer(playerid, specplayerid);
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
	}
	new string[100], Float:hp, Float:ar;
	GetPlayerName(specplayerid,string,sizeof(string));
	GetPlayerHealth(specplayerid, hp);	GetPlayerArmour(specplayerid, ar);
	format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~w~%s - id:%d~n~< sprint - jump >~n~hp:%0.1f ar:%0.1f $%d", string,specplayerid,hp,ar,GetCODMoney(specplayerid) );
	GameTextForPlayer(playerid,string,25000,3);
	return 1;
}

stock StopSpectate(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
	Spectating[playerid] = 0;
	GameTextForPlayer(playerid,"~n~~n~~n~~w~Spectate mode ended",1000,3);
	return 1;
}

stock AdvanceSpectate(playerid)
{
	if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		for(new x=PlayerInfo[playerid][SpecID]+1; x<=MAX_PLAYERS; x++)
		{
			if(x == MAX_PLAYERS) x = 0;
			if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}

stock ReverseSpectate(playerid)
{
	if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		for(new x=PlayerInfo[playerid][SpecID]-1; x>=0; x--)
		{
			if(x == 0) x = MAX_PLAYERS;
			if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}

//==============================================================================
EraseVehicle(vehicleid)
{
	for(new players=0;players<=MAX_PLAYERS;players++)
	{
		new Float:X,Float:Y,Float:Z;
		if (IsPlayerInVehicle(players,vehicleid))
		{
			GetPlayerPos(players,X,Y,Z);
			SetPlayerPos(players,X,Y,Z+2);
			SetVehicleToRespawn(vehicleid);
		}
		SetVehicleParamsForPlayer(vehicleid,players,0,1);
	}
	SetTimerEx("VehRes",3000,0,"d",vehicleid);
	return 1;
}

forward CarSpawner(playerid,model);
public CarSpawner(playerid,model)
{
	if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, red, "You already have a car!");
	else
	{
		new Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new vehicleid=CreateVehicle(model, x, y, z, angle, -1, -1, -1);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		ChangeVehicleColor(vehicleid,0,7);
		PlayerInfo[playerid][pCar] = vehicleid;
	}
	return 1;
}

forward CarDeleter(vehicleid);
public CarDeleter(vehicleid)
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		new Float:X,Float:Y,Float:Z;
		if(IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			GetPlayerPos(i,X,Y,Z);
			SetPlayerPos(i,X,Y+3,Z);
		}
		SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}
	SetTimerEx("VehRes",1500,0,"d",vehicleid);
}

forward VehRes(vehicleid);
public VehRes(vehicleid)
{
	DestroyVehicle(vehicleid);
}

public OnVehicleDeath(vehicleid)
{
	if(heliobjects[vehicleid][0] != -1)
	{
		DestroyObject(heliobjects[vehicleid][0]);
		DestroyObject(heliobjects[vehicleid][1]);
		heliobjects[vehicleid][0] = heliobjects[vehicleid][1] = 0;
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i) && vehicleid == PlayerInfo[i][pCar])
		{
			CarDeleter(vehicleid);
			PlayerInfo[i][pCar]=-1;
		}
	}
	if(heliobjects[vehicleid][0] != -1)
	{
		DestroyObject(heliobjects[vehicleid][0]);
		DestroyObject(heliobjects[vehicleid][1]);
		heliobjects[vehicleid][0] = heliobjects[vehicleid][1] = 0;
	}
	// Special Vehicle Health System
	if(GetVehicleModel(vehicleid) == 520)
	{
		SetVehicleHealth(vehicleid, 550);
	}
	if(GetVehicleModel(vehicleid) == 425)
	{
		SetVehicleHealth(vehicleid, 550);
	}
	if(GetVehicleModel(vehicleid) == 432)
	{
		SetVehicleHealth(vehicleid, 1500);
	}
	if(GetVehicleModel(vehicleid) == 447)
	{
		SetVehicleHealth(vehicleid, 550);
	}
	if(GetVehicleModel(vehicleid) == 528)
	{
		SetVehicleHealth(vehicleid, 1500);
	}
	if(GetVehicleModel(vehicleid) == 427)
	{
		SetVehicleHealth(vehicleid, 1500);
	}
	return 1;
}

stock ChangeVehPlate()
{
	for(new i;i<MAX_VEHICLES;i++)
	{
		SetVehicleNumberPlate(i, ".:MW4:." );
		SetVehicleToRespawn(i);
	}
	return 1;
}
//==============================================================================
forward TuneLCar(VehicleID);
public TuneLCar(VehicleID)
{
	ChangeVehicleColor(VehicleID,0,7);
	AddVehicleComponent(VehicleID, 1010);  AddVehicleComponent(VehicleID, 1087);
}

//==============================================================================
//							Menus
//==============================================================================

public OnPlayerSelectedMenuRow(playerid, row) {
	new Menu:Current = GetPlayerMenu(playerid);
	new string[128];

	if(Current == LMainMenu) {
		switch(row)
		{
			case 0:
			{
				if(PlayerInfo[playerid][Level] >= 4) ShowMenuForPlayer(AdminEnable,playerid);
				else {
					SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
					TogglePlayerControllable(playerid,true);
				}
			}
			case 1:
			{
				if(PlayerInfo[playerid][Level] >= 4) ShowMenuForPlayer(AdminDisable,playerid);
				else {
					SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
					TogglePlayerControllable(playerid,true);
				}
			}
			case 2: ShowMenuForPlayer(LWeather,playerid);
			case 3: ShowMenuForPlayer(LTime,playerid);
			case 4:	ShowMenuForPlayer(LVehicles,playerid);
			case 5:	ShowMenuForPlayer(LCars,playerid);
			case 6:
			{
				if(PlayerInfo[playerid][Level] >= 2)
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
						switch(LModel)
						{
							case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
							{
								SendClientMessage(playerid,red,"ERROR: {828282}You can not tune this vehicle");  TogglePlayerControllable(playerid,true);
								return 1;
							}
						}
						TogglePlayerControllable(playerid,false);	ShowMenuForPlayer(LTuneMenu,playerid);
					}
					else { SendClientMessage(playerid,red,"ERROR: {828282}You do not have a vehicle to tune"); TogglePlayerControllable(playerid,true); }
				} else { SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command"); TogglePlayerControllable(playerid,true);	}
			}
			case 7:
			{
				if(PlayerInfo[playerid][Level] >= 3) ShowMenuForPlayer(XWeapons,playerid);
				else SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command"); TogglePlayerControllable(playerid,true);
			}
			case 8:	 ShowMenuForPlayer(LTele,playerid);
			case 9:
			{
				new Menu:Currentxmenu = GetPlayerMenu(playerid);
				HideMenuForPlayer(Currentxmenu,playerid);   TogglePlayerControllable(playerid,true);
			}
		}
		return 1;
	}//-------------------------------------------------------------------------
	if(Current == AdminEnable) {
		new adminname[MAX_PLAYER_NAME], file[256]; GetPlayerName(playerid, adminname, sizeof(adminname));
		format(file,sizeof(file),"ladmin/config/Config.ini");
		switch(row){
			case 0: { ServerInfo[AntiSwear] = 1; dini_IntSet(file,"AntiSwear",1); format(string,sizeof(string),"Administrator %s has enabled antiswear",adminname); SendClientMessageToAll(blue,string);	}
			case 1: { ServerInfo[NameKick] = 1; dini_IntSet(file,"NameKick",1); format(string,sizeof(string),"Administrator %s has enabled namekick",adminname); SendClientMessageToAll(blue,string);	}
			case 2:	{ ServerInfo[AntiSpam] = 1; dini_IntSet(file,"AntiSpam",1); format(string,sizeof(string),"Administrator %s has enabled antispam",adminname); SendClientMessageToAll(blue,string);	}
			case 3:	{ ServerInfo[MaxPing] = 1000; dini_IntSet(file,"MaxPing",1000); format(string,sizeof(string),"Administrator %s has enabled ping kick",adminname); SendClientMessageToAll(blue,string);	}
			case 4:	{ ServerInfo[ReadCmds] = 1; dini_IntSet(file,"ReadCmds",1); format(string,sizeof(string),"Administrator %s has enabled reading commands",adminname); MessageToAdmins(green,string);	}
			case 5:	{ ServerInfo[ReadPMs] = 1; dini_IntSet(file,"ReadPMs",1); format(string,sizeof(string),"Administrator %s has enabled reading pms",adminname); MessageToAdmins(green,string); }
			case 6:	{ ServerInfo[NoCaps] = 0; dini_IntSet(file,"NoCaps",0); format(string,sizeof(string),"Administrator %s has allowed captial letters in chat",adminname); SendClientMessageToAll(blue,string); }
			case 7:	{ ServerInfo[ConnectMessages] = 1; dini_IntSet(file,"ConnectMessages",1); format(string,sizeof(string),"Administrator %s has enabled connect messages",adminname); SendClientMessageToAll(blue,string); }
			case 8:	{ ServerInfo[AdminCmdMsg] = 1; dini_IntSet(file,"AdminCmdMessages",1); format(string,sizeof(string),"Administrator %s has enabled admin command messages",adminname); MessageToAdmins(green,string); }
			case 9:	{ ServerInfo[AutoLogin] = 1; dini_IntSet(file,"AutoLogin",1); format(string,sizeof(string),"Administrator %s has enabled auto login",adminname); SendClientMessageToAll(blue,string); }
			case 10: return ChangeMenu(playerid,Current,LMainMenu);
		 }
		return TogglePlayerControllable(playerid,true);
	}
	if(Current == AdminDisable) {
		new adminname[MAX_PLAYER_NAME], file[256]; GetPlayerName(playerid, adminname, sizeof(adminname));
		format(file,sizeof(file),"ladmin/config/Config.ini");
		switch(row){
			case 0: { ServerInfo[AntiSwear] = 0; dini_IntSet(file,"AntiSwear",0); format(string,sizeof(string),"Administrator %s has disabled antiswear",adminname); SendClientMessageToAll(blue,string);	}
			case 1: { ServerInfo[NameKick] = 0; dini_IntSet(file,"NameKick",0); format(string,sizeof(string),"Administrator %s has disabled namekick",adminname); SendClientMessageToAll(blue,string);	}
			case 2:	{ ServerInfo[AntiSpam] = 0; dini_IntSet(file,"AntiSpam",0); format(string,sizeof(string),"Administrator %s has disabled antispam",adminname); SendClientMessageToAll(blue,string);	}
			case 3:	{ ServerInfo[MaxPing] = 0; dini_IntSet(file,"MaxPing",0); format(string,sizeof(string),"Administrator %s has disabled ping kick",adminname); SendClientMessageToAll(blue,string);	}
			case 4:	{ ServerInfo[ReadCmds] = 0; dini_IntSet(file,"ReadCmds",0); format(string,sizeof(string),"Administrator %s has disabled reading commands",adminname); MessageToAdmins(green,string);	}
			case 5:	{ ServerInfo[ReadPMs] = 0; dini_IntSet(file,"ReadPMs",0); format(string,sizeof(string),"Administrator %s has disabled reading pms",adminname); MessageToAdmins(green,string); }
			case 6:	{ ServerInfo[NoCaps] = 1; dini_IntSet(file,"NoCaps",1); format(string,sizeof(string),"Administrator %s has prevented captial letters in chat",adminname); SendClientMessageToAll(blue,string); }
			case 7:	{ ServerInfo[ConnectMessages] = 0; dini_IntSet(file,"ConnectMessages",0); format(string,sizeof(string),"Administrator %s has disabled connect messages",adminname); SendClientMessageToAll(blue,string); }
			case 8:	{ ServerInfo[AdminCmdMsg] = 0; dini_IntSet(file,"AdminCmdMessages",0); format(string,sizeof(string),"Administrator %s has disabled admin command messages",adminname); MessageToAdmins(green,string); }
			case 9:	{ ServerInfo[AutoLogin] = 0; dini_IntSet(file,"AutoLogin",0); format(string,sizeof(string),"Administrator %s has disabled auto login",adminname); SendClientMessageToAll(blue,string); }
			case 10: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}//-------------------------------------------------------------------------
	if(Current==LVehicles){
		switch(row){
			case 0: ChangeMenu(playerid,Current,twodoor);
			case 1: ChangeMenu(playerid,Current,fourdoor);
			case 2: ChangeMenu(playerid,Current,fastcar);
			case 3: ChangeMenu(playerid,Current,Othercars);
			case 4: ChangeMenu(playerid,Current,bikes);
			case 5: ChangeMenu(playerid,Current,boats);
			case 6: ChangeMenu(playerid,Current,planes);
			case 7: ChangeMenu(playerid,Current,helicopters);
			case 8: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return 1;
	}
	if(Current==twodoor){
		new vehid;
		switch(row){
			case 0: vehid = 533;
			case 1: vehid = 439;
			case 2: vehid = 555;
			case 3: vehid = 422;
			case 4: vehid = 554;
			case 5: vehid = 575;
			case 6: vehid = 536;
			case 7: vehid = 535;
			case 8: vehid = 576;
			case 9: vehid = 401;
			case 10: vehid = 526;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==fourdoor){
		new vehid;
		switch(row){
			case 0: vehid = 404;
			case 1: vehid = 566;
			case 2: vehid = 412;
			case 3: vehid = 445;
			case 4: vehid = 507;
			case 5: vehid = 466;
			case 6: vehid = 546;
			case 7: vehid = 511;
			case 8: vehid = 467;
			case 9: vehid = 426;
			case 10: vehid = 405;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==fastcar){
		new vehid;
		switch(row){
			case 0: vehid = 480;
			case 1: vehid = 402;
			case 2: vehid = 415;
			case 3: vehid = 587;
			case 4: vehid = 494;
			case 5: vehid = 411;
			case 6: vehid = 603;
			case 7: vehid = 506;
			case 8: vehid = 451;
			case 9: vehid = 477;
			case 10: vehid = 541;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==Othercars){
		new vehid;
		switch(row){
			case 0: vehid = 556;
			case 1: vehid = 408;
			case 2: vehid = 431;
			case 3: vehid = 437;
			case 4: vehid = 427;
			case 5: vehid = 432;
			case 6: vehid = 601;
			case 7: vehid = 524;
			case 8: vehid = 455;
			case 9: vehid = 424;
			case 10: vehid = 573;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==bikes){
		new vehid;
		switch(row){
			case 0: vehid = 581;
			case 1: vehid = 481;
			case 2: vehid = 462;
			case 3: vehid = 521;
			case 4: vehid = 463;
			case 5: vehid = 522;
			case 6: vehid = 461;
			case 7: vehid = 448;
			case 8: vehid = 471;
			case 9: vehid = 468;
			case 10: vehid = 586;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==boats){
		new vehid;
		switch(row){
			case 0: vehid = 472;
			case 1: vehid = 473;
			case 2: vehid = 493;
			case 3: vehid = 595;
			case 4: vehid = 484;
			case 5: vehid = 430;
			case 6: vehid = 453;
			case 7: vehid = 452;
			case 8: vehid = 446;
			case 9: vehid = 454;
			case 10: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==planes){
		new vehid;
		switch(row){
			case 0: vehid = 592;
			case 1: vehid = 577;
			case 2: vehid = 511;
			case 3: vehid = 512;
			case 4: vehid = 593;
			case 5: vehid = 520;
			case 6: vehid = 553;
			case 7: vehid = 476;
			case 8: vehid = 519;
			case 9: vehid = 460;
			case 10: vehid = 513;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==helicopters){
		new vehid;
		switch(row){
			case 0: vehid = 548;
			case 1: vehid = 425;
			case 2: vehid = 417;
			case 3: vehid = 487;
			case 4: vehid = 488;
			case 5: vehid = 497;
			case 6: vehid = 563;
			case 7: vehid = 447;
			case 8: vehid = 469;
			case 9: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}

	if(Current==XWeapons){
		switch(row){
			case 0: { GivePlayerWeapon(playerid,24,500); }
			case 1: { GivePlayerWeapon(playerid,31,500); }
			case 2: { GivePlayerWeapon(playerid,26,500); }
			case 3: { GivePlayerWeapon(playerid,27,500); }
			case 4: { GivePlayerWeapon(playerid,28,500); }
			case 5: { GivePlayerWeapon(playerid,35,500); }
			case 6: { GivePlayerWeapon(playerid,38,1000); }
			case 7: { GivePlayerWeapon(playerid,34,500); }
			case 8: return ChangeMenu(playerid,Current,XWeaponsBig);
			case 9: return ChangeMenu(playerid,Current,XWeaponsSmall);
			case 10: return ChangeMenu(playerid,Current,XWeaponsMore);
			case 11: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current==XWeaponsBig){
		switch(row){
			case 0: { GivePlayerWeapon(playerid,25,500);  }
			case 1: { GivePlayerWeapon(playerid,30,500); }
			case 2: { GivePlayerWeapon(playerid,33,500); }
			case 3: { GivePlayerWeapon(playerid,36,500); }
			case 4: { GivePlayerWeapon(playerid,37,500); }
			case 5: { GivePlayerWeapon(playerid,29,500); }
			case 6: { GivePlayerWeapon(playerid,32,1000); }
			case 7: return ChangeMenu(playerid,Current,XWeapons);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current==XWeaponsSmall){
		switch(row){
			case 0: { GivePlayerWeapon(playerid,22,500); }//9mm
			case 1: { GivePlayerWeapon(playerid,23,500); }//s9
			case 2: { GivePlayerWeapon(playerid,18,500); }// MC
			case 3: { GivePlayerWeapon(playerid,42,500); }//FE
			case 4: { GivePlayerWeapon(playerid,41,500); }//spraycan
			case 5: { GivePlayerWeapon(playerid,16,500); }//grenade
			case 6: { GivePlayerWeapon(playerid,8,500); }//Katana
			case 7: { GivePlayerWeapon(playerid,9,1000); }//chainsaw
			case 8: return ChangeMenu(playerid,Current,XWeapons);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current==XWeaponsMore){
		switch(row){
			case 0: SetPlayerSpecialAction(playerid, 2);
			case 1: GivePlayerWeapon(playerid,4,500);
			case 2: GivePlayerWeapon(playerid,14,500);
			case 3: GivePlayerWeapon(playerid,43,500);
			case 4: GivePlayerWeapon(playerid,7,500);
			case 5: GivePlayerWeapon(playerid,5,500);
			case 6: GivePlayerWeapon(playerid,2,1000);
			case 7: MaxAmmo(playerid);
			case 8: return ChangeMenu(playerid,Current,XWeapons);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == LTele)
	{
		switch(row)
		{
			case 0: ChangeMenu(playerid,Current,LasVenturasMenu);
			case 1: ChangeMenu(playerid,Current,LosSantosMenu);
			case 2: ChangeMenu(playerid,Current,SanFierroMenu);
			case 3: ChangeMenu(playerid,Current,DesertMenu);
			case 4: ChangeMenu(playerid,Current,FlintMenu);
			case 5: ChangeMenu(playerid,Current,MountChiliadMenu);
			case 6: ChangeMenu(playerid,Current,InteriorsMenu);
			case 7: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return 1;
	}

	if(Current == LasVenturasMenu)
	{
		switch(row)
		{
			case 0: { SetPlayerPos(playerid,2037.0,1343.0,12.0); SetPlayerInterior(playerid,0); }// strip
			case 1: { SetPlayerPos(playerid,2163.0,1121.0,23); SetPlayerInterior(playerid,0); }// come a lot
			case 2: { SetPlayerPos(playerid,1688.0,1615.0,12.0); SetPlayerInterior(playerid,0); }// lv airport
			case 3: { SetPlayerPos(playerid,2503.0,2764.0,10.0); SetPlayerInterior(playerid,0); }// military fuel
			case 4: { SetPlayerPos(playerid,1418.0,2733.0,10.0); SetPlayerInterior(playerid,0); }// golf lv
			case 5: { SetPlayerPos(playerid,1377.0,2196.0,9.0); SetPlayerInterior(playerid,0); }// pitch match
			case 6: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == LosSantosMenu)
	{
		switch(row)
		{
			case 0: { SetPlayerPos(playerid,2495.0,-1688.0,13.0); SetPlayerInterior(playerid,0); }// ganton
			case 1: { SetPlayerPos(playerid,1979.0,-2241.0,13.0); SetPlayerInterior(playerid,0); }// ls airport
			case 2: { SetPlayerPos(playerid,2744.0,-2435.0,15.0); SetPlayerInterior(playerid,0); }// docks
			case 3: { SetPlayerPos(playerid,1481.0,-1656.0,14.0); SetPlayerInterior(playerid,0); }// square
			case 4: { SetPlayerPos(playerid,1150.0,-2037.0,69.0); SetPlayerInterior(playerid,0); }// veradant bluffs
			case 5: { SetPlayerPos(playerid,425.0,-1815.0,6.0); SetPlayerInterior(playerid,0); }// santa beach
			case 6: { SetPlayerPos(playerid,1240.0,-744.0,95.0); SetPlayerInterior(playerid,0); }// mullholland
			case 7: { SetPlayerPos(playerid,679.0,-1070.0,49.0); SetPlayerInterior(playerid,0); }// richman
			case 8: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == SanFierroMenu)
	{
		switch(row)
		{
			case 0: { SetPlayerPos(playerid,-1990.0,137.0,27.0); SetPlayerInterior(playerid,0); } // sf station
			case 1: { SetPlayerPos(playerid,-1528.0,-206.0,14.0); SetPlayerInterior(playerid,0); }// sf airport
			case 2: { SetPlayerPos(playerid,-2709.0,198.0,4.0); SetPlayerInterior(playerid,0); }// ocean flats
			case 3: { SetPlayerPos(playerid,-2738.0,-295.0,6.0); SetPlayerInterior(playerid,0); }// avispa country club
			case 4: { SetPlayerPos(playerid,-1457.0,465.0,7.0); SetPlayerInterior(playerid,0); }// easter basic docks
			case 5: { SetPlayerPos(playerid,-1853.0,1404.0,7.0); SetPlayerInterior(playerid,0); }// esplanadae north
			case 6: { SetPlayerPos(playerid,-2620.0,1373.0,7.0); SetPlayerInterior(playerid,0); }// battery point
			case 7: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == DesertMenu)
	{
		switch(row)
		{
			case 0: { SetPlayerPos(playerid,416.0,2516.0,16.0); SetPlayerInterior(playerid,0); } // plane graveyard
			case 1: { SetPlayerPos(playerid,81.0,1920.0,17.0); SetPlayerInterior(playerid,0); }// area51
			case 2: { SetPlayerPos(playerid,-324.0,1516.0,75.0); SetPlayerInterior(playerid,0); }// big ear
			case 3: { SetPlayerPos(playerid,-640.0,2051.0,60.0); SetPlayerInterior(playerid,0); }// dam
			case 4: { SetPlayerPos(playerid,-766.0,1545.0,27.0); SetPlayerInterior(playerid,0); }// las barrancas
			case 5: { SetPlayerPos(playerid,-1514.0,2597.0,55.0); SetPlayerInterior(playerid,0); }// el qyebrados
			case 6: { SetPlayerPos(playerid,442.0,1427.0,9.0); SetPlayerInterior(playerid,0); }// actane springs
			case 7: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == FlintMenu)
	{
		switch(row)
		{
			case 0: { SetPlayerPos(playerid,-849.0,-1940.0,13.0);  SetPlayerInterior(playerid,0); }// lake
			case 1: { SetPlayerPos(playerid,-1107.0,-1619.0,76.0);  SetPlayerInterior(playerid,0); }// leafy hollow
			case 2: { SetPlayerPos(playerid,-1049.0,-1199.0,128.0);  SetPlayerInterior(playerid,0); }// the farm
			case 3: { SetPlayerPos(playerid,-1655.0,-2219.0,32.0);  SetPlayerInterior(playerid,0); }// shady cabin
			case 4: { SetPlayerPos(playerid,-375.0,-1441.0,25.0); SetPlayerInterior(playerid,0); }// flint range
			case 5: { SetPlayerPos(playerid,-367.0,-1049.0,59.0); SetPlayerInterior(playerid,0); }// beacon hill
			case 6: { SetPlayerPos(playerid,-494.0,-555.0,25.0); SetPlayerInterior(playerid,0); }// fallen tree
			case 7: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == MountChiliadMenu)
	{
		switch(row)
		{
			case 0: { SetPlayerPos(playerid,-2308.0,-1657.0,483.0);  SetPlayerInterior(playerid,0); }// chiliad jump
			case 1: { SetPlayerPos(playerid,-2331.0,-2180.0,35.0); SetPlayerInterior(playerid,0); }// bottom chiliad
			case 2: { SetPlayerPos(playerid,-2431.0,-1620.0,526.0);  SetPlayerInterior(playerid,0); }// highest point
			case 3: { SetPlayerPos(playerid,-2136.0,-1775.0,208.0);  SetPlayerInterior(playerid,0); }// chiliad path
			case 4: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == InteriorsMenu)
	{
		switch(row)
		{
			case 0: {	SetPlayerPos(playerid,386.5259, 173.6381, 1008.3828);	SetPlayerInterior(playerid,3); }
			case 1: {	SetPlayerPos(playerid,288.4723, 170.0647, 1007.1794);	SetPlayerInterior(playerid,3); }
			case 2: {	SetPlayerPos(playerid,372.5565, -131.3607, 1001.4922);	SetPlayerInterior(playerid,5); }
			case 3: {	SetPlayerPos(playerid,-1129.8909, 1057.5424, 1346.4141);	SetPlayerInterior(playerid,10); }
			case 4: {	SetPlayerPos(playerid,2233.9363, 1711.8038, 1011.6312);	SetPlayerInterior(playerid,1); }
			case 5: {	SetPlayerPos(playerid,2536.5322, -1294.8425, 1044.125);	SetPlayerInterior(playerid,2); }
			case 6: {	SetPlayerPos(playerid,1267.8407, -776.9587, 1091.9063);	SetPlayerInterior(playerid,5); }
			case 7: {	SetPlayerPos(playerid,-1421.5618, -663.8262, 1059.5569);	SetPlayerInterior(playerid,4); }
			case 8: {	SetPlayerPos(playerid,-1401.067, 1265.3706, 1039.8672);	SetPlayerInterior(playerid,16); }
			case 9: {	SetPlayerPos(playerid,285.8361, -39.0166, 1001.5156);	SetPlayerInterior(playerid,1); }
			case 10: {	SetPlayerPos(playerid,1727.2853, -1642.9451, 20.2254);	SetPlayerInterior(playerid,18); }
			case 11: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}
	if(Current == LWeather)
	{
		new adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname));
		switch(row)
		{
			case 0:	{	SetWeather(5);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);	CMDMessageToAdmins(playerid,"SETWEATHER"); format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 1:	{	SetWeather(19); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 2:	{	SetWeather(8);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 3:	{	SetWeather(20);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 4:	{	SetWeather(9);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 5:	{	SetWeather(16); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 6:	{	SetWeather(45); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 7:	{	SetWeather(44); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 8:	{	SetWeather(22); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 9:	{	SetWeather(11); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 10: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == LTuneMenu)
	{
		switch(row)
		{
			case 0:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1010); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 1:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1087); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added"); }
			case 2:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1081); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 3: {	AddVehicleComponent(GetPlayerVehicleID(playerid),1078); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 4:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1098); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 5:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1074); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 6:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1082); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 7:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1085); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 8:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1025); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 9:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1077); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 10: return ChangeMenu(playerid,Current,PaintMenu);
			case 11: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == PaintMenu)
	{
		switch(row)
		{
			case 0:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),0); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 1"); }
			case 1:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),1); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 2"); }
			case 2:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),2); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 3"); }
			case 3:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),3); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 4"); }
			case 4:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),4); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 5"); }
			case 5:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),0,0); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To Black"); }
			case 6:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),1,1); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To White"); }
			case 7:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),79,158); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To Black"); }
			case 8:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),146,183); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To Black"); }
			case 9: return ChangeMenu(playerid,Current,LTuneMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}
	if(Current == LTime)
	{
		new adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname));
		switch(row)
		{
			case 0:	{ for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,7,0);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);	CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 1:	{ for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,12,0); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 2:	{ for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,16,0);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 3:	{ for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,20,0);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 4:	{ for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,0,0);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 5: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current == LCars)
	{
		new vehid;
		switch(row) {
			case 0: vehid = 451;//Turismo
			case 1: vehid = 568;//Bandito
			case 2: vehid = 539;//Vortex
			case 3: vehid = 522;//nrg
			case 4: vehid = 601;//s.w.a.t
			case 5: vehid = 425; //hunter
			case 6: vehid = 493;//jetmax
			case 7: vehid = 432;//rhino
			case 8: vehid = 444; //mt
			case 9: vehid = 447; //sea sparrow
			case 10: return ChangeMenu(playerid,Current,LCars2);
			case 11: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return SelectCar(playerid,vehid,Current);
	}

	if(Current == LCars2)
	{
		new vehid;
		switch(row) {
			case 0: vehid = 406;// dumper
			case 1: vehid = 564; //rc tank
			case 2: vehid = 441;//RC Bandit
			case 3: vehid = 464;// rc baron
			case 4: vehid = 501; //rc goblin
			case 5: vehid = 465; //rc raider
			case 6: vehid = 594; // rc cam
			case 7: vehid = 449; //train
			case 8: return ChangeMenu(playerid,Current,LCars);
		}
		return SelectCar(playerid,vehid,Current);
	}

	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(FirstSpawn[playerid] == 1)
	{
		SendClientMessage(playerid, -1,"Please select your class");
		FirstSpawn[playerid] = 0;
		ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection","Soldier - {80C732}Rank 1\nSniper - {80C732}Rank 2\nEngineer - {80C732}Rank 5\nJetTrooper - {80C732}Rank 6\nPilot - {80C732}Rank 6\nSupport - {80C732}Rank 7\nSpy - {80C732}Rank 7\nDemolisher - {80C732}Rank 8\nHeavy - {80C732}Rank 13\nDonor - {80C732}Donor Lv. 2","Select","");
		return 0;
	}
	if(PlayerInfo[playerid][LoggedIn] == 0 && PlayerInfo[playerid][Registered] == 1)
	{
		new str[128];
		format(str,sizeof(str),"Server: You're not registered or logged in, Relog.",pName(playerid));
		SendClientMessage(playerid,red,str);
		SetTimerEx("KickTimer", 1000, false, "d", playerid);
		return 0;
	}
	new team1count = GetTeamCount(TEAM_EUROPE), team2count = GetTeamCount(TEAM_USA),
	team3count = GetTeamCount(TEAM_ARAB), team4count = GetTeamCount(TEAM_SOVIET),
	team5count = GetTeamCount(TEAM_AUS);
	switch(gTeam[playerid])
	{
		case TEAM_EUROPE:
		{
			if(team1count > team2count && team3count && team4count && team5count)
			{
				GameTextForPlayer(playerid, "~r~Team is full", 1, 3000);
				return 0;
			}
		}
		case TEAM_USA:
		{
			if(team2count > team1count && team3count && team4count && team5count)
			{
				GameTextForPlayer(playerid, "~r~Team is full", 1, 3000);
				return 0;
			}
		}
		case TEAM_ARAB:
		{
			if(team3count > team2count && team1count && team4count && team5count)
			{
				GameTextForPlayer(playerid, "~r~Team is full", 1, 3000);
				return 0;
			}
		}
		case TEAM_SOVIET:
		{
			if(team4count > team2count && team3count && team1count && team5count)
			{
				GameTextForPlayer(playerid, "~r~Team is full", 1, 3000);
				return 0;
			}
		}
		case TEAM_AUS:
		{
			if(team5count > team2count && team3count && team1count && team5count)
			{
				GameTextForPlayer(playerid, "~r~Team is full", 1, 3000);
				return 0;
			}
		}
	}
	return 1;
}
//==============================================================================

public OnPlayerExitedMenu(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	HideMenuForPlayer(Current,playerid);
	return TogglePlayerControllable(playerid,true);
}

//==============================================================================

ChangeMenu(playerid,Menu:oldmenu,Menu:newmenu)
{
	if(IsValidMenu(oldmenu)) {
		HideMenuForPlayer(oldmenu,playerid);
		ShowMenuForPlayer(newmenu,playerid);
	}
	return 1;
}

CloseMenu(playerid,Menu:oldmenu)
{
	HideMenuForPlayer(oldmenu,playerid);
	TogglePlayerControllable(playerid,1);
	return 1;
}
SelectCar(playerid,vehid,Menu:menu)
{
	CloseMenu(playerid,menu);
	SetCameraBehindPlayer(playerid);
	CarSpawner(playerid,vehid);
	return 1;
}

//==================== [ Jail & Freeze ]========================================

forward Jail1(playerid);
public Jail1(playerid)
{
	TogglePlayerControllable(playerid, 0);
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraPos(playerid, x+10, y, z+10);
	SetPlayerCameraLookAt(playerid, x, y, z);
	SetTimerEx("Jail2", 1000, false, "d", playerid);
}

forward Jail2(playerid);
public Jail2(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraPos(playerid, x+7, y, z+5);
	SetPlayerCameraLookAt(playerid, x, y, z);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	}
	GameTextForPlayer(playerid, "~r~Jailed!", 3000, 0);
	SetTimerEx("Jail3", 1000, false, "d", playerid);
}

forward Jail3(playerid);
public Jail3(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraPos(playerid, x+3, y, z);
	SetPlayerCameraLookAt(playerid, x, y, z);
}

forward JailPlayer(playerid);
public JailPlayer(playerid)
{
	SetPlayerPos(playerid, 197.6661, 173.8179, 1003.0234);
	SetPlayerInterior(playerid, 3);
	SetCameraBehindPlayer(playerid);
	KillTimer(JailTimer[playerid]);
	JailTimer[playerid] = SetTimerEx("JailRelease", 1000, true, "d", playerid);
	TogglePlayerControllable(playerid, 1);
}

forward JailRelease(playerid);
public JailRelease(playerid)
{
	new formatstr[32];
	format(formatstr, sizeof(formatstr), "~r~%d ~w~seconds remaining", PlayerInfo[playerid][JailTime]);
	GameTextForPlayer(playerid, formatstr, 1000, 3);
	if(!IsPlayerConnected(playerid))
	{
		KillTimer(JailTimer[playerid]);
		return;
	}
	if(--PlayerInfo[playerid][JailTime] < 1)
	{
		KillTimer(JailTimer[playerid]);
		PlayerInfo[playerid][Jailed] = 0;
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 0.0, 0.0, 0.0);
		SpawnPlayer(playerid);
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		GameTextForPlayer(playerid, "~g~Released!", 3000, 0);
	}
}

//------------------------------------------------------------------------------
forward UnFreezeMe(player1);
public UnFreezeMe(player1)
{
	KillTimer( FreezeTimer[player1] );
	TogglePlayerControllable(player1,true);   PlayerInfo[player1][Frozen] = 0;
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);	GameTextForPlayer(player1,"~g~Unfrozen",3000,3);
}

//============================ [ Timers ]=======================================
forward BanTimer(playerid);
public BanTimer(playerid)
{
	if(playerid != INVALID_PLAYER_ID)
	{
		Ban(playerid);
	}
	return 0;
}

forward KickTimer(playerid);
public KickTimer(playerid)
{
	if(playerid != INVALID_PLAYER_ID)
	{
		Kick(playerid);
	}
	return 0;
}

forward PingKick();
public PingKick()
{
	if(ServerInfo[MaxPing] != 0)
	{
		PingPos+= 1; if(PingPos > PING_MAX_EXCEEDS) PingPos = 0;

		for(new i=0; i<MAX_PLAYERS; i++)
		{
			PlayerInfo[i][pPing][PingPos] = GetPlayerPing(i);

			if(GetPlayerPing(i) > ServerInfo[MaxPing])
			{
				if(PlayerInfo[i][PingCount] == 0) PlayerInfo[i][PingTime] = gettime();

				PlayerInfo[i][PingCount]+= 1;
				if(gettime() - PlayerInfo[i][PingTime] > PING_TIMELIMIT)
				{
					PlayerInfo[i][PingTime] = gettime();
					PlayerInfo[i][PingCount] = 1;
				}
				else if(PlayerInfo[i][PingCount] >= PING_MAX_EXCEEDS)
				{
					new Sum, Average, x, string[128];
					while (x < PING_MAX_EXCEEDS) {
						Sum += PlayerInfo[i][pPing][x];
						x+= 1;
					}
					Average = (Sum / PING_MAX_EXCEEDS);
					format(string,sizeof(string),"%s has been kicked from the server. (Reason: High Ping (%d) | Average (%d) | Max Allowed (%d) )", pName(i), GetPlayerPing(i), Average, ServerInfo[MaxPing] );
					SendClientMessageToAll(grey,string);
					SaveToFile("KickLog",string);
					SetTimerEx("KickTimer", 1000, false, "d", i);
				}
			}
			else if(GetPlayerPing(i) < 1 && ServerInfo[AntiBot] == 1)
			{
				PlayerInfo[i][BotPing]+= 1;
				if(PlayerInfo[i][BotPing] >= 3) BotCheck(i);
			}
			else
			{
				PlayerInfo[i][BotPing] = 0;
			}
		}
	}
	return 1;
}
//==========================[ Anti Bot Checker ]====================================
forward BotCheck(playerid);
public BotCheck(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerPing(playerid) < 1)
		{
			new string[128], ip[20];  GetPlayerIp(playerid,ip,sizeof(ip));
			format(string,sizeof(string),"BOT: %s id:%d ip: %s ping: %d",pName(playerid),playerid,ip,GetPlayerPing(playerid));
			SaveToFile("BotKickLog",string);
			SaveToFile("KickLog",string);
			printf("[ADMIN] Possible bot has been detected (Kicked %s ID:%d)", pName(playerid), playerid);
			SetTimerEx("KickTimer", 1000, false, "d", playerid);
		}
	}
}
//==========================[ Server Info  ]====================================

ConnectedPlayers()
{
	new Connected;
	for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i)) Connected+= 1;
	return Connected;
}

forward JailedPlayers();
public JailedPlayers()
{
	new JailedCount;
	for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed] == 1) JailedCount+= 1;
	return JailedCount;
}

forward FrozenPlayers();
public FrozenPlayers()
{
	new FrozenCount; for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen] == 1) FrozenCount+= 1;
	return FrozenCount;
}

forward MutedPlayers();
public MutedPlayers()
{
	new coun; for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted] == 1) coun+= 1;
	return coun;
}

forward InVehCount();
public InVehCount()
{
	new InVeh; for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) InVeh+= 1;
	return InVeh;
}

forward OnBikeCount();
public OnBikeCount()
{
	new BikeCount;
	for(new i, l = GetPlayerPoolSize(); i <= l; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
		new LModel = GetVehicleModel(GetPlayerVehicleID(i));
		switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586:  BikeCount+= 1;
		}
	}
	return BikeCount;
}

forward InCarCount();
public InCarCount()
{
	new PInCarCount;
	for(new i, l = GetPlayerPoolSize(); i <= l; i++) {
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
			new LModel = GetVehicleModel(GetPlayerVehicleID(i));
			switch(LModel)
			{
				case 448,461,462,463,468,471,509,510,521,522,523,581,586: {}
				default: PInCarCount+= 1;
			}
		}
	}
	return PInCarCount;
}

//==========================[ Remote Console ]==================================

forward UnloadFS();
public UnloadFS()
{
	SendRconCommand("unloadfs ladmin4");
}

forward PrintWarning(const string[]);
public PrintWarning(const string[])
{
	new str[128];
	print("\n\n>		WARNING:\n");
	format(str, sizeof(str), " The  %s  folder is missing from scriptfiles", string);
	print(str);
	print("\n Please create the specified folder and restart the server.\n\n");
}

stock GetPlayerSpeedSpeedo(playerid, bool:kmh)
{
	new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); else GetPlayerVelocity(playerid,Vx,Vy,Vz);
	rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
	return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}

TotalGameTime(playerid, &hours, &minutes, &seconds)
{
	new variable = (gettime() - pInfo[playerid][TotalTime]) + (pInfo[playerid][Hours] * 60 * 60) + (pInfo[playerid][Mins] * 60) + pInfo[playerid][Secs];

	hours = floatround(variable, floatround_floor);
	minutes = floatround(variable, floatround_floor) % 60;
	seconds = floatround(variable, floatround_floor);

	return 1;
}

TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
	PlayerInfo[playerid][TotalTime] = ( (gettime() - PlayerInfo[playerid][ConnectTime]) + (PlayerInfo[playerid][hours]*60*60) + (PlayerInfo[playerid][mins]*60) + (PlayerInfo[playerid][secs]));

	h = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
	m = floatround(PlayerInfo[playerid][TotalTime] / 60,   floatround_floor) % 60;
	s = floatround(PlayerInfo[playerid][TotalTime] % 60,   floatround_floor);

	return PlayerInfo[playerid][TotalTime];
}

//==============================================================================
MaxAmmo(playerid)
{
	new slot, weap, ammo;
	for (slot = 0; slot < 14; slot++)
	{
		GetPlayerWeaponData(playerid, slot, weap, ammo);
		if(IsValidWeapon(weap))
		{
			GivePlayerWeapon(playerid, weap, 999999);
		}
	}
	return 1;
}

stock pName(playerid)
{
	new gName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, gName, sizeof(gName));
	return gName;
}

stock GetIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, 16);
	return ip;
}

stock PlayerSoundForAll(SoundID)
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++) PlayerPlaySound(i, SoundID, 0.0, 0.0, 0.0);
}

stock IsValidWeapon(weaponid)
{
	if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
	return 0;
}

stock IsValidSkin(SkinID)
{
	switch(SkinID)
	{
		case 1 .. 73: return 1;
		case 0, 74: return 0;
		case 75 .. 311: return 1;
	}
	return 0;
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock IsNumeric2(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '3' || string[i] < '0') return 0;
	}
	return 1;
}

stock ReturnPlayerID(PlayerName[])
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(strfind(pName(i),PlayerName,true)!=-1) return i;
		}
	}
	return INVALID_PLAYER_ID;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(VehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}

stock DisableWord(const badword[], text[])
{
	for(new i=0; i<256; i++)
	{
		if (strfind(text[i], badword, true) == 0)
		{
			for(new a=0; a<256; a++)
			{
				if (a >= i && a < i+strlen(badword)) text[a]='*';
			}
		}
	}
}

//==============================================================================
MessageToAdmins(color,const string[])
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i)) if (PlayerInfo[i][Level] >= 1) SendClientMessage(i, color, string);
	}
	return 1;
}

MessageTo4(color,const string[])
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i)) if (PlayerInfo[i][Level] >= 4) SendClientMessage(i, color, string);
	}
	return 1;
}

MessageTo5(color,const string[])
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i)) if (PlayerInfo[i][Level] >= 5) SendClientMessage(i, color, string);
	}
	return 1;
}

CMDMessageToAdmins(playerid,command[])
{
	if(ServerInfo[AdminCmdMsg] == 0) return 1;
	new string[128]; GetPlayerName(playerid,string,sizeof(string));
	format(string,sizeof(string),"[INFO]Administrator {80C732}%s {FFFFFF}has used {80C732}%s",string,command);
	return MessageToAdmins(-1,string);
}

stock GetCpName(id)
{
	new CpName[20];
	switch(id)
	{
		case 0: CpName = "Snake Farm";
		case 1: CpName = "Bay";
		case 2: CpName = "Area 51";
		case 3: CpName = "Army Restaurant";
		case 4: CpName = "Army Petrol Bunk";
		case 5: CpName = "Oil Factory";
		case 6: CpName = "Gas Station";
		case 7: CpName = "Quarry";
		case 8: CpName = "Army Guest House";
		case 9: CpName = "Big Ear";
		case 10: CpName = "Desert Airport";
		case 11: CpName = "Ammunation";
		case 12: CpName = "Sherman Dam";
		case 13: CpName = "Cluckin Bell";
		case 14: CpName = "Rusty Bridge";
		case 15: CpName = "Ghost Town";
		case 16: CpName = "Hospital";
		case 17: CpName = "Villa";
		case 18: CpName = "Biological Ship";
		case 19: CpName = "Cerberus Island";
		case 20: CpName = "Unknown";
	}
	return CpName;
}

//==============================================================================
SavePlayer(playerid)
{
	dUserSetINT(pName(playerid)).("money",PlayerInfo[playerid][Money]);
	dUserSetINT(pName(playerid)).("kills",PlayerInfo[playerid][Kills]);
	dUserSetINT(pName(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
	dUserSetINT(pName(playerid)).("Score",GetPlayerScore(playerid));
	dUserSetINT(pName(playerid)).("Donor",PlayerInfo[playerid][VIP]);
	dUserSetINT(pName(playerid)).("RegAch",PlayerInfo[playerid][pRegAch]);
	dUserSetINT(pName(playerid)).("KillAch",PlayerInfo[playerid][pKillAch]);
	dUserSetINT(pName(playerid)).("AssAch",PlayerInfo[playerid][pAssAch]);
	dUserSetINT(pName(playerid)).("OwnAch",PlayerInfo[playerid][pOwnAch]);
	dUserSetINT(pName(playerid)).("HsAch",PlayerInfo[playerid][pHsAch]);
	dUserSetINT(pName(playerid)).("PtAch",PlayerInfo[playerid][pPtAch]);
	dUserSetINT(pName(playerid)).("Achs",PlayerInfo[playerid][pAchs]);
	dUserSetINT(pName(playerid)).("Headshots",PlayerInfo[playerid][Headshots]);
	dUserSetINT(pName(playerid)).("BonusKills",PlayerInfo[playerid][BonusKills]);
	new h, m, s;
	TotalGameTime(playerid, h, m, s);

	dUserSetINT(pName(playerid)).("hours", h);
	dUserSetINT(pName(playerid)).("minutes", m);
	dUserSetINT(pName(playerid)).("seconds", s);

	new year,month,day;	getdate(year, month, day);
	new strdate[20];	format(strdate, sizeof(strdate), "%d.%d.%d",day,month,year);
	new file[256]; 		format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(pName(playerid)) );

	dini_Set(file,"LastOn",strdate);
	dUserSetINT(pName(playerid)).("loggedin",0);
	dUserSetINT(pName(playerid)).("TimesOnServer",(dUserINT(pName(playerid)).("TimesOnServer"))+1);
}

//==============================================================================
DestroyAllMenus()
{
	DestroyMenu(LVehicles); DestroyMenu(twodoor); DestroyMenu(fourdoor); DestroyMenu(fastcar); DestroyMenu(Othercars);
	DestroyMenu(bikes); DestroyMenu(boats); DestroyMenu(planes); DestroyMenu(helicopters ); DestroyMenu(LTime);
	DestroyMenu(XWeapons); DestroyMenu(XWeaponsBig); DestroyMenu(XWeaponsSmall); DestroyMenu(XWeaponsMore);
	DestroyMenu(LWeather); DestroyMenu(LTuneMenu); DestroyMenu(PaintMenu); DestroyMenu(LCars); DestroyMenu(LCars2);
	DestroyMenu(LTele); DestroyMenu(LasVenturasMenu); DestroyMenu(LosSantosMenu); DestroyMenu(SanFierroMenu);
	DestroyMenu(LMainMenu); DestroyMenu(DesertMenu); DestroyMenu(FlintMenu); DestroyMenu(MountChiliadMenu); DestroyMenu(InteriorsMenu);
	DestroyMenu(AdminEnable); DestroyMenu(AdminDisable);
}

//==============================================================================
#if defined DISPLAY_CONFIG
stock ConfigInConsole()
{
	print(" ________ Configuration ___________\n");
	print(" __________ Chat & Messages ______");
	if(ServerInfo[AntiSwear] == 0) print("  Anti Swear:              Disabled "); else print("  Anti Swear:             Enabled ");
	if(ServerInfo[AntiSpam] == 0)  print("  Anti Spam:               Disabled "); else print("  Anti Spam:              Enabled ");
	if(ServerInfo[ReadCmds] == 0)  print("  Read Cmds:               Disabled "); else print("  Read Cmds:              Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Read PMs:                Disabled "); else print("  Read PMs:               Enabled ");
	if(ServerInfo[ConnectMessages] == 0) print("  Connect Messages:        Disabled "); else print("  Connect Messages:       Enabled ");
	if(ServerInfo[AdminCmdMsg] == 0) print("  Admin Cmd Messages:     Disabled ");  else print("  Admin Cmd Messages:     Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Anti capital letters:    Disabled \n"); else print("  Anti capital letters:   Enabled \n");
	print(" ________ Server Protection ______");
	if(ServerInfo[NameKick] == 0) print("  Bad Name Kick:           Disabled\n"); else print("  Bad Name Kick:           Enabled\n");
	print(" __________ Ping Control _________");
	if(ServerInfo[MaxPing] == 0) print("  Ping Control:            Disabled"); else print("  Ping Control:            Enabled");
	printf("  Max Ping:                %d\n", ServerInfo[MaxPing] );
	print(" __________ Other ________________");
	printf("  Max Admin Level:         %d", ServerInfo[MaxAdminLevel] );
	if(ServerInfo[AutoLogin] == 0) print("  Auto Login:             Disabled\n"); else print("  Auto Login:              Enabled\n");
}
#endif

//=====================[ Configuration ] =======================================
stock UpdateConfig()
{
	new file[256], File:file2, string[100]; format(file,sizeof(file),"ladmin/config/Config.ini");
	ForbiddenWordCount = 0;
	BadNameCount = 0;
	BadPartNameCount = 0;

	if(!dini_Exists("ladmin/config/aka.txt")) dini_Create("ladmin/config/aka.txt");

	if(!dini_Exists(file))
	{
		dini_Create(file);
		print("\n >Configuration File Successfully Created");
	}

	if(!dini_Isset(file,"MaxPing")) dini_IntSet(file,"MaxPing",1200);
	if(!dini_Isset(file,"ReadPms")) dini_IntSet(file,"ReadPMs",1);
	if(!dini_Isset(file,"ReadCmds")) dini_IntSet(file,"ReadCmds",1);
	if(!dini_Isset(file,"MaxAdminLevel")) dini_IntSet(file,"MaxAdminLevel",5);
	if(!dini_Isset(file,"AntiSpam")) dini_IntSet(file,"AntiSpam",1);
	if(!dini_Isset(file,"AntiSwear")) dini_IntSet(file,"AntiSwear",1);
	if(!dini_Isset(file,"NameKick")) dini_IntSet(file,"NameKick",0);
	if(!dini_Isset(file,"PartNameKick")) dini_IntSet(file,"PartNameKick",0);
	if(!dini_Isset(file,"NoCaps")) dini_IntSet(file,"NoCaps",0);
	if(!dini_Isset(file,"SaveWeap")) dini_IntSet(file,"SaveWeap",1);
	if(!dini_Isset(file,"SaveMoney")) dini_IntSet(file,"SaveMoney",1);
	if(!dini_Isset(file,"ConnectMessages")) dini_IntSet(file,"ConnectMessages",1);
	if(!dini_Isset(file,"AdminCmdMessages")) dini_IntSet(file,"AdminCmdMessages",1);
	if(!dini_Isset(file,"AutoLogin")) dini_IntSet(file,"AutoLogin",0);
	if(!dini_Isset(file,"MaxMuteWarnings")) dini_IntSet(file,"MaxMuteWarnings",4);

	if(dini_Exists(file))
	{
		ServerInfo[MaxPing] = dini_Int(file,"MaxPing");
		ServerInfo[ReadPMs] = dini_Int(file,"ReadPMs");
		ServerInfo[ReadCmds] = dini_Int(file,"ReadCmds");
		ServerInfo[MaxAdminLevel] = dini_Int(file,"MaxAdminLevel");
		ServerInfo[AntiSpam] = dini_Int(file,"AntiSpam");
		ServerInfo[AntiSwear] = dini_Int(file,"AntiSwear");
		ServerInfo[NameKick] = dini_Int(file,"NameKick");
		ServerInfo[PartNameKick] = dini_Int(file,"PartNameKick");
		ServerInfo[NoCaps] = dini_Int(file,"NoCaps");
		ServerInfo[ConnectMessages] = dini_Int(file,"ConnectMessages");
		ServerInfo[AdminCmdMsg] = dini_Int(file,"AdminCmdMessages");
		ServerInfo[AutoLogin] = dini_Int(file,"AutoLogin");
		ServerInfo[MaxMuteWarnings] = dini_Int(file,"MaxMuteWarnings");
		print("\n -Configuration Settings Loaded");
	}

	//forbidden names
	if((file2 = fopen("ladmin/config/ForbiddenNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
			for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
			BadNames[BadNameCount] = string;
			BadNameCount+= 1;
		}
		fclose(file2);	printf(" -%d Forbidden Names Loaded", BadNameCount);
	}

	//forbidden part of names
	if((file2 = fopen("ladmin/config/ForbiddenPartNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
			for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
			BadPartNames[BadPartNameCount] = string;
			BadPartNameCount+= 1;
		}
		fclose(file2);	printf(" -%d Forbidden Tags Loaded", BadPartNameCount);
	}

	//forbidden words
	if((file2 = fopen("ladmin/config/ForbiddenWords.cfg",io_read)))
	{
		while(fread(file2,string))
		{
			for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
			ForbiddenWords[ForbiddenWordCount] = string;
			ForbiddenWordCount+= 1;
		}
		fclose(file2);	printf(" -%d Forbidden Words Loaded", ForbiddenWordCount);
	}
}

//=====================[ SAVING DATA ] =========================================
forward SaveToFile(filename[],text[]);
public SaveToFile(filename[],text[])
{
	#if defined SAVE_LOGS
	new File:LAdminfile, filepath[256], string[256], year,month,day, hour,minute,second;
	getdate(year,month,day); gettime(hour,minute,second);

	format(filepath,sizeof(filepath),"ladmin/logs/%s.txt",filename);
	LAdminfile = fopen(filepath,io_append);
	format(string,sizeof(string),"[%d.%d.%d %d:%d:%d] %s\r\n %d",day,month,year,hour,minute,second,text);
	fwrite(LAdminfile,string);
	fclose(LAdminfile);
	#endif

	return 1;
}
//==============================================================================
forward PlayerTDhide(playerid);
public  PlayerTDhide(playerid)
{
	if(PlayerTDvar[playerid])
	{
		PlayerTextDrawHide(playerid, PlayerTD);
		PlayerTDvar[playerid] = 0;
	}
	return 1;
}

forward IssuerTDhide(playerid);
public  IssuerTDhide(playerid)
{
	if(IssuerTDvar[playerid])
	{
		PlayerTextDrawHide(playerid, IssuerTD);
		IssuerTDvar[playerid] = 0;
	}
	return 1;
}
//==============================================================================
CMD:anims(playerid, params[])
{
	ShowPlayerDialog(playerid, ANIM_DIALOG, DIALOG_STYLE_MSGBOX, "Anim List", "{80C732}/Handsup | /Drunk | /Bomb | /Getarrested | /Laugh | /Robman\n{80C732}/Crossarms | /Lay | /Hide | /Vomit | /Eat | /Wave | /Taichi\n{80C732}/Deal | /Crack | /Smokem | /Smokef | /Sit | /Chat | /Dance | /Fuck", "Close", "");
	return true;
}

CMD:handsup(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);

CMD:cellin(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

CMD:cellout(playerid, params[]) return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

CMD:drunk(playerid, params[]) return AnimLoopPlayer(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,0);

CMD:bomb(playerid, params[]) return	ClearAnimations(playerid),AnimPlayer(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);

CMD:getarrested(playerid, params[]) return AnimLoopPlayer(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // Gun Arrest

CMD:laugh(playerid, params[]) return AnimPlayer(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh

CMD:lookout(playerid, params[]) return AnimPlayer(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout

CMD:robman(playerid, params[]) return AnimLoopPlayer(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob

CMD:crossarms(playerid, params[]) return AnimLoopPlayer(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed

CMD:lay(playerid, params[]) return AnimLoopPlayer(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down

CMD:hide(playerid, params[]) return AnimLoopPlayer(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Taking Cover

CMD:vomit(playerid, params[]) return AnimPlayer(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!

CMD:eat(playerid, params[]) return AnimPlayer(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger

CMD:wave(playerid, params[]) return  AnimLoopPlayer(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave

CMD:slapass(playerid, params[]) return AnimPlayer(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping

CMD:deal(playerid, params[]) return AnimPlayer(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs

CMD:crack(playerid, params[]) return AnimLoopPlayer(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack

CMD:smokem(playerid, params[]) return AnimLoopPlayer(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Smoke

CMD:smokef(playerid, params[]) return AnimLoopPlayer(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Female Smoking

CMD:sit(playerid, params[]) return AnimLoopPlayer(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Sit

CMD:chat(playerid, params[]) return AnimPlayer(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,0);

CMD:fuck(playerid, params[]) return AnimPlayer(playerid,"PED","fucku",4.0,0,0,0,0,0);

CMD:taichi(playerid, params[]) return AnimLoopPlayer(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);

CMD:chairsit(playerid, params[]) return AnimLoopPlayer(playerid,"BAR","dnk_stndF_loop",4.0,1,0,0,0,0);

CMD:dance(playerid, params[])
{
	new dancestyle;
	if(!sscanf(params, "d", dancestyle))
	{
		if(dancestyle == 1) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		else if(dancestyle == 2) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		else if(dancestyle == 3) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		else if(dancestyle == 4) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		else GameTextForPlayer(playerid,"~r~Invalid Dance-id~n~~w~USAGE: ~y~/Dance (1-4)", 3500, 3);
		return true;
	}
	else return GameTextForPlayer(playerid,"~w~USAGE: ~y~/Dance (1-4)", 3500, 3);
}

stock AnimPlayer(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid,
					animlib,
					animname,
					Speed,
					looping,
					lockx,
					locky,
					lockz,
					lp);
	return true;
}

stock AnimLoopPlayer(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	IsPlayerUsingAnims[playerid] = 1;
	ApplyAnimation(playerid,
					animlib,
					animname,
					Speed,
					looping,
					lockx,
					locky,
					lockz,
					lp);
	GameTextForPlayer(playerid, "~w~PRESS ~r~ANY KEY ~w~TO STOP ANIM", 3000, 3);
	return true;
}

stock StopAnimLoopPlayer(playerid)
{
	IsPlayerUsingAnims[playerid] = 0;
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	return true;
}

stock AnimPreloadForPlayer(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
	return true;
}

CMD:radio(playerid, params[])
{
	PlayAudioStreamForPlayer(playerid,"http://streaming.radionomy.com/Classic-Rap");
	return 1;
}

CMD:radiostop(playerid, params[])
{
   SendClientMessage(playerid,0xFFFF00C8,"Stopped all the streamings");
   StopAudioStreamForPlayer(playerid);
   return 1;
}

//=================//
forward scoretimer();
public scoretimer()
{
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(IsPlayerConnected(i))
		{
			seconds[i] += 1;
			switch(seconds[i])
			{
				case 1800:
				{
					GivePlayerScore(i, 5);
					GameTextForPlayer(i,"~n~~w~You get ~g~5 score~n~~w~for playing 30 minutes",3000,3);
				}
				case 3600:
				{
					GivePlayerScore(i, 10);
					GameTextForPlayer(i,"~n~~w~You get ~g~10 score~n~~w~for playing 1 hour",3000,3);
				}
				case 18000:
				{
					GivePlayerScore(i, 50);
					GameTextForPlayer(i,"~n~~w~You get ~g~50 score~n~~w~for playing 5 hours",3000,3);
				}
			}
		}
	}
	return 1;
}
//==============================================================================
CMD:rv(playerid,params[])
{
	if(PlayerInfo[playerid][LoggedIn] != 1) return SendClientMessage(playerid,red,"ERROR: {828282}You must be logged in to use this command.");
	if(PlayerInfo[playerid][Level] < 4) return SendClientMessage(playerid,red,"ERROR: {828282}You are not high enough level to use this command");
	for(new v = 1; v < (MAX_VEHICLES + 1); v++)
	{
		GetVehicleEmpty(v);
		SetVehicleToRespawn(v);
	}
	new string[128];
	format(string,sizeof(string),"Administrator %s has respawned all unused vehicles.",pName(playerid));
	SendClientMessageToAll(blue,string);
	return 1;
}
CMD:respawnvehicle(playerid,params[]) {
	 return cmd_rv(playerid, params);
}
stock GetVehicleEmpty(vehicleid)
{
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(IsPlayerInVehicle(i, vehicleid)) return 0;
	}
	return 1;
}
//==============================================================================
forward stats0();
public stats0()
{
	for(new i, l = GetPlayerPoolSize(); i <= l; i++)
	{
		if(IsPlayerConnected(i))
		{
			new str[150];
			format(str, sizeof(str),"~p~NAME: ~w~%s - ~g~RANK: ~w~%s - ~g~CLASS:~w~%s~n~~p~TEAM: ~w~%s - ~r~KILLS: ~w~%d - ~b~DEATHS: ~w~%d - ~y~Score: ~w~%d",
			pName(i), GetRankName(i), GetClass(i), GetTeamName(i), PlayerInfo[i][Kills], PlayerInfo[i][Deaths], GetPlayerScore(i));
			PlayerTextDrawSetString(i, StatsTD, str);
		}
	}
	return 1;
}

stock GiveCODMoney(playerid, amount)
{
/*	new string[128];
	if(amount < 0) format(string, sizeof(string), "~r~-$%d", amount*-1);
	else if(amount > 0) format(string, sizeof(string), "~g~+$%d", amount);
	GameTextForPlayer(playerid, string, 3000, 1);*/
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	PlayerInfo[playerid][Money] += amount;
	return 1;
}

stock SetCODMoney(playerid, amount)
{
	PlayerInfo[playerid][Money] = amount;
	return 1;
}

stock GetCODMoney(playerid)
{
	new CODMoney;
	CODMoney = PlayerInfo[playerid][Money];
	return CODMoney;
}

stock FixTdBracket(playerid)
{
	new Fixed[MAX_PLAYER_NAME];
	strmid(Fixed, str_replace(']', ')', pName(playerid)), 0, MAX_PLAYER_NAME);
	strmid(Fixed, str_replace('[', '(', Fixed), 0, MAX_PLAYER_NAME);
	return Fixed;
}

stock str_replace(sSearch, sReplace, const sSubject[], &iCount = 0)
{
	new sReturn[128];
	format(sReturn, sizeof(sReturn), sSubject);
	for(new i = 0; i < sizeof(sReturn); i++)
	{
		if(sReturn[i] == sSearch)
		{
			sReturn[i] = sReplace;
		}
	}
	return sReturn;
}

/*
RemoveFromCOD(playerid)
{
	PlayerInfo[playerid][CTagg] = 0;
	new tempname[MAX_PLAYER_NAME];
	format(tempname,MAX_PLAYER_NAME,"%s",PlayerName(playerid));
	new pos = strfind(tempname,"[MW4]",true);
	if(pos != -1)
	{
		strdel(tempname,pos,pos + strlen("[MW4]"));
		SetPlayerName(playerid,tempname);
	}
}

AddToCOD(playerid, place)
{
	switch(place)
	{
		PlayerInfo[playerid][CTagg] = 1;
		case 0:
		{
			new str[MAX_PLAYER_NAME];
			format(str,MAX_PLAYER_NAME,"[MW4]%s", PlayerName(playerid));
			SetPlayerName(playerid,str);
		}
		case 1:
		{
			new str[MAX_PLAYER_NAME];
			format(str,MAX_PLAYER_NAME,"%s[MW4]", PlayerName(playerid));
			SetPlayerName(playerid,str);
		}
	}
}*/

GetWeaponIDFromName(name[])
{
	for(new i; i <= 46; i++)
	{
		switch(i)
		{
			case 0, 19, 20, 21, 44, 45:
			{
				continue;
			}
			default:
			{
				new weapon_name[35];
				GetWeaponName(i, weapon_name, sizeof(weapon_name));
				if (strfind(name, weapon_name, true) != -1)
				{
					return i;
				}
			}
		}
	}
	return -1;
}
//========================================================================================
// COPYRIGHT NOTICE - SIEGE GAMING's CALL OF DUTY : MODERN WARFARE 4 - COPYRIGHT NOTICE //
//========================================================================================
