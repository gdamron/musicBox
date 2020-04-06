public class Score {
    public void main(int totalDur, DoneEvent e) {
        Gamelan gamelan;
        GVerb wet => dac;

        100 => wet.roomsize;
        0.5 => wet.damping;
        0.25::second => wet.revtime;
        1.0 => wet.dry;
        0.2 => wet.early;
        0.5 => wet.tail;

        generatePhrase() @=> int phrase[];
        Math.random2f(0.1, 0.5) => float baseDur;

        "" => string pStr;
        for (0 => int i; i < phrase.cap(); i++) {
            pStr + phrase[i] + ", " => pStr;
        }

        <<<baseDur, pStr>>>;
        gamelan.connect(wet);

        play(gamelan, baseDur, phrase, totalDur, wet);

        e.broadcast();
    }

    private int[] generatePhrase() {
        10 => int scaleCount;
        Math.random2( 1, 4 ) * 16 => int length;

        int melody[length];
        for( 0 => int i; i < length; i++ ) {
            Math.random2(0, scaleCount) => melody[i];
        }

        return melody;
    }

    private int getNote(int degree, int base, int keys) {
        if (degree == 0) {
            return degree;
        }

        // TODO: make a param
        5 => int octave;

        degree + base => int note;

        while (note < 1) {
            octave +=> note;
        }

        while (note > keys) {
            octave -=> note;
        }

        return note;
    }


    private void play(Gamelan gamelan, float tempo, int melody[], float end, GVerb reverb) {
        0.0 => float total;
        0 => int j;
        0 => int gongDex;
        0 => int cycle;
        1.0 => float gainVal;

        end * 0.2 => float p2Start;
        end * 0.66 => float p3Start;

        while (total < end && gainVal > 0) {
            tempo => float duration;

            if (total < p2Start) {
                1.0 => reverb.dry;
            } else {
                if (reverb.dry() > 0) {
                    reverb.dry() - 0.0025 => reverb.dry;
                }

                if (reverb.revtime() < 20::second) {
                    reverb.revtime() + 0.125::second => reverb.revtime;
                }
            }

            if (total > p3Start) {
                0.01 -=> gainVal;
            }

            duration::second => dur seconds;
            melody[j] => int degree;

            getNote(degree, 6, 10) => int index;
            gamelan.kantil(index, 0.2 * gainVal, duration);
            getNote(degree, 6, 10) => index;
            gamelan.pemade(index, 0.2 * gainVal, duration);

            if (j % 2 == 0) {
                gamelan.ugal(degree, 0.3 * gainVal, duration);
            }

            if (j % 4 == 0) {
                getNote(degree, 2, 5) => int jIndex;
                getNote(degree, -1, 7) => int cIndex;
                gamelan.jublag(jIndex, 0.3 * gainVal, duration);
                gamelan.calun(cIndex, 0.2 * gainVal, duration);
            }

            if (j % 8 == 0) {
                getNote(degree, 2, 5) => index;
                gamelan.jegogan(index, 0.3 * gainVal, duration);
            }

            if (j % 16 == 0) {
                gongs(gamelan, gongDex, duration * 16);
                (gongDex + 1) % 4 => gongDex;
            }

            seconds => now;
            j++;
            if (j >= melody.cap()) {
                0 => j;
                cycle++;

                tempo < 0.25 => int isFast;
                if (cycle % 8 == 0 && isFast) {
                    2 *=> tempo;
                } else if (cycle % 4 == 0 && !isFast) {
                    0.5 *=> tempo;
                }
            }

            duration +=> total;
        }
    }

    private void gongs(Gamelan gamelan, int index, float duration) {
        if (index == 0) {
            gamelan.gong(0.5, duration);
        } else if (index == 2) {
            gamelan.klentong(0.5, duration);
        } else {
            gamelan.kenpur(0.5, duration);
        }
    }
}
