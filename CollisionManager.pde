class CollisionManager {
  //ROTATED RECTANGLES COLLISIONS with Separating Axis Theorem (SAT)
  boolean checkSATCollision(PVector[] p_vertices1, PVector[] p_vertices2) {
    // Obtenemos los ejes perpendiculares a los lados de los rectángulos
    PVector[] axes = getAxes(p_vertices1);
    PVector[] axes2 = getAxes(p_vertices2);
    
    // Comprobamos solapamiento en cada eje, si alguno no se solapa, no hay colisión
    //Rectangulo 1
    for(PVector axis : axes) {
      float[] proj1 = projectToAxis(p_vertices1, axis);
      float[] proj2 = projectToAxis(p_vertices2, axis);
      
      // No hay solapamiento en este eje, por lo tanto no hay colisión
      if(!utilities.isOverlaping(proj1[0], proj1[1], proj2[0], proj2[1])) {return false;}
    }
    //Rectangulo 2
    for(PVector axis : axes2) {
      float[] proj1 = projectToAxis(p_vertices1, axis);
      float[] proj2 = projectToAxis(p_vertices2, axis);
      
      if(!utilities.isOverlaping(proj1[0], proj1[1], proj2[0], proj2[1])) {return false;}
    }
    
    return true;
  }

  // Función para obtener ejes perpendiculares a los lados de un rectángulo (normalizados)
  PVector[] getAxes(PVector[] p_vertices) {
    PVector[] axes = new PVector[p_vertices.length];
    
    for(int i = 0; i < p_vertices.length; i++) {
      PVector p1 = p_vertices[i];
      PVector p2 = p_vertices[(i + 1) % p_vertices.length];
      PVector edge = PVector.sub(p2, p1);
      PVector normal = new PVector(-edge.y, edge.x);
      axes[i] = normal.normalize();
    }
    
    return axes;
  }
  
  // Función para proyectar un conjunto de vértices en un eje y obtener el intervalo de proyección 
  // Lo usamos para comprobar si los ejes se están solapando
  float[] projectToAxis(PVector[] p_vertices, PVector p_axis) {
    float minProjection = PVector.dot(p_vertices[0], p_axis);
    float maxProjection = minProjection;
    
    for(PVector vertex : p_vertices) {
      float projection = PVector.dot(vertex, p_axis);
      if(projection < minProjection) {minProjection = projection;}
      else if(projection > maxProjection) {maxProjection = projection;}
    }
    
    return new float[] {minProjection, maxProjection};
  }
  
  // Función para calcular vértices de un rectángulo rotado
  PVector[] calculateVertices(float p_x, float p_y, float p_w, float p_h, float p_angle) {
    PVector[] vertices = new PVector[4];
    float cosAngle = cos(p_angle);
    float sinAngle = sin(p_angle);
    
    // Calcular las coordenadas de los vértices
    vertices[0] = new PVector(p_x + p_w/2 * cosAngle - p_h/2 * sinAngle, p_y + p_w/2 * sinAngle + p_h/2 * cosAngle);
    vertices[1] = new PVector(p_x - p_w/2 * cosAngle - p_h/2 * sinAngle, p_y - p_w/2 * sinAngle + p_h/2 * cosAngle);
    vertices[2] = new PVector(p_x - p_w/2 * cosAngle + p_h/2 * sinAngle, p_y - p_w/2 * sinAngle - p_h/2 * cosAngle);
    vertices[3] = new PVector(p_x + p_w/2 * cosAngle + p_h/2 * sinAngle, p_y + p_w/2 * sinAngle - p_h/2 * cosAngle);
    
    return vertices;
  }
}
