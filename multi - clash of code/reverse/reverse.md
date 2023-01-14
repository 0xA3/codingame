### 2 ^ n - 1
	4	15
	1	1
	20	1048575
	39	549755813887
	2	3
	9	511

### a b multiply add subtract
	8 2   16106
	5 4   2091
	9 6   54153
	20 3  602317

### a is -b then 1 else 0
	2			1
	-2

	1			0
	-5

	5			0
	5

	111101		1
	-111101

	2			0
	2

### add even subtract uneven
	3		3
	2
	4

	3		-2
	1
	2

	3		-9
	5
	1

	4		12
	2
	6

	121		-480
	214
	573

	1000	3000
	1000
	1000

	998		-998
	999
	997

### add minutes
	1		00:00
	23:59

	5		11:28
	11:23

	50		13:49
	12:59

	21		23:00
	22:39

### align right
	4		
	1			         1
	1234567890	1234567890
	123			       123
	90809		     90809

	5
	1			1
	2			2
	3			3
	4			4
	5			5

	3
	123			123
	12			 12
	1			  1

### ASCII
	80 85 90 100 105 115	PUZdis
	90 98 105 67 69 75		ZbiCEK
	91 82 69 65 68 93		[READ]
	
	65 67 68 69 70 80 81 82 83 84 85 100 101 102 103 104 105 106 107 108 109 110 111 112 113 120 121 122 123 124 125 126
	ACDEFPQRSTUdefghijklmnopqxyz{|}~

### average
	12		21
	30

	56		56
	56

	378		487
	596

	33		46
	60

### calculate center
	5 5			2 2
	.....
	.....
	..#..
	.....
	.....

	8 5			5 1
	...#####
	...#.#.#
	...#####
	........
	........

	5 4			2 1
	.###.
	.###.
	.###.
	.....

	5 6			2 4
	.....
	.....
	.....
	.###.
	.#.#.
	.###.

	8 6			3 2
	.#......
	..#.....
	...#....
	....#...
	.....#..
	........

### calculate result with 2 numbers
	8		5
	-
	3

	8		24
	x
	3

	3		273
	x
	91

	99		112
	+
	13

	8		1
	/
	8

	3		9
	x
	3

	3		3
	x
	1

### caesar cypher uppercase
	2
	HELLO WORLD
	
	FCJJM UMPJB

	6
	THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG

	NBY KOCWE VLIQH ZIR DOGJM IPYL NBY FUTS XIA

	3
	H3LL0 W0RLD

	E3II0 T0OIA

	2
	H4IGDFDNO£PJNHVDKHZPDOPG2

	F4GEBDBLM£NHLFTBIFXNBMNE2

### caesar cypher plus 2
	abc							cde
	IcwZmypb					KeyBoard
	Ayl wms zsw kw 2 zylylyq	Can you buy my 2 bananas
	
	Yqi, ylb gr qfyjj zc egtcl wms; qcci, ylb wms qfyjj dglb.
	Ask, and it shall be given you; seek, and you shall find.

### char quad
	4		aaa
	3		bbb
	abc		ccc
			aaa

	6		1
	1		a
	1a		1
			a
			1
			a
	1		\
	1
	\

	1		CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
	40
	C


### count digits in line
	1				
	Hello World !			0

	2
	l337 5p3k 15 c00l		9
	5pr34d 7h3 w0rd !		6

	2
	abcd1234				4
	a1b2c3d4				4

	2
	xxxxxxxxxx				0
	1111111111				10

### count uppercase letters
	Hello					1
	Hello World!			2
	Welcome to CodinGame	3
	Come back ASAP!			5
	She just replied 'LOL'	4

### create if statements
	3
	
	if n == 1:
		print("n is 1")
	elif n == 2:
		print("n is 2")
	elif n == 3:
		print("n is 3")
	else:
		print("number not found :(")
	
	1
	
	if n == 1:
		print("n is 1")
	else:
		print("number not found :(")


### cross
	5
	\   /
	 \ /
	  X
	 / \
	/   \

	2
	\/
	/\

	1
	X

	8
	\      /
	 \    /
	  \  /
	   \/
	   /\
	  /  \
	 /    \
	/      \
	
### decode ASCII
	727332688568693233
	HI DUDE !

	7384398332657832696583893280859090766946325841
	IT'S AN EASY PUZZLE. :)

	666976736986693277694432733977327879843265327673658232407485838432653282796679844146
	BELIEVE ME, I'M NOT A LIAR (JUST A ROBOT).

	847273833283697884697867693267798576683266693276797871698244327384328779857668328384737676326669326965838932333272858282893285803233325941
	THIS SENTENCE COULD BE LONGER, IT WOULD STILL BE EASY ! HURRY UP ! ;)

### complete smileys
	:)			:)
	:))			Oh no!
	::))		:):)
	):			:)
	:)::)		Oh no!
	)::)		:):)
	):)::):)):	:):):):):)

### divide identical chars with space
	AAAABBBCCDAA	AAAA BBB CC D AA
	BbbABC			B bb A B C
	ZZOOZZPPAAA		ZZ OO ZZ PP AAA
	abcdefgh		a b c d e f g h
	AaBbCcDDdEe		A a B b C c DD d E e

### fibonacci
	5	0 1 1 2 3
	1	0
	2	0 1
	10	0 1 1 2 3 5 8 13 21 34

### filter out vowels
	Hello						Hll
	This Is a sentence			Ths s  sntnc
	abcdefghijklmnopqrstuvwxyz	bcdfghjklmnpqrstvwxyz
	aeiouy						y

### filter uppercase chars
	higHlIght
	HI

	let me be a codiNgame hERo on Demand.
	NERD

	the WEstErn child KickEd the rouND ball.
	WEEKEND

### filter vowels and consonants
	Hello world					eoo
								Hllwrld

	empty						ey
								mpt

	Abcdefghihklmnopqrstuvwxyz	Aeiouy
								bcdfghhklmnpqrstvwxz

	Sort Values					oaue
								SrtVls

### find missing digit
	1
	123456789	0

	1
	920683475	1

	2
	025874963	1
	126489570	3
	10
	205749368	1	
	063981547	2
	032945671	8
	071863245	9
	341527968	0
	803751429	6
	190854376	2
	183972540	6
	603285791	4
	723695148	0

### floor 1.5 n
	1	1
	2	3
	3	4
	5	7
	10	15
	25	37
	50	75
	100	150

### greatest common denominator
	18 30	6
			3 5

	63 15	3
			21 5

	84 64	4
			21 16

	42 96	6
			7 16

	73 28	1
			73 28

	53 53	53
			1 1

### height width material
	3		####
	4		####
	#		####

### hex chars
	11		hello world
	68
	65
	6c
	6c
	6f
	20
	77
	6f
	72
	6c
	64

### KONAMI CODE
	LDDDPK			<vvvAB
	RUKRUKDLP		>^B>^Bv<A
	DUDDDLRK		v^vvv<>B
	KONAMI CODE!	^^vv<<>>BA

### line of chars
	5
	_
	
	_
	 _
	  _
	   _
		_

	2
	-

	-
	 -

	4
	$

	$
	 $
	  $
	   $

### list element n of addition and subtraction result (js eval)
	1 + 1						3
	1 2 3 4 5 6 7 8 9 10

	1 + 2 + 3					5
	0 2 9 2 5 1 5 2 2 5

	91 - 90						0
	0 0 0 0 0 0 0 0 0 0

	10 - 1 - 5					9
	5 7 2 4 9 1 5 2 6 2

### loop n times with start and delta values
	1		5
	2 3

	5		5
	2 3		7
			9
			11
			13

	2		11
	5 6		16

	6		10
	10 10	20
			30
			40
			50
			60
			70

### mark odd numbers

	5
	1 2 3 4 5

	[x] 1
	[ ] 2
	[x] 3
	[ ] 4
	[x] 5

	22
	2 3 4 9 11 12 19 20 23 36 41 56 58 59 67 72 74 89 90 92 94 99

	[ ] 2
	[x] 3
	[ ] 4
	[x] 9
	[x] 11
	[ ] 12
	[x] 19
	[ ] 20
	[x] 23
	[ ] 36
	[x] 41
	[ ] 56
	[ ] 58
	[x] 59
	[x] 67
	[ ] 72
	[ ] 74
	[x] 89
	[ ] 90
	[ ] 92
	[ ] 94
	[x] 99

	20
	-68 4 91 37 22 15 -34 -71 29 0 -42 6 -50 -39 46 -1 -29 74 73 -95

	[ ] -68
	[ ] 4
	[x] 91
	[x] 37
	[ ] 22
	[x] 15
	[ ] -34
	[x] -71
	[x] 29
	[ ] 0
	[ ] -42
	[ ] 6
	[ ] -50
	[x] -39
	[ ] 46
	[x] -1
	[x] -29
	[ ] 74
	[x] 73
	[x] -95

	-71 16 67 32 28 -49 53

	[x] -71
	[ ] 16
	[x] 67
	[ ] 32
	[ ] 28
	[x] -49
	[x] 53

### meal ingredients ascii
	CakE;102,108,111,117,114+101,103,103,115+109,105,108,107
	Cake ingredients are flour, eggs, milk

	MANsaf;114,105,99,101+106,97,109,101,101,100+108,97,109,112
	Mansaf ingredients are rice, jameed, lamp

	PiZzA;100,111,117,103,104+109,111,122,122,97,114,101,108,108,97+116,111,109,97,116,111+107,101,116,99,104,117,112+112,101,112,112,101,114,111,110,105
	Pizza ingredients are dough, mozzarella, tomato, ketchup, pepperoni

	SaNdWich;98,114,101,97,100+99,104,101,101,115,101+109,111,114,116,97,100,101,108,108,97
	Sandwich ingredients are bread, cheese, mortadella
	
### move 2d
	0 0		0 1
	1
	N 1

	0 0		0 0
	4
	N 1
	E 1
	S 1
	W 1

	-12 -8		-2 -11
	2
	E 10
	S 3

	-33 18		-33 18
	8
	W 100
	S 100
	E 100
	N 100
	E 100
	N 100
	W 100
	S 100

### n ^ n+1
	1	1
	2	8
	3	81

### n * ( 3 + n - 1 )
	1	3
	2	8
	5	35
	16	288
	18	300

### n * ( n - 2 ) - parseFloat
	8	48
	800	638400
	100	9800
	7	35

### n * n * 100
	6	2600
	12	14400
	20	40000
	1	100
	8	8100

### n + 2 * n.length
	1				3
	24				Invalid
	2345			2353
	4539			4547
	98765434531		98765434553
	58749865734		Invalid
	-12345			-12335
	6547657			6547671
	859746574695728	Invalid
	-7460782346084	Invalid

### number triangle
	2	22
		2
	
	3	333
		33
		3

	4	4444
		444
		44
		4
### number triangle with plus
	4	1234
		+123
		++12
		+++1

	2	12
		+1

	1	1

	3	123
		+12
		++1

### pattern times n
	2
	 /\  /\
	<  ><  >
	 \/  \/
	 /\  /\
	<  ><  >
	 \/  \/

	1
	 /\
	<  >
 	 \/

### percentage gained or lost
	100.00 2		225.00
	gained 50%
	gained 50%

	100.00 2		25.00
	lost 50%
	lost 50%

	99.98 0			99.98
	
	100.00 2		99.00
	gained 10%
	lost 10%


### print char n repeat n half times
	3
	5 8 10

	eee
	hhhh
	jjjjj

	5
	12 14 13 15 2

	llllll
	nnnnnnn
	mmmmmmm
	oooooooo
	b

	7
	15 14 16 25 24 23 11

	oooooooo
	nnnnnnn
	pppppppp
	yyyyyyyyyyyyy
	xxxxxxxxxxxx
	wwwwwwwwwwww
	kkkkkk

	9
	24 21 13 19 17 20 25 15 3
	
	xxxxxxxxxxxx
	uuuuuuuuuuu
	mmmmmmm
	ssssssssss
	qqqqqqqqq
	tttttttttt
	yyyyyyyyyyyyy
	oooooooo
	cc

	14
	1 4 5 3 2 9 8 12 1 24 26 15 12 23
	
	a
	dd
	eee
	cc
	b
	iiiii
	hhhh
	llllll
	a
	xxxxxxxxxxxx
	zzzzzzzzzzzzz
	oooooooo
	llllll
	wwwwwwwwwwww

### print stars with indentation
	5
	1
	3
	5
	9
	2

	 *
	   **
		***
			****
	*****

	1
	0
	
	*

	4
	6
	9
	0
	2

	      *
	         **
	***
	  ****


### quad box with n size
	3
	---------
	|...|...|
	|...|...|
	|...|...|
	|---+---|
	|...|...|
	|...|...|
	|...|...|
	---------

	7
	-----------------
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|-------+-------|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	|.......|.......|
	-----------------

	10
	-----------------------
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|----------+----------|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	|..........|..........|
	-----------------------

### rectangle type
	3		RIGHT
	4
	5

	3		SCALENE
	5
	6

	5		ISOSCELES
	6
	5

	0		IMPOSSIBLE
	0
	0

	1		IMPOSSIBLE
	1
	0

	1		IMPOSSIBLE
	5
	1

### replace text with e
	7								eeeeeee
	Example

	9								eee eeeee
	One space

	24								eeeeeee eeee eeee eeeeee
	Message with many spaces

	27
	M1x3d numb3rs @nd '$ymb0ls'		eeeee eeeeeee eee eeeeeeeee

	36
	A lot of spaces at the end		e eee ee eeeeee ee eee eee
	e eee ee eeeeee ee eee eee

### ROCK PAPER SCISSORS
	ROCK SCISSORS	PLAYER1
	PAPER PAPER		DRAW
	SCISSORS ROCK	PLAYER2
	PAPER SCISSORS	PLAYER2

### sequence 1 to n - repeat n times
	1
	1
	
	10		12345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910
	
	12		123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112123456789101112
	
	6
	123456123456123456123456123456123456

### separate digits and letters sum digits reverse letters
	12adc34s54ki					19ikscda

	ds394sk30s99					37skssd

	d3495ks39528394jsJKLJLK3849KJS	88SJKKLJLKJsjskd

	d30dk3gwuq2348cv34				30vcquwgkdd

	334s3s							13ss

	38493jdsfksd34037zjdlkzsw373885qqwpljsdkljhasquwieueiqueqio23482937wo	116owoiqeuqieueiwuqsahjlkdsjlpwqqwszkldjzdskfsdj

	fewpoi338xzvnsd					14dsnvzxiopwef

### sort chars in string
	CBA		ABC
	AhYKi	AKYhi
	3#4#15	##1345
	[#*9Ea	#*9E[a

### sort string into upper case and lower case
	ABCDefghIJKLmnop	ABCDIJKL
						efghmnop
	
	LpSOFdpgO			LSOFO
						pdpg

	UPPERCASE			UPPERCASE

	aaaaaaaaa
						aaaaaaaaa

### sum of inputs

	3		6
	1
	2
	3

	5		14
	1
	2
	1
	10
	0

	2		7
	5
	2

	1		8
	8

	4		2045
	42
	0
	1337
	666


### stars n dots
	3	...
		*..
		**.
		***

	4	....
		*...
		**..
		***.
		****

	5	.....
		*....
		**...
		***..
		****.
		*****

	6	......
		*.....
		**....
		***...
		****..
		*****.
		******

### sum of digits quad
		5		25
		12		9
		421		49
		222		36
		1090	100
		1337	196
		32767	625

### train arrival early delayed or on time
	23:18:32	EARLY
	22:19:40

	22:23:59	ON TIME
	22:23:59

	00:00:01	DELAYED
	23:23:59

	23:23:33	EARLY
	23:23:31

	22:18:18	ON TIME
	22:18:18

	22:18:15	DELAYED
	23:18:15

### triangle of numbers with n lines
	6	1
		2 3
		4 5 6
		7 8 9 10
		11 12 13 14 15
		16 17 18 19 20 21
	
	1	1

	10	1
		2 3
		4 5 6
		7 8 9 10
		11 12 13 14 15
		16 17 18 19 20 21
		22 23 24 25 26 27 28
		29 30 31 32 33 34 35 36
		37 38 39 40 41 42 43 44 45
		46 47 48 49 50 51 52 53 54 55

	2	1
		2 3

### uneven numbers up to n
	1	1
	13	1 3 5 7 9 11 13
	6	1 3 5
	-5		0
	0		0