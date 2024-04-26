class GreatSword {
  PImage swordSprite = loadImage("GreatSword.png");
  PVector pos;
  int w = 76, h = 19;
  
  float currentAngle = 0;
  float rotationSpeed = 0.08;
  int playerOffset = 60;
  
  GreatSword() {
    pos = new PVector(playerOffset, 0);
  }
  
  void update() {
    pos.x = pj.pos.x + cos(currentAngle) * playerOffset; 
    pos.y = pj.pos.y + sin(currentAngle) * playerOffset;    
    currentAngle = swordRotationAngle(currentAngle, utilities.mouseAngle(), rotationSpeed);
    
    checkCollisions();
  }
    
  void display() {
    imageMode(CENTER);
    image(swordSprite, playerOffset, 0);
  }
  
  float swordRotationAngle(float current, float target, float speed) {
    float diff = target - current;
    
    if (abs(diff) > PI) {
        if (diff > 0) {current += TWO_PI;} 
        else {current -= TWO_PI;}
    }
    
    return lerp(current, target, speed);
  }
  
  void checkCollisions() {
    // Calcular vértices de cada rectángulo
    PVector[] swordVertices = colManager.calculateVertices(pos.x, pos.y, w, h, currentAngle); //sword collider
    for(int i = enemyManager.torches.size() - 1; i >= 0; i-- ) {
      Torch torch = enemyManager.torches.get(i);
      
      PVector[] torchVertices = colManager.calculateVertices(torch.pos.x, torch.pos.y, torch.animations.spriteWidth, torch.animations.spriteHeight, 0); //torch collider
            utilities.drawRectangle(torchVertices);

      // Verificar colisión usando SAT
      boolean collision = colManager.checkSATCollision(swordVertices, torchVertices);      
      if(collision) {
        torch.health -= pj.damage;  
        if(torch.health <= 0) {enemyManager.torches.remove(torch); println("deleted");}
      }
    }
  }
}
