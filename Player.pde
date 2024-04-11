class Player {
  int health = 100;
  int diameter = 64;
  float x = width / 2, y = height / 2;
  
  GreatSword sword;
  boolean isWeaponUp;
  float deltaX = mouseX - x;
  float deltaY = mouseY - y;
  float currentAngle = 0;
  float desiredAngle = atan2(deltaY, deltaX);
  float rotatingSpeed = 0.08;
    
  //sprite
  PImage playerSprite;
  int currentFrame = 0, totalCurrentAnimFrames = 4, row = 0;
  int currentSpriteSheetX = 0, currentSpriteSheetY = 0;
  int playerSpriteW = 64, playerSpriteH = 64;
    
  Player() {
   playerSprite = loadImage("Player.png");
   
   sword = new GreatSword();
  }
  
  void update() {
    deltaX = mouseX - x;
    deltaY = mouseY - y;
    desiredAngle = atan2(deltaY, deltaX);
    
    float diff= desiredAngle - currentAngle;
    if(abs(diff) > PI) {
      if(diff > 0) { desiredAngle -= TWO_PI; }
      else { desiredAngle += TWO_PI; }
    }
    currentAngle = lerp(currentAngle, desiredAngle, rotatingSpeed);
    
    isWeaponUp = row < 5; //Sets the weapon back or front of the player
    sword.update();
    
    //sword.setRotationAngle(mouseX);
 
    //animations
    setAnimDirection();
  }
  
  void display() {
    fill(0);
    
    if(isWeaponUp) {
      pushMatrix();
        translate(x, y);
        rotate(currentAngle);
        sword.display();
      popMatrix();
    }
    
    copy(playerSprite, currentSpriteSheetX, currentSpriteSheetY, 
      playerSpriteW, playerSpriteH, 
      int(x) - playerSpriteW / 2, int(y) - playerSpriteH / 2, // draw sprite centered
      playerSpriteW, playerSpriteH);
      
    if(!isWeaponUp) {
      pushMatrix();
        translate(x, y);
        rotate(currentAngle);
        sword.display();
      popMatrix();
    }
  }
  
  void setAnimDirection() {
    float animAngle = degrees(atan2(deltaY, deltaX));
    //sprite Row update (8 dir)
    if (animAngle >= -22.5 && animAngle < 22.5) {row = 0;} //east
    else if (animAngle <= -22.5 && animAngle > -67.5) {row = 1;} //north-east
    else if (animAngle <= -67.5 && animAngle > -112.5) {row = 2;} //north
    else if (animAngle <= -112.5 && animAngle > -157.5) {row = 3;} //north-west
    else if (animAngle <= -157.5 || animAngle > 157.5) {row = 4;} //west
    else if (animAngle <= 157.5 && animAngle > 112.5) {row = 5;} //south-west
    else if (animAngle <= 112.5 && animAngle > 67.5) {row = 6;} //south
    else {row = 7;} //south-east
    
    currentSpriteSheetY = row * int(playerSpriteH);
  }
}
