import java.util.ArrayList;
public class Grasshopper extends GamePiece{
    private String name;
    private int type;
    private int xLoc, yLoc;
    private boolean OwnedByPlayerOne;

    public Grasshopper(int type, int x, int y, boolean isPlayerOneTurn, String name, Game game){
        super(type, x, y, isPlayerOneTurn, name, game);
    }

    public boolean move(int newX, int newY){
    if (isLegalMove(newX, newY)){
      xLoc = newX;
      yLoc = newY;
      return true;
    }
    else {
      return false;
    }
  }
    public boolean isLegalMove(int newX, int newY){
    return true;
  }

  private int[] getLocationInDirection(int direction){ //if returns -1, -1 then out of board
    if(direction == 0){ //up
      if(xLoc > 0){
        return new int[] {xLoc - 1, yLoc};
      }
      return new int[] {-1, -1};
    }
    if(direction == 1){//up and right
      if(yLoc % 2 == 0){
        if(xLoc > 0 && yLoc < getGame().board[0].length - 1){
          return new int[] {xLoc - 1, yLoc + 1};
        }
        return new int[] {-1, -1};
      }
      if(yLoc < getGame().board[0].length - 1){
        return new int[] {xLoc, yLoc + 1};
      }
      return new int[] {-1, -1};
    }
    if(direction == 2){ //down and right
      if(yLoc % 2 == 1){
        if(xLoc < getGame().board[0].length - 1 && yLoc < getGame().board[0].length - 1){
          return new int[] {xLoc + 1, yLoc + 1};
        }
        return new int[] {-1, -1};
      }
      if(yLoc < getGame().board[0].length - 1){
        return new int[] {xLoc, yLoc + 1};
      }
      return new int[] {-1, -1};
    }
    if(direction == 3){ //down
      if(xLoc < getGame().board[0].length - 1){
        return new int[] {xLoc + 1, yLoc};
      }
      return new int[] {-1, -1};
    }
    if(direction == 4){ //down and left
      if(yLoc % 2 == 0){
        if(yLoc > 0){
          return new int[] {xLoc, yLoc - 1};
        }
        return new int[] {-1, -1};
      }
      if(yLoc > 0 && xLoc < getGame().board[0].length - 1){
        return new int[] {xLoc + 1, yLoc - 1};
      }
      return new int[] {-1, -1};
    }
    if(direction == 5){// up and left
      if(yLoc % 2 == 1){
        if(yLoc > 0){
          return new int[] {xLoc, yLoc - 1};
        }
        return new int[] {-1, -1};
      }
      if(yLoc > 0 && xLoc > 0){
        return new int[] {xLoc - 1, yLoc - 1};
      }
      return new int[] {-1, -1};
    }
    return new int[] {-1, -1};
  }
    // no canMove method, needs board access, so needs to be in game class


  public int[][] getLegalMoves(){
    ArrayList<int[]> returner = new ArrayList<int[]>();
    int saveX = xLoc;
    int saveY = yLoc;
    for(int i = 0; i < 6; i = i){
      int[] newLoc = getLocationInDirection(i);
      if(getGame().board[newLoc[0]][newLoc[1]] == null){
        returner.add(newLoc);
        i++;
      }
      else{
        xLoc = newLoc[0];
        yLoc = newLoc[1];
      }
    }
    int[][] returnThis = new int[returner.size()][2];
    for(int i = 0; i < returner.size(); i++){
      returnThis[i] = returner.get(i);
    }
    return returnThis;
  }

}
