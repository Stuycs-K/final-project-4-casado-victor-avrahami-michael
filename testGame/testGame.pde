  import java.util.*;
  final color GREEN = color(0, 255, 0);
  final color BLUE = color(100, 100, 255);
  final color BLACK = color(0, 0, 0);
  final color WHITE = color(255, 255, 255);
  final color RED = color(255, 0, 0);
  final int QUEENBEE = 0;
  final int SPIDER = 1;
  final int BEETLE = 2;
  final int GRASSHOPPER = 3;
  final int ANT = 4;
  final int hexSize = 36;
  
  Game game; 
  GamePiece[][] gameBoard;
  GamePiece currPiece;
  int[][] legalMoves;
  
  
  void setup(){
    size(1500, 800);
    game = new Game();
  }

  void draw(){   
    game.checkGameOver();
  }
  
  void mouseClicked(){
    
    float x = mouseX;
    float y = mouseY;
    
    //text(currPiece + " " + turnType + " " + "Player's turn: " + game.isPlayerOneTurn + " " + "Placing: " + game.placing, 400, 400);
   

    
    
    
    //delay(1000);
    
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
  
  void outlineHex(float xLoc, float yLoc, color strokeColor){
    float downSet = 0;
      if (yLoc % 2 == 1){
        downSet = hexSize / 2 * sqrt(3);
      }
    float x = 7 * hexSize + hexSize * 1.5 * yLoc;
    float y = 10 + downSet + hexSize * sqrt(3) * xLoc;
    noFill();
    strokeWeight(4);
    stroke(strokeColor);
    beginShape();
    vertex(x, y);
    vertex(x + hexSize, y);
    vertex(x + hexSize * 1.5, y + hexSize / 2 * sqrt(3));
    vertex(x + hexSize, y + hexSize * sqrt(3));
    vertex(x, y + hexSize * sqrt(3));
    vertex(x - hexSize * 0.5, y + hexSize / 2 * sqrt(3));
    vertex(x, y);
    endShape();
    fill(255, 255, 255);
    strokeWeight(1);
    stroke(BLACK);
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
