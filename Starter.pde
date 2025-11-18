import fisica.*;
import ddf.minim.*;
import java.util.ArrayList;


//This class corresponds to the box/spring pair used to launch the ball into the pinball
class Starter {

  FBox s; //Block used to eject the ball
  FDistanceJoint spring; //Spring to arm to eject the ball

  boolean notInUse=true;
  
   //as the project is for educational purposes I allow myself to test different approaches. Instead of reading an audio file directly from the data folder, I use the minim audio sampler this time to load and trigger samples.
  private Minim  minim;
  private ArrayList<AudioSample> chargeSound;
  private ArrayList<AudioSample> releaseSound;



  Starter(PApplet p) {//In order to use minim it's necessary to pass a PApplet (this) from the main class as argument

    minim = new Minim(p);
    //Loading different sounds as samples in an arraylist in order to play them randomly during activation or release of the spring.
    chargeSound = new ArrayList<AudioSample>();
    releaseSound = new ArrayList<AudioSample>();
    for (int i=1; i<=3; i++) {
      chargeSound.add(minim.loadSample("Plunger"+i+".wav"));
      releaseSound.add(minim.loadSample("BallRelease"+i+".wav"));
    }


    //creation and initialization of starter block
    s = new FBox(35, 60);
    s.setRotatable(false);
    s.setPosition(628, 806);
    s.setGrabbable(true);
    s.setBullet(true);
    s.setRestitution(0);
    s.setFill(114, 147, 168);
    world.add(s);

    //creation and initialization of spring between block and bottom of window
    spring = new FDistanceJoint(world.bottom, s);
    spring.setAnchor1(304, 0);
    spring.setLength(200);
    spring.setDamping(0.5);
    spring.setFrequency(5);
    spring.setFill(0);
    spring.setStroke(80, 120, 150);
    spring.setStrokeWeight(20);

    spring.setDrawable(true);
    world.add(spring);
  }


  void charge() {

    //the notInUse boolean allows playing sound only once when charging the spring.
    if (notInUse) {

      chargeSound.get(int(random(0, 3))).trigger(); //playback of random sample from sample list
    }

    //applying downward force to compress spring
    s.addForce(0, 800000);
    notInUse=false;
  }

  void release() {
    notInUse=true; //boolean reinitialization

    releaseSound.get(int(random(0, 3))).trigger();//playback of random sample from sample list
  }
}
