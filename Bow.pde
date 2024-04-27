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
    pos = new PVector(0, 0);
    
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
      if(arrow.isActive) {checkCollisions(arrow);}     
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
  
  void checkCollisions(Projectile p_arrow) {
    // Calcular vértices de cada rectángulo
    PVector[] arrowVertices = colManager.calculateVertices(p_arrow.pos.x, p_arrow.pos.y, p_arrow.w, p_arrow.h, p_arrow.angle); //arrow collider
    for(int i = enemyManager.torches.size() - 1; i > 0; i-- ) { // Torch enemies
      Torch torch = enemyManager.torches.get(i);
      
      PVector[] torchVertices = colManager.calculateVertices(torch.pos.x, torch.pos.y, torch.animations.spriteWidth, torch.animations.spriteHeight, 0); //torch collider
            utilities.drawRectangle(torchVertices);

      // Verificar colisión usando SAT
      boolean collision = colManager.checkSATCollision(arrowVertices, torchVertices);      
      if(collision) {
        torch.health -= pj.damage;  
        if(torch.health <= 0) {
          enemyManager.torches.remove(torch); 
          pj.score += torch.score;
          pj.money += torch.money;
        }
      }
    }
  }
}
