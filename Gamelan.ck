/*
* Gamelan Class
*
* Author: Grant Damron
*
* Includes jegogan, jublag, calung, ugal, pemade, and and kantil. All
* instruments are based on Gamelan Galak Tika's pelog tuning.
*
* Measurements by Christine Southworth.
*/

public class Gamelan
{
    Kantil kntl;
    Pemade pmde;
    Ugal ugl;
    Calun cln;
    Jublag jblg;
    Jegogan jgn;
    Gongs gongs;

    Gain gain;

    public void connect( UGen u ) {
        0.0 => gain.gain;
        gain => u;
    }

    public dur kantil(int degree, float amp, float duration)
    {
        return kntl.strike(degree, amp, duration);
    }

    public dur pemade(int degree, float amp, float duration)
    {
        return pmde.strike(degree, amp, duration);
    }

    public dur ugal(int degree, float amp, float duration)
    {
        return ugl.strike(degree, amp, duration);
    }

    public dur calun(int degree, float amp, float duration)
    {
        return cln.strike(degree, amp, duration);
    }

    public dur jublag(int degree, float amp, float duration)
    {
        return jblg.strike(degree, amp, duration);
    }

    public dur jegogan(int degree, float amp, float duration)
    {
        return jgn.strike(degree, amp, duration);
    }

    public dur gong(float amp, float duration)
    {
       return  gongs.gong(amp, duration);
    }

    public dur kenpur(float amp, float duration)
    {
        return gongs.kenpur(amp, duration);
    }

    public dur klentong(float amp, float duration)
    {
        return gongs.klentong(amp, duration);
    }
}
