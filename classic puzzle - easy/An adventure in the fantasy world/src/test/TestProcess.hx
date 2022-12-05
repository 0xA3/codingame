package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.path, ip.events ).should.be( "GameClear -1 -1 133G" );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.path, ip.events ).should.be( "GameClear -2 -8 50G" );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.path, ip.events ).should.be( "-2 -1 0G goblin" );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.path, ip.events ).should.be( "1 0 50G slime" );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.path, ip.events ).should.be( "-7 13 208G slime" );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.path, ip.events ).should.be( "1 0 50G slime" );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.path, ip.events ).should.be( "GameClear 2 2 136G" );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.path, ip.events ).should.be( "GameClear 1 7 141G" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final path = lines[0];
		final n = parseInt( lines[1] );
		final events = lines.slice( 2 );
	
		return { path: path, events: events };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
	"ULULRDDLRU
	14
	-2 -3 enemy goblin
	-1 0 money 83G
	2 -1 enemy goblin
	-2 2 enemy slime
	-1 1 money 31G
	-4 -2 enemy slime
	-3 0 enemy goblin
	-4 -1 money 17G
	1 -3 money 60G
	3 0 enemy slime
	1 -2 enemy slime
	3 -1 enemy goblin
	-1 -3 enemy slime
	3 3 enemy goblin" );

	final test2 = parseInput(
	"DRLUUUULDRLRURLLLLLLDLDULRULDL
	31
	0 -9 enemy slime
	-10 9 money 22G
	6 3 enemy goblin
	2 -5 money 83G
	-4 -8 money 97G
	1 -7 money 66G
	-10 3 enemy slime
	4 1 enemy goblin
	-4 -7 money 7G
	9 6 money 76G
	6 6 enemy slime
	-7 -2 money 97G
	-9 10 money 4G
	-5 -5 enemy goblin
	-9 9 money 92G
	4 8 money 6G
	5 -5 money 6G
	8 3 money 11G
	-8 10 money 69G
	-4 1 money 64G
	-6 -1 enemy slime
	-3 -8 enemy goblin
	-9 3 enemy goblin
	-9 6 enemy slime
	2 6 money 96G
	8 -3 enemy goblin
	-9 5 money 32G
	7 6 money 2G
	-1 9 enemy goblin
	5 -6 money 16G
	1 -1 money 44G" );

	final test3 = parseInput(
	"LDUURLULRRDRDRUDRULULLDDDLLUUU
	50
	2 -5 money 24G
	-9 -8 enemy slime
	1 4 money 28G
	7 9 money 50G
	9 -10 money 67G
	-10 -1 money 92G
	8 -8 money 41G
	-8 9 enemy slime
	4 -10 enemy slime
	-9 10 enemy slime
	-9 -10 enemy goblin
	-10 -2 enemy slime
	0 4 money 39G
	-8 7 money 52G
	3 9 enemy goblin
	1 8 enemy slime
	6 -9 enemy goblin
	4 -3 enemy goblin
	6 3 enemy slime
	-7 5 enemy goblin
	5 8 enemy slime
	2 0 money 34G
	9 -5 enemy slime
	-9 0 money 38G
	2 -6 money 39G
	-4 -5 enemy goblin
	-1 10 money 69G
	2 9 enemy goblin
	6 7 money 1G
	10 -5 money 43G
	7 -6 money 71G
	9 0 money 35G
	-1 -4 enemy goblin
	-10 7 enemy slime
	2 6 enemy slime
	-5 -7 money 59G
	8 1 enemy slime
	6 -4 money 96G
	4 -5 money 100G
	-2 -1 enemy goblin
	-9 9 enemy slime
	-9 -2 money 12G
	-7 9 money 17G
	2 -8 enemy slime
	-5 9 money 86G
	5 5 enemy goblin
	5 -8 enemy slime
	4 -9 money 15G
	6 -2 money 3G
	0 6 enemy slime" );

	final test4 = parseInput(
	"UDUDDDDUUUDDLLDDULUULRLLUUDURL
	31
	-4 2 money 59G
	0 -9 enemy goblin
	3 7 money 37G
	-2 -3 enemy goblin
	-4 -7 enemy slime
	4 -4 enemy slime
	-6 8 money 86G
	-9 -8 enemy slime
	9 4 enemy slime
	-2 9 money 72G
	-3 4 money 27G
	-5 -7 enemy slime
	-7 -8 enemy slime
	-1 10 money 5G
	6 -9 money 7G
	-8 -6 enemy slime
	-7 8 money 81G
	-1 1 enemy goblin
	-10 9 money 10G
	2 10 enemy slime
	9 -5 money 74G
	3 10 money 40G
	5 -6 money 67G
	2 8 money 83G
	-9 8 money 44G
	1 0 enemy slime
	1 -6 enemy slime
	8 -3 money 14G
	2 -6 money 36G
	0 -1 enemy slime
	-10 7 money 91G" );

	final test5 = parseInput(
	"UDURULRLURURRDRRRDLURUDLRDUDURRLDRRRRLURRDDURRUDULRUDDULUURURLRUUDLLLUDLUURRULRRDRURDUDLDURDLLRUDUDD
	171
	27 -8 enemy slime
	-4 13 money 89G
	-16 -28 money 9G
	2 -14 money 2G
	0 23 money 41G
	6 13 money 75G
	22 7 enemy goblin
	-8 -22 enemy goblin
	0 13 enemy slime
	25 -21 enemy slime
	-4 -13 enemy goblin
	31 4 enemy slime
	3 19 money 59G
	24 -5 money 68G
	22 11 enemy slime
	-26 -2 enemy slime
	-24 4 enemy slime
	-3 11 money 69G
	14 28 money 24G
	-21 31 money 69G
	-15 21 enemy goblin
	0 -22 enemy goblin
	1 32 enemy slime
	29 25 money 12G
	-19 -24 money 85G
	27 7 money 10G
	-30 -17 money 6G
	28 -16 money 82G
	-6 4 money 33G
	8 8 money 22G
	9 33 money 6G
	5 -6 money 64G
	10 -29 money 32G
	-5 -31 enemy slime
	28 1 money 19G
	-18 -34 enemy slime
	-4 9 enemy goblin
	-11 23 enemy slime
	9 18 enemy slime
	-34 9 enemy goblin
	18 -20 money 36G
	16 -16 enemy goblin
	-21 27 enemy goblin
	-5 29 enemy slime
	-26 17 money 88G
	-15 -30 enemy slime
	-24 -13 enemy goblin
	-25 -4 money 4G
	9 1 money 23G
	-21 16 money 99G
	-4 19 money 69G
	-3 -30 money 32G
	-33 -8 enemy slime
	-8 25 money 20G
	3 -30 money 26G
	-6 17 money 26G
	26 -22 money 17G
	21 -9 enemy goblin
	-9 4 money 27G
	-7 -31 money 24G
	20 -20 enemy goblin
	7 12 enemy goblin
	-5 -13 money 7G
	6 18 money 95G
	-3 26 enemy slime
	25 7 enemy slime
	28 -26 enemy goblin
	26 1 money 49G
	-18 16 enemy slime
	18 -34 money 53G
	-24 13 money 99G
	8 7 enemy slime
	8 -12 money 4G
	28 -25 enemy slime
	-14 -5 money 83G
	22 -20 money 2G
	11 -27 money 23G
	-6 6 enemy slime
	18 17 enemy slime
	-10 -1 enemy slime
	21 -29 money 88G
	-23 -31 enemy goblin
	-7 13 enemy slime
	-19 30 money 91G
	-19 -21 enemy slime
	-30 -23 enemy goblin
	-15 7 money 86G
	7 -12 enemy slime
	28 16 money 27G
	8 16 money 75G
	0 25 money 22G
	-9 -17 money 15G
	28 -20 enemy slime
	29 -22 enemy slime
	-21 6 enemy goblin
	-10 28 enemy goblin
	11 29 money 41G
	-22 15 enemy slime
	28 32 money 51G
	-9 -13 money 4G
	12 31 money 8G
	-5 15 enemy goblin
	-28 24 enemy slime
	23 -21 enemy goblin
	13 -1 money 82G
	15 -27 money 46G
	-31 33 money 36G
	-28 -26 enemy slime
	-1 -8 enemy goblin
	7 -9 enemy slime
	-30 -19 money 20G
	-12 10 enemy goblin
	-33 13 enemy goblin
	-16 -11 enemy slime
	31 32 money 57G
	12 16 enemy slime
	-6 8 enemy slime
	1 -12 money 12G
	-25 14 enemy goblin
	-14 -31 money 14G
	-22 -30 money 10G
	24 13 money 32G
	32 30 enemy slime
	22 -8 enemy goblin
	3 33 money 50G
	-11 -1 enemy slime
	-11 2 enemy slime
	-26 27 money 9G
	-21 -18 enemy slime
	-22 32 money 19G
	-31 6 enemy slime
	10 11 money 86G
	-25 26 enemy slime
	24 -27 enemy goblin
	-18 -2 money 88G
	26 24 money 37G
	-24 -8 money 89G
	-32 17 enemy goblin
	5 25 money 32G
	-27 27 money 56G
	15 13 enemy slime
	19 27 enemy goblin
	-24 -16 enemy goblin
	-28 -34 money 60G
	23 32 money 46G
	-1 -18 money 92G
	-29 17 money 88G
	30 -28 enemy slime
	-34 -22 money 75G
	-19 24 money 1G
	-20 27 enemy slime
	12 -26 enemy goblin
	-7 -8 enemy goblin
	-5 32 enemy goblin
	21 28 enemy goblin
	-33 7 money 16G
	-11 -4 enemy goblin
	23 -14 money 28G
	33 17 money 49G
	-11 -31 money 38G
	-29 19 enemy goblin
	27 6 money 19G
	22 -3 money 55G
	7 28 enemy goblin
	-16 27 money 95G
	-29 15 money 71G
	-12 30 enemy goblin
	-4 -10 enemy goblin
	29 14 enemy goblin
	-8 31 money 95G
	1 12 money 85G" );

	final test6 = parseInput(
	"RDLUDDLRDLLDRUURRRDRRLRRRUDUDRLDULUUUULDURRLLLDURLUDLURDULLUURDDLRDURRDULULDLULUDDRLLRRUDLLURDLURLLD
	107
	9 -23 enemy slime
	-24 -3 enemy slime
	7 12 money 57G
	27 -33 money 69G
	13 -13 money 23G
	23 12 money 49G
	12 -8 enemy goblin
	21 -18 enemy goblin
	2 -25 enemy slime
	4 -19 enemy slime
	3 -6 money 41G
	1 0 enemy slime
	-27 22 money 41G
	-6 30 money 78G
	-21 -18 enemy slime
	28 -30 enemy slime
	14 4 money 61G
	31 26 money 91G
	23 24 money 90G
	29 29 money 82G
	2 7 enemy goblin
	-30 -21 money 93G
	23 3 money 18G
	4 -3 enemy slime
	20 8 enemy slime
	-12 -13 enemy goblin
	18 -7 money 18G
	18 27 enemy slime
	25 -5 money 98G
	22 6 money 67G
	-7 14 enemy slime
	-20 18 enemy goblin
	11 22 enemy slime
	13 -30 money 88G
	-28 3 money 60G
	13 27 money 11G
	-5 22 enemy slime
	11 -25 money 13G
	-9 -20 enemy slime
	30 -33 enemy goblin
	8 -17 enemy goblin
	-5 -13 money 49G
	31 7 money 21G
	6 22 money 19G
	5 -9 money 55G
	13 8 money 57G
	13 4 money 62G
	-24 21 enemy goblin
	10 -29 money 28G
	-16 -16 money 76G
	17 -15 money 10G
	-15 20 enemy slime
	6 32 money 44G
	-31 -20 enemy goblin
	-10 -24 money 98G
	-18 -28 money 92G
	6 25 enemy slime
	10 23 money 54G
	9 4 enemy slime
	26 -31 money 99G
	29 8 enemy slime
	-31 -16 enemy goblin
	-25 17 money 84G
	-27 4 enemy goblin
	12 -24 enemy goblin
	-5 27 money 9G
	-8 -28 enemy goblin
	5 3 enemy slime
	-33 -30 money 61G
	12 -15 enemy goblin
	25 -8 money 28G
	-18 -4 money 24G
	-13 -18 money 87G
	-32 32 money 4G
	-3 12 enemy slime
	12 0 enemy slime
	29 -8 money 38G
	-7 29 enemy slime
	5 4 money 17G
	-28 -7 money 57G
	4 7 money 56G
	11 -11 enemy slime
	-33 -3 enemy goblin
	-17 27 enemy goblin
	-6 -31 enemy goblin
	-25 28 money 93G
	4 4 money 50G
	32 -1 enemy slime
	1 -27 enemy goblin
	1 -4 money 51G
	-28 -23 money 29G
	-14 19 enemy goblin
	4 17 money 60G
	32 -19 money 34G
	25 -30 enemy goblin
	9 28 money 32G
	19 2 money 51G
	-26 -24 enemy slime
	-4 22 enemy slime
	26 -4 money 100G
	-22 -27 enemy slime
	33 -14 money 87G
	12 31 enemy goblin
	-10 -29 enemy slime
	15 -19 money 78G
	-13 8 enemy slime
	31 18 enemy slime" );

	final test7 = parseInput(
	"LUURLDLLUDRDDUDDLDRRRLUDDURRLRLRULRDULDRLURRRDUUURRDUULLLDRRDDRRDUUDDULRLDLULDLLLUDRDRUURLDULURRDLRL
	199
	13 31 money 12G
	-1 -5 money 63G
	-34 17 enemy goblin
	-28 20 enemy slime
	14 -19 enemy slime
	10 26 enemy slime
	-31 23 money 47G
	2 -17 money 13G
	8 6 money 86G
	-25 0 enemy goblin
	19 -15 money 22G
	0 -27 enemy slime
	-2 5 enemy goblin
	2 27 enemy goblin
	-16 13 money 51G
	-3 15 enemy goblin
	-11 30 enemy slime
	-19 31 money 2G
	31 2 enemy slime
	9 -33 enemy goblin
	-30 20 money 98G
	-14 8 money 40G
	9 33 money 38G
	-27 33 money 54G
	-13 4 money 30G
	-2 -10 money 48G
	24 -20 enemy goblin
	10 -28 money 63G
	-19 5 enemy slime
	8 -30 money 74G
	-14 -16 enemy slime
	-24 21 enemy slime
	11 -19 enemy slime
	-6 -31 money 95G
	5 7 money 39G
	-8 4 enemy slime
	-29 14 enemy slime
	17 16 money 12G
	7 23 money 41G
	-10 8 money 52G
	17 -22 enemy goblin
	29 -29 enemy goblin
	26 -19 enemy slime
	4 27 money 1G
	29 -1 enemy slime
	28 -19 money 90G
	32 30 money 88G
	32 0 money 44G
	-26 27 enemy goblin
	-34 -6 enemy goblin
	-1 15 money 68G
	12 -29 money 41G
	-23 -15 money 5G
	13 -12 money 61G
	-9 -4 enemy slime
	32 -30 money 33G
	-5 23 money 54G
	-26 14 enemy goblin
	17 -23 enemy goblin
	18 22 enemy slime
	-3 6 enemy goblin
	-20 0 money 35G
	-14 -33 enemy goblin
	-31 -34 enemy slime
	-16 1 enemy goblin
	0 17 enemy goblin
	23 -21 enemy slime
	15 29 money 84G
	-20 -10 money 6G
	-5 -10 money 74G
	-12 -34 money 9G
	-29 -12 money 31G
	32 13 money 22G
	1 -19 enemy goblin
	11 5 enemy slime
	-9 -13 money 9G
	18 -22 money 63G
	-19 -15 money 97G
	15 -25 money 53G
	17 11 enemy goblin
	23 25 money 46G
	3 24 enemy slime
	-8 -30 money 52G
	23 -19 money 85G
	7 -22 money 71G
	-30 8 enemy slime
	1 29 money 68G
	-10 -23 money 35G
	15 -30 enemy slime
	14 -23 enemy slime
	7 1 enemy goblin
	-21 -18 enemy slime
	24 -5 money 76G
	19 10 money 8G
	31 11 money 29G
	0 -23 enemy slime
	32 29 money 50G
	31 25 money 37G
	-18 19 money 9G
	25 17 enemy goblin
	-22 0 enemy slime
	12 1 money 10G
	-4 31 money 96G
	31 -15 enemy goblin
	-7 -14 money 45G
	21 5 money 8G
	-22 -31 enemy goblin
	-10 25 money 42G
	-9 30 enemy slime
	4 26 money 3G
	-16 -33 enemy slime
	-26 15 money 8G
	28 13 enemy goblin
	-21 -14 money 61G
	33 18 money 75G
	30 -16 enemy goblin
	-27 14 money 4G
	-9 -27 enemy goblin
	25 -21 money 40G
	-3 -31 enemy slime
	-19 16 enemy slime
	19 -6 money 82G
	-13 31 money 69G
	-23 -6 enemy goblin
	4 9 money 4G
	32 -20 money 66G
	-25 -2 money 64G
	19 -33 enemy goblin
	-13 17 enemy goblin
	-16 10 enemy goblin
	-25 -17 money 11G
	-3 -33 money 13G
	-19 9 enemy goblin
	-13 27 money 93G
	-11 32 enemy goblin
	25 -5 enemy slime
	-20 -30 money 79G
	13 24 enemy slime
	7 -6 money 2G
	-29 -14 money 30G
	-4 11 enemy slime
	4 -20 money 24G
	-31 13 enemy goblin
	-12 5 money 87G
	22 -19 enemy slime
	-22 -33 enemy slime
	-13 -28 money 49G
	31 5 money 20G
	-13 -27 money 10G
	3 -22 enemy goblin
	-3 27 money 99G
	24 16 money 38G
	-25 9 money 77G
	-6 18 enemy goblin
	18 -7 enemy slime
	5 0 money 48G
	28 -23 money 56G
	-5 -4 money 77G
	18 -19 money 70G
	0 -14 money 60G
	16 30 money 45G
	12 -26 money 27G
	-4 -1 money 87G
	-20 30 enemy goblin
	-6 24 enemy slime
	-31 -24 money 66G
	0 3 money 86G
	-3 -26 enemy slime
	33 -27 enemy goblin
	-22 23 money 77G
	1 -25 enemy slime
	24 -16 money 85G
	14 21 enemy slime
	-1 28 enemy goblin
	-23 -26 enemy slime
	-12 -28 money 74G
	-5 28 enemy goblin
	-6 13 enemy slime
	-8 -19 enemy slime
	7 -32 enemy goblin
	-3 13 enemy goblin
	-17 25 enemy goblin
	-31 -4 enemy slime
	3 28 enemy goblin
	-22 14 money 82G
	19 15 money 44G
	4 17 money 27G
	12 32 money 78G
	-1 -6 enemy slime
	-28 24 money 43G
	-5 33 enemy goblin
	16 -11 money 28G
	20 11 money 56G
	2 26 enemy slime
	-31 -15 enemy goblin
	-15 -34 money 77G
	27 -20 money 23G
	20 27 enemy goblin
	-17 30 enemy slime" );

	final test8 = parseInput(
	"DDRDRDLDLRLDDRDURLUUDRURDLDLRRURLRRDLRRDDULRURLLRRUURUDDULUUDLLDLULDULDURRDLUUULRDRRRLDRLRDRLRULUUUR
	145
	-31 -20 money 81G
	3 8 money 70G
	-9 -34 money 9G
	-12 -11 money 57G
	25 -29 money 93G
	-20 15 enemy slime
	-3 22 enemy goblin
	-28 23 enemy goblin
	-28 -6 money 75G
	-4 -21 enemy slime
	20 -16 money 2G
	4 -27 money 21G
	13 -28 money 40G
	-32 5 enemy goblin
	-12 15 money 88G
	-6 -8 money 80G
	19 -18 money 65G
	26 19 money 20G
	-10 4 enemy goblin
	-17 -26 money 91G
	28 2 money 97G
	-1 4 enemy slime
	8 4 enemy slime
	16 11 money 42G
	-1 2 money 85G
	21 3 money 11G
	-31 3 enemy slime
	-23 5 money 21G
	12 28 enemy slime
	-6 27 money 17G
	-4 -29 enemy slime
	-9 -24 enemy goblin
	2 -5 enemy slime
	-12 5 money 86G
	18 -10 enemy slime
	-2 -34 enemy slime
	22 30 enemy goblin
	-11 -28 money 73G
	32 15 enemy slime
	10 -32 money 96G
	-7 -18 enemy slime
	19 25 money 13G
	-9 13 enemy goblin
	18 -4 enemy slime
	-16 11 enemy goblin
	20 6 money 89G
	-21 -10 enemy slime
	-4 -22 enemy goblin
	2 4 enemy goblin
	30 15 enemy slime
	33 -10 enemy slime
	-23 -5 money 28G
	-32 -10 money 28G
	9 -6 enemy slime
	-26 12 enemy slime
	5 0 money 91G
	10 29 enemy slime
	-2 -19 money 87G
	2 12 money 48G
	2 18 money 81G
	-33 20 money 50G
	22 20 enemy slime
	-24 0 money 72G
	-10 -1 money 91G
	-10 -20 money 77G
	17 -32 enemy goblin
	-32 -6 enemy goblin
	21 -17 money 36G
	-19 -28 money 71G
	28 1 enemy goblin
	16 24 money 26G
	-12 6 enemy slime
	0 -10 money 31G
	32 30 money 43G
	-27 13 enemy slime
	27 3 money 4G
	-29 -12 money 69G
	19 -1 enemy slime
	-33 11 enemy goblin
	-10 -10 money 22G
	25 27 enemy slime
	-8 23 money 33G
	7 14 enemy slime
	-3 21 money 52G
	18 33 enemy goblin
	-3 -32 enemy goblin
	19 18 enemy goblin
	21 -5 enemy slime
	14 -32 enemy slime
	28 -9 money 95G
	14 28 money 22G
	-4 7 money 96G
	-6 18 money 57G
	-9 -22 enemy goblin
	12 -22 enemy slime
	-6 -6 enemy goblin
	27 -28 enemy slime
	3 -4 enemy slime
	-13 17 money 85G
	-20 -13 enemy slime
	-3 14 enemy goblin
	-26 -11 money 36G
	22 33 money 13G
	21 9 money 12G
	25 32 money 71G
	10 18 enemy goblin
	27 -13 enemy slime
	2 -8 enemy slime
	-10 29 enemy goblin
	-24 3 enemy goblin
	29 -22 money 64G
	-25 28 money 2G
	-28 21 money 71G
	-7 -10 enemy slime
	9 -9 enemy slime
	25 -34 money 46G
	7 -29 money 43G
	-20 -4 enemy slime
	19 -16 enemy goblin
	-3 19 money 65G
	-7 22 enemy goblin
	31 24 money 21G
	-19 24 money 64G
	23 10 money 3G
	8 -18 money 4G
	19 4 enemy goblin
	24 -25 money 91G
	-2 -22 money 48G
	-20 21 enemy slime
	-11 28 money 29G
	-4 10 enemy goblin
	-9 -10 enemy slime
	12 -25 money 46G
	-17 10 money 21G
	27 -6 money 15G
	11 29 enemy goblin
	10 -25 money 59G
	-21 -24 enemy slime
	16 22 money 5G
	18 -17 money 4G
	-24 -6 enemy goblin
	22 31 money 67G
	9 11 enemy slime
	26 -31 enemy goblin
	23 -13 enemy slime" );
}
