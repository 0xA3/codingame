package ai.data;

import ai.data.Node;

class NodePool {
	
	final head:ListNode<Node>;
	var current:ListNode<Node>;

	/**
		The length of `this` NodePool.
	**/
	public var length(default, null):Int;

	/**
		Creates a new empty NodePool.
	**/
	public function new() {
		head = ListNode.create( new Node(), null );
		current = head;

		length = 0;
	}

	public function get() {
		if( current.next == null ) { // current is the last Element in NodePool
			final x = ListNode.create( new Node(), null );
			current.next = x;
			current = x;

			length++;
		
		} else { // current is not the last Element in NodePool
			current = current.next;
		}

		return current.item;
	}

	public function reset() {
		if( head == null ) return;

		var temp = head;
		while( temp.next != null ) {
			temp = temp.next;
			temp.item.reset();
		}
		
		current = head;
	}
}

private class ListNode<T> {
	public var item:T;
	public var next:ListNode<T>;

	public function new(item:T, next:ListNode<T>) {
		this.item = item;
		this.next = next;
	}

	extern public inline static function create<T>(item:T, next:ListNode<T>):ListNode<T> {
		return new ListNode(item, next);
	}
}

private class ListIterator<T> {
	var head:ListNode<T>;

	public inline function new(head:ListNode<T>) {
		this.head = head;
	}

	public inline function hasNext():Bool {
		return head != null;
	}

	public inline function next():T {
		var val = head.item;
		head = head.next;
		return val;
	}
}

private class ListKeyValueIterator<T> {
	var idx:Int;
	var head:ListNode<T>;

	public inline function new(head:ListNode<T>) {
		this.head = head;
		this.idx = 0;
	}

	public inline function hasNext():Bool {
		return head != null;
	}

	public inline function next():{key:Int, value:T} {
		var val = head.item;
		head = head.next;
		return {value: val, key: idx++};
	}
}