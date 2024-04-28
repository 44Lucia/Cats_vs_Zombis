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
    PVector[] arrowVertices = colManager.calculateVertices(p_arrow.pos.x, p_arrow.pos.y, p_arrow.size.x, p_arrow.size.y, p_arrow.angle); //arrow collider
    for(int i = enemyManager.torches.size() - 1; i >= 0; i--) { // Torch enemies
      Torch torch = enemyManager.torches.get(i);
      
      PVector[] torchVertices = colManager.calculateVertices(torch.pos.x, torch.pos.y, torch.animations.spriteWidth / 8, torch.animations.spriteHeight / 4, 0); //torch collider
            utilities.drawRectangle(torchVertices);
      
      // Verificar colisión usando SAT
      boolean collision = colManager.checkSATCollision(arrowVertices, torchVertices);      
      if(collision) {
        torch.takeDamage(pj.damage);
        p_arrow.hasBeenShoot = false;
        p_arrow.isActive = false;
        if(torch.health <= 0) {
          enemyManager.torches.remove(torch); 
          pj.score += torch.score;
          pj.money += torch.money;
          
          if(enemyManager.torches.size() == 0) {enemyManager.spawnWave();}
        }
      }
    }
    
    for (int i = enemyManager.tnts.size() - 1; i >= 0; i-- ) {
      Tnt tnt = enemyManager.tnts.get(i);
      PVector[] barryVertices = colManager.calculateVertices(tnt.pos.x, tnt.pos.y, tnt.animations.spriteWidth / 8, tnt.animations.spriteHeight / 4, 0); //torch collider

      // Verificar colisión usando SAT
      boolean collision = colManager.checkSATCollision(arrowVertices, barryVertices);
      if (collision) {
        tnt.takeDamage(pj.damage);
        if (tnt.health <= 0) {
          enemyManager.tnts.remove(tnt);
          pj.score += tnt.score;
          pj.money += tnt.money;

          if (enemyManager.torches.size() == 0) {enemyManager.spawnWave();}
        }
      }
    }
    
    for (int i = enemyManager.barries.size() - 1; i >= 0; i-- ) {
      Barry barry = enemyManager.barries.get(i);
      PVector[] barryVertices = colManager.calculateVertices(barry.pos.x, barry.pos.y, barry.animations.spriteWidth / 8, barry.animations.spriteHeight / 4, 0); //torch collider

      // Verificar colisión usando SAT
      boolean collision = colManager.checkSATCollision(arrowVertices, barryVertices);
      if (collision) {
        barry.takeDamage(pj.damage);
        if (barry.health <= 0) {
          enemyManager.barries.remove(barry);
          pj.score += barry.score;
          pj.money += barry.money;

          if (enemyManager.torches.size() == 0) {enemyManager.spawnWave();}
        }
      }
    }
  }
}
