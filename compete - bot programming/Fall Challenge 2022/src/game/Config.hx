package game;

class Config {

    /**
     * Map gen
     */
	 public static var MAX_ROUNDS = 220;
	
	 public static var MAP_MIN_WIDTH = 12;
	 public static var MAP_MAX_WIDTH = 24;
	 public static var MAP_ASPECT_RATIO = 1 / 2;
	 public static var MIN_SPAWN_DISTANCE = 7;
 
	 /**
	  * Gameplay
	  */
	 public static var CELL_MAX_DURABILITY = 10;
	 public static var RECYCLER_INCOME = 1;
	 public static var PLAYER_STARTING_MONEY = 10;
	 public static var PLAYER_MINIMAL_INCOME = 10;
	 public static var PLAYER_INCOME_CELL_COUNT_CEILING = 0;
	 public static var COST_UNIT = 10;
	 public static var COST_RECYCLER = 10;
	 public static var COST_WARP = 2;
	 public static var MAX_TURNS = 200;
	 public static var EARLY_FINISH_TURNS = 20;
 
}