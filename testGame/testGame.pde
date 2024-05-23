
  int[][] gameBoard;

  void setup(){
    size(1000, 1000);
    background(255);
    gameBoard = new int[22][22];
  }

  void draw(){
    drawBoard(20);
    //hexagon(10, 10, 10);
  }
  
  void drawBoard(int hexSideLength){
    int h = hexSideLength;
    for (int i = 0; i < gameBoard.length; i++){
      for (int j = 0; j < gameBoard[i].length; j++){
        float downSet = 0;
        if (j % 2 == 1){
          downSet = h / 2 * sqrt(3);
        }
        hexagon(h + h * 1.5 * j, h + downSet + h * sqrt(3) * i, h);
      }
    }
  }
  
  // x and y represent top left vertex of hexagon
  void hexagon(float x, float y, float sideLength) {
    fill(255, 0, 0);
    beginShape();
    vertex(x, y);
    vertex(x + sideLength, y);
    vertex(x + sideLength * 1.5, y + sideLength / 2 * sqrt(3));
    vertex(x + sideLength, y + sideLength * sqrt(3));
    vertex(x, y + sideLength * sqrt(3));
    vertex(x - sideLength * 0.5, y + sideLength / 2 * sqrt(3));
    vertex(x, y);
    endShape();
  }
