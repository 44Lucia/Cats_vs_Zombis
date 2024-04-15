class GreatSword {
  PImage swordSprite;
  float x = 50, y = 0;
  int w = 76, h = 19;
  
  float currentAngle = 0;
  float rotationSpeed = 0.08;
  int playerOffset = 50;
  
  GreatSword() {
   swordSprite = loadImage("GreatSword.png");    
  }
  
  void update() {
    x = pj.x + cos(currentAngle) * playerOffset; 
    y = pj.y + sin(currentAngle) * playerOffset;
    
    currentAngle = swordRotationAngle(currentAngle, utilities.mouseAngle(), rotationSpeed);
    
    satTest();
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
    PVector[] rect2Vertices = colManager.calculateVertices(x, y, w, h, currentAngle); //sword collider
    
    // Verificar colisión usando SAT
    boolean collision = colManager.checkSATCollision(rect1Vertices, rect2Vertices);
    
    // Dibujar rectángulos de colisiones
    utilities.drawRectangle(rect1Vertices);
    utilities.drawRectangle(rect2Vertices);
    
    //println("Collision: " + collision); 
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
