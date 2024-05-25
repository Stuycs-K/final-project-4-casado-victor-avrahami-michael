public class Ant extends GamePiece{
    private String name;
    private int type;
    private int xLoc, yLoc;
    private boolean OwnedByPlayerOne;

    public Ant(int type, int x, int y, boolean isPlayerOneTurn, String name){
        super(type, x, y, isPlayerOneTurn, name);
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
		int[][] legalMoves = getLegalMoves();
		for(int i = 0; i < legalMoves.length; i++){
			if(legalMoves[i][0] == newX && legalMoves[i][1] == newY){
				return true;
			}
		}
		return false;
	}
	public int[][] getLegalMoves(){
		return getGame().findSlidableMoves(xLoc, yLoc, 1000); //1000 is just arbitrarily big
	}
    // no canMove method, needs board access, so needs to be in game class

}