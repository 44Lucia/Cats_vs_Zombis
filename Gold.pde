class Gold {
  PVector pos;
  PImage sprite = loadImage("Gold.png");
  
  Gold(float p_x, float p_y) {
    pos = new PVector(p_x, p_y);
  }
  
  void display() {
    image(sprite, pos.x, pos.y, sprite.width / 2, sprite.height / 2);
  }
  
  boolean isMouseOver() {
     return utilities.isMouseOver(pos.x, pos.y, sprite.width, sprite.height);
  }
  
  boolean isCliceked() {return (mousePressed && isMouseOver());}
}
