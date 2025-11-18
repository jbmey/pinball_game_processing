import fisica.*;
import ddf.minim.*;


//I'm not certain the term is correct but in my project bumpers are the triangular objects above the flippers with a zone that gives an impulse to the ball on contact.
class Bumper {

  FPoly bumperL, bumperR; //bumper objects
  FLine springL, springR; //bumper contact zone that will give an impulse to the ball
  
  
  //as the project is for educational purposes I allow myself to test different approaches. Instead of loading samples, I use the minim audio player this time to read sounds directly from the data folder.
  private Minim  minim;
  private AudioPlayer hit;

  Bumper(int side, PApplet p) {//Integer i is used in constructor to select which side is built. PApplet p is necessary for minim.

    minim = new Minim(p);

    switch(side) {//if side=1 ->  left bumper creation. if side=2 -> right bumper creation.
    case 1:
      //fisica polygon creation
      bumperL = new FPoly();
      bumperL.setFill(255,140,0);
      bumperL.setStroke(0);
      bumperL.setStrokeWeight(2);
      bumperL.vertex(110, 700);
      bumperL.vertex(110, 788);
      bumperL.vertex(160, 810);
      bumperL.setStatic(true);
      bumperL.setGrabbable(false);
      world.add(bumperL);

      //creation of line that will serve as bounce zone
      springL = new FLine(110, 700, 160, 810);
      springL.setStrokeWeight(5);
      springL.setStatic(true);
      world.add(springL);

      break;

    case 2:

      //fisica polygon creation
      bumperR = new FPoly();
      bumperR.setFill(255,140,0);
      bumperR.setStroke(0);
      bumperR.setStrokeWeight(2);
      bumperR.vertex(490, 700);
      bumperR.vertex(490, 788);
      bumperR.vertex(440, 810);
      bumperR.setStatic(true);
      bumperR.setGrabbable(false);
      world.add(bumperR);


      //creation of line that will serve as bounce zone
      springR = new FLine(440, 810, 490, 700);
      springR.setStrokeWeight(5);
      springR.setStatic(true);
      world.add(springR);

      break;
    }
  }


  
  //function that manages what happens in case of collision.
  void collision(FCircle ball) {

    if (ball.isTouchingBody(springL)) { //if the ball touches the left bumper spring
      ball.addImpulse(300, -500);//impulse on ball
      hit = minim.loadFile("Bumper"+int(random(1, 5))+".wav");//loading and playback of random file "bumperx.wav" from data folder
      hit.play();
    }

    if (ball.isTouchingBody(springR)) {//if the ball touches the right bumper spring
      ball.addImpulse(-300, -500);//impulse on ball
      hit = minim.loadFile("Bumper"+int(random(1, 5))+".wav");//loading and playback of random file "bumperx.wav" from data folder
      hit.play();
    }
  }
}
