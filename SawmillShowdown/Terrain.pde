 final class Terrain{
   
   ArrayList<Block> blocks;
  
   
   Terrain(int playersWidth, PImage log){

     //generate blocks
     blocks = new ArrayList<Block>();
     
     
      //12 columns of starting coordinates
     for(int xStart = playersWidth*4; xStart < displayWidth - playersWidth*4; xStart+=playersWidth){


      //height for each column randomly determined (0 - 8)
      int rand = int(random(0, 9));
      int yStart = displayHeight-playersWidth*2;

      for (int i = 0; i < rand; i++){

        //1/3 chance of spawning
        if(int(random(0,3)) == 1)
        blocks.add(new Block(xStart, yStart, playersWidth, log));

        yStart-=playersWidth;
      }

      
     } 
    
   }


   ArrayList<Block> getBlocks(){
    return this.blocks;
   }
   
   
  void draw(){
    for(Block b: blocks){
     b.draw(#000000); 
    }
  }
   
   
   
   
   
   
 }
