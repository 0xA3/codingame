package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "1-length prefixes", {
				Main.process( _1LengthPrefixes ).should.be( _1LengthPrefixesResult );
			});
			
			it( "4-length prefixes", {
				Main.process( _4LengthPrefixes ).should.be( _4LengthPrefixesResult );
			});
			
			it( "Weekly Challenge", {
				Main.process( weeklyChallenge ).should.be( weeklyChallengeResult );
			});
			
			it( "Ascending Prefixes", {
				Main.process( ascendingPrefixes ).should.be( ascendingPrefixesResult );
			});
			
			it( "Descending Prefixes", {
				Main.process( descendingPrefixes ).should.be( descendingPrefixesResult );
			});
			
			it( "Pierre, Paul, Jacques & co.", {
				Main.process( pierrePaulJacquesCo ).should.be( pierrePaulJacquesCoResult );
			});
			
			it( "Incremental options", {
				Main.process( incrementalOptions ).should.be( incrementalOptionsResult );
			});
			
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final words = [for( i in 1...lines.length) lines[i].trim()];
		return words;
	}

	static function parseOutput( input:String ) {
		final lines = input.split( "\n" );
		return lines.map( l -> l.trim()).join( "\n" );
	}

	final _1LengthPrefixes = parseInput(
	"5
	find
	the
	shortest
	unique
	prefix" );
	
	final _1LengthPrefixesResult = parseOutput(
	"f
	t
	s
	u
	p" );
	
	final _4LengthPrefixes = parseInput(
	"4
	pretend
	present
	previous
	prefix" );
	
	final _4LengthPrefixesResult = parseOutput(
	"pret
	pres
	prev
	pref" );
	
	final weeklyChallenge = parseInput(
	"6
	alphabet
	book
	carpet
	cadmium
	cadeau
	alpine" );
	
	final weeklyChallengeResult = parseOutput(
	"alph
	b
	car
	cadm
	cade
	alpi" );
	
	final ascendingPrefixes = parseInput(
	"3
	A
	AA
	AAA" );
	
	final ascendingPrefixesResult = parseOutput(
	"A
	AA
	AAA" );
	
	final descendingPrefixes = parseInput(
	"3
	DDD
	DD
	D" );
	
	final descendingPrefixesResult = parseOutput(
	"DDD
	DD
	D" );
	
	final pierrePaulJacquesCo = parseInput(
	"200
	LIONEL
	GINO
	ROBERT
	CLARK
	JONAS
	JONAH
	DARYL
	AL
	NORMAN
	BUSTER
	CHANCE
	BOYD
	CHAS
	MERLE
	ELDON
	JIM
	KEN
	MAURICIO
	FREEMAN
	TONEY
	TODD
	TOM
	KOREY
	MARIA
	FRANKLYN
	BARRY
	ADAN
	DOUG
	COLBY
	JARVIS
	NESTOR
	DREW
	EZRA
	KRISTOPHER
	ARON
	TYREE
	CURTIS
	WELDON
	DIEGO
	ANTWAN
	JESSIE
	WILLIAM
	CLEMENT
	DEE
	SCOTTIE
	JACKIE
	LAVERN
	PHILLIP
	SUNG
	KIM
	CAROL
	CYRUS
	SHAYNE
	ROLF
	TED
	THAD
	BRYCE
	XAVIER
	HOBERT
	DEAN
	LANCE
	CAMERON
	HILARIO
	BUFORD
	BRANDEN
	ALEJANDRO
	NORRIS
	EDWIN
	JUSTIN
	OMAR
	CLAIR
	QUINN
	HILTON
	BILLIE
	FREDRIC
	LANE
	ROBIN
	LUCAS
	DARRIN
	BENTON
	IAN
	TIMMY
	MEL
	DUDLEY
	GRAHAM
	GORDON
	RONNY
	WILTON
	DEANDRE
	CLEO
	CHET
	WARD
	JOHNNIE
	THURMAN
	MANUEL
	ARNOLDO
	MARLIN
	ARNOLD
	TOD
	MERRILL
	PETER
	FELIX
	JEWELL
	JAE
	RANDALL
	DILLON
	DOMINGO
	HIRAM
	REID
	BOBBY
	FREDERICK
	ANDREW
	ISAIAH
	GASTON
	CHAD
	RICKIE
	MICKEY
	ODIS
	BROCK
	BENEDICT
	ARTHUR
	BARNEY
	KEITH
	JAMEL
	FELIPE
	DUANE
	JULIO
	RENE
	MORTON
	DOMINIQUE
	EARNEST
	HANS
	KERMIT
	KENT
	JEFFRY
	ROBBY
	NOLAN
	JEFFERY
	LAMAR
	STEFAN
	ABRAHAM
	BURT
	HORACE
	DUSTIN
	AUSTIN
	JARRED
	KELVIN
	BLAKE
	FRANK
	LEIGH
	WADE
	WILLARD
	DOUGLAS
	CALVIN
	JODY
	BUCK
	LAZARO
	RAMON
	CHRIS
	PARKER
	ADOLFO
	JACQUES
	JEAN
	DESMOND
	FEDERICO
	PHIL
	JARED
	SANFORD
	LINDSAY
	JASPER
	DOMINIC
	DAMIAN
	DENVER
	CARROL
	ROCCO
	WILBURN
	BENITO
	BRUNO
	WILLIAMS
	STERLING
	TEDDY
	RANDY
	WILLIE
	BRADFORD
	FIDEL
	WILBER
	EZEQUIEL
	REUBEN
	LUIS
	MOHAMMAD
	DONOVAN
	MARSHALL
	WES
	ISAAC
	BRYANT
	JESS
	WALLY
	STANTON
	KENDALL
	REGGIE" );
	
	final pierrePaulJacquesCoResult = parseOutput(
	"LIO
	GI
	ROBE
	CLAR
	JONAS
	JONAH
	DARY
	AL
	NORM
	BUS
	CHAN
	BOY
	CHAS
	MERL
	EL
	JI
	KEN
	MAU
	FREE
	TON
	TODD
	TOM
	KO
	MARI
	FRANKL
	BARR
	ADA
	DOUG
	CO
	JARV
	NE
	DR
	EZR
	KR
	ARO
	TY
	CU
	WEL
	DIE
	ANT
	JESSI
	WILLIAM
	CLEM
	DEE
	SC
	JACK
	LAV
	PHILL
	SU
	KI
	CARO
	CY
	SH
	ROL
	TED
	THA
	BRYC
	X
	HOB
	DEAN
	LANC
	CAM
	HILA
	BUF
	BRAN
	ALE
	NORR
	ED
	JUS
	OM
	CLAI
	Q
	HILT
	BI
	FREDR
	LANE
	ROBI
	LUC
	DARR
	BENT
	IA
	TI
	MEL
	DUD
	GR
	GO
	RON
	WILT
	DEAND
	CLEO
	CHE
	WAR
	JOH
	THU
	MAN
	ARNOLDO
	MARL
	ARNOLD
	TOD
	MERR
	PE
	FELIX
	JEW
	JAE
	RANDA
	DIL
	DOMING
	HIR
	REI
	BOB
	FREDE
	AND
	ISAI
	GA
	CHAD
	RI
	MI
	OD
	BRO
	BENE
	ART
	BARN
	KEI
	JAM
	FELIP
	DUA
	JUL
	REN
	MOR
	DOMINIQ
	EA
	HA
	KER
	KENT
	JEFFR
	ROBB
	NOL
	JEFFE
	LAM
	STEF
	AB
	BUR
	HOR
	DUS
	AU
	JARR
	KEL
	BL
	FRANK
	LE
	WAD
	WILLA
	DOUGL
	CAL
	JOD
	BUC
	LAZ
	RAM
	CHR
	PA
	ADO
	JACQ
	JEA
	DES
	FED
	PHIL
	JARE
	SA
	LIN
	JAS
	DOMINIC
	DAM
	DEN
	CARR
	ROC
	WILBU
	BENI
	BRU
	WILLIAMS
	STER
	TEDD
	RANDY
	WILLIE
	BRAD
	FI
	WILBE
	EZE
	REU
	LUI
	MOH
	DON
	MARS
	WES
	ISAA
	BRYA
	JESS
	WAL
	STA
	KEND
	REG" );
	
	final incrementalOptions = parseInput(
	"5
	verbose
	verb
	verbose
	verb
	verbose" );
	
	final incrementalOptionsResult = parseOutput(
	"verbo
	verb
	verbo
	verb
	verbo" );
	
}

