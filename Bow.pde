class Bow {
  PImage bowSprite = loadImage("Bow.png");
  PVector pos;
  int w = 64, h = 127;
  
  ArrayList<Projectile> arrowList = new ArrayList<Projectile>();
  Projectile currentArrow;
  
  //sprite
  int currentFrame = 0, totalCurrentAnimFrames = 4;
  float timeSinceFrameChange = 0;
  
  float currentAngle = 0;
  float rotationSpeed = 0.2;
  
  Bow() {
    pos = new PVector(50, 0);
    
    for(int i = 0; i < 3; i++) {arrowList.add(new Projectile());}  
    getNextArrow();
  }
  
  void update() {
    pos.x = pj.pos.x + cos(currentAngle);
    pos.y = pj.pos.y + sin(currentAngle); 
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
        currentArrow.shootArrow(pos.x, pos.y, currentAngle);
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
