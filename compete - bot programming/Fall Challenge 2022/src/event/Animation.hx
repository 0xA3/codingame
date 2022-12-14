package event;

import xa3.MathUtils.max;

class Animation {

	public static inline var HUNDREDTH = 10;
    public static inline var TWENTIETH = 50;
    public static inline var TENTH = 100;
    public static inline var THIRD = 300;
    public static inline var HALF = 500;
    public static inline var WHOLE = 1000;

	public var frameTime = 0;
	public var endTime( default, null ) = 0;

	public function reset() {
		frameTime = 0;
		endTime = 0;
	}

	public function  wait( time:Int ) return frameTime += time;

	public function startAnim( animData:Array<AnimationData>, duration:Int ) {
		animData.push( new AnimationData( frameTime, duration ));
		endTime = max( endTime, frameTime + duration );
	}

	public function waitForAnim( animData:Array<AnimationData>, duration:Int ) {
		animData.push( new AnimationData( frameTime, duration ));
		frameTime += duration;
		endTime = max( endTime, frameTime + duration );
	}

	public function chainAnims( count:Int, animData:Array<AnimationData>, duration:Int, separation:Int, waitForEnd = true ) {
		for( i in 0...count ) {
			animData.push( new AnimationData( frameTime, duration ));
			if( i < count - 1 ) frameTime += separation;
		}

		endTime = max( endTime, frameTime + duration );
		if( waitForEnd && count > 0 ) frameTime += duration;
	}

	public function catchUp() frameTime = endTime;
}