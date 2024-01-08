package main.event;

import xa3.MathUtils.max;

class Animation {
    public static final HUNDREDTH = 10;
    public static final TWENTIETH = 50;
    public static final TENTH = 100;
    public static final THIRD = 300;
    public static final HALF = 500;
    public static final WHOLE = 1000;
	
	var frameTime = 0;
	var endTime = 0;

	public function new() {}

	public function reset() {
        frameTime = 0;
        endTime = 0;
    }

    public function wait( time:Int ) {
        return frameTime += time;
    }

    public function getFrameTime() {
        return frameTime;
    }

    public function startAnim( animData:Array<AnimationData>, duration:Int ) {
        animData.push( new AnimationData(frameTime, duration));
        endTime = max( endTime, frameTime + duration );
    }

    public function waitForAnim( animData:Array<AnimationData>, duration:Int ) {
        animData.push( new AnimationData( frameTime, duration ));
        frameTime += duration;
        endTime = max( endTime, frameTime );
    }

    public function chainAnims( count:Int, animData:Array<AnimationData>, duration:Int, separation:Int ) {
        chainAnimsWithWait(count, animData, duration, separation, true);
    }

    public function chainAnimsWithWait( count:Int , animData:Array<AnimationData>, duration:Int, separation:Int, waitForEnd:Bool ) {
        for( i in 0...count ) {
            animData.push( new AnimationData( frameTime, duration ));

            if( i < count - 1 ) {
                frameTime += separation;
            }
        }
        endTime = max( endTime, frameTime + duration );
        if( waitForEnd && count > 0 ) {
            frameTime += duration;
        }
    }

    public function setFrameTime( startTime:Int ) {
        this.frameTime = startTime;
    }

    public function getEndTime() {
        return endTime;
    }

    public function catchUp() {
        frameTime = endTime;
    }
    
    public function computeEvents() {
        final minTime = 1000;

        catchUp();

        final frameTime = max(
            getFrameTime(),
            minTime
        );
        return frameTime;
    }

}