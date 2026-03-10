package ya;

import haxe.ds.*;
import haxe.Constraints.IMap;

@:transitive
@:multiType(@:followWithAbstracts K)
abstract Set<T>(IMap<T, Bool>) {
	public function new();
	
	@:to static inline function toStringMap<K:String>(t:IMap<K, Bool>):StringMap<Bool> {
		return new StringMap<Bool>();
	}
	@:to static inline function toIntMap<K:Int>(t:IMap<K, Bool>):IntMap<Bool> {
		return new IntMap<Bool>();
	}
	@:to static inline function toEnumValueMapMap<K:EnumValue>(t:IMap<K, Bool>):EnumValueMap<K, Bool> {
		return new EnumValueMap<K, Bool>();
	}
	@:to static inline function toObjectMap<K:{}>(t:IMap<K, Bool>):ObjectMap<K, Bool> {
		return new ObjectMap<K, Bool>();
	}

	@:from static inline function fromStringMap(map:StringMap<Bool>):Set<String> {
		return cast map;
	}
	@:from static inline function fromIntMap(map:IntMap<Bool>):Set<Int> {
		return cast map;
	}
	@:from static inline function fromObjectMap<K:{}>(map:ObjectMap<K, Bool>):Set<K> {
		return cast map;
	}

	public function add(val:T) this.set(val, true);
	public function remove(val:T) this.remove(val);
	public function contains(val:T):Bool return this.exists(val);
	public function toString() return toArray().toString();
	
	@:from static public function fromStringArray(arr:Array<String>) {
		final newSet = new Set();
		for (val in arr) newSet.add(val);
		return newSet;
	}
	@:from static public function fromIntArray(arr:Array<Int>) {
		final newSet = new Set();
		for (val in arr) newSet.add(val);
		return newSet;
	}
	@:from static public function fromObjArray<T:{}>(arr:Array<T>) {
		final newSet = new Set();
		for (val in arr) newSet.add(val);
		return newSet;
	}
	public function toArray<T>() {
		return [for (val in this.keys()) val];
	};
}