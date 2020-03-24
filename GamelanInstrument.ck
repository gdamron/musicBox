public class GamelanInstrument {
    ADSRKey m_harmonics[];
    Attack m_attacks[];
    float m_scale[];
    Gain m_output => dac;
    1 => int m_defaultDac;

    24.0 => static float LongTail;

    public void connect(UGen u) {
        if (m_defaultDac >= 1) {
            0 => m_defaultDac;
            m_output !=> dac;
        }
        m_output => u;
    }

    public dur strike(int scaleDegree, float amplitude, float duration) {
        scaleDegree % m_scale.cap() => scaleDegree;
        m_scale[scaleDegree] => float frequency;
        return makeNote(frequency, amplitude, duration);
    }

    public dur stop() {
        for (0 => int i; i < m_harmonics.cap(); i++) {
            m_harmonics[i].stop();
        }
    }

    public void tune(Attack attacks[], ADSRKey harmonics[], float scale[]) {
        harmonics @=> m_harmonics;
        attacks @=> m_attacks;
        scale @=> m_scale;

        for (0 => int i; i < m_harmonics.cap(); i++) {
            m_harmonics[i].connect(m_output);
        }

        for (0 => int i; i < m_attacks.cap(); i++) {
            m_attacks[i].connect(m_output);
        }
    }

    public dur makeNote(float frequency, float amplitude, float duration) {
        amplitude => m_output.gain;

        Math.pow(amplitude, 1+amplitude) => float impulseAmplitude;
        LongTail * impulseAmplitude => float fullDecay;
        duration::second => dur noteT;
        fullDecay::second => dur T;

        for (0 => int i; i < m_harmonics.cap(); i++) {
            m_harmonics[i].update(frequency, amplitude, fullDecay);
            m_harmonics[i].keyOn();
        }

        for (0 => int i; i < m_attacks.cap(); i++) {
            m_attacks[i].update(amplitude);
            m_attacks[i].keyOn();
        }

        Attack.StrikeTick => now;

        for (0 => int i; i < m_harmonics.cap(); i++ ) {
            m_harmonics[i].keyOff();
        }

        for (0 => int i; i < m_attacks.cap(); i++) {
            m_attacks[i].keyOff();
        }

        return noteT - Attack.StrikeTick;
    }
}
