import ddf.minim.*;
import fisica.*;
import java.util.ArrayList;


//this class is one of the most complex. It's the class used to create the flippers, "the paddles" that the player controls to hit the ball

class Flipper {

  FCircle axis; //flipper rotation axis
  FBox flipper; //the fisica object that serves as flipper
  FRevoluteJoint rotor; //Joint between flipper and axis that will serve as motor


  boolean notInUse=true; //boolean that corresponds to flipper state: activated or not.
  
  int fx, fy, px, py, pAnchorx; //size in x and y, position in x and y, anchor point position in x

  PImage flip;

   //as the project is for educational purposes I allow myself to test different approaches. Instead of reading an audio file directly from the data folder, I use the minim audio sampler this time to load and trigger samples.
  private Minim minim;
  private ArrayList<AudioSample> shotSound;
  private ArrayList<AudioSample> releaseSound;


  //The constructor takes an integer as argument to select which side is built.
  Flipper(int side, PApplet p) {//In order to use minim it's necessary to pass a PApplet (this) from the main class as argument

    //size is defined
    fx=110;
    fy=30;


    //if argument 1 is passed to constructor, left flipper is created. If argument 2 is passed, right side is created.
    switch(side) {
    case 1:
      
      //left flipper position
      px=220;
      py=875;
      pAnchorx=px-fx/2;//left flipper axis anchor point
      flip = loadImage("flipperG.png"); //loading left flipper image
      flip.resize(fx+20, fy+10); //image size slightly larger than fisica object size
      break;

    case 2:

      //right flipper position
      px=380;
      py=875;
      pAnchorx=px+fx/2;//right flipper axis anchor point
      flip = loadImage("flipperD.png"); //loading right flipper image
      flip.resize(fx+20, fy+10); //image size slightly larger than fisica object size
      break;
    }


    //creation and configuration of fisica flipper object
    flipper = new FBox(fx, fy);
    flipper.setPosition(px, py);
    flipper.setGrabbable(false);
    flipper.setBullet(true);
    flipper.setFill(187, 105, 81);
    flipper.attachImage(flip); //image attachment
    world.add(flipper);


    //creation of rotation axis
    axis = new FCircle(30);
    axis.setPosition(pAnchorx, py); //position at anchor point
    axis.setStatic(true);
    axis.setGrabbable(false);
    axis.setRotatable(true);
    axis.setDrawable(false); //no axis display
    world.add(axis);


    //creation of joint between axis and flipper
    rotor = new FRevoluteJoint(axis, flipper);
    rotor.setNoFill();
    rotor.setNoStroke();
    rotor.setAnchor(pAnchorx, py); // anchor point corresponds to middle of axis.
    rotor.setCollideConnected(false); //no collision between connected elements.
    rotor.setEnableLimit(true); //activation of rotation limit.


    if (side==1) { //left flipper
      rotor.setLowerAngle(-PI/4); //lower movement limit
      rotor.setUpperAngle(PI/8); //upper movement limit
      rotor.setMotorSpeed(-5*PI); //motor speed
      rotor.setMaxMotorTorque(100000); //motor force. This must be very high to allow rapid flipper action.
    } else if (side==2) {//right flipper, identical principle with different values, symmetrical
      rotor.setLowerAngle(-PI/8);
      rotor.setUpperAngle(PI/4);
      rotor.setMotorSpeed(5*PI);
      rotor.setMaxMotorTorque(100000);
    }

    world.add(rotor);


    minim = new Minim(p);
    
    //loading different audio samples for flipper activation and release.
    shotSound = new ArrayList<AudioSample>();
    releaseSound = new ArrayList<AudioSample>();

    shotSound.add(minim.loadSample("FlipperUp1.wav"));
    shotSound.add(minim.loadSample("FlipperUp2.wav"));
    shotSound.add(minim.loadSample("FlipperUp3.wav"));
    shotSound.add(minim.loadSample("FlipperUp4.wav"));
    shotSound.add(minim.loadSample("FlipperUp5.wav"));
    shotSound.add(minim.loadSample("FlipperUp6.wav"));


    releaseSound.add(minim.loadSample("FlipperDown1.wav"));
    releaseSound.add(minim.loadSample("FlipperDown2.wav"));
    releaseSound.add(minim.loadSample("FlipperDown3.wav"));
  }


  //function used during flipper activation
  void shot() {


    if (notInUse) { //if flipper is not already activated
      shotSound.get(int(random(0, 6))).trigger(); //sample playback
    }



    rotor.setEnableMotor(true); //motor activation
    flipper.addForce(0, -1); //small additional impulse to help flipper start its movement.
    notInUse=false; //flipper is in use so boolean is changed.
  }

  void releaseShot() {

    rotor.setEnableMotor(false); //motor shutdown
    flipper.addForce(0, 1); //small impulse to help flipper go back down
    releaseSound.get(int(random(0, 3))).trigger(); //release sample playback
    notInUse=true; //boolean reinitialization because flipper is no longer in use
  }
}
