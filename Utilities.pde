class Utilities {   //<>//
  //Overlaping between two intervals
  boolean isOverlaping(float min1, float max1, float min2, float max2) {return !(max1 < min2 || max2 < min1);}
  
  void drawRectangle(PVector[] vertices) {
    beginShape();
    for (PVector v : vertices) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
  
  //Interaction helper function
  boolean isMouseOver(float p_x, float p_y, int p_w, int p_h) {
    return (mouseX >= p_x && mouseX <= p_x + p_w && mouseY >= p_y && mouseY <= p_y + p_h);
  }
}
