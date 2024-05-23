public class Spider extends GamePiece{
    private String name;
    private int type;
    private int xLoc, yLoc;
    private boolean OwnedByPlayerOne;

    public Spider(int type, int x, int y, boolean isPlayerOneTurn, String name){
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
		return true;
	}
    // no canMove method, needs board access, so needs to be in game class

}