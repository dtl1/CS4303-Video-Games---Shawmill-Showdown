class Axe extends Particle {
  int width, height;
  PImage axe1, axe2, axe3, axe4;

  int last = 0;

  public Axe(final PVector position) {

    //axe weighs 100 units
    super(position, 100);

  }

  void applyTextures(PImage axe1, PImage axe2, PImage axe3, PImage axe4, int playersWidth){
    this.width = playersWidth*3/4;
    this.height = this.width;

    this.axe1 = axe1;
    this.axe2 = axe2;
    this.axe3 = axe3;
    this.axe4 = axe4;
  }

  public void draw() {
   
    //change image every 5 frames
    if(last <= 5)
    image(axe1, getPosition().x, getPosition().y, width, height);
    else if (last <= 10)
    image(axe2, getPosition().x, getPosition().y, width, height);
    else if (last <= 15)
    image(axe3, getPosition().x, getPosition().y, width, height);
    else if (last <= 20)
    image(axe4, getPosition().x, getPosition().y, width, height);
    
    if(last == 20)
    last = 0;
  
    last += 1;
    
  }
}