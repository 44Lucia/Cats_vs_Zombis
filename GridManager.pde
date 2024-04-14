class GridManager {
  //Grid
  final int rows; // Número de filas en la cuadrícula
  final int cols; // Número de columnas en la cuadrícula
  final int cellSize; // Tamaño de cada celda de la cuadrícula
  int[][] grid; // Matriz que representa la cuadrícula
  boolean[][] ocupedCells; // Matriz que registra las casillas ocupadas
  int selectedRow;
  int selectedCol;
  ArrayList<TreeWall> treeList;
  
  boolean gridLocked;
  int lockDuration; 
  int lastLockTime;
  
  boolean selectedTree;
  boolean selectedMine;
  boolean selectedArcher;
  
  GridManager() {
    rows = 15;
    cols = 15;
    cellSize = 64;
    selectedRow = -1;
    selectedCol = -1;
    lockDuration = 500;
    lastLockTime = 0;
    
    grid = new int[rows][cols];
    ocupedCells = new boolean[rows][cols];
    treeList = new ArrayList<TreeWall>();
    
    selectedTree = false;
    selectedMine = false;
    selectedArcher = false;
    gridLocked = false;
    
     // Initializes the grid with default values (0 for empty spaces)
     for (int i = 0; i < rows; i++) {
       for (int j = 0; j < cols; j++) { grid[i][j] = 0; }
     }
  }
  
   void update() {     
     if (gridLocked && millis() - lastLockTime >= lockDuration) { gridLocked = false; }
     for(TreeWall tree : treeList) { tree.display(); }
     
     if(isClicked){
       checkItemToInsert();
       gridManagement();
     }
   }

   void display(){
     // Draw the grid
     for (int i = 0; i < rows; i++) {
       for (int j = 0; j < cols; j++) {
         strokeWeight(1);
         noFill();
         rect(j * cellSize, i * cellSize, cellSize, cellSize);
         // Cambia el color de la celda seleccionada
         if (i == selectedRow && j == selectedCol) {
           strokeWeight(2);
           //fill(0, 255, 0); // Color verde
           rect(j * cellSize, i * cellSize, cellSize, cellSize);     
         }
         // Dibuja un marcador si la casilla está ocupada
         if (ocupedCells[i][j]) {
           strokeWeight(1);
           fill(255, 0, 0); // Color rojo
           ellipse(j * cellSize + cellSize/2, i * cellSize + cellSize/2, cellSize/2, cellSize/2);
         }
       }
     }
   }
  
   void gridManagement(){
     // Calcula la fila y columna seleccionadas en función de la posición del ratón
     int row = mouseY / cellSize;
     int col = mouseX / cellSize;
     // Verifica si la celda seleccionada está dentro de los límites de la cuadrícula
     if (row >= 0 && row < rows && col >= 0 && col < cols) {
       // Verifica si la casilla está ocupada
       if (!ocupedCells[row][col] && !gridLocked && canPlaceItems()) {
         // Marca la casilla como ocupada y seleccionada
         ocupedCells[row][col] = true;
         selectedRow = row;
         selectedCol = col;
         if(selectedTree){
           treeList.add(new TreeWall(col * cellSize + 6, row * cellSize - 2));
           pj.money -= 50;
           selectedTree = false;
         }else if (selectedMine){
           pj.money -= 100;
           selectedMine = false;
         }
       }
     }
  }
  
  void checkItemToInsert(){
    if(ui.treeButton.isMouseOver()){
      if (!gridLocked) { gridLocked = true; lastLockTime = millis(); }
      selectedTree = true;
    }else if (ui.goldButton.isMouseOver()){
      if (!gridLocked) { gridLocked = true; lastLockTime = millis(); }
      selectedMine = true;
    }
  }
  
  boolean canPlaceItems(){ return selectedMine || selectedTree || selectedArcher; }
}
