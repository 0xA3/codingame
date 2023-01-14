package test;

using buddy.Should;

@:access(Main)
class TestGetTotalDistance extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test GetTotalDistance", {
			
			final t1 = [{ x:9, y:12 }, { x:24, y:15 }, { x:12, y:30 }, { x:4, y:3 }, { x:13, y:27 }];
			final t2 = [{ x:4, y:5 }, { x:12, y:80 }, { x:65, y:18 }, { x:39, y:29 }, { x:99, y:11 }, { x:84, y:31 }, { x:9, y:9 }, { x:54, y:49 }, { x:16, y:27 }, { x:31, y:67 }, { x:0, y:71 }, { x:60, y:0 }];
			
			final t3 = [{ x:62, y:6 }, { x:21, y:19 }, { x:23, y:25 }, { x:11, y:29 }, { x:73, y:10 }, { x:14, y:55 }, { x:47, y:3 }, { x:18, y:71 }, { x:4, y:7 }, { x:52, y:93 }, { x:12, y:31 }, { x:76, y:60 }, { x:81, y:72 }, { x:59, y:34 }];
			
			final t4 = [{ x:0, y:26 }, { x:18, y:27 }, { x:33, y:15 }, { x:25, y:11 }, { x:41, y:36 }, { x:80, y:41 }, { x:9, y:10 }, { x:34, y:15 }, { x:71, y:11 }, { x:84, y:6 }];

            it( "t1", {
                Main.getTotalDistance( t1 ).should.be( 71 );
			});
            
            it( "t2", {
                Main.getTotalDistance( t2 ).should.be( 403 );
			});
            
            it( "t3", {
                Main.getTotalDistance( t3 ).should.be( 327 );
			});
            
            it( "t4", {
                Main.getTotalDistance( t4 ).should.be( 252 );
			});
            
            
		});

	}
}