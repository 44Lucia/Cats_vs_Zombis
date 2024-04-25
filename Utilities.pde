class Utilities { //<>//
  float deltaX() {return mouseX - pj.pos.x;}
  float deltaY() {return mouseY - pj.pos.y;}
  float mouseAngle() {return atan2(deltaY(), deltaX());}

  //Overlaping between two intervals
  boolean isOverlaping(float min1, float max1, float min2, float max2) {
    return !(max1 < min2 || max2 < min1);
  }

  void drawRectangle(PVector[] p_vertices) {
    beginShape();
      for(PVector v : p_vertices) {vertex(v.x, v.y);}
    endShape(CLOSE);
  }

  void drawCircle(float p_x, float p_y, float p_radius) {
    push();
      noFill();
      strokeWeight(5);
      stroke(150);
      circle(p_x, p_y, 2 * p_radius);
    pop();
  }
  
  void fps() {println(frameRate);}

  //Interaction helper function
  boolean isMouseOver(float p_x, float p_y, int p_w, int p_h) {
    return (mouseX >= p_x && mouseX <= p_x + p_w && mouseY >= p_y && mouseY <= p_y + p_h);
  }
}
