public class Score {
    public void main(int totalDur, DoneEvent e) {
        Gamelan gamelan;
        Gain feedback => Echo echo => NRev r1 => NRev r2 => dac;
        0.7 => feedback.gain;
        echo => feedback;

        0.0 => r1.mix;
        0.0 => r2.mix;
        3.6::second => echo.max;
        1.8::second => echo.delay;
        0.0 => echo.mix;

        generatePhrase() @=> int phrase[];
        Math.random2f(0.1, 0.5) => float baseDur;

        "" => string pStr;
        for (0 => int i; i < phrase.cap(); i++) {
            pStr + phrase[i] + ", " => pStr;
        }

        <<<baseDur, pStr>>>;
        gamelan.connect(r1);
        gamelan.connect(echo);

        play(gamelan, baseDur, phrase, totalDur, r1, r2, echo);

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

    private int getNote(int degree, int base, int keys, int octave) {
        if (degree == 0) {
            return degree;
        }

        degree + base => int note;

        while (note < 1) {
            octave +=> note;
        }

        while (note > keys) {
            octave -=> note;
        }

        return note;
    }


    private void play(Gamelan gamelan, float tempo, int melody[], float end, NRev r1, NRev r2, Echo e) {
        0.0 => float total;
        0 => int j;
        0 => int gongDex;
        0 => int cycle;
        1.0 => float gainVal;
        gamelan.octave => int octave;

        end * 0.2 => float p2Start;
        end * 0.66 => float p3Start;

        while (total < end && gainVal > 0) {
            tempo => float duration;

            if (total < p2Start) {
                0.0 => r1.mix;
                0.1 => r2.mix;
                0.0 => e.mix;
            } else {
                if (r1.mix() < 1) {
                    r1.mix() + 0.0025 => r1.mix;
                }

                if (r2.mix() < 1) {
                    r2.mix() + 0.0005 => r2.mix;
                }

                if (e.mix() < 1) {
                    Math.min(1.0, e.mix() + 0.01) => e.mix;
                }
            }

            if (total > p3Start) {
                0.01 -=> gainVal;
            }

            duration::second => dur seconds;
            melody[j] => int degree;

            getNote(degree, 6, 10, octave) => int index;
            gamelan.kantil(index, 0.1 * gainVal, duration);
            getNote(degree, 6, 10, octave) => index;
            gamelan.pemade(index, 0.1 * gainVal, duration);

            if (j % 2 == 0) {
                gamelan.ugal(degree, 0.15 * gainVal, duration);
            }

            if (j % 4 == 0) {
                getNote(degree, 2, 5, octave) => int jIndex;
                getNote(degree, -1, 7, octave) => int cIndex;
                gamelan.jublag(jIndex, 0.12 * gainVal, duration);
                gamelan.calun(cIndex, 0.1 * gainVal, duration);
            }

            if (j % 8 == 0) {
                getNote(degree, 2, 5, octave) => index;
                gamelan.jegogan(index, 0.12 * gainVal, duration);
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
            gamelan.gong(0.2, duration);
        } else if (index == 2) {
            gamelan.klentong(0.2, duration);
        } else {
            gamelan.kenpur(0.2, duration);
        }
    }
}
