class Utilities { //<>// //<>// //<>//
  float deltaX() {
    return mouseX - pj.pos.x;
  }
  float deltaY() {
    return mouseY - pj.pos.y;
  }
  float mouseAngle() {
    return atan2(deltaY(), deltaX());
  }

  //Overlaping between two intervals
  boolean isOverlaping(float min1, float max1, float min2, float max2) {
    return !(max1 < min2 || max2 < min1);
  }

  void drawRectangle(PVector[] p_vertices) {
    beginShape();
    for (PVector v : p_vertices) {
      vertex(v.x, v.y);
    }
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

  //Interaction helper function
  boolean isMouseOver(float p_x, float p_y, int p_w, int p_h) {
    return (mouseX >= p_x && mouseX <= p_x + p_w && mouseY >= p_y && mouseY <= p_y + p_h);
  }
  
  float distanceToPlayer(PVector p_pos) {
    PVector distance = new PVector();
    distance.x = p_pos.x - pj.pos.x;
    distance.y = p_pos.y - pj.pos.y;

    return sqrt(pow(distance.x, 2) + pow(distance.y, 2));
  }

  PVector getRandomSpawn() {
    float offset = 50;
    PVector spawn;
    int side = int(random(4));
    switch (side) {
    case 0:
      spawn = new PVector(random(-offset, width + offset), -offset);
      break;
    case 1:
      spawn = new PVector (random(-offset, width + offset), height + offset);
      break;
    case 2:
      spawn = new PVector (width + offset, random(-offset, height + offset));
      break;
    case 3:
      spawn = new PVector(-offset, random(-offset, height));
      break;
    default:
      spawn = new PVector(random(width, height), random(width, height));
    }
    return spawn;
  }
}
