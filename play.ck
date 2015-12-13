// argument variables 
int INSTR;
float TEMPO;
float AMP;
int MELODY[];


GVerb wet => dac;
100 => wet.roomsize;
0.5 => wet.damping;
10::second => wet.revtime;
0.2 => wet.early;
0.5 => wet.tail;
0.2 => wet.dry;

if (me.args())
{
	Std.atoi(me.arg(0)) => INSTR;
	Std.atof(me.arg(1)) / 1000.0 + 0.25 => TEMPO;

	me.args() - 2 => int melCount;
	int arr[melCount] @=> MELODY;

	for (2 => int i; i < me.args(); i++) {
		Std.atoi(me.arg(i)) => MELODY[i-2];
	}
}

Gamelan gamelan;
//gamelan.connect(dac);
gamelan.connect(wet);
//gamelan.connect(dry);
// gamelan.connect(e);

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
