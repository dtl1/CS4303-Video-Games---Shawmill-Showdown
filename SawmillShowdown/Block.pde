final class Block{
  
  int xStart;
  int yStart;
  int playersWidth;
  PVector position ;
  PImage img;

  
  Block(int xStart, int yStart, int playersWidth, PImage log){
    position = new PVector(xStart, yStart) ;
    this.xStart = xStart;
    this.yStart = yStart;
    this.playersWidth = playersWidth;
    img = log;
  }
  
   PVector getPosition() {
    return position.get();
  }

  void draw(color fillColour){
    image(img, this.xStart, this.yStart, this.playersWidth, this.playersWidth);
  }
  

}
