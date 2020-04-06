public class Attack extends ISoundChain {
    float m_dampen;
    Noise m_attack => LPF m_lpf => HPF m_hpf => ADSR m_adsr;

    2::ms => static dur StrikeTick;

    public void init(float lpfFreq, float hpfFreq, float dampening, float a, float d, float s, float r) {
        StrikeTick => dur t;
        m_adsr.set(a * t, d * t, s, r * t);
        dampening => m_dampen;
        lpfFreq => m_lpf.freq;
        hpfFreq => m_hpf.freq;
    }

    public void update(float amplitude) {
        amplitude * m_dampen => m_attack.gain;
    }

    public void connect(UGen u) {
        m_adsr => u;
    }

    public void keyOn() {
        m_adsr.keyOn();
    }

    public void keyOff() {
        m_adsr.keyOff();
    }
}
