class Player {
  int health = 100;
  int diameter = 64;
  float x = width / 2, y = height / 2;
  
  //sprite
  PImage playerSprite;
  int currentFrame = 0, totalCurrentAnimFrames = 4, row = 0;
  int currentSpriteSheetX = 0, currentSpriteSheetY = 0;
  int playerSpriteW = 64, playerSpriteH = 64;
    
  Player() {
   playerSprite = loadImage("Player.png");
   
  }
  
  void update() {
    
    
    //animations
    setAnimDirection();
  }
  
  void display() {
  
    //draw sprite
    fill(0);
    copy(playerSprite, currentSpriteSheetX, currentSpriteSheetY, 
          playerSpriteW, playerSpriteH, 
          int(x) - playerSpriteW / 2, int(y) - playerSpriteH / 2, // draw sprite centered
          playerSpriteW, playerSpriteH);
  }
  
    void setAnimDirection() {
    float deltaX = mouseX - x;
    float deltaY = mouseY - y;
        
    float angle = degrees(atan2(deltaY, deltaX));
    println(angle);
    //sprite Row update (8 dir)
    if (angle >= -22.5 && angle < 22.5) {row = 0;} //east
    else if (angle <= -22.5 && angle > -67.5) {row = 1;} //north-east
    else if (angle <= -67.5 && angle > -112.5) {row = 2;} //north
    else if (angle <= -112.5 && angle > -157.5) {row = 3;} //north-west
    else if (angle <= -157.5 && angle > 157.5) {row = 4;} //west
    else if (angle <= 157.5 && angle > 112.5) {row = 5;} //south-west
    else if (angle <= 112.5 && angle > 67.5) {row = 6;} //south
    else {row = 7;} //south-east
    
    currentSpriteSheetY = row * int(playerSpriteH);
  }
}
