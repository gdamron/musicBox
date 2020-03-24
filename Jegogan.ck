public class Jegogan extends GamelanInstrument {
    ADSRKey key1;
    key1.init(1.0, 0.5, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    Attack a1;
    a1.init(3000, 1000, 0.4, 0.5, 0.5, 0.05, 1.0);
    [a1] @=> Attack attacks [];

    [0.0,
     138.929,
     148.797,
     162.084,
     206.502,
     222.46] @=> float scale [];

    tune(attacks, harmonics, scale);
}
