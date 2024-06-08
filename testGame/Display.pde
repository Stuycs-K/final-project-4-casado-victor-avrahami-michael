  import java.util.*;
  public class Display{
    
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
    GamePiece currPiece;
    GamePiece[][] gameBoard;
    Game game;
    int[][] legalMoves;
    
    public Display(Game game){
      this.game = game;
      currPiece = null;
      legalMoves = null;
      gameBoard = game.board;
    }
    
    public void display(){
      background(255);
      drawUnplacedPieces(hexSize);
      drawBoard(hexSize);
      drawBorder(hexSize * 4);
    
      game.displayInfo();
    
      if (game.turnType == 1 && game.canMove(currPiece.getX(), currPiece.getY())){
        for (int[] loc: legalMoves){
          //println(loc[0] + ", " + loc[1]);
        outlineHex(loc[0], loc[1], RED);
      }
    }
  }
