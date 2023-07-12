class Particle {
  // air resistance
 final float DAMPING = 0.997;

   PVector position;
   PVector velocity;
   final float inverseMass;
   PVector forceAccumulator;

   Particle(final PVector position, final float mass) {
    this.position = position.get();
    velocity = new PVector(0, 0);
    inverseMass = 1 / mass;
    clearAccumulator();
  }

   void update() {
    //new position
    position.add(velocity);
    //new velocity
    PVector acceleration = forceAccumulator.get().mult(inverseMass);
    velocity.add(acceleration);
    velocity.mult(DAMPING);

    clearAccumulator();
  }

   void addForce(final PVector force) {
    forceAccumulator.add(force);
  }

   void setVelocity(final PVector velocity) {
    this.velocity = velocity.get();
  }

   float mass() {
    return 1 / inverseMass;
  }

   PVector getPosition() {
    return position.get();
  }

   void clearAccumulator() {
    forceAccumulator = new PVector(0, 0);
  }
}
