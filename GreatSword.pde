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
    float cx1 = mouseX;
    float cy1 = mouseY;
    float w1 = 100;
    float h1 = 50;
    float theta1 = radians(0);  // Ángulo de rotación en radianes
    
    // Calcular vértices de cada rectángulo
    PVector[] rect1Vertices = colManager.calculateVertices(cx1, cy1, w1, h1, theta1);
    PVector[] rect2Vertices = colManager.calculateVertices(matrixPos.x, matrixPos.y, w, h, currentAngle);
    
    // Verificar colisión usando SAT
    boolean collision = colManager.checkSATCollision(rect1Vertices, rect2Vertices);
    
    // Dibujar rectángulo 1
    utilities.drawRectangle(rect1Vertices);
    utilities.drawRectangle(rect2Vertices);
    
    // Mostrar resultado de colisión
    fill(0);
    text("Collision: " + collision, 20, 20); 
  } 
}
