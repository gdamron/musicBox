/****************************************/
/* GAMELAN CLASS                        */
/*                                      */
/* by Grant Damron: includes jegogan,   */
/* jublag, calung, ugal, pemade,  and   */
/* and kantil.  All instruments are     */
/* based on Gamelan Galak Tika's pelog  */
/* tuning. -- Measurements by Christine */
/* Southworth.                          */
/****************************************/


// TODO: work on envelopes of partials and amplitudes of both partials and attacks

public class Gamelan
{
    static Gamelan @ instance;
    
    /********************************************************/
    // INITIALIZE OSCILLATORS
    SinOsc h1 => ADSR env1 => Gain env0;
    // INITIALIZE ATTACK NOISE
    Noise att1 => LPF lpf => ADSR aenv => env0;
    
    public void connect( UGen u ) {
        0.0 => env0.gain;
        env0 => u;
    }
    
    /***************************************/
    /* Kantil: instrument to generate       */
    /* tones according to pelog scale      */
    /***************************************/
    
    public void kantil(int degree, float amp, float duration)
    {   
        0.9 *=> amp;
        0.1*amp => att1.gain;
        
        // Tuning based on Gamelan Galak Tika's pelog -- 0 triggers attack only
        [0.0, 611.581, 661.043, 827.835, 893.7948, 1152.22, 1232.011, 1333.128, 1663.032, 1792.553, 2295.512] @=> float tuning[];
        (degree % tuning.cap()) => degree;               // 'wrap around' note if it is out of range
        tuning[degree] => float fund;
        
        // FOR ATTACK
        6000.0 => lpf.freq;
        aenv.set(0::ms, 0::ms, 1., 6::ms);
        
        makeNote(fund, amp, duration) => now;
    }
        
        /************************************************************/
        
       
        
            
    /***************************************/
    /* Pemade: instrument to generate       */
    /* tones according to pelog scale      */
    /***************************************/
    
    public void pemade(int degree, float amp, float duration)
    {   
        0.95 *=> amp;
        0.1*amp => att1.gain;
        
        // Tuning based on Gamelan Galak Tika's pelog -- 0 triggers attack only
        [0.0, 303.426, 326.514, 417.838, 451.631, 571.338, 612.26, 660.31, 829.214, 893.795, 1149.029] @=> float tuning[];
        (degree % tuning.cap()) => degree;               // 'wrap around' note if it is out of range
        tuning[degree] => float fund;
        
        // FOR ATTACK
        6000.0 => lpf.freq;
        aenv.set(0::ms, 0::ms, 1., 6::ms);
        
        makeNote(fund, amp, duration) => now;
    } 
    
    
    /***************************************/
    /* Ugal: instrument to generate       */
    /* tones according to pelog scale      */
    /***************************************/
    
    public void ugal(int degree, float amp, float duration)
    {   
        0.3 => att1.gain;
        
        // Tuning based on Gamelan Galak Tika's pelog -- 0 triggers attack only
        [0.0, 305.96, 328.147, 418.07, 451.13, 571.338, 611.92, 662.878, 827.531, 885.9, 1150.304] @=> float tuning[];
        (degree % tuning.cap()) => degree;               // 'wrap around' note if it is out of range
        tuning[degree] => float fund;  
        
        // FOR ATTACK
        600.0 => lpf.freq;
        aenv.set(1::ms, 1::ms, 1., 12::ms);
        
        makeNote(fund, amp, duration) => now;
    }
    
    
    /***************************************/
    /* Calun: instrument to generate       */
    /* tones according to pelog scale      */
    /***************************************/
    
    public void calun(int degree, float amp, float duration)
    {   
        0.75 *=> amp;
        0.25 => att1.gain;
        
        // Tuning based on Gamelan Galak Tika's pelog -- 0 triggers attack only
        [0.0, 212.306, 226.191, 285.669, 307.661, 331.623, 414.006, 449.881] @=> float tuning[];
        (degree % tuning.cap()) => degree;               // 'wrap around' note if it is out of range
        tuning[degree] => float fund;  
        
        // FOR ATTACK
        600.0 => lpf.freq;
        aenv.set(1::ms, 1::ms, 1., 12::ms);
        
        makeNote(fund, amp, duration) => now;
    }
    
    /***************************************/
    /* Jublag: instrument to generate       */
    /* tones according to pelog scale      */
    /***************************************/
    
    public void jublag(int degree, float amp, float duration)
    {   
        0.75 *=> amp;
        0.2 => att1.gain;
        
        // Tuning based on Gamelan Galak Tika's pelog -- 0 triggers attack only
        [0.0, 283.303, 303.089, 326.876, 417.606, 452.323] @=> float tuning[];
        (degree % tuning.cap()) => degree;               // 'wrap around' note if it is out of range
        tuning[degree] => float fund;  
        
        // FOR ATTACK
        50.0 => lpf.freq;
        aenv.set(1::ms, 1::ms, 0.25, 12::ms);
        
        makeNote(fund, amp, duration) => now;
    }
    
    /***************************************/
    /* Jegogan: instrument to generate       */
    /* tones according to pelog scale      */
    /***************************************/
    
    public void jegogan(int degree, float amp, float duration)
    {   
        0.5 *=> amp;
        0.2 => att1.gain;
        
        // Tuning based on Gamelan Galak Tika's pelog -- 0 triggers attack only
        [0.0, 138.929, 148.797, 162.084, 206.502, 222.46] @=> float tuning[];
        (degree % tuning.cap()) => degree;               // 'wrap around' note if it is out of range
        tuning[degree] => float fund;  
        
        // FOR ATTACK
        50.0 => lpf.freq;
        aenv.set(1::ms, 1::ms, 0.05, 12::ms);
        
        makeNote(fund, amp, duration) => now;
    }

    public void gong(float amp, float duration)
    {
        // TIME VARIABLES:
        Math.pow(amp, 1+amp) => float ampScl;
        // If the bar is struck and allowed to ring, it lasts 24 seconds
        24*ampScl => float fullDecay;
        duration::second => dur noteT;
        fullDecay::second => dur T;

        57.33 => float fund => h1.freq;
        1 => h1.gain;
        env1.set(0.0001*T, 0.0001*T, amp, 0.9998*T);

        amp => env0.gain;
        
        // TRIGGER THE NOTES
        // key on events
        env1.keyOn();

        1::ms => now;

        // key off starts release
        env1.keyOff();

        noteT - 1::ms => now;
    }

    public void kenpur(float amp, float duration)
    {
        // TIME VARIABLES:
        Math.pow(amp, 1+amp) => float ampScl;
        // If the bar is struck and allowed to ring, it lasts 24 seconds
        24*ampScl => float fullDecay;
        duration::second => dur noteT;
        fullDecay::second => dur T;
        76.36 => float fund => h1.freq;
        1 => h1.gain;
        env1.set(0.0001*T, 0.0001*T, amp, 0.9998*T);

        amp => env0.gain;
        
        // TRIGGER THE NOTES
        // key on events
        env1.keyOn();

        1::ms => now;

        // key off starts release
        env1.keyOff();

        noteT - 1::ms => now;
    }

    public void klentong(float amp, float duration)
    {
        // FOR ATTACK
        6000.0 => lpf.freq;
        aenv.set(0::ms, 0::ms, 1., 6::ms);

        // TIME VARIABLES:
        Math.pow(amp, 1+amp) => float ampScl;
        // If the bar is struck and allowed to ring, it lasts 24 seconds
        16*ampScl => float fullDecay;
        duration::second => dur noteT;
        fullDecay::second => dur T;

        410.8 => float fund => h1.freq;
        1 => h1.gain;
        env1.set(0.0001*T, 0.0001*T, amp, 0.9998*T);

        amp => env0.gain;
        
        // TRIGGER THE NOTES
        // key on events
        env1.keyOn();

        1::ms => now;

        // key off starts release
        env1.keyOff();

        noteT - 1::ms => now;
    }
    
    /************************************/
    /* Function to actually generate    */
    /* the notes!                       */
    /************************************/
    
    
    private dur makeNote ( float fund, float amp, float duration)
    {    
        // TIME VARIABLES:
		Math.pow(amp, 1+amp) => float ampScl;
        // If the bar is struck and allowed to ring, it lasts 24 seconds
        24*ampScl => float fullDecay;
        duration => float noteDur;
        noteDur::second => dur noteT;
        fullDecay::second => dur T;
        
        /**************************************************************/
        
        
        // DEFINE THE HARMONICS AND ENVELOPES
        // fundamental osc and env (h1, env1)
        fund => h1.freq;
        1 => h1.gain;
        env1.set((.0001*T), (.0001*T), amp, (.9998*T));
        
        amp => env0.gain; 
        /**************************************************************/
        
        // TRIGGER THE NOTES
        // key on events
        env1.keyOn();
        // advance to release
        1::ms => now;
        // key off starts release
        env1.keyOff();
        // do it!
        return noteT - 1::ms;
    }
}

new Gamelan @=> Gamelan.instance;
