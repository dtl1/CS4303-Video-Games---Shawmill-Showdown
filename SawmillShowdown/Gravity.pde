class Gravity implements ForceGenerator {
  private PVector gravity;

  public Gravity(final float gravity) {
    //gravity is vertical
    this.gravity = new PVector(0, gravity);
  }

  public void update(Particle p) {
    p.addForce(gravity);
  }
}
