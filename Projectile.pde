class Projectile {
  PImage arrowSprite = loadImage("arrow.png");
  boolean hasbeenShoot, isActive;

  float x = width / 2, y = height / 2;
  int w = 52, h = 11;
  float angle;
  float speed = 8;
  
  void update() {
    if(hasbeenShoot) {
      if(x < 0 || x > width || y > height || y < 0) {
        hasbeenShoot = false; 
        isActive = false;
      }
      
      //movement
      x += cos(angle) * speed;
      y += sin(angle) * speed;
    }
    else if(isActive) {angle = utilities.mouseAngle();}
  }
    
  void display(int p_currentFrame) {
    pushMatrix();
      if(hasbeenShoot) {
        resetMatrix();
        translate(x, y);
        rotate(angle);
      }
      rectMode(CENTER);
      
      copy(arrowSprite, 0, 0,
      w, h,
      32 + p_currentFrame * -10, -arrowSprite.height / 2, // draw sprite centered
      w, h);
      
    popMatrix();
  }
  
  void shootArrow(float p_x, float p_y, float p_angle) {
    x = p_x;
    y = p_y;
    angle = p_angle;
    hasbeenShoot = true;
  }
}
