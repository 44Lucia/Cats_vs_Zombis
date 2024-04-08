class CollisionManager {
  
  
  
  //ROTATED RECTANGLES COLLISIONS with Separating Axis Theorem (SAT)
  boolean checkSATCollision(PVector[] vertices1, PVector[] vertices2) {
    // Obtenemos los ejes perpendiculares a los lados de los rectángulos
    PVector[] axes = getAxes(vertices1);
    PVector[] axes2 = getAxes(vertices2);
    
    // Comprobamos solapamiento en cada eje, si alguno no se solapa, no hay colisión
    //Rectangulo 1
    for (PVector axis : axes) {
      float[] proj1 = projectToAxis(vertices1, axis);
      float[] proj2 = projectToAxis(vertices2, axis);
      
      if (!utilities.isOverlap(proj1[0], proj1[1], proj2[0], proj2[1])) {
        return false; // No hay solapamiento en este eje, por lo tanto no hay colisión
      }
    } 
    //Rectangulo 2
    for (PVector axis : axes2) {
      float[] proj1 = projectToAxis(vertices1, axis);
      float[] proj2 = projectToAxis(vertices2, axis);
      
      if (!utilities.isOverlap(proj1[0], proj1[1], proj2[0], proj2[1])) {return false;}
    }
    
    return true;
  }

  // Función para obtener ejes perpendiculares a los lados de un rectángulo (normalizados)
  PVector[] getAxes(PVector[] vertices) {
    PVector[] axes = new PVector[vertices.length];
    
    for (int i = 0; i < vertices.length; i++) {
      PVector p1 = vertices[i];
      PVector p2 = vertices[(i + 1) % vertices.length];
      PVector edge = PVector.sub(p2, p1);
      PVector normal = new PVector(-edge.y, edge.x);
      axes[i] = normal.normalize();
    }
    
    return axes;
  }
  
  // Función para proyectar un conjunto de vértices en un eje y obtener el intervalo de proyección 
  // Lo usamos para comprobar si los ejes se están solapando
  float[] projectToAxis(PVector[] vertices, PVector axis) {
    float minProjection = PVector.dot(vertices[0], axis);
    float maxProjection = minProjection;
    
    for (PVector vertex : vertices) {
      float projection = PVector.dot(vertex, axis);
      if (projection < minProjection) {
        minProjection = projection;
      } else if (projection > maxProjection) {
        maxProjection = projection;
      }
    }
    
    return new float[] { minProjection, maxProjection };
  }
  
  // Función para calcular vértices de un rectángulo rotado
  PVector[] calculateVertices(float cx, float cy, float w, float h, float theta) {
    PVector[] vertices = new PVector[4];
    float cosTheta = cos(theta);
    float sinTheta = sin(theta);
    
    // Calcular las coordenadas de los vértices
    vertices[0] = new PVector(cx + w/2 * cosTheta - h/2 * sinTheta, cy + w/2 * sinTheta + h/2 * cosTheta);
    vertices[1] = new PVector(cx - w/2 * cosTheta - h/2 * sinTheta, cy - w/2 * sinTheta + h/2 * cosTheta);
    vertices[2] = new PVector(cx - w/2 * cosTheta + h/2 * sinTheta, cy - w/2 * sinTheta - h/2 * cosTheta);
    vertices[3] = new PVector(cx + w/2 * cosTheta + h/2 * sinTheta, cy + w/2 * sinTheta - h/2 * cosTheta);
    
    return vertices;
  }
  
  //CONSERVAR PARA TESTEO
  void satTest() {
  // Definir rectángulo 1
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
  PVector[] Rect1Vertices = calculateVertices(cx1, cy1, w1, h1, theta1);
  PVector[] rect2Vertices = calculateVertices(cx2, cy2, w2, h2, theta2);
  
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
