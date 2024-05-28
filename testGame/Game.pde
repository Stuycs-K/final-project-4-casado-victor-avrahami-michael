import java.util.ArrayList;
public class Game{
    public GamePiece[][] board;
    public boolean isPlayerOneTurn;
    public GamePiece[] player1Pieces, player2Pieces, p1Store, p2Store;
    public Queen player1Queen, player2Queen;

    public Game(){
        player1Pieces = new GamePiece[11];
        player2Pieces = new GamePiece[11];
        p1Store = new GamePiece[11];
        p2Store = new GamePiece[11];
        //create queens when added into game
        isPlayerOneTurn = true;
        board = new GamePiece[22][22];
        initializePieceStore();
    }
    
    public void choosePiece(int x, int y){
      String prompt = "Player ";
      if (isPlayerOneTurn){
        prompt += "1";
      }
      else {
        prompt += "2";
      }
      prompt += "\'s turn. Choose a piece to add or move.";
      text(prompt, 100, height - 100);
      
    }
    
    public void initializePieceStore(){
      p1Store[0] = new Queen(0, 0, 0, true, "Queen", this);
      p2Store[0] = new Queen(0, 0, 0, false, "Queen", this);
      
      p1Store[1] = new Spider(1, 0, 0, true, "Spider", this);
      p2Store[1] = new Spider(1, 0, 0, false, "Spider", this);
      
      p1Store[2] = new Spider(1, 0, 0, true, "Spider", this);
      p2Store[2] = new Spider(1, 0, 0, false, "Spider", this);
      
     // p1Store[3] = new Beetle(2, 0, 0, true, "Beetle", this);
     // p2Store[3] = new Beetle(2, 0, 0, false, "Beetle", this);
      
     // p1Store[4] = new Beetle(2, 0, 0, true, "Beetle", this);
     // p2Store[4] = new Beetle(2, 0, 0, false, "Beetle", this);
      
      p1Store[5] = new Grasshopper(3, 0, 0, true, "Grasshopper", this);
      p2Store[5] = new Grasshopper(3, 0, 0, false, "Grasshopper", this);
      
      p1Store[6] = new Grasshopper(3, 0, 0, true, "Grasshopper", this);
      p2Store[6] = new Grasshopper(3, 0, 0, false, "Grasshopper", this);
      
      p1Store[7] = new Grasshopper(3, 0, 0, true, "Grasshopper", this);
      p2Store[7] = new Grasshopper(3, 0, 0, false, "Grasshopper", this);
      
      p1Store[8] = new Ant(4, 0, 0, true, "Ant", this);
      p2Store[8] = new Ant(4, 0, 0, false, "Ant", this);
      
      p1Store[9] = new Ant(4, 0, 0, true, "Ant", this);
      p2Store[9] = new Ant(4, 0, 0, false, "Ant", this);
      
      p1Store[10] = new Ant(4, 0, 0, true, "Ant", this);
      p2Store[10] = new Ant(4, 0, 0, false, "Ant", this);
      
    }
    
    public void addQueen(Queen queen){
        if(isPlayerOneTurn)
            player1Queen = queen;
        else
            player2Queen = queen;
        addPiece(queen);
    }

    public void addPiece(GamePiece piece){
        int x = piece.getX();
        int y = piece.getY();
        if(isPlayerOneTurn){
            for(int i = 0; i < player1Pieces.length; i++){
                if(player1Pieces[i] == null){
                    player1Pieces[i] = piece;
                }
            }
        }
        else{
            for(int i = 0; i < player2Pieces.length; i++){
                if(player2Pieces[i] == null){
                    player2Pieces[i] = piece;
                }
            }
        }
        board[x][y] = piece;
    }

    public void toggleTurn(){
        isPlayerOneTurn = !isPlayerOneTurn;
    }

    public GamePiece[] getNeighbors(int x, int y){
        if(y % 2 == 0){
            if(x > 0 && y > 0)
            return new GamePiece[] {board[x-1][y], board[x][y-1], board[x][y+1], board[x+1][y], board[x-1][y-1], board[x-1][y+1]};
            if(x > 0)
            return new GamePiece[] {board[x-1][y], board[x][y+1], board[x+1][y], board[x-1][y+1]};
            if(y > 0)
            return new GamePiece[] {board[x][y-1], board[x][y+1], board[x+1][y]};
            return new GamePiece[] {board[x][y+1], board[x+1][y]};



        }
        else{
            if(x > 0 && y > 0)
            return new GamePiece[] {board[x-1][y], board[x][y-1], board[x][y+1], board[x+1][y], board[x+1][y-1], board[x+1][y+1]};
            if(x > 0)
            return new GamePiece[] {board[x-1][y], board[x][y+1], board[x+1][y], board[x+1][y+1]};
            if(y > 0)
            return new GamePiece[] {board[x][y-1], board[x][y+1], board[x+1][y], board[x+1][y-1], board[x+1][y+1]};
            return new GamePiece[] {board[x][y+1], board[x+1][y], board[x+1][y+1]};
        }
    }


    public int[][] getNeighborLocations(int x, int y){
        if(y % 2 == 0){
            if(x > 0 && y > 0)
            return new int[][] {{x-1,y}, {x,y-1}, {x, y+1}, {x+1, y}, {x-1,y-1}, {x-1,y+1}};
            if(x > 0)
            return new int[][] {{x-1,y}, {x, y+1}, {x+1, y}, {x-1,y+1}};
            if(y > 0)
            return new int[][] {{x,y-1}, {x, y+1}, {x+1, y}};
            return new int[][] {{x, y+1}, {x+1, y}};
        }
        else{
            if(x > 0 && y > 0)
            return new int[][] {{x-1,y}, {x,y-1}, {x, y+1}, {x+1, y}, {x+1,y-1}, {x+1,y+1}};
            if(x > 0)
            return new int[][] {{x-1,y}, {x, y+1}, {x+1, y}, {x+1,y+1}};
            if(y > 0)
            return new int[][] {{x,y-1}, {x, y+1}, {x+1, y}, {x+1,y-1}, {x+1,y+1}};
            return new int[][] {{x, y+1}, {x+1, y}, {x+1,y+1}};
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

    public boolean isHiveConnected(){
        //searches through array to make sure that hive is intact
        //will be called after removing a piece from the board to make sure it can move

        if (player1Pieces[0] == null) {
            return true; //no pieces on board
        }
        int[] start = new int[] {player1Pieces[0].getX(), player1Pieces[0].getY()}; //this piece has to exist if a piece exists
        boolean[][] visited = new boolean[board.length][board[0].length]; //check if a square has been "found"

        search(start, visited); //makes all connections possible from start

        for(int i = 0; i < board.length; i++){
            for (int j = 0; j < board[0].length; j++){ //make sure all pieces have been found
                if(board[i][j] != null && !visited[i][j]){
                    return false;
                }
            }
        }
        return true;
    }

    private void search(int[] start, boolean[][] visited){
        visited[start[0]][start[1]] = true;
        int[][] neighbors = getNeighborLocations(start[0], start[1]);
        for(int i = 0; i < neighbors.length; i++){
            if(board[neighbors[i][0]][neighbors[i][1]] != null && !visited[neighbors[i][0]][neighbors[i][1]]){
                search(new int[] {neighbors[i][0], neighbors[i][1]}, visited);
            }
        }
    }

    public int[][] findSlidableMoves(int startX, int startY, int stepNum){
        ArrayList<int[]> a= new ArrayList<int[]>();
        GamePiece temp = board[startX][startY];
        board[startX][startY] = null; // so we dont try to move onto ourselves
        boolean[][] beenIn = new boolean[board.length][board[0].length];
        findSlidableMoves(startX, startY, stepNum, a, beenIn, true);
        int[][] returner = new int[a.size()][2]; 
        for(int i = 0; i < a.size(); i++){
            returner[i] = a.get(i);
        }
        board[startX][startY] = temp;
        return returner;
    }

    private void findSlidableMoves(int startX, int startY, int stepNum, ArrayList<int[]> returnThis, boolean[][] beenIn, boolean isFirst){
        if(stepNum != 0){
            int[][] neighbors = getNeighborLocations(startX, startY);
            for(int[] pos: neighbors){
                if(board[pos[0]][pos[1]] == null && hasPieceNeighbor(pos[0], pos[1])){ //empty space w piece neighbor
                    //need to see if we can fit through there
                    if(!beenIn[pos[0]][pos[1]] && canPhysicallySlideToDist1(startX, startY, pos[0], pos[1])){
                        beenIn[pos[0]][pos[1]] = true;
                        if(!isFirst){ //you cant move to where you already are
                            returnThis.add(pos);
                        }
                        findSlidableMoves(pos[0], pos[1], stepNum - 1, returnThis, beenIn, false);
                    }
                }
            }
        }
    }

    public boolean hasPieceNeighbor(int x, int y){
        GamePiece[] neighbors = getNeighbors(x, y);
        for(int i = 0; i < neighbors.length; i++){
            if(neighbors[i] != null)
                return true;
        }
        return false;
    }

    //we only ask it to slide one tile with this method
    //too hard to call exception so just be careful when calling it
    private boolean canPhysicallySlideToDist1(int startX, int startY, int endX, int endY){
        //one of their mutual neighbors must be empty
        int[][] startNeighbors = getNeighborLocations(startX, startY);
        int[][] endNeighbors = getNeighborLocations(endX, endY);
        for(int i = 0; i < startNeighbors.length; i++){
            for(int j = 0; j < endNeighbors.length; j++){
                if(startNeighbors[i][0] == endNeighbors[j][0] && startNeighbors[i][1] == endNeighbors[j][1]){ //mutual neighbor
                    if(board[startNeighbors[i][0]][startNeighbors[i][1]] == null){ //empty
                        return true;
                    }
                }
            }
        }
        return false;
    }
}
