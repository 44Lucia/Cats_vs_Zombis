class Sword {
    float x = 60, y = 0;
    int w = 100, h = 20;
    float rotationAngle = radians(0);
    
    void update() {
      
    }
    
    void display() {
      PVector[] Rect1Vertices = colManager.calculateVertices(x, y, w, h, rotationAngle);

      drawRectangle(Rect1Vertices);
    }
  
  void setRotationAngle(float p_angle){
    rotationAngle = radians(p_angle);
  }
  
  //CONSERVAR PARA TESTEO
  void satTest() {
    float cx1 = 150;
    float cy1 = 150;
    float w1 = 100;
    float h1 = 50;
    float theta1 = radians(30);  // Ángulo de rotación en radianes
    
    // Definir rectángulo 2
    float cx2 = mouseX;
    float cy2 = mouseY;
    float w2 = 80;
    float h2 = 80;
    float theta2 = radians(-20);  // Ángulo de rotación en radianes
    
    // Calcular vértices de cada rectángulo
    PVector[] Rect1Vertices = colManager.calculateVertices(cx1, cy1, w1, h1, theta1);
    PVector[] rect2Vertices = colManager.calculateVertices(cx2, cy2, w2, h2, theta2);
    
    // Verificar colisión usando SAT
    boolean collision = colManager.checkSATCollision(Rect1Vertices, rect2Vertices);
    
    // Dibujar rectángulo 1
    drawRectangle(Rect1Vertices);
    
    // Dibujar rectángulo 2
    drawRectangle(rect2Vertices);
    
    // Mostrar resultado de colisión
    fill(0);
    text("Collision: " + collision, 20, 20); 
  } 
}
