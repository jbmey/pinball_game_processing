import fisica.*;


//The frame corresponds to the structural elements of the pinball, the "walls" and other parts of the box.

class Frame {

  //different fisica polygonal objects for structure
  FPoly baseL;
  FPoly baseR;
  FPoly middleL;
  FPoly middleR;
  FPoly topL;
  FPoly topR;
  FPoly top;
  FPoly launcher;
  
  //object that serves as a flap to close the ball launch area once it has exited.
  FPoly flap;
  
  //joints for flap operation (rotation axis and spring)
  FRevoluteJoint flapAxis;
  FDistanceJoint flapSpring;

  Frame() {

    baseL = new FPoly(); //creation of fisica object
    float[][] baseLVertex = {{0, 900}, {100, 1000}, {0, 1000}}; //creation of array containing vertex coordinates
    createElement(baseL, baseLVertex); //call function to generate object


    baseR = new FPoly();
    float[][] baseRVertex = {{600, 900}, {500, 1000}, {600, 1000}};
    createElement(baseR, baseRVertex);


    middleL = new FPoly();
    float[][] middleLVertex = {{40, 838}, {145, 880}, {160, 854}, {70, 810}, {70, 700}, {40, 650}};
    createElement(middleL, middleLVertex);



    middleR = new FPoly();
    float[][] middleRVertex = {{555, 838}, {454, 880}, {440, 852}, {530, 810}, {530, 700}, {555, 650}};
    createElement(middleR, middleRVertex);



    topL = new FPoly();
    float[][] topLVertex = {{0, 250}, {50, 450}, {0, 600}};
    createElement(topL, topLVertex);


    topR = new FPoly();
    float[][] topRVertex = {{600, 250}, {550, 450}, {600, 600}};
    createElement(topR, topRVertex);


    top = new FPoly();
    float[][] topVertex = {{0, 0}, {0, 200}, {30, 75}, {100, 20}, {325, 0}, {500, 20}, {570, 75}, {615, 115}, {645, 200}, {645, 1000}, {645, 0}};
    createElement(top, topVertex);


    launcher = new FPoly();
    float[][] launcherVertex = {{600, 1000}, {610, 1000}, {610, 250}, {600, 250}};
    createElement(launcher, launcherVertex);
    launcher.setRestitution(0); //For structure that separates ball launch area, restitution is zero to avoid micro bounces that can cause bugs.

    flap = new FPoly();
    float[][] flapVertex = {{600, 250}, {610, 250}, {635, 172}, {630, 158}};
    createElement(flap, flapVertex);
    flap.setStatic(false); // unlike the rest of the structure the flap must not be static.
    flap.setDensity(1000); // I deliberately set enormous density so the flap is very stable and doesn't move despite ball impacts. This prevents fisica collision bugs
    flap.setBullet(true);
    flap.setGrabbable(false);
 


    //creation of axis between launcher part and flap
    flapAxis = new FRevoluteJoint(launcher, flap);
    flapAxis.setAnchor(605, 250); //anchor point definition
    flapAxis.setCollideConnected(true);
    flapAxis.setEnableLimit(true); //activation of movement limits
    flapAxis.setEnableMotor(false);
    flapAxis.setMaxMotorTorque(9000000); //motor must have enormous force because flap has very high density.
    flapAxis.setMotorSpeed(-PI/2); //motor speed
    flapAxis.setLowerAngle(0); //lower limit angle definition
    flapAxis.setLowerAngle(-PI/4); //upper limit angle definition
    flapAxis.setNoFill();
    flapAxis.setNoStroke();
    world.add(flapAxis);


    //creation of spring between flap and right side of window. This is useful for closing the flap.
    flapSpring = new FDistanceJoint(world.right, flap);
    flapSpring.setDamping(0.1);
    flapSpring.setFrequency(5);
    flapSpring.setNoFill();
    flapSpring.setNoStroke();
    world.add(flapSpring);
  }



  //function to configure different frame elements based on vertex array passed as argument
  void createElement(FPoly fp, float[][] tab) {

    fp.setFill(102, 102, 102, 99);
    fp.setStroke(0);
    fp.setStrokeWeight(1);

    for (int i=0; i<tab.length; i++) {
      fp.vertex(tab[i][0], tab[i][1]);
    }

    fp.setStatic(true);
    fp.setGrabbable(false);
    fp.setRestitution(1); //normal bounces
    world.add(fp);
  }



  //function to open the flap
  void openFlap() {

    
    flapAxis.setEnableMotor(true); //Flap motor activation
    flap.addImpulse(-1, 0); //small impulse to help open the flap.
  }


  //function to close the flap
  void closeFlap() {

    flapAxis.setEnableMotor(false); //Flap motor deactivation. The spring brings it back to starting position.
    flap.addImpulse(1, 0); //small impulse to help close the flap.
  }
}
