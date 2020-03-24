Gamelan gamelan;
int shreds[7];

fun int[] generatePhrase() {
    10 => int scaleCount;
    Math.random2( 1, 4 ) * 16 => int length;

    int melody[length];
    for( 0 => int i; i < length; i++ ) {
        Math.random2(0, scaleCount) => melody[i];
    }

    return melody;
}

fun int getNote(int degree, int base, int keys) {
    if (degree == 0) {
        return degree;
    }

    base +=> degree;
    degree %=> keys;
    return degree;
}


fun void play(int INSTR, float TEMPO, int MELODY[], float end) {
    0.0 => float total;
    0 => int j;
    0 => int gongDex;
    while (total < end) {
        TEMPO => float duration;
        duration::second => dur seconds;

        getNote(MELODY[j], 6, 10) => int index;
        gamelan.kantil(index, 0.2, duration);
        getNote(MELODY[j], 6, 10) => index;
        gamelan.pemade(index, 0.2, duration);

        if (j % 2 == 0) {
            gamelan.ugal(MELODY[j], 0.25, duration);
        }

        if (j % 4 == 0) {
            getNote(MELODY[j], 2, 5) => index;
            gamelan.jublag(index, 0.4, duration);
            getNote(MELODY[j], 4, 7) => index;
            gamelan.calun(index, 0.3, duration);
        }

        if (j % 8 == 0) {
            getNote(MELODY[j], 2, 5) => index;
            gamelan.jegogan(index, 0.4, duration);
        }

        if (j % 16 == 0) {
            gongs(gongDex, duration * 16);
            (gongDex + 1) % 4 => gongDex;
        }

        seconds => now;
        (j + 1) % MELODY.cap() => j;
        duration +=> total;
    }
}

fun void gongs(int index, float duration) {
    if (index == 0) {
        gamelan.gong(0.5, duration);
    } else if (index == 2) {
        gamelan.klentong(0.5, duration);
    } else {
        gamelan.kenpur(0.5, duration);
    }
}

generatePhrase() @=> int phrase[];
Math.random2f(0.1, 0.5) => float baseDur;
//baseDur * 2.0 => float gongDur;

"" => string pStr;
for (0 => int i; i < phrase.cap(); i++) {
    pStr + phrase[i] + ", " => pStr;
}

<<<baseDur, pStr>>>;
gamelan.connect(dac);
play(2, baseDur, phrase, 40.0);
//for (0 => int i; i < 6; i++) {
//    spork ~ play(2, baseDur, phrase);
//    me.yield();
//}

//spork ~ gongs(baseDur, phrase.cap(), 4);
//me.yield();

/*

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
