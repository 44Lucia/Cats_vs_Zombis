class EnemyManager {
  PVector waveEnemies;
  ArrayList<Torch> torches; //vector x
  ArrayList<Tnt> tnts; //vector y
  ArrayList<Barry> barries; //vector z
  
  boolean isSpawning;
  PVector spawnedEnemies;

  EnemyManager() {
    torches = new ArrayList<Torch>();
    tnts = new ArrayList<Tnt>();
    barries = new ArrayList<Barry>();
    waveEnemies = new PVector(1,1,1);
    spawnedEnemies = new PVector();
  }

  void update() {
    
    for (int i = 0; i < torches.size(); i++) {torches.get(i).update();}
    for (int i = 0; i < tnts.size(); i++) {tnts.get(i).update();}
    for (int i = 0; i < barries.size(); i++) {barries.get(i).update();}
  }

  void display() {
    for (int i = 0; i < torches.size(); i++) {torches.get(i).display();}
    for (int i = 0; i < tnts.size(); i++) {tnts.get(i).display();}
    for (int i = 0; i < barries.size(); i++) {barries.get(i).display();}
  }

  void spawnWave() {
    PVector spawnPos;

    for (int i = 0; i < waveEnemies.x; i++) {
      spawnPos = utilities.getRandomSpawn();
      torches.add(new Torch(spawnPos));
    }

    for (int i = 0; i < waveEnemies.y; i++) {
      spawnPos = utilities.getRandomSpawn();
      tnts.add(new Tnt(spawnPos));
    }

    for (int i = 0; i < waveEnemies.z; i++) {
      spawnPos = utilities.getRandomSpawn();
      barries.add(new Barry(spawnPos));
    }
    
    waveEnemies.x++;
  }
}
