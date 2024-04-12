class Gold {
  float x, y;
  PImage sprite;
  
  Gold(float p_x, float p_y) {
    x = p_x;
    y = p_y;
    sprite = loadImage("Gold.png");
  }
  
  void display() {
    image(sprite, x, y, sprite.width / 2, sprite.height / 2);
  }
  
  boolean isCliceked() {
    if (mousePressed && utilities.isMouseOver(x, y, sprite.width, sprite.height)) {
      return true;
    }return false;
  }
}
