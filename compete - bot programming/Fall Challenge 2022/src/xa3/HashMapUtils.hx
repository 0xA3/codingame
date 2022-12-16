package xa3;

import haxe.ds.HashMap;

function compute<K,V>( map:HashMap<K, V>, key:K, remappingFunction:( k:K, v:V ) -> Null<V> ) {
	
	// if( map.exists( key )) {
		final result = try {
			remappingFunction( key, map[key] );
		} catch( e:Dynamic ) {
			throw e;
		}
		if( result == null ) map.remove( key );
		else map.set( key, result );
	// } else {
		// throw 'Error: map $map has no key $key';
	// }
}

function getOrDefault<K,V>( map:HashMap<K, V>, key:K, defaultValue:V ) {
	if( map.exists( key )) return map[key];
	return defaultValue;
}

function size<V>( map:HashMap<K, V> ) {
	var count = 0;
	for( _ in map ) count++;
	return count;
}