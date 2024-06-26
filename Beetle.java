public class Beetle extends GamePiece{
    private String name;
    private int type;
    private int xLoc, yLoc;
    private boolean OwnedByPlayerOne;

    public Beetle(int type, int x, int y, boolean isPlayerOneTurn, String name, Game game){
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
    // no canMove method, needs board access, so needs to be in game class

}