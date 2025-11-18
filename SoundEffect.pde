import ddf.minim.*;
import ddf.minim.ugens.*;

//class for ball bounce sounds
class SoundEffect implements Instrument
{
 
  Oscil sineOsc;
  ADSR  adsr1;
  ADSR  adsr2;
  Noise myNoise;

  
  SoundEffect( float frequency, float amplitude, Noise.Tint noiseTint)
  {
    //creation of an oscillator and noise
    sineOsc = new Oscil( frequency, amplitude, Waves.TRIANGLE );
    myNoise = new Noise(amplitude, noiseTint);
    
    //creation of two envelopes
    adsr1 = new ADSR( 1, 0.010, 0.010, 0.010, 0.5 );
    adsr2 = new ADSR( 0.5, 0.007, 0.010, 0.010, 0.1 );

  
    //patch oscillator into envelope 1 and noise into envelope 2
    sineOsc.patch( adsr1 );
    myNoise.patch( adsr2 );
  }

  //all instruments must have a noteOn function
  void noteOn( float dur )
  {
 
    adsr1.noteOn();
    adsr2.noteOn();
    
    // patch to output
    adsr1.patch( out );
    adsr2.patch( out );
  }

  //all instruments must have a noteOff function
  void noteOff()
  {
    // unpatch after sound ends
    adsr1.unpatchAfterRelease( out );
    adsr2.unpatchAfterRelease( out );
    
    // call noteOff
    adsr1.noteOff();
    adsr2.noteOff();
  }
}
