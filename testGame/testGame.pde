// Every "Object" in this class will eventually be replaced by GamePiece
  final color RED = color(255, 0, 0);
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(0, 0, 255);
  final color YELLOW = color(127, 127, 0);
  final color MAGENTA = color(127, 0, 127);
  final color CYAN = color(0, 127, 127);
  final color BLACK = color(0, 0, 0);
  final color WHITE = color(255, 255, 255);
  
  Game game; 
  GamePiece[][] gameBoard;
  
  
  void setup(){
    size(1000, 800);
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
    
  }
  
  void mouseClicked(){
    int x = mouseX;
    int y = mouseY;
    
    background(255);
    drawUnplacedPieces(36);
    drawBoard(36);
    
    boolean successfulAction = game.makeAction(x, y); // This will return true if a piece is added or moved, and false otherwise;
    
    if (successfulAction){
      game.toggleTurn();
    }
    
    promptUser();
  }
  
  public void promptUser(){
      String prompt = "Player ";
      if (game.isPlayerOneTurn){
        prompt += "1";
      }
      else {
        prompt += "2";
      }
      prompt += "\'s turn. Choose a piece to add or move.";
      text(prompt, 300, height - 100);
      
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
          hexagon(5 * h + h * 1.5 * j, h + downSet + h * sqrt(3) * i, h, gameBoard[i][j]);
        }
      }
    }
  }
  
  void drawUnplacedPieces(int hexSideLength){
    int h = hexSideLength;
    for (int i = 0; i < game.p1Store.length; i++){
      if (game.p1Store[i] != null){
        hexagon(10, (2 * i + 0.5) * h, h, game.p1Store[i]);
      }
      if (game.p2Store[i] != null){
        hexagon(10 + 2 * h, (2 * i + 0.5) * h, h, game.p2Store[i]);
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
    
    beginShape();
    vertex(x, y);
    vertex(x + sideLength, y);
    vertex(x + sideLength * 1.5, y + sideLength / 2 * sqrt(3));
    vertex(x + sideLength, y + sideLength * sqrt(3));
    vertex(x, y + sideLength * sqrt(3));
    vertex(x - sideLength * 0.5, y + sideLength / 2 * sqrt(3));
    vertex(x, y);
    endShape();
    
    fill(BLACK);
    text(text, x + sideLength / 2, y + sideLength / 2 * sqrt(3));
  }
