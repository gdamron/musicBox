Machine.add("Gamelan.ck");

fun string generatePhrase() {
	10 => int scaleCount;
	Math.random2( 1, 4 ) * 16 => int length;

	int melody[length];
	"" => string argStr;

	for( 0 => int i; i < length; i++ ) {
		Math.random2(0, scaleCount) => melody[i];
		argStr + melody[i] => argStr;

		if (i < length - 1) {
			argStr + ":" => argStr;
		}
	}

	return argStr;
}


generatePhrase() => string argStr;
Math.random2f(0.3, 0.9) => float baseDur;
baseDur * 2.0 => float gongDur;

int shreds[7];

Machine.add("gongCycle.ck:" + gongDur) => shreds[0];
Machine.add("play.ck:" + 0 + ":" + baseDur + ":" + argStr) => shreds[1];
Machine.add("play.ck:" + 1 + ":" + baseDur + ":" + argStr) => shreds[2];
Machine.add("play.ck:" + 2 + ":" + baseDur + ":" + argStr) => shreds[3];
Machine.add("play.ck:" + 3 + ":" + baseDur + ":" + argStr) => shreds[4];
Machine.add("play.ck:" + 4 + ":" + baseDur + ":" + argStr) => shreds[5];
Machine.add("play.ck:" + 5 + ":" + baseDur + ":" + argStr) => shreds[6];

(gongDur * 4.0 * 4.0)::second => now;

while (true) {

	generatePhrase() => argStr;
	Math.random2f(0.3, 0.9) => baseDur;
	baseDur * 2.0 => gongDur;

	Machine.replace(shreds[0], "gongCycle.ck:" + gongDur) => shreds[0];
	Machine.replace(shreds[1], "play.ck:" + 0 + ":" + baseDur + ":" + argStr) => shreds[1];
	Machine.replace(shreds[2], "play.ck:" + 1 + ":" + baseDur + ":" + argStr) => shreds[2];
	Machine.replace(shreds[3], "play.ck:" + 2 + ":" + baseDur + ":" + argStr) => shreds[3];
	Machine.replace(shreds[4], "play.ck:" + 3 + ":" + baseDur + ":" + argStr) => shreds[4];
	Machine.replace(shreds[5], "play.ck:" + 4 + ":" + baseDur + ":" + argStr) => shreds[5];
	Machine.replace(shreds[6], "play.ck:" + 5 + ":" + baseDur + ":" + argStr) => shreds[6];

	(gongDur * 4.0 * 4.0)::second => now;
}
