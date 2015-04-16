//////////////////////////////////////////
#define USE_HARDCODED_PWS           (true)  // Use a changing PW list
#define USE_NAME_WHITELIST          (false) // Only players with a listed name
											// can login to the RCON
#define USE_IP_WHITELIST            (false) // Only people with a listed IP
											// can login to the RCON
#define PW_CHANGE_INTERVAL          (120)   // Interval in seconds to change the PWs
#define CLOSE_SERVER_ON_RISK        (false) // Auto-close the server on security risks

#define MAX_PW_LENGTH               (32)
#define MIN_PW_LENGTH               (8)     // Shorter PWs will create security warnings

#pragma unused ipwhitelist , namewhitelist



new pws[][MAX_PW_LENGTH] =              // Change this when using hardcoded
{                                       //
	"saeed@432",                             //
	"abhay@432",                             // SPECIALL MADE FOR KAPIL HAXOR AND ORANGE
	"xenon@432",
	"mex@432"
};

new namewhitelist[][MAX_PLAYER_NAME] =  // Only the names in this list can login
{                                       // as RCON admin, if USE_NAME_WHITELIST
	       "Perfect_Boy"                // is activated
};

new ipwhitelist[][16] =                 // Only the IPs in this list can login
{                                       // as RCON admin, if USE_IP_WHITELIST
	"1"
                         // is activated
};

new currenthcindex;


