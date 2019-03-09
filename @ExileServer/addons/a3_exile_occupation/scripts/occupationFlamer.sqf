private ["_veh","_weed","_weed2","_weed3","_weed4","_weed5","_weed6","_staticGuns","_group","_position"];

if (!isServer) exitWith {};

_logDetail = format ["[OCCUPATION:Flamer]:: Starting Occupation Flamer"];
[_logDetail] call SC_fnc_log;

_logDetail = format["[OCCUPATION:Flamer]:: worldname: %1 crates to spawn: %2",worldName,SC_numberofFlamers];
[_logDetail] call SC_fnc_log;
private _position = [0,0,0];

for "_i" from 1 to SC_numberofFlamers do
{
	_validspot 	= false;
	while{!_validspot} do 
	{
		sleep 0.2;
		if(SC_occupyFlamerStatic) then
		{
			_tempPosition = SC_occupyFlamerLocations call BIS_fnc_selectRandom;
			SC_occupyFlamerLocations = SC_occupyFlamerLocations - _tempPosition;
			
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
	
	_mapMarkerName = format ["Flamer_%1", _i];
	
	if (SC_occupyFlamerMarkers) then 
	{		
		_event_marker = createMarker [_mapMarkerName, _position];
		_event_marker setMarkerColor "ColorRed";
		_event_marker setMarkerAlpha 1;
		_event_marker setMarkerText "Flamer: bring grenades";
		_event_marker setMarkerType "ExileContaminatedZoneIcon";
	};	
	
null = [_mapMarkerName,200,0.1,400] execVM "AL_Flamer\al_flamer.sqf";
	//	null = ["Flamer_2"] execVM "AL_Flamer\Flamer.sqf";
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";
	//	null = ["Flamer_2","H_PilotHelmetFighter_B",false,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";	
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";
	//	null = ["Flamer_2","H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";	

	if (SC_SpawnFlamerGuards) then
	{
			//Infantry spawn using DMS
			_AICount = SC_FlamerCrateGuards;
			
			if(SC_FlamerCrateGuardsRandomize) then 
			{
				_AICount = 1 + (round (random (SC_FlamerCrateGuards-1)));    
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
					"MMG_01_hex_F",
					["muzzle_snds_93mmg","optic_AMS","bipod_03_F_blk"],
					[["150Rnd_93x64_Mag",2],["Titan_AT",1]],          
					"",
					[""],
					["Rangefinder","ItemGPS"],
					"launch_O_Titan_short_ghex_F",
					"H_PilotHelmetFighter_B", // helmet
					"CUP_U_C_Fireman_01",  // uniform
					"CUP_V_PMC_CIRAS_Black_Grenadier",  //vest
					"CUP_B_USPack_Black" //backpack
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
				
				_logDetail = format ["[OCCUPATION:Flamer]::  Creating crate %3 at drop zone %1 with %2 guards",_position,_AICount,_i];
				[_logDetail] call SC_fnc_log;		
			};
	}
	else
	{
		_logDetail = format ["[OCCUPATION:Flamer]::  Creating crate %2 at drop zone %1 with no guards",_position,_i];
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
	
	_box enableRopeAttach SC_FlamerRopeAttach; 	// Stop people airlifting the crate
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
	}forEach SC_FlamerItems;	
	
	
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

					["toastRequest", ["InfoTitleAndText", ["The Flamer has arrived!", "Better get some grenades or prepare to become the human BBQ."]]] call ExileServer_system_network_send_broadcast;			
					
// mission objects
private _objects = [
	["Land_CamoNet_EAST",[1.39233,27.269,0],184.705,[true,false]],
	["Land_BarrelWater_F",[13.1292,-16.625,0],359.981,[true,false]],
	["Land_Barrack2",[10.629,-20.75,0],0,[true,false]],
	["Land_WoodenBox_F",[13.9811,-21.2529,0],90,[true,false]],
	["Land_MetalBarrel_F",[7.12891,-18.75,0],179.973,[true,false]],
	["Land_MetalBarrel_F",[7.07861,-17.9131,0],150.007,[true,false]],
	["Land_Barrack2",[-9.24597,-20.75,0],0,[true,false]],
	["Land_Barrack2",[0.754028,-20.625,0],0,[true,false]],
	["Land_CratesWooden_F",[-4.38098,-20.6709,0],270,[true,false]],
	["Land_Fire_barrel_burning",[4.79272,-14.0034,0],0,[true,false]],
	["Land_Fire_barrel_burning",[22.3358,17.0479,0],0,[true,false]],
	["Land_Fire_barrel_burning",[-10.8929,24.8501,0],0,[true,false]],
	["Land_Fire_barrel_burning",[-25.645,6.40869,0],0,[true,false]],
	["Land_Fire_barrel_burning",[-16.9799,-16.3359,0],0,[true,false]],
	["Land_Fire_barrel_burning",[16.5269,-12.8003,0],0,[true,false]],
	["Land_Cargo_Tower_V1_No7_F",[-23.0068,3.10596,0],0,[true,false]],
	["Land_Lampa_ind_zebr",[-16.7657,8.49121,4.76837e-007],0,[true,false]],
	["Land_Lampa_ind_zebr",[-17.9209,-3.23438,4.76837e-007],0,[true,false]],
	["Land_Lamp_Small_EP1",[-5.11731,-17.1567,0],192.221,[true,false]],
	["Land_Lamp_Small_EP1",[6.00952,-16.9814,0],192.222,[true,false]],
	["BRDMWreck",[27.6381,-8.5332,0],51.7609,[true,false]],
	["Land_Wreck_HMMWV_F",[25.4366,20.7632,0],315.169,[true,false]],
	["Land_Wreck_CarDismantled_F",[-24.4177,14.9077,0],219.485,[true,false]],
	["Land_Wreck_Hunter_F",[-21.8005,-10.9443,0],140.685,[true,false]],
	["Mi8Wreck",[35.0742,5.97803,0],352.111,[true,false]],
	["datsun02Wreck",[23.7583,-14.6792,0],233.505,[true,false]],
	["Land_Wreck_AFV_Wheeled_01_F",[-15.3654,28.9819,0],63.7861,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[4.2207,26.5293,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-26.5548,2.44775,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-1.8728,27.2144,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-1.8728,27.2144,0],0,[true,false]],
	["Land_Lampa_ind_zebr",[2.23035,30.4106,4.76837e-007],80.6896,[true,false]]
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


