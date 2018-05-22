# Alias-Anomaly-Creatures
**Arma3 Exile Anomoly Pack by Alias**

modifed for Arma3 Exile by aussie.

If you like this script please support Alias:
Become a Patron https://www.patreon.com/aliascartoons
Donate a dollar or two https://goo.gl/vTRJru 

Original scripts can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=1123074587


About this script: 

The script places random ToXic field missions on any map with soldiers & anomoly creatures protecting a loot crate. The three creatures are Farty, Sparky & the Screamer. It is very easy to install.

Farty is a smelly green slug creature that appears from the ground to spit tooxic goo on it's enemies.
https://goo.gl/FSK7WV
Sparky is at every mission protecting the loot crate. It cretes electircal shock waves when someone comes to collect the reward.
https://goo.gl/zmJrnL
The Screamer is an anicient statue that screams sonic waves at it's enemies. 
https://goo.gl/Pw6KuQ

The soldiers guarding the mission include up to 4 guards, two static guns and an armed vehicle. The loot in the crate includes a variety of Exile items plus $500 to $20000 poptabs.

**Requirements**
You must have Exile, Dms & Occupation installed for this to work.
Exile http://www.exilemod.com/downloads/
Exile Dms mission System by @Defent: https://goo.gl/R8xjns
Exile Occupation by @second_coming: https://goo.gl/YJjKjW
Edit files with https://notepad-plus-plus.org/download/v7.5.6.html


**Install**

Exile mission file - 
1. Unpack your mission file and drop the folders Al_Farty, Al_screamer, Al_spark & sound in your mission default directory.
2. Edit your description.ext and and add the following:
```
class CfgSounds
{
#include "sound\sounds.hpp"
};
```
(If you already have a class CfgSounds just add in the line: #include "sound\sounds.hpp")
3. Repack your mission file & that bit is done.

a3_exile_occupation - 
1. Open @ExileServer\addons\a3_exile_occupation\config.sqf and set lootcrates to "true":
```
SC_occupyLootCrates		    	= true;						// true if you want to have random loot crates with guards
```
Now find & change the following:
```
SC_SpawnLootCrateGuards			= true;						// true if you want to enable AI guards
SC_numberofLootCrates       	= 2;                    	// if SC_occupyLootCrates = true spawn this many loot crates (overrided below for Namalsk)
SC_LootCrateGuards          	= 4;                    	// number of AI to spawn at each crate
SC_LootCrateGuardsRandomize 	= true;                 	// Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupyLootCratesMarkers		= true;						// true if you want to have markers on the loot crate spawns
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
									                  ["H_PilotHelmetFighter_O",0,1],						  
									                  ["Exile_Item_MetalScrews",0,5]
                                    ];

```

2. Drop the files deleteMapMarkers.sqf, occupationFarty.sqf, occupationScreamer.sqf, startOccupation.sqf into your @ExileServer\addons\a3_exile_occupation\scripts

**JOB DONE, sit back and have a beer.**




