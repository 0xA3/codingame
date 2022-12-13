package game;

import game.action.Action;
import game.action.BuildAction;
import game.action.MoveAction;
import game.action.SpawnAction;
import game.action.WarpAction;
import gameengine.core.AbstractMultiplayerPlayer;
import view.Coord;

using StringTools;
using xa3.MapUtils;

class Player extends AbstractMultiplayerPlayer {

	public static final NO_PLAYER = new Player( -1, "" );

	public final name:String;
	
	public var money:Int;
	public var warpCooldown:Int;
	@:isVar public var units(get, never):Map<Coord, Unit> = [];
	@:isVar public var message(get, set):String;
	public var builds:Array<BuildAction> = [];
	public var spawns:Array<SpawnAction> = [];
	public var moves:Array<MoveAction> = [];
	public var warps:Array<WarpAction> = [];

	public function new( index:Int, name:String ) {
		this.index = index;
		this.name = name;
		warpCooldown = 0;
	}

	override public function init() {
		super.init();
		units.clear();
		reset();
	}
	
	public function getExpectedOutputLines() return 1;

	function get_message() return message;

	function set_message( message:String ) {
		if( message != "" ) {
			var trimmed = message.trim();
			if( trimmed.length > 48 ) trimmed = trimmed.substr( 0, 46 ) + "...";
			if( trimmed.length > 0 ) return this.message = trimmed;
		}
		return "";
	}

	public function reset() {
		message = "";
		builds.splice( 0, builds.length );
		spawns.splice( 0, spawns.length );
		moves.splice( 0, moves.length );
		warps.splice( 0, warps.length );
	}

	public function get_units() return units;

	public function getUnitAt( coord:Coord ) {
		return units.getOrDefault( coord, Unit.NO_UNIT );
	}

	public function getUnitAtXY( x:Int, y:Int ) {
		return getUnitAt( new Coord( x, y ));
	}

	public function addAction( action:Action ) {
		switch action {
			case Build( pos ): builds.push({ pos: pos });
			case Message( text ): message = text;
			case Move( amount, from, to ): moves.push({ amount: amount, from: from, to: to });
			case Spawn( amount, pos ): spawns.push({ amount: amount, pos: pos });
			case Wait: // no-op
			case Warp( amount, from, to ): warps.push({ amount: amount, from: from, to: to });
		}
	}

	public function placeStartUnit( coord:Coord ) {
		units.set( coord, new Unit( 1, 0 ));
	}

	public function placeUnits( target:Coord, amount:Int ) {
		units.set( target, getUnitAt( target ).add( 0, amount ));
	}

	public function resetUnits() {
		for( coord => unit in units ) {
			unit.reset();
			if( unit.availableCount <= 0 ) units.remove( coord );
		}
	}

	public function removeUnits( coord:Coord, n:Int ) {
		if( n == 0 ) return;
		units.compute( coord, ( k, v ) -> {
			final unit = getUnitAt( coord );
			if( unit.availableCount -n <= 0 ) return null;
			return v.remove( n );
		});
	}

	public function toString() {
		return '$name index $index';
	}
}