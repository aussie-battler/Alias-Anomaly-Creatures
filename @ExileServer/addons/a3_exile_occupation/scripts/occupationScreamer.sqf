private ["_veh","_weed","_weed2","_weed3","_weed4","_weed5","_weed6","_staticGuns","_group","_position"];

if (!isServer) exitWith {};

_logDetail = format ["[OCCUPATION:Screamer]:: Starting Occupation Screamer"];
[_logDetail] call SC_fnc_log;

_logDetail = format["[OCCUPATION:Screamer]:: worldname: %1 crates to spawn: %2",worldName,SC_numberofScreamers];
[_logDetail] call SC_fnc_log;
private _position = [0,0,0];

for "_i" from 1 to SC_numberofScreamers do
{
	_validspot 	= false;
	while{!_validspot} do 
	{
		sleep 0.2;
		if(SC_occupyScreamerStatic) then
		{
			_tempPosition = SC_occupyScreamerLocations call BIS_fnc_selectRandom;
			SC_occupyScreamerLocations = SC_occupyScreamerLocations - _tempPosition;
			
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
	
	_mapMarkerName = format ["Screamer_%1", _i];
	
	if (SC_occupyScreamerMarkers) then 
	{		
		_event_marker = createMarker [_mapMarkerName, _position];
		_event_marker setMarkerColor "ColorGreen";
		_event_marker setMarkerAlpha 1;
		_event_marker setMarkerText "Screamer: bring grenades";
		_event_marker setMarkerType "ExileContaminatedZoneIcon";
	};	
	
	null = [_mapMarkerName] execVM "AL_screamer\screamer.sqf";
	//	null = ["screamer_2"] execVM "AL_screamer\screamer.sqf";
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";
	//	null = ["screamer_2","H_PilotHelmetFighter_B",false,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";	
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";
	//	null = ["screamer_2","H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";	

	if (SC_SpawnScreamerGuards) then
	{
			//Infantry spawn using DMS
			_AICount = SC_ScreamerCrateGuards;
			
			if(SC_ScreamerCrateGuardsRandomize) then 
			{
				_AICount = 1 + (round (random (SC_ScreamerCrateGuards-1)));    
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
					"CUP_lmg_m249_SQuantoon",
					["muzzle_snds_M","optic_SOS","CUP_acc_Flashlight"],
					[["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",2],["Titan_AT",1]],          
					"",
					[""],
					["Rangefinder","ItemGPS"],
					"launch_O_Titan_short_ghex_F",
					"H_PilotHelmetFighter_B", // helmet
					"ADF_Base_UM",  // uniform
					"ADF_PlateCarrierK_A1",  //vest
					"ADF_KitbagAT_AC" //backpack
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
						[(_position select 0) -(35-(random 5)),(_position select 1) +(35+(random 5)),0]
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
				
				_logDetail = format ["[OCCUPATION:Screamer]::  Creating crate %3 at drop zone %1 with %2 guards",_position,_AICount,_i];
				[_logDetail] call SC_fnc_log;		
			};
	}
	else
	{
		_logDetail = format ["[OCCUPATION:Screamer]::  Creating crate %2 at drop zone %1 with no guards",_position,_i];
		[_logDetail] call SC_fnc_log;	
	};
/*
    _weed1 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) - 25, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed2 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) - 8, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed3 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) + 15, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed4 = createVehicle ["CUP_A2_p_fiberplant_ep1",[(_position select 0) + 5, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed5 = createVehicle ["Land_DPP_01_transformer_F",[(_position select 0) - 3, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
	_weed6 = createVehicle ["Mass_grave",[(_position select 0) - 10, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
*/	


	_box = "CargoNet_01_box_F" createvehicle _position;
	clearMagazineCargoGlobal _box;
	clearWeaponCargoGlobal _box;
	clearItemCargoGlobal _box;
	
	_box enableRopeAttach SC_ScreamerRopeAttach; 	// Stop people airlifting the crate
	_box setVariable ["permaLoot",true]; 	// Crate stays until next server restart
	_box setVariable ["ExileMoney", (5000 + round (random (20000))),true];
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
	}forEach SC_ScreamerItems;	
	
	
	_effect = "test_EmptyObjectForSmoke";	
	_wreckFire = _effect createVehicle (position _box);   
	_wreckFire attachto [_box, [0,0,-1]];
	
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

					["toastRequest", ["InfoTitleAndText", ["A screamer is on a warpath!", "Better get some grenades or dig your grave."]]] call ExileServer_system_network_send_broadcast;			
// mission objects
		private _objects = [
	["Land_AncientHead_01_F",[-0.447754,-12.2441,0],180,[true,false]],
	["Land_AncientStatue_01_F",[-14.0044,-0.165527,0],284.614,[true,false]],
	["Land_AncientStatue_01_F",[12.9238,2.74658,0],80.3488,[true,false]],
	["Land_AncientStatue_01_F",[0.0488281,15.7905,0],5.83839,[true,false]],
	["Land_AncientStatue_02_F",[-6.80859,-12.3301,0],269.078,[true,false]],
	["Land_AncientStatue_02_F",[7.09717,-13.1284,0],91.2094,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[12.9282,2.64453,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-13.062,-0.0585938,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-6.83789,-11.8901,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[0.144531,15.3569,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[6.91992,-13.3188,0],0,[true,false]],
	["GraveCross1",[-9.59521,10.9609,0],0,[true,false]],
	["GraveCross1",[8.21924,11.3696,0],0,[true,false]]
];

private _center = [_position select 0, _position select 1, 0];
{
	private _object = (_x select 0) createVehicle [0,0,0];
	_object setDir (_x select 2);
	_object setPosATL (_center vectorAdd (_x select 1));
	_object enableSimulationGlobal ((_x select 3) select 0);
	_object allowDamage ((_x select 3) select 1);
} forEach _objects;
};


