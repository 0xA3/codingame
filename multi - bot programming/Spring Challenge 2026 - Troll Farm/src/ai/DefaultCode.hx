/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var myId = Std.parseInt(sys.stdin().readLine());
var width = Std.parseInt(sys.stdin().readLine());
var height = Std.parseInt(sys.stdin().readLine());
for (i in 0...height) {
    var row = sys.stdin().readLine();
}
var snakebotsPerPlayer = Std.parseInt(sys.stdin().readLine());
for (i in 0...snakebotsPerPlayer) {
    var mySnakebotId = Std.parseInt(sys.stdin().readLine());
}
for (i in 0...snakebotsPerPlayer) {
    var oppSnakebotId = Std.parseInt(sys.stdin().readLine());
}

// game loop
while (true) {
    var powerSourceCount = Std.parseInt(sys.stdin().readLine());
    for (i in 0...powerSourceCount) {
        var inputs = sys.stdin().readLine().split(' ');
        var x = Std.parseInt(inputs[0]);
        var y = Std.parseInt(inputs[1]);
    }
    var snakebotCount = Std.parseInt(sys.stdin().readLine());
    for (i in 0...snakebotCount) {
        var inputs = sys.stdin().readLine().split(' ');
        var snakebotId = Std.parseInt(inputs[0]);
        var body = inputs[1];
    }

    // Write an action using trace()
    // To debug: trace('Debug messages...');

    trace('WAIT');
}
