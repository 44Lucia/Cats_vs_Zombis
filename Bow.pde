class Bow {
  PImage bowSprite = loadImage("Bow.png");
  float x = 50, y = 0;
  int w = 64, h = 127;
  
  ArrayList<Projectile> arrowList = new ArrayList<Projectile>();
  Projectile currentArrow;
  
  //sprite
  int currentFrame = 0, totalCurrentAnimFrames = 4;
  float timeSinceFrameChange = 0;
  
  float currentAngle = 0;
  float rotationSpeed = 0.2;
  
  Bow() {
    for(int i = 0; i < 3; i++) { //3 arrows pool
      arrowList.add(new Projectile()); 
    }
    
    getNextArrow();
  }
  
  void update() {
    x = pj.x + cos(currentAngle);
    y = pj.y + sin(currentAngle); 
    currentAngle = bowRotationAngle(currentAngle, utilities.mouseAngle(), rotationSpeed);
    
    
    if(rightClickDown) {tenseBow();}
    else if(currentFrame != 0) {
      currentFrame = 0;
      timeSinceFrameChange = millis();
    }
    
    //Arrows
    for(Projectile arrow : arrowList) {
      arrow.update();
    }
  }
    
  void display() {
    copy(bowSprite, currentFrame * w, 0,
      w, h,
      0, -bowSprite.height / 2, // draw sprite centered
      w, h);
      
    //Arrows
    for(Projectile arrow : arrowList) {
      if(arrow.isActive) {arrow.display(currentFrame);}
    }
  }

  float bowRotationAngle(float current, float target, float speed) {
    float diff = target - current;
    
    if (abs(diff) > PI) {
      if (diff > 0) {current += TWO_PI;}
      else {current -= TWO_PI;}
    }
    
    return lerp(current, target, speed);
  }
  
  void tenseBow() {  
    if(millis() >= timeSinceFrameChange + 500) {
      currentFrame++;
      timeSinceFrameChange = millis();
      
      if(currentFrame == totalCurrentAnimFrames) {
        //shoot inactive arrow
        currentArrow.shootArrow(x, y, currentAngle);
        getNextArrow();
        currentFrame = 0;
      }
    }
  }
  
  void getNextArrow() {    
    for(Projectile arrow : arrowList) {
      if(!arrow.isActive) { //select arrow
        currentArrow = arrow;
        currentArrow.isActive = true;
      }
    }    
  }
}
