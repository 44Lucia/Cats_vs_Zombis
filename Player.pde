class Player extends Entity {
  int damage = 0;
  int money = 0;
  int score = 0;
  String name = "";
  PVector pos;
  
  boolean isWeaponUp;
    
  //sprite
  PImage playerSprite = loadImage("Player.png");
  int currentFrame = 0, totalCurrentAnimFrames = 4, row = 0;
  int currentSpriteSheetX = 0, currentSpriteSheetY = 0;
  int playerSpriteW = 64, playerSpriteH = 64;
  
  Player() {
    pos = new PVector(width / 2, height / 2);
    healthBar = new HealthBar(this, pos.x - playerSpriteW / 2, pos.y + 30, 60, 10);
  }
  
  //default no weapon update
  void update() {    
    playerAnimDirection();
    isWeaponUp = row < 5; //Sets the weapon back or front of the player
    
    //game over
    if(!isAlive) {gameState = 3;}
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
    maxHealth = 100;
    health = maxHealth;
    damage = 5;
  }
  
  void update() {
    super.update();
    
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
    
    healthBar.display(health, maxHealth);
  }
}

class Archer extends Player {
  Bow bow;

  Archer() {
    bow = new Bow();
    maxHealth = 60;
    health = maxHealth;
    damage = 40;
  }
  
  void update() {
    super.update();
     
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
    
    healthBar.display(health, maxHealth);
  }
}
