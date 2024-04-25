class HealthBar {
  PVector healthBarPos;
  float w, h;
  Object target;

  HealthBar(Object p_target, float p_x, float p_y, float p_w, float p_h) {
    target = p_target;
    healthBarPos = new PVector(p_x, p_y);
    w = p_w;
    h = p_h;
  }

  void display() {
    // Draw the background of the life bar
    fill(255);
    rect(healthBarPos.x, healthBarPos.y, w, h);
  
    // Gain health and maximum health from the target using reflection
    int health = 0;
    int maxHealth = 0;
    try {
      health = (int) target.getClass().getDeclaredField("health").get(target);
      maxHealth = (int) target.getClass().getDeclaredField("maxHealth").get(target);
    } catch (Exception e) {
      // Handle any exceptions that may occur when accessing fields
      e.printStackTrace();
    }
  
    // Calculates the length of the life bar based on current health
    float healthLength = map(health, 0, maxHealth, 0, w);
  
    // Draw the life bar
    fill(0, 255, 0); 
    rect(healthBarPos.x, healthBarPos.y, healthLength, h);
  }
}
