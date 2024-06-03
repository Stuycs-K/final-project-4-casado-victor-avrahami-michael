public class Spider extends GamePiece{
    private String name;
    private int type;
    private boolean OwnedByPlayerOne;

    public Spider(int type, int x, int y, boolean isPlayerOneTurn, String name, Game game){
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
  public int[][] getLegalMoves(){
    int[][] a3 = getGame().findSlidableMoves(this.getX(), this.getY(), 3);
    int[][] a2 = getGame().findSlidableMoves(this.getX(), this.getY(), 2);
    ArrayList<int[]> list = new ArrayList<int[]>();
    for(int i = 0; i < a3.length; i++){ //everything in 3 thats not in 2
      for(int j = 0; j < a2.length; j++){
        if(a3[i][0] != a2[j][0] || a3[i][1] != a2[j][1]){
          list.add(a3[i]);
        }
      }
    }
    int[][] returner = new int[list.size()][2];
    for(int i = 0; i < list.size(); i++){
      returner[i] = list.get(i);
    }
    return returner;
  }

}
