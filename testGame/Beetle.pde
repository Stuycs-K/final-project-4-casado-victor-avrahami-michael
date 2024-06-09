public class Beetle extends GamePiece{
    private String name;
    private int type;
    private boolean OwnedByPlayerOne;

    public Beetle(int type, int x, int y, boolean isPlayerOneTurn, String name, Game game){
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
    ArrayList<int[]> locs = new ArrayList<int[]>();
    game.board[this.getX()][this.getY()]  = null;
    int[][] neighbors = game.getNeighborLocations(this.getX(), this.getY());
    for(int[] neighbor : neighbors){
      if(game.board[neighbor[0]][neighbor[1]] != null){
        locs.add(neighbor);
      }
      else if(game.hasPieceNeighbor(neighbor[0], neighbor[1])){
        locs.add(neighbor);
      }
    }
    int[][] returner = new int[locs.size()][2];
    for(int i = 0; i < locs.size(); i++){
      returner[i] = locs.get(i);
    }
    game.board[this.getX()][this.getY()] = this;
    return returner;
  }
    // no canMove method, needs board access, so needs to be in game class

}
