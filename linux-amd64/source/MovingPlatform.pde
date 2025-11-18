import fisica.*;



//This is the moving platform at the top of the pinball. This platform will be in the form of a small ship that moves back and forth horizontally. In case of contact with the ball, the ship explodes and disappears. The player then gets points added to their score.
class MovingPlatform {

  FBox mp; //fisica rectangle object
  
  boolean forward = true; //boolean used to calculate forward or backward movement
  boolean alive = true; //boolean used to know if object has been hit or not
  boolean blast = false; //boolean used for explosion animation
  
  float newX; //coordinate for movement
  
  PImage ship, explosion;
  
  int timer = 100; //timer to manage explosion animation
  int score = 2000; //points that the object gives when hit in the pinball
  
   //as the project is for educational purposes I allow myself to test different approaches. Instead of reading an audio file directly from the data folder, I use the minim audio sampler this time to load and trigger samples.
  private Minim minim;
  private AudioSample explode;

  MovingPlatform(PApplet p) { //In order to use minim it's necessary to pass a PApplet (this) from the main class as argument
    
    minim = new Minim(p);
    explode = minim.loadSample("explosion.wav"); //loading explosion sample
    
    //loading images
    ship = loadImage("ship.png");
    ship.resize(128, 61);
    explosion = loadImage("explosion.png");
    explosion.resize(200,200);
    
    //creation and configuration of fisica object
    mp = new FBox(64, 5);
    mp.setStatic(true);
    mp.setGrabbable(false);
    mp.setBullet(true);
    mp.setSensor(true);//sensor is a parameter that determines if the object will have collisions or not. In this case collisions are not necessary
    world.add(mp);

  
  }

  //initialization function
  void init() {
    
    alive=true; //object is alive
    mp.setPosition(300, 50);
    mp.setDrawable(true);//object is displayed
    mp.attachImage(ship);//attach ship image


  }
  
  //function that manages collision
  int collision(FCircle ball){
    
    int res = 0;
    
    if(ball.isTouchingBody(mp) && alive){ //If ball touches platform, and it is still alive
      
      mp.attachImage(explosion); //change image to explosion
      explode.trigger(); //play sample
      blast=true; //start explosion animation initialized by blast boolean
      alive=false; 
      res = score; //score will be returned by function.
    }
    
    if(blast==true){//while blast is true, timer decrementation
      
      timer-=1;
      
      
    }
    
    if(timer<0){//when timer reaches zero it's end of animation. Object is no longer displayed, timer reinitialized as well as blast boolean.
      
      mp.setDrawable(false);
      timer=100;
      blast=false;

    
    }
    
    return res; //return zero or score when ball touches platform
    
    
    
    
    
    
  }
  
  



  void move() { //function that manages horizontal movement



    if (forward) {
      newX = mp.getX() + 1;
    } else {
      newX = mp.getX() - 1;
    }

    if (mp.getX()>=400) {
      forward=false;
    }

    if (mp.getX()<=200) {
      forward=true;
    }


    mp.setPosition(newX, 50);
  }
}
