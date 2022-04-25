package agent.level1;

import Std.int;
import game.Configuration;
import game.GameEntity;
import game.Hero;
import game.Mob;
import game.Vector;

class Boss extends Agent {
	
	var myBase:Base;
	var enemyBase:Base;
	var heroAssociatedVector:Array<Vector>;

	public function new() {
		super();
		agentId = "Boss1";
	}

	override function init(inputLines:Array<String>) {
		super.init( inputLines );
		
		myBase = new Base( me.basePosition, me.index );
		enemyBase = new Base( opp.basePosition, opp.index );

		final indexBase = myBase.baseCenter.x < enemyBase.baseCenter.x ? 1 : -1;

		heroAssociatedVector = [
            new Vector( indexBase * 2000, indexBase * 2000 ),
            new Vector( indexBase * 4000, indexBase * 1000 ),
            new Vector( indexBase * 2500, indexBase * 3000 )
		];
	}

	override function process():String {
		turn++;

		final threateningMobs = getOrderedMonstersThreateningBase( mobSwarm.mobsMap, me.basePosition );

		for( i in 0...me.heros.length ) {
			final hero = me.heros[i];
			var action = 'MOVE ${myBase.attractionCenter.add( heroAssociatedVector[i] ).toIntString()}';

			final heroCloseMobs = getMobsInDistance( hero, mobSwarm.mobsMap, Configuration.HERO_VIEW_RADIUS );
			orderEntitiesByDistance( heroCloseMobs, hero.position );

			if( threateningMobs.length > 0 && i == 0 && turn < 100 ) {
				final mobTargeted = threateningMobs[0];
				action = 'MOVE ${mobTargeted.position.add( mobTargeted.velocity ).toIntString()}';
			} else if( threateningMobs.length > 0 && i == 1 && turn < 45 ) {
				final mobTargeted = threateningMobs[0];
				action = 'MOVE ${mobTargeted.position.add( mobTargeted.velocity ).toIntString()}';
			} else if( threateningMobs.length > 0 && i == 2 && turn < 15 ) {
				final mobTargeted = threateningMobs[0];
				action = 'MOVE ${mobTargeted.position.add( mobTargeted.velocity ).toIntString()}';
			} else {
				final randomx = Std.random( Configuration.MAP_WIDTH );
				final randomy = Std.random( Configuration.MAP_HEIGHT );
				action = 'MOVE $randomx $randomy';
			}
			actions[i] = action;
		}
		trace( "\n" + actions.join( "\n" ));
		return actions.join( "\n" );
	
	}

	function getOrderedMonstersThreateningBase( mobs:Map<Int, Mob>, baseCenter:Vector ) {
		final mobsThreateningBase = [];
		for( mob in mobs ) {
			if( mob.threatFor == 1 ) mobsThreateningBase.push( mob );
		}
		orderMobsByDistance( mobsThreateningBase, baseCenter );
		return mobsThreateningBase;
	}

	function orderEntitiesByDistance( entities:Array<GameEntity>, v:Vector ) {
		entities.sort(( a, b ) -> {
			return int( Vector.fromVectors( a.position, v ).lengthSquared() ) - int( Vector.fromVectors( b.position, v ).lengthSquared() );
		});
	}

	function orderMobsByDistance( entities:Array<Mob>, v:Vector ) {
		entities.sort(( a, b ) -> {
			return int( Vector.fromVectors( a.position, v ).lengthSquared() ) - int( Vector.fromVectors( b.position, v ).lengthSquared() );
		});
	}

	function getMobsInDistance( hero:Hero, mobs:Map<Int, Mob>, distance:Int ) {
		final mobsInDistance:Array<GameEntity> = [];
		for( mob in mobs ) if( hero.position.distance( mob.position ) < distance ) mobsInDistance.push( mob );
		return mobsInDistance;
	}
}

class Base {
	public var playerBase:Int;
	public var baseCenter:Vector;
	public var attractionCenter:Vector;

	public function new( base:Vector, playerBase:Int ) {
		baseCenter = base;
		this.playerBase = playerBase;
		attractionCenter = baseCenter.add( new Vector( 1, 1 )).normalize().mult( Configuration.BASE_ATTRACTION_RADIUS / 2 );
		if( base.y > Configuration.MAP_HEIGHT / 2 ) attractionCenter = attractionCenter.symmetric( Configuration.MAP_CENTER );
	}
}