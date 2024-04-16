class Bow {
  PImage bowSprite = loadImage("Bow.png");
  float x = 50, y = 0;
  int w = 64, h = 127;
  
  //sprite
  int currentFrame = 0, totalCurrentAnimFrames = 4;
  int currentSpriteSheetX = 0;
  
  float currentAngle = 0;
  float rotationSpeed = 0.2;
  
  void update() {
    x = pj.x + cos(currentAngle); 
    y = pj.y + sin(currentAngle);
    
    currentAngle = bowRotationAngle(currentAngle, utilities.mouseAngle(), rotationSpeed);
    
  }
    
  void display() {
    copy(bowSprite, currentSpriteSheetX, 0, 
      w, h, 
      0, -bowSprite.height / 2, // draw sprite centered
      w, h);
  }

  float bowRotationAngle(float current, float target, float speed) {
    float diff = target - current;
    
    if (abs(diff) > PI) {
        if (diff > 0) {current += TWO_PI;} 
        else {current -= TWO_PI;}
    }
    
    return lerp(current, target, speed);
  }
}
