package main.game;

import gameengine.core.AbstractMultiplayerPlayer;
import main.game.action.Action;

using StringTools;

class Player extends AbstractMultiplayerPlayer {
	
	public static final NO_PLAYER = new Player( "" );

	final id:String;
	var message = "";
	final _anthills:Array<Int> = [];
	public var anthills(get, never):haxe.ds.ReadOnlyArray<Int>;
	function get_anthills() return _anthills;

	public final beacons:Array<{cellIndex:Int, power:Int}> = [];
	public final lines:Array<{from:Int, to:Int, ants:Int}> = [];
	public var points = 0;

	public function new( id:String ) {
		this.id = id;
	}

	override function getExpectedOutputLines() {
		return 1;
	}

	public function getMessage() {
		return message;
	}

	public function setMessage( message:Null<String> ) {
		if( message != null ) {
			final trimmed = message.trim();
			if( trimmed.length > 48 ) this.message = trimmed.substring( 0, 48 ) + "...";
			if( trimmed.length > 0 ) this.message = trimmed;
		}
	}
	
	public function reset() {
		message = "";
		beacons.slice( 0, beacons.length );
		lines.slice( 0, lines.length );
	}

	override function getNicknameToken() {
		return id;
	}

	public function addAction( action:Action ) {
		switch action {
			case BEACON( cellIndex, power ): beacons.push({ cellIndex: cellIndex, power: power });
			case LINE( from, to, ants ): lines.push({ from: from, to: to, ants: ants });
			case MESSAGE( message ): this.message = message;
			default: // no-op
		}
	}

	public function addAnthill( index:Int ) {
		_anthills.push( index );
	}

	public function addPoints( n:Int ) {
		points += n;
	}

	function getPoints() {
		return points;
	}
}