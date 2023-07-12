final class Player{
  
    // The player is represented as a rectangle
  // the position field indicates the top-left of that rectangle.
  PVector position ;
  PVector direction;
  PVector end;
  PImage img;
  int playerWidth, playerHeight ;
  int moveIncrement ;
  float  angle = 45;
  int power = 50;
boolean player1;

  
    Player(int x, int y, PVector direction, int playerWidth, int playerHeight, int moveIncrement, boolean player1) {
    position = new PVector(x, y) ;
    this.direction = direction.get();
    this.playerWidth = playerWidth ;
    this.playerHeight = playerHeight ;
    this.moveIncrement = moveIncrement ;
    this.player1 = player1;
    if (player1)
    img = loadImage("textures/player1.png", "png");
    else
    img = loadImage("textures/player2.png", "png");
  }
  
  
    // getters
  int getX() {return (int)position.x ;}
  int getY() {return (int)position.y ;}
  
  PVector getPosition() {
    return position.get();
  }

   PVector getEnd() {
    return end.get();
  }


  float getAngle() {
    return angle;
  }

  int getPower() {
    return power;
  }

  void setPower(int power){
    this.power = power;
  }
  void setAngle(float angle){
    this.angle = angle;
  }

   PVector setDirection(PVector vector) {
    // Set a vector's direction for the gun's current direction
    vector.x *= direction.x;
    vector.y *= direction.y;
    return vector;
  }




  
  // The player is displayed as a rectangle
  void draw() {
    
   

    //fill(255) ;
    image(img, position.x, position.y, playerWidth, playerHeight) ;

     // Draw a line representing the angle of the shot
    strokeWeight(power/4);
   PVector pos = position.get();
    pos.x += playerWidth / 2;
   end = angleToVector();
    // Scale and position the normalised vector
    setDirection(end).mult(power*2).add(pos);
    if(player1)
    stroke(#ff0000);
    else
     stroke(#0000ff);


    line(pos.x, pos.y, end.x, end.y);


  }


  boolean checkCollision(ArrayList<Block> blocks, float posX){

    Rectangle2D playerBox = new Rectangle2D.Float(posX, position.y, playerWidth, playerHeight);
    for(Block b: blocks){
        if (playerBox.intersects(b.getPosition().x, b.getPosition().y, playerWidth, playerWidth/2))
        return true;
    }
    return false;



  }




  //movement 
  void moveLeft(ArrayList<Block> blocks) {

    if(checkCollision(blocks, position.x - moveIncrement) == false){
    position.x -= moveIncrement;
    if (position.x < 0) position.x = 0;
    }

  
  }
  void moveRight(ArrayList<Block> blocks) {

    if(checkCollision(blocks, position.x + moveIncrement) == false){
       position.x += moveIncrement ;
       if (position.x > displayWidth-playerWidth)
        position.x = displayWidth-playerWidth ;
       
    }


  }

  void powerUp(){
    if(power < 100)
    power+=5;
  }

  void powerDown(){
    if(power > 40)
    power-=5;
  }

  void angleUp(){
    if(angle < 180)
    angle+=5;
  }

  void angleDown(){
    if(angle > 0)
    angle-=5;
  }
  
    // Convert the angle in degrees to a vector
  PVector angleToVector() {
    final float x = (float) Math.cos(Math.toRadians(angle));
    final float y = (float) -Math.sin(Math.toRadians(angle));
    return new PVector(x, y);
  }


}
