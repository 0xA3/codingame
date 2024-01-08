package main.game;

import haxe.ds.ReadOnlyArray;

using Lambda;

class GameSummaryManager {
	
	final lines:Array<String> = [];
	final playersErrors:Map<String, Array<String>> = [];
	var playersErrorsSize = 0;
	final mealMap:Map<Int, Array<AntConsumption>> = [0 => [], 1 => []];
	final eggMap:Map<Int, Array<AntConsumption>> = [0 => [], 1 => []];

	public function new() {}

	public function getSummary() {
		return toString();
	}

	public function clear() {
		lines.splice( 0, lines.length );
		playersErrors.clear();
		playersErrorsSize = 0;
		mealMap.iter( list -> list.splice( 0, list.length ));
		eggMap.iter( list -> list.splice( 0, list.length ));
	}

	public function toString() {
		return formatErrors() + formatLines();
	}

	public function addError( player:Player, error:String ) {
		trace( '${player.getNicknameToken()} $error' );
		final key = player.getNicknameToken();
		if( !playersErrors.exists( key )) {
			playersErrors.set( key, [] );
		}
		playersErrors[key].push( error );
		playersErrorsSize++;
	}

	function formatLines() {
		final harvestLines:Array<String> = [];

		for( pIdx in 0...2 ) {
			final meals:Array<AntConsumption> = [];// eggMap[pIdx];
			meals.sort(( a, b ) -> a.cell.getIndex() - b.cell.getIndex() );

			if( meals.length == 1 ) {
				final meal = meals[0];
				final cellString = meal.player.anthills.length == 1 ? "cell" : "cells";
				harvestLines.push(
					'${meal.player.getNicknameToken()} has harvested ${meal.amount} egg from cell ${meal.cell.getIndex()}, spawning that many ants on $cellString ${formatCellList( meal.player.anthills )}.\n'
				);
			} else if( meals.length > 1 ) {
				final player = meals[0].player;
				harvestLines.push(
					'${player.getNicknameToken()} has harvested:'
				);
				var total = 0;
				for( meal in meals ) {
					
				}
			}
		}

		return "";
	}

	function formatErrors() {
		if( playersErrorsSize == 0 ) return "";

		return [for( key => errors in playersErrors ) {
			final additionalErrorsMessage = errors.length > 1
			? " + " + ( errors.length - 1 ) + " other error" + ( errors.length > 2 ? "s" : "" )
			: "";
			return 'key: ${errors[0]} ${additionalErrorsMessage}';
		}].join( "\n" )
		+ "\n\n";
	}

	public function addNotEnoughFoodLeft( ?player:Player ) {
		lines.push(
			player == null
			? "At least half of the crystals have been harvested. Game over!"
			: player.getNicknameToken() + " has harvested at least half the crystals. Game over!"
		);
	}

	public function addNoMoreFood() {
		lines.push(
			"All the crystals have been harvested. Game over!"
		);
	}

	public function addBuild( meal:AntConsumption ) {
		eggMap[meal.player.getIndex()].push( meal );
	}

	public function addMeal( meal:AntConsumption ) {
		mealMap[meal.player.getIndex()].push( meal );
	}

	function formatCellList( list:ReadOnlyArray<Int> ) {
		if( list.length == 1 ) {
			return '${list[0]}';
		}
		return list.join(" & ");
	}
}