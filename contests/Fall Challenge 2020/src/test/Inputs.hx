package test;

//  0 the unique ID of this spell or recipe
//  1 in the first league: BREW, later: CAST, OPPONENT_CAST, LEARN, BREW
//  2 tier-0 ingredient change
//  3 tier-1 ingredient change
//  4 tier-2 ingredient change
//  5 tier-3 ingredient change
//  6 the price in rupees if this is a potion
//  7 the index in the tome if this is a tome spell, equal to the read-ahead tax
//  8 the amount of taxed tier-0 ingredients you gain from learning this spell
//  9 1 if this is a castable player spell
// 10 1 if this is a repeatable player spell

class Inputs {

public static inline var INPUT_ACTIONS_1 =
//0   1   2 3 4 5  6 7 8 9 10
"51 BREW -3 0 0 0 10 0 0 0 0";

public static inline var PLAYERS_1 =
"3 0 0 0 0
3 0 0 0 0";


public static inline var INPUT_ACTIONS_2 =
//0   1   2 3 4 5  6 7 8 9 10
"51 BREW -1 0 0 0 10 0 0 0 0
52 BREW -1 0 0 0 20 0 0 0 0";

public static inline var PLAYERS_2 =
"2 0 0 0 0
2 0 0 0 0";

public static inline var INPUT_ACTIONS_3 =
//0   1   2 3 4 5  6 7 8 9 10
"51 BREW -1 0 0 0 10 0 0 0 0
52 BREW -1 0 0 0 20 0 0 0 0
53 BREW -1 0 0 0 30 0 0 0 0";

public static inline var PLAYERS_3 =
"6 0 0 0 0
6 0 0 0 0";


public static inline var INPUT_ACTIONS_6 =
//0   1   2 3 4 5  6 7 8 9 10
"51 BREW -1 0 0 0 10 0 0 0 0
52 BREW -1 0 0 0 20 0 0 0 0
53 BREW -1 0 0 0 30 0 0 0 0
54 BREW -1 0 0 0 40 0 0 0 0
55 BREW -1 0 0 0 50 0 0 0 0
56 BREW -1 0 0 0 60 0 0 0 0";

public static inline var PLAYERS_6 =
"6 0 0 0 0
6 0 0 0 0";

public static inline var INPUT_ACTIONS_1_2 =
//0   1   2 3 4 5  6 7 8 9 10
"78 CAST 2 0 0 0 0 -1 -1 1 0
51 BREW -1 0 0 0 10 0 0 0 0
52 BREW -1 0 0 0 20 0 0 0 0";

public static inline var PLAYERS_EMPTY =
"0 0 0 0 0
0 0 0 0 0";

public static inline var INPUT_ACTIONS_1_3 =
//0   1   2 3 4 5  6 7 8 9 10
"78 CAST 2 0 0 0 0 -1 -1 1 0
79 CAST -1 1 0 0 0 -1 -1 1 0
51 BREW 0 -1 0 0 10 0 0 0 0
52 BREW 0 -1 0 0 20 0 0 0 0";

public static inline var INPUT_ACTIONS_1_4 =
//0   1   2 3 4 5  6 7 8 9 10
"78 CAST 2 0 0 0 0 -1 -1 1 0
79 CAST -1 1 0 0 0 -1 -1 1 0
80 CAST 0 -1 1 0 0 -1 -1 1 0
81 CAST 0 0 -1 1 0 -1 -1 1 0
51 BREW 0 -1 0 0 10 0 0 0 0
52 BREW 0 -2 0 0 20 0 0 0 0";


public static inline var INPUT_ACTIONS_A =
//0   1   2 3 4 5  6 7 8 9 10
"71 BREW -2 0 -2 -2 20 3 4 0 0
49 BREW 0 -5 0 0 11 1 4 0 0
61 BREW 0 0 0 -4 16 0 0 0 0
59 BREW -2 0 0 -3 14 0 0 0 0
56 BREW 0 -2 -3 0 13 0 0 0 0
39 LEARN 0 0 -2 2 0 0 0 0 1
35 LEARN 0 0 -3 3 0 1 0 0 1
21 LEARN -3 1 1 0 0 2 0 0 1
37 LEARN -3 3 0 0 0 3 0 0 1
22 LEARN 0 2 -2 1 0 4 0 0 1
16 LEARN 1 0 1 0 0 5 0 0 0
78 CAST 2 0 0 0 0 -1 -1 1 0
79 CAST -1 1 0 0 0 -1 -1 1 0
80 CAST 0 -1 1 0 0 -1 -1 1 0
81 CAST 0 0 -1 1 0 -1 -1 1 0
82 OPPONENT_CAST 2 0 0 0 0 -1 -1 1 0
83 OPPONENT_CAST -1 1 0 0 0 -1 -1 1 0
84 OPPONENT_CAST 0 -1 1 0 0 -1 -1 1 0
85 OPPONENT_CAST 0 0 -1 1 0 -1 -1 1 0";

public static inline var INPUT_ACTIONS_B =
//0   1   2 3 4 5  6 7 8 9 10
"48 BREW 0 -2 -2 0 13 3 4 0 0
72 BREW 0 -2 -2 -2 20 1 4 0 0
49 BREW 0 -5 0 0 10 0 0 0 0
77 BREW -1 -1 -1 -3 20 0 0 0 0
51 BREW -2 0 -3 0 11 0 0 0 0
10 LEARN 2 2 0 -1 0 0 0 0 1
7 LEARN 3 0 1 -1 0 1 0 0 1
3 LEARN 0 0 1 0 0 2 0 0 0
12 LEARN 2 1 0 0 0 3 0 0 0
20 LEARN 2 -2 0 1 0 4 0 0 1
40 LEARN 0 -2 2 0 0 5 0 0 1
78 CAST 2 0 0 0 0 -1 -1 1 0
79 CAST -1 1 0 0 0 -1 -1 1 0
80 CAST 0 -1 1 0 0 -1 -1 1 0
81 CAST 0 0 -1 1 0 -1 -1 1 0
82 OPPONENT_CAST 2 0 0 0 0 -1 -1 1 0
83 OPPONENT_CAST -1 1 0 0 0 -1 -1 1 0
84 OPPONENT_CAST 0 -1 1 0 0 -1 -1 1 0
85 OPPONENT_CAST 0 0 -1 1 0 -1 -1 1 0";

public static inline var PLAYERS_CODINGAME =
"3 0 0 0 0
3 0 0 0 0";
		
}