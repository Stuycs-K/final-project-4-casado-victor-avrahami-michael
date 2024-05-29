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
    int hexSize = 36;
    
    background(255);
    Game.drawUnplacedPieces(hexSize);
    Game.drawBoard(hexSize);
    Game.drawBorder(hexSize * 4);
    
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
   
