class Projectile {
  PImage arrowSprite = loadImage("arrow.png");
  boolean hasbeenShoot, isActive;

  PVector pos;
  int w = 52, h = 11;
  float angle;
  float speed = 8;
  
  Projectile() {
    pos = new PVector(width / 2, height / 2);
  }
  
  void update() {
    if(hasbeenShoot) {
      if(pos.x < 0 || pos.x > width || pos.y > height || pos.y < 0) {
        hasbeenShoot = false; 
        isActive = false;
      }
      
      //movement
      pos.x += cos(angle) * speed;
      pos.y += sin(angle) * speed;
    }
    else if(isActive) {angle = utilities.mouseAngle();}
  }
    
  void display(int p_currentFrame) {
    pushMatrix();
      if(hasbeenShoot) {
        resetMatrix();
        translate(pos.x, pos.y);
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
    pos.x = p_x;
    pos.y = p_y;
    angle = p_angle;
    hasbeenShoot = true;
  }
}
