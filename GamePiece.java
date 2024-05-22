public abstract class GamePiece{
    //public String name; Idk what its used for tho
    private int type;
    public int xLoc, yLoc;
    public boolean OwnedByPlayerOne;

    public GamePiece(int type, int x, int y, boolean isPlayerOneTurn){
        this.type = type;
        xLoc = x;
        yLoc = y;
        OwnedByPlayerOne = isPlayerOneTurn;
    }

    abstract boolean move(int newX, int newY);
    abstract boolean isLegalMove(int newX, int newY);
    // no canMove method, needs board access, so needs to be in game class

    public String toString(){
        return "" + type + "(" + xLoc + "," + yLoc + ")" + "Player 1:" + OwnedByPlayerOne;//placeholder
    }

}