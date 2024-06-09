  Game game; 
  final int hexSize = 36;
  GamePiece currPiece = null;
  int[][] legalMoves = null;
  boolean gameEnded = false;
  
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
  
  
