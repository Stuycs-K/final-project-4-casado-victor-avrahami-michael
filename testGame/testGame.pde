  Game game; 
  final int hexSize = 36;
  GamePiece currPiece = null;
  int[][] legalMoves = null;
  boolean gameEnded = false;
  final int QUEENBEE = 0;
  final int SPIDER = 1;
  final int BEETLE = 2;
  final int GRASSHOPPER = 3;
  final int ANT = 4;
  
  void setup(){
    size(1500, 800);
    game = new Game();
  }

  void draw(){
    if (! gameEnded){
      gameEnded = game.checkGameOver();
    }
  }
  
  void mouseClicked(){
    
    float x = mouseX;
    float y = mouseY;
    
    game.run(x, y);
  }
  
  void keyPressed(){
    if(key == 'r' || key == 'R'){
      game = new Game();
    }
  }
 
