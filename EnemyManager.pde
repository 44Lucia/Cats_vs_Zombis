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

    PVector spawnPos;

    for (int i = 0; i < torches; i++) {
      spawnPos = utilities.getRandomSpawn();
      this.torches.add(new Torch(spawnPos));
    }

    for (int i = 0; i < tnts; i++) {
      spawnPos = utilities.getRandomSpawn();
      this.tnts.add(new Tnt(spawnPos));
    }

    for (int i = 0; i < barries; i++) {
      spawnPos = utilities.getRandomSpawn();
      this.barries.add(new Barry(spawnPos));
    }
  }
}
