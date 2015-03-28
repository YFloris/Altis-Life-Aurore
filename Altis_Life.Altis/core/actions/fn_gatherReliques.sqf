/*
    File: fn_gatherReliques.sqf
    Script by Tonic Edit by Heimdall #AltisAurore.fr
	
*/
if(life_action_inUse) exitWith {hint "Tu n'as que deux mains !";};
private["_sum","_dice"];

_dice=ceil(random 3);
_sum = ["relique",_dice,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;

if(_sum > 0) then
{
    life_action_inUse = true;
    titleText["Récolte de reliques...","PLAIN"];
    titleFadeOut 6;
    sleep 6;
    if(([true,"relique",_sum] call life_fnc_handleInv)) then
    {
        titleText[format["Tu as ramassé %1 relique(s).",_sum],"PLAIN"];
    };
};

life_action_inUse = false;