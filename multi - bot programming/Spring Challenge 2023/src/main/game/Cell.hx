package main.game;

import main.game.CellType;
import xa3.MathUtils.min;

class Cell {
	
	public static final NO_CELL = {
		final cell = new Cell( -1, CubeCoord.NO_COORD );
		cell.isValid = () -> false;
		cell.getIndex = () -> -1;
		cell;
	}

	var type = EMPTY;
	var richness = 0;
	final index:Int;
	var anthill:Player;
	var ants:Array<Int> = [0, 0];
	var beacons:Array<Int> = [0, 0];
	final coord:CubeCoord;

	public function new( index:Int, coord:CubeCoord ) {
		this.index = index;
		this.coord = coord;
	}

	public function toString() return 'index: $index, coord: $coord, type: $type, richness: $richness, ants: $ants, beacons: $beacons';

	dynamic public function getIndex() {
		return index;
	}

	dynamic public function isValid() {
		return true;
	}

	public function setFoodAmount( richness:Int ) {
		this.richness = richness;
		type = FOOD;
	}

	public function getRichness() {
		return richness;
	}

	public function getSpawnPower() {
		return richness;
	}

	public function setSpawnPower( richness:Int ) {
		this.richness = richness;
		type = EGG;
	}

	public function getAnthill() {
		return anthill;
	}

	public function getCoord() {
		return coord;
	}

	public function setAnthill( anthill:Player ) {
		this.anthill = anthill;
	}

	public function placeAnts( player:Player, amount:Int ) {
		placeAntsId( player.getIndex(), amount );
	}

	public function placeAntsId( playerIdx:Int, amount:Int ) {
		ants[playerIdx] += amount;
	}

	public function removeAnts( player:Player, amount:Int ) {
		removeAntsId( player.getIndex(), amount );
	}

	public function getAntsPlayer( player:Player ) {
		return getAntsId( player.getIndex() );
	}

	public function getAntsId( playerIdx:Int ) {
		return ants[playerIdx];
	}

	public function setBeaconPower( playerIdx:Int, power:Int ) {
		beacons[playerIdx] = power;
	}

	public function getBeaconPowerId( playerIdx:Int ) {
		return beacons[playerIdx];
	}

	public function getBeaconPower( player:Player ) {
		return getBeaconPowerId( player.getIndex());
	}
	
	public function removeAntsId( playerIdx:Int, amount:Int ) {
		ants[playerIdx] -= amount;
	}

	public function deplete( amount:Int ) {
		richness -= min( amount, richness );
	}

	public function getType() {
		return type;
	}

	public function removeBeacons() {
		beacons[0] = 0;
		beacons[1] = 0;
 	}

	public function getAnts() {
		return ants;
	}
}