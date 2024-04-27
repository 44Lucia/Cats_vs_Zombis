class TreeWall extends Entity {
  PImage treeImage;
  PVector pos;

  TreeWall(float p_x, float p_y) {
    treeImage = loadImage("Tree.png");
    treeImage.resize(55, 70);
    pos = new PVector(p_x,p_y);
    maxHealth = 100;
    health = maxHealth;
    isAlive = true;
    healthBar = new HealthBar(this, p_x, p_y - 10, 50, 5);
  }

  void display() {
    image(treeImage, pos.x, pos.y);
    if(isAlive) {healthBar.display(health, maxHealth);}
  }
}
