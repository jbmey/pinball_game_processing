import fisica.*;


//the Player class contains info about the player: number of lives, score, game state...
class Player {


  int score;
  int lives; //player's number of lives
  int scoreThreshold; //score to reach to unlock a bonus (extra life and second ball)


  Player() {

    init();
  }



  void init() {
    score=0;
    lives=3;
    scoreThreshold=10000;
  }

  
  //function to increment player's score when hitting targets.
  void addScore(int i) {
    score+= i;
  }

  //in case the player reaches a bonus threshold, this function increments their lives
  void gainLife(){
    lives+=1;
  }
  
  //function to remove a life when ball exits.
  void loseLife() {

    lives-=1;
  }


  //function that calculates the next bonus threshold
  void nextThreshold() {

    scoreThreshold=scoreThreshold*2;
  }


  //accessors
  int getScore() {

    return score;
  }

  int getLives() {

    return lives;
  }

  int getThreshold() {

    return scoreThreshold;
  }
}
