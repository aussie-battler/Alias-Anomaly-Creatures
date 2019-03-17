private ["_veh","_weed","_weed2","_weed3","_weed4","_weed5","_weed6","_staticGuns","_group","_position"];

if (!isServer) exitWith {};

_logDetail = format ["[OCCUPATION:Farty]:: Starting Occupation Farty"];
[_logDetail] call SC_fnc_log;

_logDetail = format["[OCCUPATION:Farty]:: worldname: %1 crates to spawn: %2",worldName,SC_numberofFarts];
[_logDetail] call SC_fnc_log;
private _position = [0,0,0];

for "_i" from 1 to SC_numberofFarts do
{
	_validspot 	= false;
	while{!_validspot} do 
	{
		sleep 0.2;
		if(SC_occupyFartStatic) then
		{
			_tempPosition = SC_occupyFartLocations call BIS_fnc_selectRandom;
			SC_occupyFartLocations = SC_occupyFartLocations - _tempPosition;
			
			_position = [_tempPosition select 0, _tempPosition select 1, _tempPosition select 2];
			if(isNil "_position") then
			{
				_position = [ false, false ] call SC_fnc_findsafePos;
			};
		}
		else
		{
			_position = [ false, false ] call SC_fnc_findsafePos;
		};
		
		_validspot	= true;
		
		//Check if near another crate site
		_nearOtherCrate = (nearestObjects [_position,["CargoNet_01_box_F"],500]) select 0;	
		if (!isNil "_nearOtherCrate") then { _validspot = false; };			
	};	
	
	_mapMarkerName = format ["Toxic_%1", _i];
	
	if (SC_occupyFartMarkers) then 
	{		
		_event_marker = createMarker [_mapMarkerName, _position];
		_event_marker setMarkerColor "ColorGreen";
		_event_marker setMarkerAlpha 1;
		_event_marker setMarkerText "Toxic Slug: bring grenades";
		_event_marker setMarkerType "ExileContaminatedZoneIcon";
	};	
	
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",true,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";	
	//null = ["Toxic_2","H_PilotHelmetFighter_B",true,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";
	//null = ["Toxic_3","H_CrewHelmetHeli_B",true,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";	
	//null = ["Toxic_4","H_CrewHelmetHeli_B",true,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";		
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";
	
	if (SC_SpawnFartGuards) then
	{
			//Infantry spawn using DMS
			_AICount = SC_FartCrateGuards;
			
			if(SC_FartCrateGuardsRandomize) then 
			{
				_AICount = 1 + (round (random (SC_FartCrateGuards-1)));    
			};

			if(_AICount > 0) then
			{
				_spawnPosition = [_position select 0, _position select 1, 0];
				
				_initialGroup = createGroup SC_BanditSide;
				_initialGroup setCombatMode "BLUE";
				_initialGroup setBehaviour "SAFE";
				
				for "_i" from 1 to _AICount do
				{		
					_customGearSet =
				[
					"srifle_DMR_05_blk_F",
					["muzzle_snds_93mmg","optic_AMS","bipod_01_F_blk"],
					[["10Rnd_93x64_DMR_05_Mag",6],["Titan_AT",2]],          
					"",
					[""],
					["Rangefinder","ItemGPS"],
					"launch_O_Titan_short_ghex_F",
					"H_PilotHelmetFighter_B",
					"U_I_Protagonist_VR",
					"CUP_V_PMC_IOTV_Black_TL",
					"CUP_B_UAVTerminal_Black"
				];
					_unit = [_initialGroup,_spawnPosition,"custom","random","bandit","soldier",_customGearSet] call DMS_fnc_SpawnAISoldier; 
					_unitName = ["bandit"] call SC_fnc_selectName;
					if(!isNil "_unitName") then { _unit setName _unitName; }; 
					reload _unit;
				};
				
				// Get the AI to shut the fuck up :)
				enableSentences true;
				enableRadio true;

				  
				_group = createGroup SC_BanditSide;           
				_group setVariable ["DMS_LockLocality",nil];
				_group setVariable ["DMS_SpawnedGroup",true];
				_group setVariable ["DMS_Group_Side", SC_BanditSide];
				_group setVariable ["VCM_TOUGHSQUAD",true];
				_group setVariable ["VCM_NORESCUE",true];
				_group setVariable ["Vcm_Disable",true];
				{	
					_unit = _x;           
					[_unit] joinSilent grpNull;
					[_unit] joinSilent _group;
					_unit setCaptive false;                               
				}foreach units _initialGroup;  		
				deleteGroup _initialGroup;
				
				[_group, _spawnPosition, 25] call bis_fnc_taskPatrol;
				_group setBehaviour "STEALTH";
				_group setCombatMode "RED";
				
					// add vehicle patrol and randomise a little - same for all levels (as it uses variable)
				_veh =
				[
					[
						[(_position select 0) -(25-(random 25)),(_position select 1) +(25+(random 25)),0]
					],
					_group,
					"assault",
					"hardcore",
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIVehicle;		
				
				_group setVariable ["VCM_TOUGHSQUAD",true];
				_group setVariable ["VCM_NORESCUE",true];
				_group setVariable ["Vcm_Disable",true];
				
				_logDetail = format ["[OCCUPATION:Farty]::  Creating crate %3 at drop zone %1 with %2 guards",_position,_AICount,_i];
				[_logDetail] call SC_fnc_log;		
			};
	}
	else
	{
		_logDetail = format ["[OCCUPATION:Farty]::  Creating crate %2 at drop zone %1 with no guards",_position,_i];
		[_logDetail] call SC_fnc_log;	
	};

    _weed1 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) - 25, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed2 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) - 8, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed3 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) + 15, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed4 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) + 5, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed5 = createVehicle ["Land_DPP_01_transformer_F",[(_position select 0) - 3, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed6 = createVehicle ["Mass_grave",[(_position select 0) - 10, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];

	_box = "CargoNet_01_box_F" createvehicle _position;
	clearMagazineCargoGlobal _box;
	clearWeaponCargoGlobal _box;
	clearItemCargoGlobal _box;
	
	_box enableRopeAttach SC_FartropeAttach; 	// Stop people airlifting the crate
	_box setVariable ["permaLoot",true]; 	// Crate stays until next server restart
	_box setVariable ["ExileMoney",16000,true]; //Adds 25,000 poptabs to the box/container/crate referred to as "_crate1"
	_box allowDamage false; 				// Stop crates taking damage

	{
		_item = _x select 0;
		_amount = _x select 1;
		_randomAmount = _x select 2;
		_amount = _amount + (random _randomAmount);
		_itemType = _x call BIS_fnc_itemType;
		
		
		if((_itemType select 0) == "Weapon") then
		{
			_box addWeaponCargoGlobal [_item, _amount];	
		};
		if((_itemType select 0) == "Magazine") then
		{
			_box addMagazineCargoGlobal [_item, _amount];	
		};
		if((_itemType select 0) == "Item") then
		{
			_box addItemCargoGlobal [_item, _amount];	
		};
		if((_itemType select 0) == "Equipment") then
		{
			_box addItemCargoGlobal [_item, _amount];	
		};	
		if((_itemType select 0) == "Backpack") then
		{
			_box addBackpackCargoGlobal [_item, _amount];	
		};			
	}forEach SC_LootFartItems;	
	
					["toastRequest", ["InfoTitleAndText", ["A Slimy Fart is in the swamp!", "Better get some grenades or prepare to be destroyed."]]] call ExileServer_system_network_send_broadcast;			
					
	_effect = "test_EmptyObjectForSmoke";	
	_wreckFire = _effect createVehicle (position _weed5);   
	_wreckFire attachto [_weed5, [0,0,-1]];
	
// add static guns - same for all levels
_staticGuns =
[
	[
		// make statically positioned relative to centre point and randomise a little
	//	[(_pos select 0) -(25-(random 1)),(_pos select 1)+(25-(random 1)),0], 
	//	[(_pos select 0) -(45-(random 1)),(_pos select 1)+(45-(random 1)),0],
		[(_position select 0) +(45-(random 10)),(_position select 1)-(45-(random 10)),0],
		[(_position select 0) +(25-(random 10)),(_position select 1)-(25-(random 10)),0]
	],
	_group,
	"assault",
	"difficult",
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;					   
	// Add a wreck for defensive purposes
	_wrecks = selectRandom [
							"CUP_A2_oil_pump_ep1",
							"Land_AncientHead_01_F",
							"Land_AncientStatue_02_F",
							"Land_Slum_House03_F",
							"Land_Slum_House02_F",
							"Land_cargo_house_slum_F",
							"Land_Slum_03_F",
							"Land_Slum_House01_F"
							];
							
	_vehWreck = _wrecks createVehicle [0,0,0];
	//null = ["Toxic","H_CrewHelmetHeli_B",true,30,0.01,true,7] execVM "AL_farty\area_toxic_ini.sqf";

	/*
	_effect = "test_EmptyObjectForSmoke";	
	if(SC_HeliCrashesOnFire) then 
	{
		_effect = "test_EmptyObjectForFireBig";	
	};
	_wreckFire = _effect createVehicle (position _vehWreck);   
	_wreckFire attachto [_vehWreck, [0,0,-1]];
	*/
	
	_vehWreckRelPos = _box getRelPos [(10 + (ceil random 15)), (random 360)];
	_vehWreck setPos _vehWreckRelPos;
	_vehWreck setDir (random 360);
	_vehWreck setVectorUp surfaceNormal position _vehWreck;
};


	//null = ["Toxic_2","H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";	
	//null = ["Toxic_3","H_CrewHelmetHeli_B",false] execvm "AL_spark\al_sparky.sqf";
	//null = ["Toxic_4","H_CrewHelmetHeli_B",false] execvm "AL_spark\al_sparky.sqf";		