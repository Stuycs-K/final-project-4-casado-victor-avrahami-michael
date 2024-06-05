  import java.util.*;
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(100, 100, 255);
  final color BLACK = color(0, 0, 0);
  final color WHITE = color(255, 255, 255);
  final int QUEENBEE = 0;
  final int SPIDER = 1;
  final int BEETLE = 2;
  final int GRASSHOPPER = 3;
  final int ANT = 4;
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
    
    game.displayInfo();
    game.turnCount++;
  }
  
  void printDebug(){
    fill(WHITE);
    rect(width - 250, 0, 150, 150);
    fill(BLACK);
    text("DEBUG INFO", width - 240, 20);
    text("isTurnOne: " + game.isPlayerOneTurn, width - 240, 30);
    text("isPlacing: " + game.placing, width - 240, 40);
    text("CurrPiece: " + currPiece, width - 240, 50);
    text("Turn: " + game.turnCount, width - 240, 60);
    text("Turntype: " + turnType, width - 240, 70);
  }

  void draw(){
    //println("HI");
    
    //printDebug();
    
    if (game.turnCount >= 9){
      int gameOver = game.isGameOver();
      if (gameOver > 0){
        background(255);
        drawUnplacedPieces(hexSize);
        drawBoard(hexSize);
        drawBorder(hexSize * 4);
        game.endGame(gameOver);
       // rect(300, 300, 200, 200);
       // text("GAME OVER", 400, 400);
      }
    }
  }
  
  void mouseClicked(){
    
    float x = mouseX;
    float y = mouseY;
    
    //text(currPiece + " " + turnType + " " + "Player's turn: " + game.isPlayerOneTurn + " " + "Placing: " + game.placing, 400, 400);
   

    
    if (turnType == 0){
      if(game.turnCount == 7 && game.player1Queen == null){
        turnType++;
        turnType %= 2;
        game.placing = true;
        System.out.println("forcing you to place a queen as it is your fourth turn");
        currPiece = game.getUnplacedPiece(18,18,hexSize);
      }
      else if(game.turnCount == 8 && game.player2Queen == null){
        turnType++;
        turnType %= 2;
        game.placing = true;
        System.out.println("forcing you to place a queen as it is your fourth turn");
        currPiece = game.getUnplacedPiece(90,20,hexSize);
      }
      else{
        GamePiece successfulAction = game.findAction(x, y, hexSize);                
        currPiece = successfulAction;
        
        if (successfulAction != null && ((successfulAction.getTurn() && game.isPlayerOneTurn) || ! (successfulAction.getTurn() || game.isPlayerOneTurn))){
          turnType++;
          turnType %= 2;
        }
      }
    }
    else{
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
        else{
          turnType++;
          turnType %= 2;
          if(game.placing){
            if(game.isPlayerOneTurn){
              game.p1Store[game.placingPieceStoreCoor] = currPiece;
            }
            else{
              game.p2Store[game.placingPieceStoreCoor] = currPiece;
            }
          }
        }
      }
    }
    
    background(255);
    drawUnplacedPieces(hexSize);
    drawBoard(hexSize);
    drawBorder(hexSize * 4);
    
    outlineHex(currPiece.
    
    game.displayInfo();
    
    //text(currPiece + " " + turnType + " " + game.isPlayerOneTurn, 400, 400);
  }
  
  public void drawBorder(int xLoc){
    fill(BLACK);
    rect(xLoc, 0, 10, height);
  }
  
    
  
  void drawBoard(int hexSideLength){
    int h = hexSideLength;
    for (int i = 0; i < 12; i++){
      for (int j = 0; j < gameBoard[i].length; j++){
          float downSet = 0;
          if (j % 2 == 1){
            downSet = h / 2 * sqrt(3);
          }
          hexagon(7 * h + h * 1.5 * j, 10 + downSet + h * sqrt(3) * i, h, gameBoard[i][j]);
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
  
  void outlineHex(float x, float y, float sideLength, color strokeColor){
    float x = 7 * hexSize + hexSize * 1.5 * currPiece.getX();
    7 * h + h * 1.5 * j, 10 + downSet + h * sqrt(3) * i
    noFill();
    stroke(strokeColor);
    beginShape();
    vertex(x, y);
    vertex(x + sideLength, y);
    vertex(x + sideLength * 1.5, y + sideLength / 2 * sqrt(3));
    vertex(x + sideLength, y + sideLength * sqrt(3));
    vertex(x, y + sideLength * sqrt(3));
    vertex(x - sideLength * 0.5, y + sideLength / 2 * sqrt(3));
    vertex(x, y);
    endShape();
    fill(255, 255, 255);
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
