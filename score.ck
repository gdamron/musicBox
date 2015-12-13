fun int[] generatePhrase() {
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

	return melody;
}

Gamelan gamelan;
gamelan.connect(dac);

//generatePhrase() @=> int argStr[];
//Math.random2f(0.3, 0.9) => float baseDur;
Std.atof(me.arg(1)) => float baseDur;
baseDur * 2.0 => float gongDur;

me.args() - 2 => int melCount;
int arr[melCount] @=> int argStr[];

for (2 => int i; i < me.args(); i++) {
  Std.atoi(me.arg(i)) => argStr[i-2];
}

int shreds[7];

fun void play(int INSTR, float TEMPO, int MELODY[]) {
while (true) {
	for (0 => int j; j < MELODY.cap(); j++) {
		TEMPO => float duration;

		if (INSTR == 0) {
			duration / 4.0 => duration;
			MELODY[j] => int index;

			if (index > 0) {
				5 +=> index;
			}

			if (index > 10) {
				10 -=> index;
			}

			gamelan.kantil(index, 0.3, duration);

		} else if (INSTR == 1) {
			duration / 4.0 => duration;
			MELODY[j] => int index;

			if (index > 0) {
				5 +=> index;
			}

			if (index > 10) {
				10 -=> index;
			}

			gamelan.pemade(index, 0.3, duration);
		} else if (INSTR == 2) {
			duration / 2.0 => duration;
			gamelan.ugal(MELODY[j], 0.3, duration);
			1 +=> j;
		} else if (INSTR == 3) {
			duration => duration;
			MELODY[j] => int index;

			if (index > 0) {
				3 +=> index;
			}

			if (index > 7) {
				7 -=> index;
			}

			gamelan.calun(index, 0.3, duration);
			4 +=> j;
		} else if (INSTR == 4) {

			duration => duration;
			MELODY[j] => int index;

			if (index > 0) {
				1 +=> index;
			}

			if (index > 5) {
				5 -=> index;
			}

			gamelan.jublag(index, 0.3, duration);
			4 +=> j;
		} else if (INSTR == 5) {
			duration * 2.0 => duration;
			MELODY[j] => int index;

			if (index > 0) {
				1 +=> index;
			}

			if (index > 5) {
				5 -=> index;
			}

			gamelan.jegogan(index, 0.3, duration);
			8 +=> j;
		}

		duration::second => now;
	}
}
}


play(Std.atoi(me.arg(0)), baseDur, argStr);;

/*
for (0 => int i; i < 6; i++) {
    spork ~ play(i, baseDur, argStr);
    me.yield();
}

while (true) {
    second => now;
}

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
*/
