class GridManager {
  //Grid
  final int rows; // Número de filas en la cuadrícula
  final int cols; // Número de columnas en la cuadrícula
  final int cellSize; // Tamaño de cada celda de la cuadrícula
  int[][] grid; // Matriz que representa la cuadrícula
  boolean[][] ocuped; // Matriz que registra las casillas ocupadas
  int selectedRow;
  int selectedCol;
  
  GridManager() {
    rows = 18;
    cols = 18;
    cellSize = 50;
    selectedRow = -1;
    selectedCol = -1;
    
    grid = new int[rows][cols];
    ocuped = new boolean[rows][cols];
  }
  
   void update() {
     displayGrid();
     if(isClicked){
       gridManagement();
     }
   }
   
   void display(){
     // Inicializa la cuadrícula con valores predeterminados (0 para espacios vacíos)
     for (int i = 0; i < rows; i++) {
       for (int j = 0; j < cols; j++) { grid[i][j] = 0; }
     }
   }
   
   void displayGrid(){
     // Dibuja la cuadrícula
     for (int i = 0; i < rows; i++) {
       for (int j = 0; j < cols; j++) {
         stroke(0);
         noFill();
         rect(j * cellSize, i * cellSize, cellSize, cellSize);
         // Cambia el color de la celda seleccionada
         if (i == selectedRow && j == selectedCol) {
           fill(0, 255, 0); // Color verde
           rect(j * cellSize, i * cellSize, cellSize, cellSize);     
         }
         // Dibuja un marcador si la casilla está ocupada
         if (ocuped[i][j]) {
           fill(255, 0, 0); // Color rojo
           ellipse(j * cellSize + cellSize/2, i * cellSize + cellSize/2, cellSize/2, cellSize/2);
         }
       }
     }
      
     // Muestra las coordenadas de la celda seleccionada
     fill(0);
     textSize(20);
     text("Fila: " + selectedRow + ", Columna: " + selectedCol, 10, 30);
   }
  
   void gridManagement(){
     // Calcula la fila y columna seleccionadas en función de la posición del ratón
     int row = mouseY / cellSize;
     int col = mouseX / cellSize;
     // Verifica si la celda seleccionada está dentro de los límites de la cuadrícula
     if (row >= 0 && row < rows && col >= 0 && col < cols) {
       // Verifica si la casilla está ocupada
       if (!ocuped[row][col]) {
         // Marca la casilla como ocupada y seleccionada
         ocuped[row][col] = true;
         selectedRow = row;
         selectedCol = col;
       }
     }
  }
}
