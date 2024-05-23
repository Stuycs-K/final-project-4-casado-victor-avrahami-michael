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

    public GamePiece[] getNeighbors(int x, int y){
        if(y % 2 == 0){
            return new GamePiece[] {board[x-1][y], board[x][y-1], board[x][y+1], board[x+1][y], board[x-1][y-1], board[x-1][x+1]};
        }
        else{
            return new GamePiece[] {board[x-1][y], board[x][y-1], board[x][y+1], board[x+1][y], board[x+1][y-1], board[x+1][x+1]};
        }
    }

    public boolean isGameOver(){
        GamePiece[] queen1Neighbors = getNeighbors(player1Queen.getX(), player1Queen.get(Y));
        GamePiece[] queen2Neighbors = getNeighbors(player2Queen.getX(), player2Queen.get(Y));
    }
}