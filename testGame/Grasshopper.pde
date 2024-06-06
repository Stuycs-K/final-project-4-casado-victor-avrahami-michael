import java.util.ArrayList;
public class Grasshopper extends GamePiece{
    private String name;
    private int type;
    private boolean OwnedByPlayerOne;

    public Grasshopper(int type, int x, int y, boolean isPlayerOneTurn, String name, Game game){
        super(type, x, y, isPlayerOneTurn, name, game);
    }

    public boolean move(int newX, int newY){
    if (isLegalMove(newX, newY)){
      changeLocation(newX, newY);
      return true;
    }
    else {
      return false;
    }
  }
    public boolean isLegalMove(int newX, int newY){
    int[][] legalMoves = getLegalMoves();
    for(int i = 0; i < legalMoves.length; i++){
      if(legalMoves[i][0] == newX && legalMoves[i][1] == newY){
        return true;
      }
    }
    return false;
  }

  private int[] getLocationInDirection(int direction){ //if returns -1, -1 then out of board
    if(direction == 0){ //up
      if(this.getX() > 0){
        return new int[] {this.getX() - 1, this.getY()};
      }
      return new int[] {-1, -1};
    }
    if(direction == 1){//up and right
      if(this.getY() % 2 == 0){
        if(this.getX() > 0 && this.getY() < getGame().board[0].length - 1){
          return new int[] {this.getX() - 1, this.getY() + 1};
        }
        return new int[] {-1, -1};
      }
      if(this.getY() < getGame().board[0].length - 1){
        return new int[] {this.getX(), this.getY() + 1};
      }
      return new int[] {-1, -1};
    }
    if(direction == 2){ //down and right
      if(this.getY() % 2 == 1){
        if(this.getX() < getGame().board[0].length - 1 && this.getY() < getGame().board[0].length - 1){
          return new int[] {this.getX() + 1, this.getY() + 1};
        }
        return new int[] {-1, -1};
      }
      if(this.getY() < getGame().board[0].length - 1){
        return new int[] {this.getX(), this.getY() + 1};
      }
      return new int[] {-1, -1};
    }
    if(direction == 3){ //down
      if(this.getX() < getGame().board[0].length - 1){
        return new int[] {this.getX() + 1, this.getY()};
      }
      return new int[] {-1, -1};
    }
    if(direction == 4){ //down and left
      if(this.getY() % 2 == 0){
        if(this.getY() > 0){
          return new int[] {this.getX(), this.getY() - 1};
        }
        return new int[] {-1, -1};
      }
      if(this.getY() > 0 && this.getX() < getGame().board[0].length - 1){
        return new int[] {this.getX() + 1, this.getY() - 1};
      }
      return new int[] {-1, -1};
    }
    if(direction == 5){// up and left
      if(this.getY() % 2 == 1){
        if(this.getY() > 0){
          return new int[] {this.getX(), this.getY() - 1};
        }
        return new int[] {-1, -1};
      }
      if(this.getY() > 0 && this.getX() > 0){
        return new int[] {this.getX() - 1, this.getY() - 1};
      }
      return new int[] {-1, -1};
    }
    return new int[] {-1, -1};
  }
    // no canMove method, needs board access, so needs to be in game class


  public int[][] getLegalMoves(){
    ArrayList<int[]> returner = new ArrayList<int[]>();
    int saveX = this.getX();
    int saveY = this.getY();
    for(int i = 0; i < 6; i = i){
      int[] newLoc = getLocationInDirection(i);
      if(newLoc[0] == -1){
         i++;
      }
      else if(getGame().board[newLoc[0]][newLoc[1]] == null){
        if(game.hasPieceNeighbor(newLoc[0],newLoc[1]))
        returner.add(newLoc);
        i++;
      }
      else{
        changeLocation(newLoc[0], newLoc[1]);
      }
    }
    int[][] returnThis = new int[returner.size()][2];
    for(int i = 0; i < returner.size(); i++){
      returnThis[i] = returner.get(i);
    }
    changeLocation(saveX, saveY);
    return returnThis;
  }

}
