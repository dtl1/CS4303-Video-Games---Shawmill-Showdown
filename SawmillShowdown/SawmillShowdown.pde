import java.awt.geom.*;

Player player1, player2;
Ai playerAi;
int playersWidth, playersHeight;

int player1Pts = 0;
int player2Pts = 0;

Terrain terrain;
Axe axe = null;
Gravity gravity;
Wind wind;
ForceRegistry forces = new ForceRegistry();
final float POWER_DAMP = 0.8;


//these Booleans are used instead of polling the keyboard every frame.
boolean movingLeft = false ;
boolean movingRight = false ;
boolean powerUp = false;
boolean powerDown = false;
boolean angleUp = false;
boolean angleDown = false;

boolean player1Turn = true;
boolean aiMode = false;
boolean aiWaited = false;

// Some constants used to derive sizes for game elements from display size
final int PLAYER_WIDTH_PROPORTION = 20,
          PLAYER_INCREMENT_PROPORTION = 100;

//textures
PImage axe1p1, axe1p2, axe1p3, axe1p4,
  axe2p1, axe2p2, axe2p3, axe2p4;

PImage log;

PImage background;

Button mode1, mode2;

boolean ready = false;
int winMessage = 0;


void setup(){

  fullScreen();
   background(#ADD8E6);
   background = loadImage("textures/background.png", "png");
   image(background, 0, 0, displayWidth, displayHeight);

    
    playersWidth = displayWidth/PLAYER_WIDTH_PROPORTION ;

    //brown
    fill(#964B00);

    textSize(displayWidth/20);
    text("Sawmill Showdown", displayWidth/4, playersWidth);


    textSize(displayWidth/40);
    text("Use the keyboard to move and to throw your axe.", playersWidth/2, playersWidth*2);

     textSize(displayWidth/40);
    text("Move Left: 'A'\nMove Right: 'D'\nThrow: Spacebar ' ' ", playersWidth/2, playersWidth*3);


    textSize(displayWidth/40);
    text("Use the arrow keys to change the power and angle of your throw.", playersWidth/2, playersWidth*7);

     textSize(displayWidth/40);
    text("Increase Power: UP '^'\nDecrease Power: DOWN 'v'\nAngle up: LEFT '<'\nAngle down: RIGHT '>'", playersWidth/2, playersWidth*8);


     textSize(displayWidth/80);
        text("Game Rules:\nHit the other player to score points\nFirst to 3 points wins the game\nTip: don't hit yourself!", displayWidth - 6*playersWidth, playersWidth*4);

  if(winMessage == 1){
     textSize(displayWidth/40);
     //red
     fill(#ff0000);
     text("Player 1 Wins!", displayWidth/3, displayHeight/2);
     winMessage =0;
  } else if (winMessage == 2){
      textSize(displayWidth/40);
     //blue
     fill(#0000ff);
     text("Player 2 Wins!", displayWidth/3, displayHeight/2);
       winMessage =0;
  }

  fill(#ffffff);  
  mode1 = new Button(displayWidth - 2*playersWidth, playersWidth*2, playersWidth, "Local 2-Player Versus", #964B00);
  mode2 = new Button(displayWidth - 2*playersWidth,  playersWidth*6, playersWidth, "Single Player vs AI", #964B00);
  mode1.visible = true;
  mode2.visible = true;


   if (mode1.visible) mode1.show();
   if (mode2.visible) mode2.show();

}

void mousePressed() {
  if (mode1.visible) { // Don't process click if button is disabled    
    float d = dist(mode1.pos.x, mode1.pos.y, mouseX, mouseY);
    if (d <= mode1.radius){
      mode1.visible = false;
      mode2.visible = false;
      ready = true;
      reset();
    } 
  }
    if (mode2.visible) { // Don't process click if button is disabled    
    float d = dist(mode2.pos.x, mode2.pos.y, mouseX, mouseY);
    if (d <= mode2.radius){
      mode1.visible = false;
      mode2.visible = false;
     ready = true;
      aiMode = true;
      reset();
    } 
  }

}



void newGame(){
  loadTextures();
  createObjects();
  createForces();
  if(aiMode)
    createAI();
  fullScreen();
}




//load axe and block textures at startup and pass into classes instead of having to repetedly load
void loadTextures(){

    axe1p1 = loadImage("textures/axe1p1.png", "png");
    axe1p2 = loadImage("textures/axe1p2.png", "png");
    axe1p3 = loadImage("textures/axe1p3.png", "png");
    axe1p4 = loadImage("textures/axe1p4.png", "png");

    axe2p1 = loadImage("textures/axe2p1.png", "png");
    axe2p2 = loadImage("textures/axe2p2.png", "png");
    axe2p3 = loadImage("textures/axe2p3.png", "png");
    axe2p4 = loadImage("textures/axe2p4.png", "png");

    log = loadImage("textures/wood.png", "png");

}

void createObjects(){
    
   playersWidth = displayWidth/PLAYER_WIDTH_PROPORTION ;
   playersHeight = playersWidth; //we want a square 
  
  int playersInitY = displayHeight - playersHeight*2 ;
  int playersIncrement = displayWidth/PLAYER_INCREMENT_PROPORTION ;  

  int player1InitX = playersWidth;
  int player2InitX = displayWidth - playersWidth*2;
  
  
  player1 = new Player(player1InitX, playersInitY, new PVector(1, 1),
playersWidth, playersHeight, playersIncrement, true);

                        

  player2 = new Player(player2InitX, playersInitY, new PVector(-1, 1),
playersWidth, playersHeight, playersIncrement, false);

terrain = new Terrain(playersWidth, log);

}

void createForces(){
gravity = new Gravity(200);
wind = new Wind();
wind.setWind();



}

void createAI(){
  //create a new ai player and give it the human players object and the player2 object, as well as the current wind
  playerAi = new Ai(player1, player2, wind);
}



// Read keyboard for input. Notice how booleans are used to maintain state
void keyPressed() {
  if(ready){
  // space to fire
if (key == ' ') {

  //if theres no current axe being thrown, throw one 
  if(axe == null){
   fire(); 
  }
  }

  //can only move if no axe is being thrown
  if(axe == null){
  if (key == 'd'){
    movingRight = true;
  } else if (key == 'a'){
    movingLeft = true;
  }

  if (key == CODED) {
     switch (keyCode) {
       case LEFT :
         angleUp = true ;
         break ;
       case RIGHT :
         angleDown = true ;
         break ;
      case UP :
         powerUp = true;
         break;
      case DOWN :
         powerDown = true;
         break;
     }
  }
}
  }

}

void keyReleased() {
  if (key == 'd'){
    movingRight = false;
  } else if (key == 'a'){
    movingLeft = false;
  }


  if (key == CODED) {
     switch (keyCode) {
       case LEFT :
         angleUp = false ;
         break ;
       case RIGHT :
         angleDown = false ;
         break ;
       case UP :
         powerUp = false;
         break;
       case DOWN :
         powerDown = false;
         break;
     }
  }  
}

  void fire() {
    // Only one axe may be fired at a time
    if (axe != null) {
      return;
    }
    // Create the axe and give it a starting velocity
    if(player1Turn){
    makeAxe(player1);
    throwAxe(player1);
    } else{
    makeAxe(player2);
    throwAxe(player2);
    }

    // The axe is subject to gravity
    forces.register(gravity, axe);
    // The axe is subject to the wind
    forces.register(wind, axe);

  }

  void makeAxe(Player player) {

    PVector axePos;

    //start the axe from the end of the indicator, then some padding so a self hit doesnt occur
    if(player1Turn)
    axePos = new PVector(player.getEnd().x, player.getEnd().y - playersHeight/2);
    else
    axePos = new PVector(player.getEnd().x - playersWidth/2, player.getEnd().y - playersHeight/2);

    axe = new Axe(axePos);

    //make sure the textures for the axe face the right way
    if(player1Turn)
    axe.applyTextures(axe1p1, axe1p2, axe1p3, axe1p4, playersWidth);
    else
    axe.applyTextures(axe2p1, axe2p2, axe2p3, axe2p4, playersWidth);
  }

 void throwAxe(Player player) {
    // Give it an initial firing velocity
    PVector axeVelocity = player.angleToVector();
    axeVelocity.mult(player.getPower() * POWER_DAMP);
    // Point the axe in the right direction
    axeVelocity = player.setDirection(axeVelocity);
    axe.setVelocity(axeVelocity);

  
  }

  void update() {
    // Apply all forces
    forces.updateForces();
    if (axe != null) {
      axe.update();
      // The axe may collide, resulting in a turn change
      // and possibly a score update
     detectAxeCollision();
     // detectHit();
    }
   // updateBlocks();
  }




  void destroyAxe() {
    // Deregister the forces on the axe
    forces.deregister(gravity, axe);
    forces.deregister(wind, axe);
    // Remove the axe
    axe = null;

    //change turns
      if(player1Turn)
    player1Turn = false;
      else
         player1Turn = true;


  }

  
  void detectAxeCollision() {
    // Get the axe's collision box
    PVector pos = axe.getPosition();
    Rectangle2D axeBox = new Rectangle2D.Float(pos.x, pos.y, axe.width, axe.height);
    // Detect and handle collision

    if (playerCollision(axeBox)){
      
       destroyAxe();
       reset();
    }
    else if (terrainCollision(axeBox) ||checkBounds()) {
      // The axe is destroyed if it hits terrain or goes out of bounds
        
      destroyAxe();
      
      if(!player1Turn && aiMode){
        ArrayList<Block> blocks = terrain.getBlocks();
        playerAi.move(blocks);
        draw();
        draw();
        player2.setAngle(playerAi.newAngle());
        player2.setPower(playerAi.newPower());
        draw();
        draw();
        fire();
        aiWaited = false;
      }
    } 
  }

  void reset(){
    background(#ADD8E6);

    if(aiMode)
    player1Turn = true;

    if(player1Pts == 3|| player2Pts == 3){
    
      
      if(player1Pts ==3)
      winMessage = 1;
      else
      winMessage = 2;

      player1Pts = 0;
      player2Pts = 0;
      ready = false;
      aiMode = false;


      setup();
    } else {
      newGame();
    }

    
  }


  boolean playerCollision(Rectangle2D axeBox) {
    // heck for collisions with players
       PVector pos1 = player1.getPosition();
       PVector pos2 = player2.getPosition();
      // If the axe collides with a player
      if (axeBox.intersects(pos1.x, pos1.y, playersWidth, playersHeight)){
 
          player2Pts +=1;
          return true;
      } else if (axeBox.intersects(pos2.x, pos2.y, playersWidth, playersHeight)){
  
          player1Pts +=1;
          return true;
      } else {
      return false;
      }
  }


  boolean terrainCollision(Rectangle2D axeBox) {
    // Check for a collision with any blocks
   ArrayList<Block> blocks = terrain.getBlocks();
    for(Block b: blocks){
    PVector pos = b.getPosition();

     if (axeBox.intersects(pos.x, pos.y, playersWidth, playersWidth/2)) {
        b.draw(#ffffff);
        b.draw(#ffffff);
        b.draw(#ffffff);
        b.draw(#ffffff);
        blocks.remove(b);
        return true;
    }
    }
    return false;
  }


   boolean checkBounds() {

  //if it goes out of top of screen or if it hits the ground
   if(axe.getPosition().y < 0 - displayHeight || axe.getPosition().y >= displayHeight - playersHeight){
      return true;
   } else {
    return false;
   }

  }







void draw(){


if(ready){
  background(#ADD8E6);
  
   
          
 

 fill(#ff0000);
 textSize(displayWidth/40);
 text("Power: " + player1.getPower() +"\nAngle: " + player1.getAngle()+ "°\nPoints: " + player1Pts, playersWidth, playersWidth*2);

 
fill(#0000ff);
textSize(displayWidth/40);
 text("Power: " + player2.getPower() +"\nAngle: " + player2.getAngle()+ "°\nPoints: " + player2Pts, displayWidth - playersWidth*3, playersWidth*2);

  textSize(displayWidth/20);
  if(player1Turn){
    fill(#ff0000);
     text("Player 1 Turn", displayWidth/3, playersWidth);
  }
  
  else{
      fill(#0000ff);
   text("Player 2 Turn", displayWidth/3, playersWidth);

  }
  fill(#ffffff);
  textSize(displayWidth/40);
  int windSpeed = wind.getWind();
  if (windSpeed < 0){
    windSpeed*=-1;
    text("Windspeed: " + windSpeed + "km/h <--- West ", displayWidth/3, playersWidth*2);
  } else {
    text("Windspeed: " + windSpeed + "km/h East --->", displayWidth/3, playersWidth*2);
  }
  



  //ground
 strokeWeight(4);
 stroke(#964B00);
 line(0, displayHeight - playersHeight, displayWidth, displayHeight - playersHeight);


 terrain.draw();
ArrayList<Block> blocks = terrain.getBlocks();

  //player movement
  if (player1Turn){
    if(movingLeft){
        player1.moveLeft(blocks);
    } else if (movingRight){
        player1.moveRight(blocks);
    } else if (powerUp){
       player1.powerUp();
    } else if (powerDown){
       player1.powerDown();
    } else if (angleUp){
      player1.angleUp();
    } else if (angleDown){
      player1.angleDown();
    }
    } else { //player 2 turn
    if(movingLeft){
        player2.moveLeft(blocks);
    } else if (movingRight){
        player2.moveRight(blocks);
    } else if (powerUp){
       player2.powerUp();
    } else if (powerDown){
       player2.powerDown();
    } else if (angleUp){
      player2.angleUp();
    } else if (angleDown){
      player2.angleDown();
    }
  }
 

  player1.draw();
  player2.draw();
 
  if (axe != null) {
    axe.draw();
    update();
  }



}

}
