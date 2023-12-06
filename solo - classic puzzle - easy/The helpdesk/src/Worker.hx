import CodinGame.printErr;

enum SegmentType {
	Work( workerId:Int );
	Break;
}

typedef TimeSegment = {
	final type:SegmentType;
	final duration:Float;
	final from:Float;
	final to:Float;
}

class Worker {
	
	static final BREAK_TIME = 10;

	public final id:Int;
	final efficiency:Float;
	final worktime:Int;
	
	public final timeSegments:Array<TimeSegment> = [];

	public function new( id:Int, efficiency:Float, worktime:Int ) {
		this.id = id;
		this.efficiency = efficiency;
		this.worktime = worktime;
	}

	public function getEndtime() return timeSegments.length == 0 ? 0.0 : timeSegments[timeSegments.length - 1].to;
	public function getNumCustomers() return timeSegments.filter( timeSegment -> timeSegment.type.match( Work(_) )).length;
	public function getNumBreaks() return timeSegments.filter( timeSegment -> timeSegment.type == Break ).length;

	public function checkForBreak() return getTimeWithoutBreaks() < worktime ? false : true;
	public function hasJustTakenABreak() return timeSegments.length == 0 ? false : timeSegments[timeSegments.length -1].type == Break;

	function getTimeWithoutBreaks() {
		var time = 0.0;
		for( i in -timeSegments.length + 1...1 ) {
			final timeSegment = timeSegments[-i];
			switch timeSegment.type {
				case Work(_): time += timeSegment.duration;
				case Break: return time;
			}
		}

		return time;
	}

	public function takeABreak() {
		final previousTimeSegment = timeSegments[timeSegments.length - 1];
		final breakTime:TimeSegment = {
			type: Break,
			from: previousTimeSegment.to,
			to: previousTimeSegment.to + BREAK_TIME,
			duration: BREAK_TIME
		}

		timeSegments.push( breakTime );
		// trace( '$id takes a break.' );
	}

	public function work( visitorId:Int, helptime:Int ) {
		final previousEndTime = timeSegments.length == 0 ? 0.0 : timeSegments[timeSegments.length - 1].to;
		final workTime = helptime / efficiency;
		
		final worktime:TimeSegment = {
			type: Work( visitorId ),
			from: previousEndTime,
			to: previousEndTime + workTime,
			duration: workTime
		}
		
		timeSegments.push( worktime );
		// trace( 'worker $id works $workTime until ${worktime.to}' );
	}

	public function toString() {
		final segmentsOutput = [];
		for( segment in timeSegments ) {
			final char = switch segment.type {
				case Work( workerId ): '${workerId % 10}';
				case Break: '-';
			}
			final segmentDisplay = [for( i in 0...Math.round( segment.duration )) char].join( "" );
			segmentsOutput.push( segmentDisplay );
		}
		return '$id | ${segmentsOutput.join("")}';
	}
}