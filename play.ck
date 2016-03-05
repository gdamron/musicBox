// argument variables 
int INSTR;
float TEMPO;
float AMP;
int MELODY[];
180 => float DURATION;
0 => float ELAPSED;
0.3 => float G_AMP;
1.0 => float gainVal;
0.2 => float dryVal;
1.0 => float revTime;

GVerb wet => dac;
100 => wet.roomsize;
0.5 => wet.damping;
revTime::second => wet.revtime;
0.2 => wet.early;
0.5 => wet.tail;
dryVal => wet.dry;
true => int keepPlaying;

if (me.args())
{
	Std.atoi(me.arg(0)) => INSTR;
	(Std.atof(me.arg(1)) / 1000.0 + 0.25) * 2.0 => TEMPO;

	me.args() - 2 => int melCount;
	int arr[melCount] @=> MELODY;

	for (2 => int i; i < me.args() - 1; i++) {
		Std.atoi(me.arg(i)) => MELODY[i-2];
	}
}

Gamelan gamelan;
gamelan.connect(wet);

TEMPO < 0.75 => int isFast;
0 => int cycle;

while (keepPlaying) {
	for (0 => int j; j < MELODY.cap() - 1; j++) {
		TEMPO => float duration;

		if (ELAPSED < 30) {
			0.9 => dryVal;
		} else if (ELAPSED < 120.0) {
			if (dryVal > 0) {
				0.0025 -=> dryVal;
			}
			
			if (revTime < 10) {
				0.1 +=> revTime;
			}
		} else if (ELAPSED > 120.0) {
			0.01 -=> gainVal;
		}

		G_AMP * gainVal => float amp;

		if (INSTR == 0) {
			duration / 4.0 => duration;
			MELODY[j] => int index;

			if (index > 0) {
				5 +=> index;
			}

			if (index > 10) {
				10 -=> index;
			}

			gamelan.kantil(index, amp, duration);

		} else if (INSTR == 1) {
			duration / 4.0 => duration;
			MELODY[j] => int index;

			if (index > 0) {
				5 +=> index;
			}

			if (index > 10) {
				10 -=> index;
			}

			gamelan.pemade(index, amp, duration);
		} else if (INSTR == 2) {
			duration / 2.0 => duration;
			gamelan.ugal(MELODY[j], amp, duration);
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

			gamelan.calun(index, amp, duration);
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

			gamelan.jublag(index, amp, duration);
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

			gamelan.jegogan(index, amp, duration);
			8 +=> j;
		}

		dryVal => wet.dry;
		revTime::second => wet.revtime;
		duration +=> ELAPSED;

		if (ELAPSED >= DURATION || gainVal <= 0) { 
			false => keepPlaying; 
			break;
		}

		//<<<"instrument: ",INSTR," elapsed: ",ELAPSED," amp: ",gainVal>>>;
	}

	cycle++;

	if (cycle%8==0 && isFast) {
		2 *=> TEMPO;
		false => isFast;
	} else if (cycle%4==0 && !isFast) { 
		2 /=> TEMPO;
		true => isFast;
	}
}

<<<"instrument: ", INSTR, " done.">>>;
