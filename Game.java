public class Game{
    public GamePiece[][] board;
    public boolean isPlayerOneTurn;
    public GamePiece[] player1Pieces, player2Pieces;
    public Queen player1Queen, player2Queen;

    public Game(){
        player1Pieces = new GamePiece[11];
        player2Pieces = new GamePiece[11];
        //create queens when added into game
        isPlayerOneTurn = true;
        board = new GamePiece[22][22];
    }

    public void setQueen(Queen queen){
        if(isPlayerOneTurn)
            player1Queen = queen;
        else
            player2Queen = queen;
    }

    public void toggleTurn(){
        isPlayerOneTurn = !isPlayerOneTurn;
    }

    public GamePiece[] getNeighbors(int x, int y){
        if(y % 2 == 0){
            return new GamePiece[] {board[x-1][y], board[x][y-1], board[x][y+1], board[x+1][y], board[x-1][y-1], board[x-1][x+1]};
        }
        else{
            return new GamePiece[] {board[x-1][y], board[x][y-1], board[x][y+1], board[x+1][y], board[x+1][y-1], board[x+1][x+1]};
        }
    }

    public int isGameOver(){//0 for false, 1 for p1 queen trapped, 2 for p2 queen trapped, 3 for both trapped
        GamePiece[] queen1Neighbors = getNeighbors(player1Queen.getX(), player1Queen.getY());
        GamePiece[] queen2Neighbors = getNeighbors(player2Queen.getX(), player2Queen.getY());
        boolean queen1Trapped = true;
        for(int i = 0; i < queen1Neighbors.length; i++){
            if(queen1Neighbors[i] == null)
                queen1Trapped = false;
        }
        boolean queen2Trapped = true;
        for(int i = 0; i < queen2Neighbors.length; i++){
            if(queen2Neighbors[i] == null)
                queen2Trapped = false;
        }
        if(queen1Trapped && queen2Trapped)
            return 3;
        if(queen1Trapped)
            return 1;
        if(queen2Trapped)
            return 2;
        return 0;
    }
}