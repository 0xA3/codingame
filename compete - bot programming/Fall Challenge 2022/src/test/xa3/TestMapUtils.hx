package test.xa3;

using buddy.Should;
using xa3.MapUtils;

class TestMapUtils extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test MapUtils", {
			
			it( "test compute incrementValue", {
				final map = [ "A" => 1 ];
				map.compute( "A", ( k, v ) -> ( v == null ) ? 1 : v + 1 );
				map["A"].should.be( 2 );
			} );
			
			it( "test replaceString", {
				final map = [ 101 => "Mahesh" ];
				map.compute( 101, ( k, v ) -> '${v}-$k' );
				map[101].should.be( "Mahesh-101" );
			} );
			
		} );
	}
}