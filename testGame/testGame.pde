  final color RED = color(255, 0, 0);
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(0, 0, 255);
  final color YELLOW = color(127, 127, 0);
  final color MAGENTA = color(127, 0, 127);
  final color CYAN = color(0, 127, 127);
  final color BLACK = color(0, 0, 0);
  final color WHITE = color(255, 255, 255);
  final int hexSize = 36;
  
  Game game; 
  GamePiece[][] gameBoard;
  int turnType = 0;
  GamePiece currPiece;
  
  
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
    
    background(255);
    drawUnplacedPieces(hexSize);
    drawBoard(hexSize);
    drawBorder(hexSize * 4);
    promptUser();
  }

  void draw(){
  }
  
  void mouseClicked(){
    float x = mouseX;
    float y = mouseY;
    
    text(currPiece + " " + turnType + " " + game.isPlayerOneTurn, 400, 400);
    
    
    
    if (turnType == 0){
        GamePiece successfulAction = game.findAction(x, y, hexSize); // This will return true if a piece is added or moved, and false otherwise;
        
        
        currPiece = successfulAction;
        
        if (successfulAction != null){
          turnType++;
          turnType %= 2;
        }
    }
    else {
      int[] whereToGo = game.getPlacedLocation(x, y, hexSize);
      if (whereToGo != null){
        
        currPiece.setX(whereToGo[0]);
        currPiece.setY(whereToGo[1]);
        if (game.placing){
          game.addPiece(currPiece);
        }
        else {
          //movePiece(whereToGo[0], whereToGo[1]);
        }
        turnType++;
        turnType %= 2;
        game.toggleTurn();
      }
    }
    
    background(255);
    drawUnplacedPieces(hexSize);
    drawBoard(hexSize);
    drawBorder(hexSize * 4);
    promptUser();
    
    text(currPiece + " " + turnType + " " + game.isPlayerOneTurn, 400, 400);
  }
  
  public void drawBorder(int xLoc){
    fill(BLACK);
    rect(xLoc, 0, 10, height);
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
          hexagon(5 * h + h * 1.5 * j, 10 + downSet + h * sqrt(3) * i, h, gameBoard[i][j]);
        }
      }
    }
  }
  
  void drawUnplacedPieces(int hexSideLength){
    int h = hexSideLength;
    for (int i = 0; i < game.p1Store.length; i++){
      if (game.p1Store[i] != null){
        hexagon(h / 2, 10 + 2 * i * h, h, game.p1Store[i]);
      }
      if (game.p2Store[i] != null){
        hexagon(h / 2 + 2 * h, 10 + 2 * i * h, h, game.p2Store[i]);
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
    image(findImage(g), x+ sideLength / 2 - 20, y + sideLength / 2 * sqrt(3) - 20, 20, 20);
  }
  
  PImage findImage(GamePiece g){
    if(g.type == 0){ // Queen
      return loadImage("../images/bee.png");
    }
    return loadImage("../images/ant.png");
  }
