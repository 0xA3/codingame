package test.tunnel;

import data.Node;
import parser.ParseLevel;
import parser.ParseLocation;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestGetChildNodes extends buddy.BuddySuite {

	static final colLeft = 0;
	static final colCenter = 1;
	static final colRight = 2;

	static final TOP = 0;
	static final LEFT = 1;
	static final RIGHT = 2;

	public function new() {
		
		describe( "Test Tunnel getChildNodes", {
			
			it( "Type 0", {
				final input = type0;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 0 );
			});	
			
			it( "Type 1", {
				final input = type1;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 7 );
			});	
			
			it( "Type 2", {
				final input = type2;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 7 );
			});	
			
			it( "Type 3", {
				final input = type3;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 7 );
			});	
			
			it( "Type 4", {
				final input = type4;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 2 );
				childNodes[0].index.should.be( 3 );
				childNodes[1].index.should.be( 5 );
			});	
			
			it( "Type 4 locked", {
				final input = type4Locked;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 3 );
			});	
			

			it( "Type 6 Top", {
				final input = type6Top;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 7 );
			});	
			
			it( "Type 6 Left", {
				final input = type6Left;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 2 );
				childNodes[0].index.should.be( 2 );
				childNodes[1].index.should.be( 4 );
			});	
			
			it( "Type 6 Right", {
				final input = type6Right;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 2 );
				childNodes[0].index.should.be( 0 );
				childNodes[1].index.should.be( 4 );
			});	
			
			it( "Type 10 Top", {
				final input = type10Top;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 2 );
				childNodes[0].index.should.be( 3 );
				childNodes[1].index.should.be( 5 );
			});	
			
			it( "Type 10 Left", {
				final input = type10Left;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 4 );
			});	
			
			it( "Type 10 Right", {
				final input = type10Right;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
				final childNodes = tunnel.getChildNodes( startNode, input.cells );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 4 );
			});	
			
		});
		
	}

	final type0 = parseLevel(
	"3 2
	0 3 0
	0 0 0
	1
	1 0 TOP
	0" );
	
	final type1 = parseLevel(
	"3 2
	0 3 0
	0 1 0
	1
	1 0 TOP
	0" );
	
	final type2 = parseLevel(
	"3 2
	0 3 0
	0 2 0
	1
	1 0 TOP
	0" );
	
	final type3 = parseLevel(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP
	0" );
	
	final type4 = parseLevel(
	"3 2
	0 3 0
	0 4 0
	1
	1 0 TOP
	0" );
	
	final type4Locked = parseLevel(
	"3 2
	0 3 0
	0 -4 0
	1
	1 0 TOP
	0" );
	
	final type6Top = parseLevel(
	"3 2
	0 3 0
	0 6 0
	1
	1 0 TOP
	0" );
	
	final type6Left = parseLevel(
	"3 2
	2 6 0
	0 3 0
	1
	0 0 LEFT
	0" );
	
	final type6Right = parseLevel(
	"3 2
	0 6 2
	0 3 0
	1
	2 0 RIGHT
	0" );
	
	final type10Top = parseLevel(
	"3 2
	0 3 0
	2 10 2
	1
	1 0 TOP
	0" );
		
	final type10Left = parseLevel(
	"3 2
	2 10 0
	0 3 0
	1
	0 0 LEFT
	0" );
	
	final type10Right = parseLevel(
	"3 2
	0 10 2
	0 3 0
	1
	2 0 RIGHT
	0" );
	
}

