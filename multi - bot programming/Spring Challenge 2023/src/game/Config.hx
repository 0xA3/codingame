package game;

class Config {
	
	/**
 	 * Map generation
 	 */
	public static final MAP_MIN_WIDTH = 12;
	public static final MAP_ASPECT_RATIO = 1 / 2;
	public static final MAP_RING_COUNT_MIN = 4;
	public static var MAP_RING_COUNT_MAX = 7;
	public static final MIN_EMPTY_CELLS_PERCENT = 10;
	public static final MAX_EMPTY_CELLS_PERCENT = 20;
	public static final MIN_EGG_CELLS_PERCENT = 10;
	public static final MAX_EGG_CELLS_PERCENT = 28;
	public static final MIN_FOOD_CELLS_PERCENT = 10;
	public static final MAX_FOOD_CELLS_PERCENT = 30;
	public static final STARTING_HILL_DISTANCE = 2;

	/**
	 * Gameplay
	 */
	public static final MAX_ANT_LOSS = 3;
	public static var FRAMES_PER_TURN = 1;
	public static final MAX_TURNS = 100 * FRAMES_PER_TURN;

	/***
	 * Rules
	 */
	public static var FIGHTING_ANTS_KILL = false;
	public static var LOSING_ANTS_CANT_MOVE = false;
	public static var LOSING_ANTS_CANT_CARRY = true;
	public static var FORCE_SINGLE_HILL = false;
	public static var ENABLE_EGGS = true;
	public static var SCORES_IN_IO = false;
}