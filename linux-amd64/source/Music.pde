
//class used to play different musical themes and sound effects
class Music {


  Music() {
  }


  //I wrote the pieces manually note by note. For rhythm, I simply recorded the rhythm by tapping my finger on my desk and analyzed the different note timings via audio software like audacity.
  //There are probably better optimized and simpler ways to make music in processing, but for educational purposes I tried to start from the basics.

  void playTheme1() {

    //lead
    out.playNote( 0, midiToFreq(64) );
    out.playNote( 0.1, midiToFreq(63) );
    out.playNote( 0.2, midiToFreq(62) );
    out.playNote( 0.3, midiToFreq(61) );
    out.playNote( 0.4, midiToFreq(60) );
    out.playNote( 0.5, midiToFreq(59) );
    out.playNote( 0.6, midiToFreq(58) );


    //bass
    out.playNote( 0, midiToFreq(46) );
    out.playNote( 0.1, midiToFreq(47) );
    out.playNote( 0.2, midiToFreq(48) );
    out.playNote( 0.3, midiToFreq(49) );
    out.playNote( 0.4, midiToFreq(50) );
    out.playNote( 0.5, midiToFreq(51) );
    out.playNote( 0.6, midiToFreq(52) );
  }

  void playTheme2() {

    //lead
    out.playNote( 0, midiToFreq(60) );
    out.playNote( 0.525, midiToFreq(60) );
    out.playNote( 0.879, midiToFreq(60) );
    out.playNote( 1.036, midiToFreq(60) );
    out.playNote( 1.554, midiToFreq(63) );
    out.playNote( 1.933, midiToFreq(62) );
    out.playNote( 2.1, midiToFreq(62) );
    out.playNote( 2.448, midiToFreq(60) );
    out.playNote( 2.627, midiToFreq(60) );
    out.playNote( 2.952, midiToFreq(59) );
    out.playNote( 3.131, midiToFreq(60) );

    //bass
    out.playNote( 0, midiToFreq(48) );
    out.playNote( 0.525, midiToFreq(48) );
    out.playNote( 0.879, midiToFreq(48) );
    out.playNote( 1.036, midiToFreq(44) );
    out.playNote( 1.554, midiToFreq(44) );
    out.playNote( 1.933, midiToFreq(44) );
    out.playNote( 2.1, midiToFreq(41) );
    out.playNote( 2.448, midiToFreq(43) );
    out.playNote( 2.627, midiToFreq(48) );
    out.playNote( 2.952, midiToFreq(50) );
    out.playNote( 3.131, midiToFreq(48) );
  }


  void playTheme3() {

    //high

    out.playNote( 0, midiToFreq(72) );
    out.playNote( 0.255, midiToFreq(72) );
    out.playNote( 0.506, midiToFreq(76) );
    out.playNote( 0.664, midiToFreq(72) );
    out.playNote( 0.893, midiToFreq(76) );
    out.playNote( 1.162, midiToFreq(72) );
    out.playNote( 1.398, midiToFreq(76) );
    out.playNote( 1.542, midiToFreq(72) );
    out.playNote( 1.803, midiToFreq(70) );
    out.playNote( 2.071, midiToFreq(72) );


    //lead

    out.playNote( 0, midiToFreq(60) );
    out.playNote( 0.255, midiToFreq(60) );
    out.playNote( 0.506, midiToFreq(58) );
    out.playNote( 0.664, midiToFreq(60) );
    out.playNote( 0.893, midiToFreq(64) );
    out.playNote( 1.162, midiToFreq(60) );
    out.playNote( 1.398, midiToFreq(58) );
    out.playNote( 1.542, midiToFreq(60) );
    out.playNote( 1.803, midiToFreq(64) );
    out.playNote( 2.071, midiToFreq(60) );


    //bass

    out.playNote( 0, midiToFreq(48) );
    out.playNote( 0.255, midiToFreq(48) );
    out.playNote( 0.506, midiToFreq(46) );
    out.playNote( 0.664, midiToFreq(48) );
    out.playNote( 0.893, midiToFreq(46) );
    out.playNote( 1.162, midiToFreq(48) );
    out.playNote( 1.398, midiToFreq(46) );
    out.playNote( 1.542, midiToFreq(48) );
    out.playNote( 1.803, midiToFreq(46) );
    out.playNote( 2.071, midiToFreq(52) );
  }

  void playTheme4() {

    //lead
    out.playNote( 0, midiToFreq(64) );
    out.playNote( 0.2, midiToFreq(62) );
    out.playNote( 0.4, midiToFreq(68) );




    //bass
    out.playNote( 0, midiToFreq(46) );
    out.playNote( 0.2, midiToFreq(48) );
    out.playNote( 0.4, midiToFreq(52) );
  }

  void playTheme5() {

    //lead
    out.playNote( 0, midiToFreq(64) );
    out.playNote( 0.2, midiToFreq(61) );
    out.playNote( 0.4, midiToFreq(64) );
    out.playNote(0.6, midiToFreq(61) );
    out.playNote( 0.8, midiToFreq(64) );
    out.playNote( 1, midiToFreq(61) );
    out.playNote( 1.2, midiToFreq(64) );
    out.playNote( 1.4, midiToFreq(63) );
    out.playNote( 1.6, midiToFreq(64) );
    out.playNote( 1.8, midiToFreq(61) );
    out.playNote( 2, midiToFreq(64) );
    out.playNote(2.2, midiToFreq(61) );
    out.playNote( 2.4, midiToFreq(64) );
    out.playNote( 2.6, midiToFreq(61) );
    out.playNote( 2.8, midiToFreq(64) );
    out.playNote( 3, midiToFreq(63) );
    out.playNote( 3.2, midiToFreq(64) );


    //bass
    out.playNote( 0, midiToFreq(48) );
    out.playNote( 0.2, midiToFreq(48) );
    out.playNote( 0.4, midiToFreq(48) );
    out.playNote(0.6, midiToFreq(48) );
    out.playNote( 0.8, midiToFreq(48) );
    out.playNote( 1, midiToFreq(48) );
    out.playNote( 1.2, midiToFreq(48) );
    out.playNote( 1.4, midiToFreq(49) );
    out.playNote( 1.6, midiToFreq(48) );
    out.playNote( 1.8, midiToFreq(48) );
    out.playNote( 2, midiToFreq(48) );
    out.playNote(2.2, midiToFreq(48) );
    out.playNote( 2.4, midiToFreq(48) );
    out.playNote( 2.6, midiToFreq(48) );
    out.playNote( 2.8, midiToFreq(48) );
    out.playNote( 3, midiToFreq(49) );
    out.playNote( 3.2, midiToFreq(48) );
  }



  //small midi to frequence translator.
  float midiToFreq(int note) {
    return (pow(2, ((note-69)/12.0))) * 440;
  }
}
