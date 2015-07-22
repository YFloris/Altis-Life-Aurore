#include <macro.h>
/*
	File: fn_useItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main function for item effects and functionality through the player menu.
*/
private "_item";
disableSerialization;
if(EQUAL(lbCurSel 2005,-1)) exitWith {hint localize "STR_ISTR_SelectItemFirst";};
_item = CONTROL_DATA(2005);

switch (true) do {
	case (_item in ["waterBottle","coffee","redgull","coca","tea"]): {
		if(([false,_item,1] call life_fnc_handleInv)) then {
			life_thirst = 100;
			if(EQUAL(LIFE_SETTINGS(getNumber,"enable_fatigue"),1)) then {player setFatigue 0;};
			if(EQUAL(_item,"redgull") && {EQUAL(LIFE_SETTINGS(getNumber,"enable_fatigue"),1)}) then {
				[] spawn {
					life_redgull_effect = time;
					titleText[localize "STR_ISTR_RedGullEffect","PLAIN"];
					player enableFatigue false;
					waitUntil {!alive player OR ((time - life_redgull_effect) > (3 * 60))};
					player enableFatigue true;
				};
			};
		};
	};
	
	case (EQUAL(_item,"boltcutter")): {
		[cursorTarget] spawn life_fnc_boltcutter;
		closeDialog 0;
	};
	
	case (EQUAL(_item,"blastingcharge")): {
		player reveal fed_bank;
		(group player) reveal fed_bank;
		[cursorTarget] spawn life_fnc_blastingCharge;
	};
	
	case (EQUAL(_item,"gpstracker")): 
	{
		[cursorTarget] spawn life_fnc_gpsTracker;
	};
	
	case (EQUAL(_item,"defusekit")): {
		[cursorTarget] spawn life_fnc_defuseKit;
	};
	
	case (_item in ["storagesmall","storagebig"]): {
		[_item] call life_fnc_storageBox;
	};
	
	case (EQUAL(_item,"spikeStrip")): {
		if(!isNull life_spikestrip) exitWith {hint localize "STR_ISTR_SpikesDeployment"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_spikeStrip;
		};
	};
	
	case (EQUAL(_item,"mauer")): {
		if(!isNull life_mauer) exitWith {hint "Tu as deja une barriere en main !"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_mauer;
		};
	};
	
	case (EQUAL(_item,"double")): {
		if(!isNull life_double) exitWith {hint "Tu as deja une lumiere en main !"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_double;
		};
	};
	
	case (EQUAL(_item,"pan1")): {
		if(!isNull life_pan1) exitWith {hint "Tu as deja un panneau halte en main !"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_pan1;
		};
	};
	
	case (EQUAL(_item,"cone")): {
		if(!isNull life_cone) exitWith {hint "Tu as deja un cone en main !"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_cone;
		};
	};
	
	case (EQUAL(_item,"vird")): {
		if(!isNull life_vird) exitWith {hint "Tu as deja un pan D en main !"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_vird;
		};
	};
	
	case (EQUAL(_item,"virg")): {
		if(!isNull life_virg) exitWith {hint "Tu as deja un pan G en main !"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_virg;
		};
	};
	
	case (EQUAL(_item,"fuelFull")): {
		if(vehicle player != player) exitWith {hint localize "STR_ISTR_RefuelInVehicle"};
		[] spawn life_fnc_jerryRefuel;
	};
	
	case (EQUAL(_item,"lockpick")): {
		[] spawn life_fnc_lockpick;
	};
	
	case (_item == "marijuana","resine"):
{
    if(([false,_item,1] call life_fnc_handleInv)) then
    {
        [] spawn life_fnc_weed;
    };
};

	case (_item in ["apple","caviar","rabbitgrilled","salemagrilled","ornategrilled","mackerelgrilled","tunagrilled","mulletfried","catshark","turtle","turtlesoup","donut","tbacon","peach","cacahuete","burger","redwine","blanquette","frite","pizza","kebab"]): {
		if(!(EQUAL(M_CONFIG(getNumber,"VirtualItems",_item,"edible"),-1))) then {
			if([false,_item,1] call life_fnc_handleInv) then {
				_val = M_CONFIG(getNumber,"VirtualItems",_item,"edible");
				_sum = life_hunger + _val;
				switch (true) do {
					case (_val < 0 && _sum < 1): {life_hunger = 5;}; //This adds the ability to set the entry edible to a negative value and decrease the hunger without death
					case (_sum > 100): {life_hunger = 100;};
					default {life_hunger = _sum;};
				};
			};
		};
	};

	case (_item =="bottledwhiskey"):
	{
		if(playerSide in [west,independent]) exitWith {hint localize "STR_MISC_WestIndNoNo";};
		if((player getVariable ["inDrink",FALSE])) exitWith {hint localize "STR_MISC_AlreadyDrinking";};
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			if(isNil "life_drink") then {life_drink = 0;};
			life_drink = life_drink + 0.06;
			if (life_drink < 0.07) exitWith {};
			[] spawn life_fnc_drinkwhiskey;
		};
	};
	
	case (_item =="bottledshine"):
	{
		if(playerSide in [west,independent]) exitWith {hint localize "STR_MISC_WestIndNoNo";};
		if((player getVariable ["inDrink",FALSE])) exitWith {hint localize "STR_MISC_AlreadyDrinking";};
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			if(isNil "life_drink") then {life_drink = 0;};
			life_drink = life_drink + 0.08;
			if (life_drink < 0.09) exitWith {};
			[] spawn life_fnc_drinkmoonshine;
		};
	};
	
	case (_item =="resine"):
	{
		if(playerSide in [west,independent]) exitWith {hint localize "STR_MISC_WestIndNoNo";};
		if((player getVariable ["inDrink",FALSE])) exitWith {hint localize "STR_MISC_AlreadyDrinking";};
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			if(isNil "life_drink") then {life_drink = 0;};
			life_drink = life_drink + 0.08;
			if (life_drink < 0.09) exitWith {};
			[] spawn life_fnc_drinkmoonshine;
		};
	};
	
	case (_item =="bottledbeer"):
	{
		
		if(playerSide in [west,independent]) exitWith {hint localize "STR_MISC_WestIndNoNo";};
		if((player getVariable ["inDrink",FALSE])) exitWith {hint localize "STR_MISC_AlreadyDrinking";};
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			if(isNil "life_drink") then {life_drink = 0;};
			life_drink = life_drink + 0.02;
			if (life_drink < 0.06) exitWith {};
			[] spawn life_fnc_drinkbeer;
		};
	};
	
	case (EQUAL(_item,"pickaxe")): {
		[] spawn life_fnc_pickAxeUse;
	};
	
	default {
		hint localize "STR_ISTR_NotUsable";
	};
};
	
[] call life_fnc_p_updateInventory;
[] call life_fnc_hudUpdate;
