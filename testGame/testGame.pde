  import java.util.*;
  final color RED = color(255, 0, 0);
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(0, 0, 255);
  final color YELLOW = color(127, 127, 0);
  final color MAGENTA = color(127, 0, 127);
  final color CYAN = color(0, 127, 127);
  final color BLACK = color(0, 0, 0);
  final color WHITE = color(255, 255, 255);
  final int QUEENBEE = 0;
  final int ANT = 1;
  final int BEETLE = 2;
  final int GRASSHOPPER = 3;
  final int SPIDER = 4;
  final int hexSize = 36;
  
  Game game; 
  GamePiece[][] gameBoard;
  int turnType = 0;
  GamePiece currPiece;
  
  
  void setup(){
    size(1500, 800);
    background(255);
    game = new Game();
    gameBoard = game.board;
    
    background(255);
    drawUnplacedPieces(hexSize);
    drawBoard(hexSize);
    drawBorder(hexSize * 4);
    promptUser();
  }

  void draw(){
    //println("HI");
    fill(WHITE);
    rect(width - 150, 0, 150, 150);
    fill(BLACK);
    text("DEBUG INFO", width - 140, 20);
    text("isTurnOne: " + game.isPlayerOneTurn, width - 140, 30);
    text("isPlacing: " + game.placing, width - 140, 40);
    text("CurrPiece: " + currPiece, width - 140, 50);
    text("Turn: " + game.turnCount, width - 140, 60);
    text("Turntype: " + turnType, width - 140, 70);
  }
  
  void mouseClicked(){
    
    float x = mouseX;
    float y = mouseY;
    
    //text(currPiece + " " + turnType + " " + "Player's turn: " + game.isPlayerOneTurn + " " + "Placing: " + game.placing, 400, 400);
    
    if (game.turnCount >= 8){
      int gameOver = game.isGameOver();
      if (gameOver > 0){
        game.endGame(gameOver);
      }
    }
    
    if (turnType == 0){
        GamePiece successfulAction = game.findAction(x, y, hexSize); // This will return true if a piece is added or moved, and false otherwise;
        
        
        currPiece = successfulAction;
        
        if (successfulAction != null && ((successfulAction.getTurn() && game.isPlayerOneTurn) || ! (successfulAction.getTurn() || game.isPlayerOneTurn))){
          turnType++;
          turnType %= 2;
        }
    }
    else {
      int[] whereToGo = game.getPlacedLocation(x, y, hexSize);
      if (whereToGo != null){
        
        boolean successfulAction = false;
        if (game.placing){
          if (game.addPiece(currPiece, whereToGo[0], whereToGo[1])){
            successfulAction = true;
          }
        }
        else {
          if (game.movePiece(currPiece, whereToGo[0], whereToGo[1])){
            successfulAction = true;
          }
        }
        if (successfulAction){
          turnType++;
          turnType %= 2;
          game.toggleTurn();
          game.turnCount++;
        }
      }
    }
    
    background(255);
    drawUnplacedPieces(hexSize);
    drawBoard(hexSize);
    drawBorder(hexSize * 4);
    promptUser();
    
    //text(currPiece + " " + turnType + " " + game.isPlayerOneTurn, 400, 400);
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
          float downSet = 0;
          if (j % 2 == 1){
            downSet = h / 2 * sqrt(3);
          }
          hexagon(5 * h + h * 1.5 * j, 10 + downSet + h * sqrt(3) * i, h, gameBoard[i][j]);
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
    if (g != null){
      String text = g.getName().substring(0, 1);
      //fill(255, 0, 0);
      boolean player1 = g.getTurn();
    
      if (player1){
        fill(GREEN);
      }
      else{
        fill(BLUE);
      }
    }
    else {
      fill(WHITE);
      stroke(BLACK);
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
    
    if (g != null){
      fill(BLACK);
      image(findImage(g), x+ sideLength / 2 - 45, y + sideLength / 2 * sqrt(3) - 40, 100, 100);
    }
  }
  
  PImage findImage(GamePiece g){
    if(g.type == QUEENBEE){ // Queen
      return loadImage("../images/bee.png");
    }
    if(g.type == ANT){
      return loadImage("../images/ant.png");
    }
    if(g.type == GRASSHOPPER){
      return loadImage("../images/grasshopper.png");
    }
    if(g.type == SPIDER){
      return loadImage("../images/spider.png");
    }
    if(g.type == BEETLE){
      return loadImage("../images/beetle.png");
    }
    throw new IllegalArgumentException();
  }
