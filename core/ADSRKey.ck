public class ADSRKey extends ISoundChain {
    ADSRModifier m_modifier;
    SinOsc m_sin => ADSR m_adsr;
    public void connect(UGen u) {
        m_adsr => u;
    }

    public void init(float gain, float freq, float a, float d, float s, float r) {
        gain => m_modifier.gain;
        freq => m_modifier.frequency;
        a => m_modifier.attack;
        d => m_modifier.decay;
        s => m_modifier.sustain;
        r => m_modifier.release;
    }

    public void update(float frequency, float amplitude, float decay) {
        frequency * m_modifier.frequency => m_sin.freq;
        amplitude * m_modifier.gain => m_sin.gain;
        (m_modifier.attack * decay)::second => dur a;
        (m_modifier.decay * decay)::second => dur d;
        (m_modifier.sustain * decay) => float s;
        (m_modifier.release * decay)::second => dur r;
        m_adsr.set(a, d, s, r);
    }

    public void stop() {
        250::samp => m_adsr.releaseTime;
        keyOff();
    }

    public void keyOn() {
        m_adsr.keyOn();
    }

    public void keyOff() {
        m_adsr.keyOff();
    }
}
