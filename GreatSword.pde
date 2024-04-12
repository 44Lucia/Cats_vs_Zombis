class GreatSword {
  PImage swordSprite;
  float x = 50, y = 0;
  PVector matrixPos = new PVector(0, 0);
  int w = 76, h = 19;
  
  float currentAngle = 0;
  float rotatingSpeed = 0.08;
  
  GreatSword() {
   swordSprite = loadImage("GreatSword.png"); 
  }
  
  void update() {
    satTest();
  }
    
  void display() {
    imageMode(CENTER);
    image(swordSprite, x, y);
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
    PVector[] rect2Vertices = colManager.calculateVertices(matrixPos.x, matrixPos.y, w, h, currentAngle); //sword collider
    
    // Verificar colisión usando SAT
    boolean collision = colManager.checkSATCollision(rect1Vertices, rect2Vertices);
    
    // Dibujar rectángulos de colisiones
    utilities.drawRectangle(rect1Vertices);
    utilities.drawRectangle(rect2Vertices);
    
    //println("Collision: " + collision); 
  } 
}
