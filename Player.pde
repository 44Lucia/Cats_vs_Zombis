class Player {
  int MAX_HEALTH = 100;
  int health = MAX_HEALTH;
  int money = 0;
  int score = 0;
  String name = "";
  PVector pos;//x = width / 2, y = height / 2;
  
  boolean isWeaponUp;
    
  //sprite
  PImage playerSprite = loadImage("Player.png");
  int currentFrame = 0, totalCurrentAnimFrames = 4, row = 0;
  int currentSpriteSheetX = 0, currentSpriteSheetY = 0;
  int playerSpriteW = 64, playerSpriteH = 64;
  
  Player() {
    pos = new PVector(width / 2, height / 2);
  }
  
  //default no weapon update
  void update() {    
    playerAnimDirection();
  }
  
  //default no weapon display
  void display() {
    fill(0);
    copy(playerSprite, currentSpriteSheetX, currentSpriteSheetY, 
      playerSpriteW, playerSpriteH, 
      int(pos.x) - playerSpriteW / 2, int(pos.y) - playerSpriteH / 2, // draw sprite centered
      playerSpriteW, playerSpriteH);
  }
  
  void playerAnimDirection() {
    float animAngle = degrees(utilities.mouseAngle());
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

class Knight extends Player {
  GreatSword sword;

  Knight() {
    sword = new GreatSword();
    MAX_HEALTH = 100;
    health = MAX_HEALTH;
  }
  
  void update() {
    super.update();
    
    isWeaponUp = row < 5; //Sets the weapon back or front of the player     
    sword.update();
  }
  
  void display() {
    fill(0);
 
    if(isWeaponUp) {
      pushMatrix();
        translate(pos.x, pos.y);
        rotate(sword.currentAngle);
        sword.display();
      popMatrix();
    }
    
    copy(playerSprite, currentSpriteSheetX, currentSpriteSheetY, 
      playerSpriteW, playerSpriteH, 
      int(pos.x) - playerSpriteW / 2, int(pos.y) - playerSpriteH / 2, // draw sprite centered
      playerSpriteW, playerSpriteH);
      
    if(!isWeaponUp) {
      pushMatrix();
        translate(pos.x, pos.y);
        rotate(sword.currentAngle);
        sword.display();
      popMatrix();
    }
  }
}

class Archer extends Player {
  Bow bow;

  Archer() {
    bow = new Bow();
    MAX_HEALTH = 60;
    health = MAX_HEALTH;
  }
  
  void update() {
    super.update();
    
    isWeaponUp = row < 5; //Sets the weapon back or front of the player     
    bow.update();
  }
  
  void display() {
    fill(0);
 
    if(isWeaponUp) {
      pushMatrix();
        translate(pos.x, pos.y);
        rotate(bow.currentAngle);
        bow.display();
      popMatrix();
    }
    
    copy(playerSprite, currentSpriteSheetX, currentSpriteSheetY, 
      playerSpriteW, playerSpriteH, 
      int(pos.x) - playerSpriteW / 2, int(pos.y) - playerSpriteH / 2, // draw sprite centered
      playerSpriteW, playerSpriteH);
      
    if(!isWeaponUp) {
      pushMatrix();
        translate(pos.x, pos.y);
        rotate(bow.currentAngle);
        bow.display();
      popMatrix();
    }
  }
}
