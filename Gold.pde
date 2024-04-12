class Gold {
  float x, y;
  PImage img;
  
  Gold(float x, float y) {
    this.x = x;
    this.y = y;
    this.img = loadImage("Gold.png");
  }
  
  void display() {
    image(img, x, y, img.width / 2, img.height / 2);
  }
  
  boolean isCliceked() {
    if (mousePressed && mouseX > x && mouseX < x + img.width / 2 && mouseY > y && mouseY < y + img.height / 2) {
      return true;
    }return false;
  }
}
