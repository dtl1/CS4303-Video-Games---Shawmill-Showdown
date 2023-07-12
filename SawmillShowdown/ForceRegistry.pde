import java.util.HashMap;
import java.util.Map;

interface ForceGenerator {
  public void update(Particle p);
}

class ForceRegistry {
  // register particle with force generator
  HashMap<ForceGenerator, Particle> registry;

 ForceRegistry() {
    registry = new HashMap<ForceGenerator, Particle>();
  }

 void register(ForceGenerator fg, Particle p) {
    registry.put(fg, p);
  }

 void deregister(ForceGenerator fg, Particle p) {
    registry.remove(fg);
  }

 void clear() {
    registry.clear();
  }

   void updateForces() {
    // For every force generator
    for (Map.Entry<ForceGenerator, Particle> reg : registry.entrySet()) {
      ForceGenerator fg = reg.getKey();
      if(fg!=null)
      fg.update(reg.getValue());
    }
  }
}