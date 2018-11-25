///////////////////////////////////////////////////////////////////////
//
//		Exile Occupation by second_coming
//		http://www.exilemod.com/profile/60-second_coming/
//
//              For support, visit:
//              http://www.exilemod.com/topic/12517-release-exile-occupation-roaming-ai-more/
//
//		This script uses the fantastic DMS by Defent and eraser1:
//		http://www.exilemod.com/topic/61-dms-defents-mission-system/
//    
///////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Add the following in your config, don't just replace it with this file :)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Turn Modules On or Off (can be overridden in the map overrides section)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Flamer Setup 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////								

SC_Flamer									= false;						// true if you want Alias Flamer
SC_occupyFlamerStatic   	= false;			    	// true if you want to have random loot crates spawn in pre-defined locations set in SC_occupyLootCratesLocations
SC_occupyFlamerLocations	= [
                                    [1000,1000,0],
                                    [2000,2000,0],
                                    [3000,3000,0],
                                    [4000,4000,0]
                                ];
SC_SpawnFlamerGuards			= true;						// true if you want to enable AI guards
SC_numberofFlamers       	= 1;                    	// if SC_Flamer = true spawn this many Flamer missions (overrided below for Namalsk)
SC_FlamerCrateGuards          	= 4;                    	// number of AI to spawn at each crate
SC_FlamerCrateGuardsRandomize 	= true;                 	// Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupyFlamerMarkers		= true;						// true if you want to have markers on the loot crate spawns

SC_FlamerRopeAttach               	= false;                	// Allow lootcrates to be airlifted (for SC_occupyLootCrates and SC_occupyHeliCrashes)

// Array of possible common items to go in loot crates ["classname",fixed amount,random amount]
// ["Exile_Item_Matches",1,2] this example would add between 1 and 3 Exile_Item_Matches to the crate (1 + 0 to 2 more)
// to add a fixed amount make the second number 0
SC_FlamerItems           	= [
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
                                    ["ItemMap",0,1],											
									["H_PilotHelmetFighter_B",0,1],						  
									["Exile_Item_MetalScrews",0,5]
                            ];
publicVariable "SC_numberofFlamer"; //dont touch this											
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Screamer Setup 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////								

SC_Screamer									= true;						// true if you want Alias Screamer
SC_occupyScreamerStatic   	= false;			    	// true if you want to have random loot crates spawn in pre-defined locations set in SC_occupyLootCratesLocations
SC_occupyScreamerLocations	= [
                                    [1000,1000,0],
                                    [2000,2000,0],
                                    [3000,3000,0],
                                    [4000,4000,0]
                                ];
SC_SpawnScreamerGuards			= true;						// true if you want to enable AI guards
SC_numberofScreamers       	= 1;                    	// if SC_Screamer = true spawn this many Screamer missions (overrided below for Namalsk)
SC_ScreamerCrateGuards          	= 4;                    	// number of AI to spawn at each crate
SC_ScreamerCrateGuardsRandomize 	= true;                 	// Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupyScreamerMarkers		= true;						// true if you want to have markers on the loot crate spawns

SC_ScreamerRopeAttach               	= false;                	// Allow lootcrates to be airlifted (for SC_occupyLootCrates and SC_occupyHeliCrashes)

// Array of possible common items to go in loot crates ["classname",fixed amount,random amount]
// ["Exile_Item_Matches",1,2] this example would add between 1 and 3 Exile_Item_Matches to the crate (1 + 0 to 2 more)
// to add a fixed amount make the second number 0
SC_ScreamerItems           	= [
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
publicVariable "SC_numberofScreamer"; //dont touch this											
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Spectre Setup (Strigoi )
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////								

SC_Spectre									= true;						// true if you want Alias Spectre Missions
SC_occupySpectreStatic   	= false;			    	// true if you want to have random loot crates spawn in pre-defined locations set in SC_occupyLootCratesLocations
SC_occupySpectreLocations	= [
                                    [1000,1000,0],
                                    [2000,2000,0],
                                    [3000,3000,0],
                                    [4000,4000,0]
                                ];
SC_SpawnSpectreGuards			= true;						// true if you want to enable AI guards
SC_numberofSpectres       	= 1;                    	// if SC_Spectre = true spawn this many spectre missions (overrided below for Namalsk)
SC_SpectreCrateGuards          	= 4;                    	// number of AI to spawn at each crate
SC_SpectreCrateGuardsRandomize 	= true;                 	// Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupySpectreMarkers		= true;						// true if you want to have markers on the loot crate spawns

SC_SpectreropeAttach               	= false;                	// Allow lootcrates to be airlifted (for SC_occupyLootCrates and SC_occupyHeliCrashes)

// Array of possible common items to go in loot crates ["classname",fixed amount,random amount]
// ["Exile_Item_Matches",1,2] this example would add between 1 and 3 Exile_Item_Matches to the crate (1 + 0 to 2 more)
// to add a fixed amount make the second number 0
SC_SpectreItems           	= [
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
publicVariable "SC_numberofSpectre"; //dont touch this											
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Fart Setup (ToXic Slug)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////								

SC_Fart									= true;						// true if you want Alias Farty Misisons
SC_occupyFartStatic   	= false;			    	// true if you want to have random loot crates spawn in pre-defined locations set in SC_occupyLootCratesLocations
SC_occupyFartLocations	= [
                                    [1000,1000,0],
                                    [2000,2000,0],
                                    [3000,3000,0],
                                    [4000,4000,0]
                                ];
SC_SpawnFartGuards			= true;						// true if you want to enable AI guards
SC_numberofFarts       	= 1;                    	// if SC_Fart = true spawn this many Fart misisons (overrided below for Namalsk)
SC_FartCrateGuards          	= 4;                    	// number of AI to spawn at each crate
SC_FartCrateGuardsRandomize 	= true;                 	// Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupyFartMarkers		= true;						// true if you want to have markers on the loot crate spawns

SC_FartropeAttach               	= false;                	// Allow lootcrates to be airlifted (for SC_occupyLootCrates and SC_occupyHeliCrashes)

// Array of possible common items to go in loot crates ["classname",fixed amount,random amount]
// ["Exile_Item_Matches",1,2] this example would add between 1 and 3 Exile_Item_Matches to the crate (1 + 0 to 2 more)
// to add a fixed amount make the second number 0
SC_LootFartItems           	= [
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
publicVariable "SC_numberofFarts"; //dont touch this						
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
