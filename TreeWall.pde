class TreeWall extends Entity {
  boolean flipped;
  int gridRow;
  int gridCol;

  TreeWall(float p_x, float p_y, int p_gridRow, int p_gridCol) {
    
    animations = new Animations(loadImage("Tree.png"), 0, 55, 70);
    flipped = random(1) == 1;
    animations.spriteSheet.resize(55, 70);
    pos = new PVector(p_x,p_y);
    maxHealth = 100;
    health = maxHealth;
    isAlive = true;
    healthBar = new HealthBar(this, p_x, p_y - 10, 50, 5);
    
    gridRow = p_gridRow;
    gridCol = p_gridCol;
  }

  void display() {
    animations.play(0, int(pos.x) + animations.spriteWidth / 2, int(pos.y) + animations.spriteHeight / 2, flipped);
    if(isAlive) {healthBar.display(health, maxHealth);}
  }
}
