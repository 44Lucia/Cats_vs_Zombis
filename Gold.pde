class Gold {
  float x, y;
  PImage sprite = loadImage("Gold.png");
  
  Gold(float p_x, float p_y) {
    x = p_x;
    y = p_y;
  }
  
  void display() {
    image(sprite, x, y, sprite.width / 2, sprite.height / 2);
  }
  
  boolean isMouseOver() {
     return utilities.isMouseOver(x, y, sprite.width, sprite.height);
  }
  
  boolean isCliceked() {return (mousePressed && isMouseOver());}
}
