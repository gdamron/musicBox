// argument variables 
int INSTR;
float TEMPO;
float AMP;
int MELODY[];

NRev wet => dac;
Echo e;
e => wet;
Gain dry => dac;  
Gain g2 => dac;



0.6 => wet.gain;
0.6 => wet.mix;
0.1 => dry.gain;
0.8 => e.gain;
500::ms => e.delay;
1.0 => e.mix;
0.9 => g2.gain;

e => g2;
wet => g2;

if (me.args())
{
	Std.atoi(me.arg(0)) => INSTR;
	Std.atof(me.arg(1)) => TEMPO;

	me.args() - 2 => int melCount;
	int arr[melCount] @=> MELODY;

	for (2 => int i; i < me.args(); i++) {
		Std.atoi(me.arg(i)) => MELODY[i-2];
	}
}

Gamelan gamelan;
gamelan.connect(dac);
// gamelan.connect(wet);
// gamelan.connect(dry);
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
