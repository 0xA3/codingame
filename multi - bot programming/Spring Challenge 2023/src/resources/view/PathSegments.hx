package resources.view;

import main.event.EventData;
import resources.view.Types.AggregatedPathsEvent;
import resources.view.Types.PathSegment;
import resources.view.Utils.keyOf;
import resources.view.Utils.last;

typedef PathSegmentKey = {
	var key:String;
	var from:Int;
	var to:Int;
}

function pathToKeys( path:Array<Int> ) {
	final fromIdx = path[0];
	
	final p:Array<PathSegmentKey> = [];
	for( toIdx in path.slice( 1 )) {
		final k = keyOf( fromIdx, toIdx );
		p.push({ key: k, from: fromIdx, to: toIdx });
	}

	return p;
}

function computePathSegments( events:Array<EventData>, playerIdx:Int, type:Int ) {
	if( events.length == 0 ) return null;

	final segmentMap:Map<String, PathSegment> = [];
	var startAnim = Math.POSITIVE_INFINITY;
	var endAnim = Math.NEGATIVE_INFINITY;
	var total = 0;
	final bouncing = [];

	final totalMap:Map<Int, Int> = [];

	for( event in events ) {
		startAnim = Math.min( startAnim, event.animData[0].start );
		endAnim = Math.max( endAnim, event.animData[event.animData.length - 1].end );
		
		final pathSegmentKeys = pathToKeys( event.path );
		final firstPathSegmentKey = pathSegmentKeys[0];
		if( !segmentMap.exists( firstPathSegmentKey.key )) {
			final pathSegment:PathSegment = {
				pathKeys: [],
				amount: 0,
				from: firstPathSegmentKey.from,
				to: firstPathSegmentKey.to,
				key: firstPathSegmentKey.key
			}
			
			segmentMap.set( firstPathSegmentKey.key, pathSegment );
		}
		final segment = segmentMap[firstPathSegmentKey.key];

		segment.amount += event.amount;
		total += event.amount;

		for( i in 1...pathSegmentKeys.length) {
			segment.pathKeys.set( pathSegmentKeys[i].key, true );
		}
		
		final hillIdx = last( event.path );
		if( !totalMap.exists( hillIdx )) totalMap.set( hillIdx, 0 );
		totalMap[hillIdx] += event.amount;
		bouncing.push( event.path[0] );
	}

	final aggregatedPathsEvent:AggregatedPathsEvent = {
		animData: {
			start: startAnim,
			end: endAnim
		},
		segmentMap: segmentMap,
		segments: [for( segment in segmentMap ) segment],
		totals: [for( k => v in totalMap ) {cellIdx: k, amount: v}],
		bouncing: bouncing,
		type: type,
		playerIdx: playerIdx
	}

	return aggregatedPathsEvent;
}