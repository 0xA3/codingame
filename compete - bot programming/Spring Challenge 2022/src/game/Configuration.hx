package game;

class Configuration {

	public static final MAX_ROUNDS = 220;
	
	public static final MAP_WIDTH = 17630;
    public static final MAP_HEIGHT = 9000;
    public static final MAP_LIMIT = 800;

    public static final BASE_ATTRACTION_RADIUS = 5000;
    public static final BASE_VIEW_RADIUS = 6000;
    public static final BASE_RADIUS = 300;

    public static final HERO_MOVE_SPEED = 800;
    public static final HEROES_PER_PLAYER = 3;
    public static final HERO_VIEW_RADIUS = 2200;
    public static final HERO_ATTACK_RANGE = 800;
    public static final HERO_ATTACK_DAMAGE = 2;

    public static final MAX_MANA = -1;
    public static final STARTING_MANA = 0;
    public static final STARTING_BASE_HEALTH = 3;

    public static final MOB_MOVE_SPEED = 400;
    public static final MOB_SPAWN_LOCATIONS = [
        new SpawnLocation(Std.int( MAP_WIDTH / 2 ), -MAP_LIMIT + 1),
        new SpawnLocation(Std.int( MAP_WIDTH / 2 ) + 4000, -MAP_LIMIT + 1)
    ];
    public static final MOB_SPAWN_MAX_DIRECTION_DELTA = 5 * Math.PI / 12;
    public static final MOB_SPAWN_RATE = 5;
    public static final MOB_STARTING_MAX_ENERGY = 10.0;
    public static final MOB_GROWTH_MAX_ENERGY = 0.5;

    public static final SPELL_WIND_COST = 10;
    public static final SPELL_CONTROL_COST = 10;
    public static final SPELL_PROTECT_COST = 10;
    public static final SPELL_PROTECT_DURATION = 12;
    public static final SPELL_WIND_DISTANCE = 2200;
    public static final SPELL_WIND_RADIUS = 1280;
    public static var ENABLE_FOG = true;
    public static var ENABLE_WIND = true;
    public static var ENABLE_CONTROL = true;
    public static var ENABLE_SHIELD = true;
    public static var ENABLE_TIE_BREAK = true;

}