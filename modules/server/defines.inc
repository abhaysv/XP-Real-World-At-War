
	
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))	
	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#define MAX_ARMOUR (99.0)
#define DIALOG_PRAVILA (1000) // 1000 = DIALOG ID
#define ResetMoneyBar ResetPlayerMoney
#define UpdateMoneyBar GivePlayerMoney
#define MAX_PING 600//////
#define GetPlayerSpeed




//-----------------------------------------------------------------------------------//
//--------
#define USE_MENUS       	// Comment to remove all menus.  Uncomment to enable menus
//#define DISPLAY_CONFIG 	// displays configuration in console window on filterscript load
#define SAVE_LOGS           // Comment if your server runs linux (logs wont be saved)
#define ENABLE_SPEC         // Comment if you are using a spectate system already
#define USE_STATS
#define ANTI_MINIGUN
//#define USE_AREGISTER       // Changes /register, /login etc to  /areister, /alogin etc
//#define HIDE_ADMINS 		// Displays number of admins online instead of level and names
#define ENABLE_FAKE_CMDS   	// Comment to disable /fakechat, /fakedeath, /fakecmd commanads


//=============================================================================================//
#define MAX_WARNINGS 5      // /warn command

#define MAX_REPORTS 20
#define MAX_BANS 20
#define MAX_CHAT_LINES 7

#define SPAM_MAX_MSGS 5
#define SPAM_TIMELIMIT 8 // SECONDS

#define PING_MAX_EXCEEDS 4
#define PING_TIMELIMIT 60 // SECONDS

#define MAX_FAIL_LOGINS 3