class TreeWall extends Entity {
  PImage treeImage;
  PVector pos;
  int health;
  int maxHealth;
  boolean alive;
  HealthBar healthBar;

  TreeWall(float p_x, float p_y) {
    treeImage = loadImage("Tree.png");
    treeImage.resize(55, 70);
    pos = new PVector(p_x,p_y);
    maxHealth = 100;
    health = maxHealth;
    alive = true;
    healthBar = new HealthBar(this, p_x, p_y - 10, 50, 5);
  }

  void display() {
    image(treeImage, pos.x, pos.y);
    if(alive) {healthBar.display(health, maxHealth);}
  }

  void takeDamage(int damage) {
    health -= damage;
    if(health <= 0) {alive = false;}
  }
}
