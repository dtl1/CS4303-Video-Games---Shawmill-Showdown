class Wind implements ForceGenerator {
  //The wind varies between -max and +max
 final int max = 50;
 final float dampening = 2;

  private PVector wind = new PVector(0, 0);

   void update(Particle p) {
    p.addForce(wind.get().mult(dampening));
  }

   void setWind() {
    //wind is horizontal, a random value between -max and +max.
    this.wind.x = (float) random(-max, max);
  }

 int getWind() {
    return (int) this.wind.x;
  }
}