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
  }
    
  void display() {
    imageMode(CENTER);
    image(swordSprite, playerOffset, 0);
  }
    
  //CONSERVAR PARA TESTEO
  void satTest() {
    float testX = mouseX;
    float testY = mouseY;
    float testW = 100;
    float testH = 50;
    float testAngle = radians(0);  // Ángulo de rotación en radianes
    
    // Calcular vértices de cada rectángulo
    PVector[] rect1Vertices = colManager.calculateVertices(testX, testY, testW, testH, testAngle); //me
    PVector[] rect2Vertices = colManager.calculateVertices(pos.x, pos.y, w, h, currentAngle); //sword collider
    
    // Verificar colisión usando SAT
    boolean collision = colManager.checkSATCollision(rect1Vertices, rect2Vertices);
    
    // Dibujar rectángulos de colisiones
    utilities.drawRectangle(rect1Vertices);
    utilities.drawRectangle(rect2Vertices);
    
    println("Collision: " + collision); 
  } 
  
  float swordRotationAngle(float current, float target, float speed) {
    float diff = target - current;
    
    if (abs(diff) > PI) {
        if (diff > 0) {current += TWO_PI;} 
        else {current -= TWO_PI;}
    }
    
    return lerp(current, target, speed);
  }
}
