  Game game; 
  final int hexSize = 36;
  GamePiece currPiece = null;
  int[][] legalMoves = null;
  
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
    
    game.run(x, y);
  }
  
  
