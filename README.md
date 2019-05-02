# Alias-Anomaly-Creatures
**Arma3 Exile Anomaly Pack by Alias**

modified for Arma3 Exile by aussie.

If you like this script please support Alias:
Become a Patron https://www.patreon.com/aliascartoons

Donate a dollar or two to keep more mods.

Original scripts can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=1123074587

Shout out to @kuplion who gave me the idea to add random objects & smoke into these missions.<br />
![Farty](https://media.discordapp.net/attachments/281649762934194187/448403282315182085/20180519222528_1.jpg)
**About this script:**

The script places random ToXic field missions on any map with soldiers & anomaly creatures protecting a loot crate. The four creatures are Farty, Sparky, Strigoi & the Screamer. All creatures can be destroyed with explosives, under-barrel launchers or grenades. It is very easy to install.

**Farty** is a smelly green slug creature that appears from the ground to spit toXic goo on it's enemies.
https://goo.gl/FSK7WV

**Sparky** is at every mission protecting the loot crate. It creates electrical shock waves when someone comes to collect the reward.
https://goo.gl/zmJrnL

**The Screamer** is an ancient statue that screams sonic waves at it's enemies. 
https://goo.gl/Pw6KuQ

**STRIGOI** a spectre that runs at lightening speeds with the abilty to jump into tree tops for cover. 
https://goo.gl/cEZcp6

**Flamer** a fire demon that shoots fire balls and sets the ground of it's enemies on fire. 
https://goo.gl/ZKM1CH

The soldiers guarding the mission include up to 4 guards, two static guns and an armed vehicle. The loot in the crate includes a variety of Exile items plus $500 to $20000 poptabs.

**Requirements**
You must have Exile, Dms & Occupation installed for this to work.<br />
Exile http://www.exilemod.com/downloads/<br />
Exile Dms mission System by @Defent: https://goo.gl/R8xjns<br />
Exile Occupation by @second_coming: https://goo.gl/YJjKjW<br />
Edit files with https://notepad-plus-plus.org/download/v7.5.6.html<br />


**Install**

Exile mission file - <br />
1. Unpack your mission file and drop the folders Al_Farty, Al_screamer, Al_spark & sound in your mission default directory.<br />
2. Edit your description.ext and and add the following:
```
class CfgSounds
{
#include "sound\sound_farty\sound.hpp"
#include "sound\sound_screamer\sound.hpp"
#include "sound\sound_sparky\sound.hpp"
#include "sound\sound_strigoi\sound.hpp"
#include "sound\sound_flamer\sound.hpp"
};
```
If you already have a class CfgSounds just add these lines into it:   
```
#include "sound\sound_farty\sound.hpp"
#include "sound\sound_screamer\sound.hpp"
#include "sound\sound_sparky\sound.hpp"
#include "sound\sound_strigoi\sound.hpp"
#include "sound\sound_flamer\sound.hpp"
```
3. Repack your mission file & that bit is done.

a3_exile_occupation - 
1. Open @ExileServer\addons\a3_exile_occupation\config.sqf and:
   + Just below"SC_occupyHeliCrashes = true; // true if you want to have Dayz style helicrashes.
     Paste in the Fart Setup (ToXic Slug), Screamer Setup & Spectre Setup (Strigoi) code. 
   + Turn off Anomalies by setting the first line in each section to false. You can also configure each anomaly to your liking.
```
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Screamer Setup 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
```
Now find & change the following if needed:
```
SC_Screamer     		= true;		// true if you want Alias Screamer
SC_occupyScreamerStatic         = false;       // true if you want to have random loot crates spawn in pre-defined locations set in SC_occupyLootCratesLocations
SC_occupyScreamerLocations	= [
                                    [1000,1000,0],
                                    [2000,2000,0],
                                    [3000,3000,0],
                                    [4000,4000,0]
                                ];
SC_SpawnScreamerGuards			= true;		// true if you want to enable AI guards
SC_numberofScreamers       	        = 2; 	// if SC_Screamer = true spawn this many Screamer missions (overrided below for Namalsk)
SC_ScreamerCrateGuards          	= 4;     // number of AI to spawn at each crate
SC_ScreamerCrateGuardsRandomize 	= true;  // Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupyScreamerMarkers		= true;	 // true if you want to have markers on the loot crate spawns

SC_ScreamerRopeAttach               	= false;   // Allow lootcrates to be airlifted (for SC_occupyLootCrates and SC_occupyHeliCrashes)
```
Change the loot gear by searching for SC_LootCrateItems, here is mine:
```
SC_LootCrateItems           	= [
                                    ["Exile_Melee_Axe",1,0],
                                    ["Exile_Item_GloriousKnakworst",1,2],
                                    ["Exile_Item_PlasticBottleFreshWater",1,2],
                                    ["Exile_Item_Knife",5,1],
                                    ["Exile_Item_BaseCameraKit",0,2],
                                    ["Exile_Item_InstaDoc",1,3],
                                    ["Exile_Item_Matches",1,0],
                                    ["Exile_Item_CookingPot",1,0],                      
                                    ["Exile_Item_MetalPole",1,0],
                                    ["Exile_Item_CodeLock",1,2],
                                    ["Exile_Item_FuelCanisterEmpty",1,0],
                                    ["Exile_Item_WoodPlank",0,8],
                                    ["Exile_Item_woodFloorKit",0,2],
                                    ["Exile_Item_WoodWindowKit",0,1],
                                    ["Exile_Item_WoodDoorwayKit",0,1],
                                    ["Exile_Item_WoodFloorPortKit",0,2],   
                                    ["Exile_Item_Laptop",0,1],
                                    ["Exile_Item_CodeLock",0,1],
				    ["Exile_Item_Cement",2,10],
				    ["Exile_Item_Sand",2,10],
				    ["Exile_Item_MetalWire",1,5],
      				    ["Exile_Item_WaterCanisterEmpty",0,2],
				    ["Exile_Item_Shovel",0,1],
				    ["Exile_Item_SafeKit",1,2],
				    ["H_PilotHelmetFighter_B",0,1],						  
				    ["Exile_Item_MetalScrews",0,5]
                            ];        
			    
```
2. Drop the files deleteMapMarkers.sqf, occupationFarty.sqf, occupationScreamer.sqf, occupationSpectre.sqf, startOccupation.sqf 
   into your @ExileServer\addons\a3_exile_occupation\scripts folder.

3. Add thus to your mission file initServer.sqf:
```
#include "AL_flamer\functions_flame.hpp"
```

   
**JOB DONE, sit back and have a beer.**
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

**Optional Mods**
+ Change the soldier's uniform in occupationFarty.sqf & occupationScreamer.sqf
```
					_customGearSet =
				[
					"srifle_DMR_05_blk_F",
					["muzzle_snds_93mmg","optic_AMS","bipod_01_F_blk"],
					[["10Rnd_93x64_DMR_05_Mag",6],["Titan_AT",2]],          
					"",
					[""],
					["Rangefinder","ItemGPS"],
					"launch_O_Titan_short_ghex_F",
					"H_PilotHelmetFighter_B",  //helmet (leave this, it is the protection against Sparky's damage)
					"U_I_Protagonist_VR",   //the ai uniform
					"V_PlateCarrierIAGL_dgtl", //vest
					"B_Carryall_ghex_F"  //backpack
				];
```
+ Add a weed crop by uncommenting CUP_A2_p_fiberplant_ep1 in occupationFarty.sqf, occupationSpectre.sqf & occupationScreamer.sqf  
+ Harvest the weed adding this cool script by @GolovaRaoul http://www.exilemod.com/topic/24426-harvest-weed/
+ Change the loot $$cash$$ amount search for:
```
_box setVariable ["ExileMoney", (5000 + round (random (20000))),true];//Adds between $5K to $20K in poptabs to the loot crate
```
in occupationFarty.sqf & occupationScreamer.sqf  

+ Sparky now deals damage, players can wear / have a protective item to avoid it.   
  The protection is defined in Exile.Mission\\AL_spark\al_orb_move.sqf in line 6:
```
         obj_prot_sparky = "H_PilotHelmetFighter_B";  // I set it to the helmet worn by the mission ai.   
```	 
Need HELP??   
Head to the forums here: http://www.exilemod.com/topic/26451-release-anomaly-creatures-pack-by-alias/#comment-192572

![Sparky](https://media.discordapp.net/attachments/288089861955518465/447418006927179776/20180519203800_1.jpg)
![The Screamer](https://media.discordapp.net/attachments/288089861955518465/447777316731355146/20180520234416_2.jpg)
![Farty](https://media.discordapp.net/attachments/281649762934194187/448403282356862977/20180519231141_1.jpg)
![Spectre](https://cdn.discordapp.com/attachments/281649762934194187/451072062606540811/20180529013425_1.jpg)  

**Updates 5.06.18**  

+ Configured an easy setup for each Anomaly in: @ExileServer\addons\a3_exile_occupation\config.sqf  

+ Added toast success hint at the end of each misison. Configure it here:  

  @ExileServer\addons\a3_exile_occupation\scripts\deleteMapMarkers.sqf  

+ Anomalies wont depawn when the map marker deletes (except for Farty).   
  I extended the player detection range for Farty so you can't run in & delete the map marker (removing the Farty Slug).    


![Spectre](https://cdn.discordapp.com/attachments/331697969231298562/453286560821936130/20180605040854_1.jpg)  

**Updates 26.11.18**  

+ Randomly spawn one of the Anomaly missons on each server restart found in: 
  @ExileServer\addons\a3_exile_occupation\startOccupation.sqf  

+ Added toast messages at the start of each misison. Configure it here:  

  @ExileServer\addons\a3_exile_occupation\scripts
  occupationFarty.sqf, occupationFlamer.sqf, occupationScreamer.sqf, occupationSpectre.sqf.

+ Changed the sparky code to deal damage if you dont wear the protective helmet.

+ Added the Flamer mission.

![Flamer](https://cdn.discordapp.com/attachments/382927612210708494/516205352002387968/20181125212055_1.jpg)  
![Flamer](https://goo.gl/tCFH7z)  

