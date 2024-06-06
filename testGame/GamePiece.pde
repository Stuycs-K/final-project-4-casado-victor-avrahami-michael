public abstract class GamePiece{
    private String name;// Idk what its used for tho. It's a useful identifier and can be used in the toString if needed
    private int type;
    private int xLoc, yLoc;
    private boolean OwnedByPlayerOne;
    public GamePiece pieceOnTop;
    private Game game;

    public GamePiece(int type, int x, int y, boolean p1, String name, Game game){
        this.type = type;
        pieceOnTop = null;
        xLoc = x;
        yLoc = y;
        OwnedByPlayerOne = p1;
        this.game = game;
        this.name = name;
    }

    abstract boolean move(int newX, int newY);
    abstract int[][] getLegalMoves();
    abstract boolean isLegalMove(int newX, int newY);
    // no canMove method, needs board access, so needs to be in game class
  
  public String getName(){
    return name;
  }
  
    public Game getGame(){
        return game;
    }

  public int getX(){
    return xLoc;
  }
  
  public int getY(){
    return yLoc;
  }

    public void changeLocation(int newX, int newY){
        xLoc = newX;
        yLoc = newY;
    }
  
  public boolean getTurn(){
    return OwnedByPlayerOne;
  }
  
  public int getType(){
    return type;
  }

    public String toString(){
        return "" + type + "(" + xLoc + "," + yLoc + ")" + "Player 1:" + OwnedByPlayerOne;//placeholder
    }
    
    public void setX(int newX){
      xLoc = newX;
    }
    
    public void setY(int newY){
      yLoc = newY;
    }

}
