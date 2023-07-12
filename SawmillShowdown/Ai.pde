class Ai {

Player humanPlayer;
Player thisPlayer;
Wind wind;

Ai(Player player1, Player player2, Wind wind){
this.humanPlayer = player1;
this.thisPlayer = player2;
this.wind = wind;
}


void move(ArrayList<Block> blocks){
//if not next to block, move towards block
int randLeft = int(random(5, 16));
int randRight = int(random(0, 11));

for(int i = 0; i <= randLeft; i++){
thisPlayer.moveLeft(blocks);
}



for(int i = 0; i <= randRight; i++){
thisPlayer.moveRight(blocks);
}

}

int newPower(){

int randPowerMod = int(random(0, 21));
//if wind is facing player 1 add less of the random power
if(wind.getWind() < 0){
    int result = humanPlayer.getPower() - randPowerMod;
    if (result < 40) result = 40;
    return result;    
}
else { //else add more to compensate for wind
     int result = humanPlayer.getPower() + randPowerMod;
     if(result > 100) result = 100;
     return result;
}

}

float newAngle(){
int randAngleMod = int(random(0, 31));
int sign = int(random(0,2));

if(sign == 0){
    float result = humanPlayer.getAngle() - randAngleMod;
    if(result < 0.0) result = 0.0;
    return result;
} else {
    float result = humanPlayer.getAngle() + randAngleMod;
    if(result > 180.0)result = 180.0;
    return result;
}


}



}