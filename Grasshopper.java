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

	public int[] getLocationInDirection(int direction){ //if returns -1, -1 then out of board
		if(direction == 0){ //up
			if(xLoc > 0){
				return new int[] {xLoc - 1, yLoc};
			}
			return new int[] {-1, -1};
		}
		if(direction == 1){//up and right
			if(y % 2 == 0){
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
			if(y % 2 == 1){
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
			if(y % 2 == 0){
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
			if(y % 2 == 1){
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

}