import fisica.*;
import ddf.minim.*;

//class that corresponds to obstacles in the middle of the pinball
class Planet {

  FCircle o1, o2, o3, o4, anchor;
  FRevoluteJoint r1, r2, r3, r4;
  PImage img1, img2, img3, img4, img5;

  
  
  
  Planet() {
    
   
    //loading images
    img1 = loadImage("planete1.png");
    img1.resize(100, 100);
    img2 = loadImage("planete2.png");
    img2.resize(60, 60);
    img3 = loadImage("planete3.png");
    img3.resize(80, 80);
    img4 = loadImage("planete4.png");
    img4.resize(70, 70);

    //creating circles with fisica
    o1 = new FCircle(50);
    o2 = new FCircle(50);
    o3 = new FCircle(50);
    o4 = new FCircle(50);

    //call configuration function
    configObstacle(o1, 180, 380);
    configObstacle(o2, 420, 380);
    configObstacle(o3, 420, 620);
    configObstacle(o4, 180, 620);
    
    //attaching images to obstacles
    o1.attachImage(img1);
    o2.attachImage(img2);
    o3.attachImage(img3);
    o4.attachImage(img4);
    
    
    
   
    //creating an anchor point at the center of obstacles to perform rotation
    anchor= new FCircle(0);
    anchor.setStatic(true);
    anchor.setPosition(300,500);
    anchor.setDrawable(false);
    world.add(anchor);
    
    
    //creating revolute joints between anchor and obstacles to create rotation around center
    r1 = new FRevoluteJoint(anchor, o1);
    r1.setAnchor(300,500);
    r1.setCollideConnected(false);
    r1.setEnableLimit(false);
    r1.setEnableMotor(true);
    r1.setMotorSpeed(PI/100);
    r1.setMaxMotorTorque(90000);
    r1.setNoFill();
    r1.setNoStroke();
    world.add(r1);
    
    
    
    r2 = new FRevoluteJoint(anchor, o2);
    r2.setAnchor(300,500);
    r2.setCollideConnected(false);
    r2.setEnableLimit(false);
    r2.setEnableMotor(true);
    r2.setMotorSpeed(PI/100);
    r2.setMaxMotorTorque(90000);
    r2.setNoFill();
    r2.setNoStroke();
    world.add(r2);
    
    
    r3 = new FRevoluteJoint(anchor, o3);
    r3.setAnchor(300,500);
    r3.setCollideConnected(false);
    r3.setEnableLimit(false);
    r3.setEnableMotor(true);
    r3.setMotorSpeed(PI/100);
    r3.setMaxMotorTorque(90000);
    r3.setNoFill();
    r3.setNoStroke();
    world.add(r3);
    
    
    r4 = new FRevoluteJoint(anchor, o4);
    r4.setAnchor(300,500);
    r4.setCollideConnected(false);
    r4.setEnableLimit(false);
    r4.setEnableMotor(true);
    r4.setMotorSpeed(PI/100);
    r4.setMaxMotorTorque(90000);
    r4.setNoFill();
    r4.setNoStroke();
    world.add(r4);
    
  }


  //function to configure obstacles
  void configObstacle(FCircle fp, int x, int y) {

    fp.setPosition(x, y);
    fp.setStatic(false);
    fp.setGrabbable(false);
    fp.setRestitution(1.5); //high bounce
    world.add(fp);
  }
}
