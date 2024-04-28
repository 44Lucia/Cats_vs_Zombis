class TreeWall extends Entity {
  PImage treeImage;
  PVector pos;
  int gridRow;
  int gridCol;

  TreeWall(float p_x, float p_y, int p_gridRow, int p_gridCol) {
    treeImage = loadImage("Tree.png");
    treeImage.resize(55, 70);
    pos = new PVector(p_x,p_y);
    maxHealth = 100;
    health = maxHealth;
    isAlive = true;
    healthBar = new HealthBar(this, p_x, p_y - 10, 50, 5);
    
    gridRow = p_gridRow;
    gridCol = p_gridCol;
  }

  void display() {
    image(treeImage, pos.x, pos.y);
    if(isAlive) {healthBar.display(health, maxHealth);}
  }
}
