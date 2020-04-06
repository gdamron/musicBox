public class Pemade extends GamelanInstrument {
    ADSRKey key1;
    key1.init(0.95, 1.0, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    Attack a1;
    a1.init(12000, 8000, 0.3, 0, 0, 1., 3.0);
    [a1] @=> Attack attacks [];

    [0.0,
    303.426,
    326.514,
    417.838,
    451.631,
    571.338,
    612.26,
    660.31,
    829.214,
    893.795,
    1149.029] @=> float scale[];

    tune(attacks, harmonics, scale);
}
