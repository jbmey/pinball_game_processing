
import ddf.minim.*;
import fisica.*;

//Main class of the Program that implements instances of other classes and different functions to make the pinball operational

PFont karma;


FWorld world; //the fisica world
Frame frame;
Music m;
PImage img, img2, img3, img4;

Target target1, target2, target3;
Planet p;
MovingPlatform ship;
Ball ball, bonusBall;
Flipper f1, f2;
Bumper b1, b2;
Starter catapult;
Player player;

boolean downPressed, leftPressed, rightPressed, newGame=true, endGame=false, flashActive, slamActive, tiltProtection=false;

int timer=180;
int slamTimer=30;
int tiltProtectionTimer= 250;
int slamCounter=3;
int newLifeScore;

String slamSide;

//The project is for educational purpose and I allow myself to test different approaches. Here the sound reading will be done with a minim audio player and also with a minim sampler.
private Minim minim;
private AudioSample slamSound;
private AudioPlayer audioPlayer;
private AudioOutput out;



void setup() {
  size(650, 1000); //pinball size. I unfortunately didn't code the pinball to be resizable. The size is fixed.

  karma = createFont("Karma Future.otf", 30); //loading the font


  //loading images. I made a Moebius-themed pinball
  img = loadImage("moebiusPinball.jpeg");
  img2 = loadImage("moebiusStart.jpg");
  img3= loadImage("moebiusEnd.jpg");
  img4= loadImage("pow.png");
  img4.resize(300, 300);


  minim = new Minim( this );
  out = minim.getLineOut();
  slamSound = minim.loadSample("tiltSound.wav");//loading the sample for the pinball slam


  //fisica initialization
  Fisica.init(this);
  //world creation and configuration
  world = new FWorld();
  world.setEdges();
  world.setEdgesRestitution(0);//no bouncing on window edges
  world.setGravity(0, 500);//gravity definition
  world.setGrabbable(true);//allows using the mouse to move objects that are defined for this. Useful for testing and debugging. Also for gameplay, if we want to load the launcher spring with the mouse.


  //creation of instances of the different necessary classes.
  player = new Player();

  m = new Music();

  frame = new Frame();

  f1 = new Flipper(1, this);
  f2 = new Flipper(2, this);

  b1 = new Bumper(1, this);
  b2 = new Bumper(2, this);

  target1= new Target(1, this);
  target2= new Target(2, this);
  target3= new Target(3, this);

  p = new Planet();
  catapult= new Starter(this);

  ship = new MovingPlatform(this);


  ball = new Ball(this, "standard");
  bonusBall= new Ball(this, "bonus");
}




void draw() {
  background(120);

  //conditional block that allows selecting whether to launch a new game, the game over screen or the game screen.
  if (newGame) {
    newGameScreen();
  } else if (endGame) {
    finalScreen();
  } else {
    image(img, 0, 0); //game screen image
    tint(255, 255);//no tint



    displayText();
    testFlap(); //manages the opening/closing of the flap
    testKey();
    testCollision();
    testScore();
    testEnd();
    testFlash();
    slamAnimation(slamSide);
    testTiltProtection();
    ship.move(); //animation of the ship instance movement
    world.step(); //advance the simulation
    world.draw(); //world display
  }
}





//function that initializes the game
void newGameScreen() {

  background(120);
  image(img2, 0, 0); //start game screen
  tint(255, 255); //no tint

  //initialization of targets, player, platform, balls
  target1.init();
  target2.init();
  target3.init();
  player.init();
  ship.init();
  ball.restart();
  bonusBall.restart();

  bonusBall.remove(); //remove the bonus ball from the game for now

  //text display
  textAlign(CENTER);
  textFont(karma);
  fill(255);
  text("To start the journey,", width/2, height-150);
  text("Insert a coin with the space bar", width/2, height-100);
}





//function that displays the game over screen
void finalScreen() {

  background(120);
  image(img3, 0, 0); //final image
  tint(255, 0, 0, 75);//transparent red tint

  //text display
  textAlign(CENTER);
  textFont(karma, 40);
  fill(255);
  text("Your Score: "+player.getScore(), width/2, height/3);
  text("Press r to restart", width/2, height/2);
}





//display of textual elements
void displayText() {

  textAlign(CENTER);
  fill(255);
  textFont(karma, 20);
  text("Score: " + str(player.getScore()), 311, 275);
  text("Lives remaining: " + str(player.getLives()), 175, 975);
  newLifeScore = player.getThreshold() - player.getScore();
  text("new life in: ", 450, 955);
  text( str(newLifeScore) + "points", 450, 985);


  //textSize(20);//debug: mouse coordinates display.
  //text("x: " + mouseX + " y: " + mouseY, 315, 500);
}





//function that manages the flap opening based on ball positions.
void testFlap() {

  if (ball.getFCircle().getX()>610 || (bonusBall.exist() && bonusBall.getFCircle().getX()>610)) {//if the ball is in the launch area OR the bonus ball exists AND is in the launch area, the flap opens
    frame.openFlap();
  } else {//otherwise the flap closes
    frame.closeFlap();
  }
}





//function that triggers events based on pressed keys. The booleans are used to determine the state of the DOWN, LEFT, RIGHT keys.
//the use of booleans is relevant to manage continuous key presses, not just punctual presses from the keyPressed() function.
//the function is used in the draw loop so using an if condition with a boolean is equivalent to a "while" the boolean is true
void testKey() {

  if (downPressed)
  {
    catapult.charge(); //while down key pressed, loading the launcher spring
  }

  if (leftPressed) { //while left key pressed, activate left flipper
    f1.shot();
  }

  if (rightPressed) {//while right key pressed, activate right flipper
    f2.shot();
  }
}





//function that calls the different collision functions of instantiated objects to define actions in case of collisions.
void testCollision() {


  //ball collision verification
  ball.collision();
  bonusBall.collision();

  //collision verification between balls and platform. Add points to score (0 if no collision, platform value if collision)
  player.addScore(ship.collision(ball.getFCircle()));
  player.addScore(ship.collision(bonusBall.getFCircle()));

  //collision verification between balls and bumpers
  b1.collision(ball.getFCircle());
  b2.collision(ball.getFCircle());
  b1.collision(bonusBall.getFCircle());
  b2.collision(bonusBall.getFCircle());


  //collision verification between balls and targets. Add points to score (0 if no collision, target value if collision)
  player.addScore(target1.collision(ball.getFCircle()));
  player.addScore(target2.collision(ball.getFCircle()));
  player.addScore(target3.collision(ball.getFCircle()));
  player.addScore(target1.collision(bonusBall.getFCircle()));
  player.addScore(target2.collision(bonusBall.getFCircle()));
  player.addScore(target3.collision(bonusBall.getFCircle()));
}





//function that tests if the score has passed a threshold. If a threshold is passed, the player gains a life,
//the next threshold is updated, target flash activation is activated thanks to the flashActive boolean,
//theme3 is played, and if the bonus ball is not in play, it is put in the launch area.
void testScore() {

  if (player.getScore()>=player.getThreshold()) {

    player.gainLife();
    player.nextThreshold();
    flashActive=true;
    m.playTheme3();

    if (!bonusBall.exist()) {
      bonusBall.create();
    }
  }
}





//function that tests if we've reached the end of a round or game.
void testEnd() {

  if (ball.getFCircle().isTouchingBody(world.bottom)) {//when the ball touches the ground
    player.loseLife();//the player loses a life
    if (player.getLives()<0) {//if this was the last life
      m.playTheme2();//play the end theme
      endGame=true;//trigger game end with the endGame boolean

      ;
    } else {
      newRound(); //otherwise if the player still has lives, start a new round
    }
  }

  if (bonusBall.getFCircle().isTouchingBody(world.bottom)) {//special case if the bonus ball touches the ground, no life loss, special theme 4 is played, and bonus ball is simply removed from the game.
    m.playTheme4();
    bonusBall.restart();
    bonusBall.remove();
  }
}





//function that initializes a new round
void newRound() {

  ball.restart(); //the ball is placed in the launch area
  frame.openFlap();//force flap opening, due to a small bug.
  audioPlayer = minim.loadFile("Sling"+int(random(1, 3))+".wav");//loading and random playback of an audio file "Slingx.wav" from the data folder.
  audioPlayer.play();
  ship.init(); //platform reinitialization (the ship reappears even if it was destroyed)
  m.playTheme1(); //play theme1 for new round
}





//function that activates flash (rapid color changes of targets for 180 frames) when the flashActive boolean is true
//the function is used in the draw loop so using an if condition with a boolean is equivalent to a "while" the boolean is true
void testFlash() {

  if (flashActive) {
    if (timer>0) {//during timer duration, randomly change target colors every frame.
      target1.changeColor();
      target2.changeColor();
      target3.changeColor();
      timer-=1; //timer decrementation
    } else { //at the end, the boolean is set back to false, and timer reinitialized
      flashActive=false;
      timer=180;
    }
  }
}





//the slam function simulates the player's action of shaking the pinball in one direction. This has the effect of giving an impulse to the ball. But beware if this is used too much, protection activates and freezes the flipper commands for a few frames.
void slam(String side) {

  slamSound.trigger(); //slam sound sample trigger

  switch(side) {//impulse on the ball based on side
  case "left":

    ball.getFCircle().addImpulse(500, -300);
    bonusBall.getFCircle().addImpulse(500, -300);
    slamActive=true; //boolean necessary to activate animation
    break;

  case "right":
    ball.getFCircle().addImpulse(-500, -300);
    bonusBall.getFCircle().addImpulse(-500, -300);
    slamActive=true; //boolean necessary to activate animation
    break;
  }

  slamSide=side; //recording the slam side in a variable that will be used as argument for the animation function.
  slamCounter-=1;//the counter of allowed slams before pinball protection is decremented.



  if (slamCounter <= 0) {//if too many slams are used the pinball goes into protection mode by setting the tiltProtection boolean to true

    tiltProtection=true;
    m.playTheme5(); //play theme5 indicating pinball protection
  }
}





//function that manages slam animations
//the function is used in the draw loop so using an if condition with a boolean is equivalent to a "while" the boolean is true
void slamAnimation(String side) {

  if (slamActive) {//while the slamActive boolean is true

    switch(side) {//based on side, image display
    case "left":

      image(img4, 0, 300);
      break;

    case "right":
      image(img4, 350, 300);
      break;
    }

    slamTimer-=1;//timer decrementation
    if (slamTimer<=0) {//if timer reaches zero, deactivate animation by setting slamActive boolean to false.
      slamActive=false;
      slamTimer=30;//timer reinitialization.
    }
  }
}





//protection that activates when too many slams have been performed
//the function is used in the draw loop so using an if condition with a boolean is equivalent to a "while" the boolean is true
void testTiltProtection() {

  if (tiltProtection) {//while tiltProtection is true

    fill(255, 0, 0, 50);
    rect(0, 0, width, height);//overlay a semi-transparent red rectangle over the entire window.
    tiltProtectionTimer-=1;//timer decrementation.
  }

  if (tiltProtectionTimer<=0) {//when timer reaches zero

    tiltProtection=false;//deactivate protection by setting tiltProtection boolean to false
    tiltProtectionTimer=250;//timer reinitialization
    slamCounter=3;//counter reinitialization
  }
}





//key detection function
void keyPressed() {

  if (key=='r') {//r key starts a new game

    newGame=true;
    endGame=false;
    newGameScreen();
  }

  if (key=='p') {//debug key

    //flashActive=true;
    //m.playTheme5();
  }

  if (key==' ') {//space key to launch the game with a coin insertion sound

    if (newGame) {
      audioPlayer = minim.loadFile("CoinIn5.wav");
    }

    newGame=false;

    audioPlayer.play();
  }

  //for the following keys, we check that the pinball is not in protection state to be able to activate them
  if (key=='q' && !tiltProtection) {//q key left slam
    if (!newGame && !endGame) {
      slam("left");
    }
  }

  if (key=='e' && !tiltProtection) {//e key right slam
    if (!newGame && !endGame) {
      slam("right");
    }
  }


  if (key==CODED  && !tiltProtection) {
    switch(keyCode) {

    case LEFT:
      leftPressed=true; //left arrow key to activate left flipper with leftPressed boolean
      break;

    case RIGHT:
      rightPressed=true; //right arrow key to activate right flipper with rightPressed boolean
      break;


    case DOWN:
      downPressed=true; //down arrow key to activate launcher spring with downPressed boolean
      break;
    }
  }
}





//function that manages key releases
void keyReleased() {

  if (key==CODED && !tiltProtection) { //check that we're not in protection state

    switch(keyCode) {
    case LEFT :
      leftPressed=false; //left arrow release by setting boolean to false
      f1.releaseShot(); //left flipper release
      break;

    case RIGHT:
      rightPressed=false; //right arrow release by setting boolean to false
      f2.releaseShot(); //right flipper release

      break;

    case DOWN:
      downPressed=false; //down arrow release by setting boolean to false
      catapult.release(); //let the launcher spring relax and eject the ball(s).
      break;
    }
  }
}
