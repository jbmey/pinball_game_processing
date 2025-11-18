import fisica.*;
import ddf.minim.*;


//Targets are the 3 big circles at the top of the pinball that give points when the ball touches them.
//Upon contact with the ball, targets change color, trigger a sound, and return a score.


class Target {

  FCircle target; //fisica circle object corresponding to the target

  int value, x, y; //points that the target gives, x coordinate, y coordinate

  int[] baseColor={0, 0, 0}; //array that contains RGB data


  //as the project is for educational purposes I allow myself to test different approaches. Instead of loading samples, I use the minim audio player this time to read sounds directly from the data folder.
  private Minim  minim;
  private AudioPlayer hit;



  Target(int i, PApplet p) {//Integer i is used in constructor to select which of the 3 targets is built. PApplet p is necessary for minim.

    switch(i) { // The switch allows selecting position, value and color of the target instance being built.

    case 1:

      baseColor[0]=255;
      x=150;
      y=250;
      value=100;

      break;

    case 2:
      baseColor[1]=255;
      x=300;
      y=150;
      value=1000;

      break;

    case 3:
      baseColor[2]=255;
      x=450;
      y=250;
      value=100;

      break;
    }



    target = new FCircle(110);
    target.setRestitution(1.2);//targets must bounce a lot.
    target.setStatic(true); //targets are fixed
    target.setGrabbable(false);
    target.setStroke(0);
    target.setStrokeWeight(2);
    target.setPosition(x, y);

    world.add(target);


    minim = new Minim(p);
  }


  //function that manages what happens in case of collision with the ball
  int collision(FCircle ball) {

    int res = 0;


    //in case of collision, loading of random file "dingx.wav" from data folder and playback, call color change function, target value is returned
    if (ball.isTouchingBody(target)) {

      hit = minim.loadFile("Ding"+int(random(1, 6))+".wav");
      hit.play();

      changeColor();
      res=value;
    }

    return res;
  }

  //target color initialization function.
  void init() {

    target.setFill(baseColor[0], baseColor[1], baseColor[2], 80);
  }


  //random color change function
  void changeColor() {

    int R = (int)(Math.random() * 255+1);
    int G = (int)(Math.random() * 255+1);
    int B = (int)(Math.random() * 255+1);
    target.setFill(R, G, B, 80);
  }


  //accessor
  FCircle getFCircle() {

    return target;
  }
}