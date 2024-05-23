// Every "Object" in this class will eventually be replaced by GamePiece
  Object[][] gameBoard;
  
  final color RED = color(255, 0, 0);
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(0, 0, 255);
  final color YELLOW = color(127, 127, 0);
  final color MAGENTA = color(127, 0, 127);
  final color CYAN = color(0, 127, 127);

  void setup(){
    size(1000, 1000);
    background(255);
    gameBoard = new Object[22][22];
  }

  void draw(){
    drawBoard(20);
    //hexagon(10, 10, 10);
  }
  
  void drawBoard(int hexSideLength){
    int h = hexSideLength;
    for (int i = 0; i < gameBoard.length; i++){
      for (int j = 0; j < gameBoard[i].length; j++){
        if (gameBoard[i][j] != null){
          float downSet = 0;
          if (j % 2 == 1){
            downSet = h / 2 * sqrt(3);
          }
          hexagon(h + h * 1.5 * j, h + downSet + h * sqrt(3) * i, h, gameBoard[i][j]);
        }
      }
    }
  }
  
  // x and y represent top left vertex of hexagon
  void hexagon(float x, float y, float sideLength, Object g) {
    String text = "";
    //fill(255, 0, 0);
    int type = 0;
    /* WHEN g is GAMEPIECE UNCOMMENT THIS!!! 
       type = g.getType();*/
    if (type == 0){
      fill(RED);
      text = "?";
    }
    if (type == 1){
      fill(GREEN);
      text = "?";
    }
    if (type == 2){
      fill(BLUE);
      text = "?";
    }
    if (type == 3){
      fill(YELLOW);
      text = "?";
    }
    if (type == 4){
      fill(MAGENTA);
      text = "?";
    }
    text(text, x + sideLength / 2, y + sideLength / 2 * sqrt(3));
    
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
