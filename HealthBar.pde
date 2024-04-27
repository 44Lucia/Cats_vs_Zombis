class HealthBar {
  PVector healthBarPos;
  PVector healthBarSize;
  Object target;

  HealthBar(Object p_target, float p_x, float p_y, float p_w, float p_h) {
    target = p_target;
    healthBarPos = new PVector(p_x, p_y);
    healthBarSize = new PVector(p_w, p_h);
  }

  void display(int p_health, int p_maxHealth) {
    // Draw the background of the life bar
    fill(255);
    rect(healthBarPos.x, healthBarPos.y, healthBarSize.x, healthBarSize.y);
  
    // Calculates the length of the life bar based on current health
    float healthLength = map(p_health, 0, p_maxHealth, 0, healthBarSize.x);
  
    // Draw the life bar
    fill(0, 255, 0); 
    rect(healthBarPos.x, healthBarPos.y, healthLength, healthBarSize.y);
  }
}
