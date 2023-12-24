package ai;

import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;

interface IAi {
	function setGlobalInputs( myDrones:Array<Drone>, creatures:Array<Creature> ):Void;
	function setInputs(
		myScore:Int,
		foeScore:Int,
		myScannedCreatureIds:Array<Int>,
		foeIds:Array<Int>,
		foeDrones:Array<Drone>,
		droneScans:Array<DroneScan>,
		visibleCreatureDatasets:Array<CreatureDataset>,
		radarBlips:Array<RadarBlip>
	):Void;
	function process():String;
}