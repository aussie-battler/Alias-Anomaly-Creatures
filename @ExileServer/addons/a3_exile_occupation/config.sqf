////////////////////////////////////////////////////////////////////////
//
//		Exile Occupation by second_coming
//		http://www.exilemod.com/profile/60-second_coming/
//
//      For support, visit:
//      http://www.exilemod.com/topic/12517-release-exile-occupation-roaming-ai-more/
//
//		This script uses the fantastic DMS by Defent and eraser1:
//		http://www.exilemod.com/topic/61-dms-defents-mission-system/
//    
////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Modify the following in your config, don't just replace it with this file :)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Turn Modules On or Off (can be overridden in the map overrides section)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SC_occupyLootCrates		    	= true;						// true if you want to have random loot crates with guards


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Loot Crate Setup
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////								


SC_occupyLootCratesStatic   	= false;			    	// true if you want to have random loot crates spawn in pre-defined locations set in SC_occupyLootCratesLocations
SC_occupyLootCratesLocations	= [
                                    [1000,1000,0],
                                    [2000,2000,0],
                                    [3000,3000,0],
                                    [4000,4000,0]
                                ];
SC_SpawnLootCrateGuards			= true;						// true if you want to enable AI guards
SC_numberofLootCrates       	= 2;                    	// if SC_occupyLootCrates = true spawn this many loot crates (overrided below for Namalsk)
SC_LootCrateGuards          	= 4;                    	// number of AI to spawn at each crate
SC_LootCrateGuardsRandomize 	= true;                 	// Use a random number of guards up to a maximum = SC_LootCrateGuards (so between 1 and SC_LootCrateGuards)
SC_occupyLootCratesMarkers		= true;						// true if you want to have markers on the loot crate spawns

SC_ropeAttach               	= false;                	// Allow lootcrates to be airlifted (for SC_occupyLootCrates and SC_occupyHeliCrashes)

// Array of possible common items to go in loot crates ["classname",fixed amount,random amount]
// ["Exile_Item_Matches",1,2] this example would add between 1 and 3 Exile_Item_Matches to the crate (1 + 0 to 2 more)
// to add a fixed amount make the second number 0
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
