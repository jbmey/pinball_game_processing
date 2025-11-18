import fisica.*;
import ddf.minim.*;


//class that corresponds to pinball balls. The pinball has a standard ball and possibly a bonus ball.
class Ball {

  FCircle b; //fisica circle object

  //as the project is for educational purposes I allow myself to test different approaches. Instead of loading samples or reading a sound, I use audio synthesis this time to generate the ball sound (see SoundEffect class)
  private Minim minim;
  AudioOutput out;


  boolean inWorld; //ball in play or not
  boolean contact; //contact or not
  boolean alreadyInContact = true;//was the ball already in contact or not. This boolean prevents triggering the SoundEffect continuously if the ball is placed or rolling on an object for example.

  PImage img;

  Ball(PApplet p, String type) { //PApplet argument is necessary for minim. The type argument allows selecting if the construction is for the main ball or bonus ball

    minim = new Minim(p);
    out = minim.getLineOut( Minim.MONO);

    b = new FCircle(30);
    b.setGrabbable(false);
    b.setBullet(true); //the bullet option is necessary for fast objects or those heavily used by the simulation to have better rendering but more resource intensive.
    b.setFill(114, 147, 168);
    restart();

    switch(type) {
    case "standard":


      //loading and attaching image for standard ball.
      img = loadImage("ball.png");
      img.resize(30, 30);
      b.attachImage(img);
      world.add(b);

      break;

    case "bonus":

      //loading and attaching image for bonus ball.
      img = loadImage("ballBonus.png");
      img.resize(30, 30);
      b.attachImage(img);

      break;
    }
  }


  //function that removes the ball from the simulation and stops display
  void remove() {

    b.removeFromWorld();
    b.setDrawable(false);
    inWorld=false;
  }


  //function that adds the ball to the simulation and activates display
  void create() {
    world.add(b);
    b.setDrawable(true);
    inWorld=true;
  }


  //function that returns whether the ball is present in game (in the simulation) or not
  boolean exist() {

    return inWorld;
  }


  //function to reinitialize the ball position in the launch area
  void restart() {

    b.setPosition(627, 750);
  }




  //function that manages what happens in case of collision
  void collision() {
    
    //this line of code checks if the list of objects in contact with the ball contains at least one element and assigns the boolean value to contact
    //in other words, if there is at least one object in the list of objects in contact with the ball, the contact boolean is true. If the list is empty the contact boolean is false.
    contact = !b.getTouching().isEmpty();

    if (contact==true && alreadyInContact==false) { //If there is contact with the ball, and it was not yet in contact with an object, we play the sound effect. The condition with the alreadyInContact boolean prevents playing the SoundEffect continuously if the ball is rolling on an object or placed on it.

      out.resumeNotes();
      out.playNote( 0, 0.05, new SoundEffect( 200, 0.2, Noise.Tint.PINK ) );
      alreadyInContact=true; //the alreadyInContact boolean becomes true because the ball is in contact with an object
    }

    if (contact==false) { // if there is no more contact between the ball and an object
      out.pauseNotes(); //stop the sound effect
      alreadyInContact=false;//the alreadyInContact boolean becomes false because the ball is now free.
    }
  }



  // accessors
  FCircle getFCircle() {

    return b;
  }
}
