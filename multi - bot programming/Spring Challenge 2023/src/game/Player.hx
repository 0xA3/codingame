package game;

import game.action.actions.BeaconAction;
import game.action.actions.LineAction;
import gameengine.core.AbstractMultiplayerPlayer;

class Player extends AbstractMultiplayerPlayer {
	
	var message:String;
	final anthills:Array<Int> = [];
	final beacons:Array<BeaconAction> = [];
	final lines:Array<LineAction> = [];
	var points = 0;

	public function new() {}

	
}