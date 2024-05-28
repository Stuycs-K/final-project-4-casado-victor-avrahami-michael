// Every "Object" in this class will eventually be replaced by GamePiece
  final color RED = color(255, 0, 0);
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(0, 0, 255);
  final color YELLOW = color(127, 127, 0);
  final color MAGENTA = color(127, 0, 127);
  final color CYAN = color(0, 127, 127);
  
  Game game; 
  GamePiece[][] gameBoard;
  
  
  void setup(){
    size(1000, 1000);
    background(255);
    game = new Game();
    gameBoard = game.board;
    
    game.addPiece(new Queen(0,0,0,true,"a", game));
    game.addPiece(new Queen(0,0,1,true,"a", game));
    game.addPiece(new Queen(0,1,1,true,"a",game));
    game.addPiece(new Queen(0,2,1,true,"a",game));
    game.addPiece(new Queen(0,3,1,true,"a",game));
    game.addPiece(new Queen(0,3,2,true,"a",game));
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
  void hexagon(float x, float y, float sideLength, GamePiece g) {
    String text = g.getName().substring(0, 1);
    //fill(255, 0, 0);
    int type = 0;
    type = g.getType();
    
    if (type == 0){
      fill(RED);
    }
    if (type == 1){
      fill(GREEN);
    }
    if (type == 2){
      fill(BLUE);
    }
    if (type == 3){
      fill(YELLOW);
    }
    if (type == 4){
      fill(MAGENTA);
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
