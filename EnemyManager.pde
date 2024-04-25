class EnemyManager {

  ArrayList<Torch> torches;
  ArrayList<Tnt> tnts;
  ArrayList<Barry> barries;

  EnemyManager() {
    torches = new ArrayList<Torch>();
    tnts = new ArrayList<Tnt>();
    barries = new ArrayList<Barry>();
  }

  void update() {
    for (int i = 0; i < torches.size(); i++)
      torches.get(i).update();

    for (int i = 0; i < tnts.size(); i++)
      tnts.get(i).update();

    for (int i = 0; i < barries.size(); i++)
      barries.get(i).update();
  }

  void display() {
    for (int i = 0; i < torches.size(); i++) {
      torches.get(i).display();
    }

    for (int i = 0; i < tnts.size(); i++) {
      tnts.get(i).display();
    }

    for (int i = 0; i < barries.size(); i++) {
      barries.get(i).display();
    }
  }

  void enemyWave(int torches, int tnts, int barries) {

    float spawnX, spawnY;
    float randomAngle;
    float hipotenusa = sqrt(pow(width / 2, 2) + pow(height / 2, 2));

    for (int i = 0; i < torches; i++) {
      randomAngle = random(TWO_PI);
      spawnX = width / 2 + hipotenusa * cos(randomAngle);
      spawnY = height / 2 + hipotenusa * sin(randomAngle);
      this.torches.add(new Torch(spawnX, spawnY));
    }

    for (int i = 0; i < tnts; i++) {
      randomAngle = random(TWO_PI);
      spawnX = width / 2 + hipotenusa * cos(randomAngle);
      spawnY = height / 2 + hipotenusa * sin(randomAngle);
      this.tnts.add(new Tnt(spawnX, spawnY));
    }

    for (int i = 0; i < barries; i++) {
      randomAngle = random(TWO_PI);
      spawnX = width / 2 + hipotenusa * cos(randomAngle);
      spawnY = height / 2 + hipotenusa * sin(randomAngle);
      this.barries.add(new Barry(spawnX, spawnY));
    }
  }
}
