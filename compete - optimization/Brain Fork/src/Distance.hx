class Distance {
	
	public static function getDistance( current:Int, target:Int, length:Int ) {
		final distanceLeft = getLeft( current, target, length );
		final distanceRight = getRight( current, target, length );
		return distanceLeft < distanceRight ? -distanceLeft : distanceRight;
	}

	inline static function getRight( current:Int, target:Int, length:Int ) return target >= current ? target - current : length - current + target;
	inline static function getLeft( current:Int, target:Int, length:Int ) return target <= current ? current - target : current + length - target;
}