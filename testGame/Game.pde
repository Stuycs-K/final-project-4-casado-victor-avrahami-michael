import java.util.ArrayList;
public class Game{
    public GamePiece[][] board;
    public GamePiece[] player1Pieces, player2Pieces, p1Store, p2Store;
    public GamePiece player1Queen, player2Queen;
    public Display d;
    
    public boolean placing, isPlayerOneTurn;
    public int turnCount, turnType;
    public int placingPieceStoreCoor;
    

    public Game(){
        player1Pieces = new GamePiece[11];
        player2Pieces = new GamePiece[11];
        p1Store = new GamePiece[11];
        p2Store = new GamePiece[11];
        board = new GamePiece[23][23];
        //create queens when added into game
        
        d = new Display(this);
        
        isPlayerOneTurn = true;
        placing = true;
        
        turnCount = 0;
        turnType = 0;

        
        gameSetup();
    }
    
    public void gameSetup(){
      initializePieceStore();
      d.display();
      turnCount++;
    }
    
    public void run(float x, float y){
      boolean earlyExit = false;
      if(nothingLegal()){
        isPlayerOneTurn = !isPlayerOneTurn;
        earlyExit = true;
      }
      if (turnType == 0 && !earlyExit){
        if(turnCount == 7 && player1Queen == null){
          turnType++;
          turnType %= 2;
          placing = true;
          legalMoves = game.getPlacableLocations();
          System.out.println("forcing you to place a queen as it is your fourth turn");
          currPiece = game.getUnplacedPiece(18,18,hexSize);
        }
        else if(turnCount == 8 && player2Queen == null){
          turnType++;
          turnType %= 2;
          placing = true;
          legalMoves = game.getPlacableLocations();
          System.out.println("forcing you to place a queen as it is your fourth turn");
          currPiece = game.getUnplacedPiece(90,20,hexSize);
        }
        else{
          GamePiece successfulAction = findAction(x, y, hexSize);                
          currPiece = successfulAction;
        
          if (currPiece != null && ((successfulAction.getTurn() && isPlayerOneTurn) || ! (successfulAction.getTurn() || isPlayerOneTurn))){
            turnType++;
            turnType %= 2;
            if (! placing){
              legalMoves = currPiece.getLegalMoves();
              if(legalMoves.length == 0 || canMove(currPiece.getX(), currPiece.getY()) == false){
                turnType++;
                turnType %= 2;
              }
            }
            else {
              legalMoves = getPlacableLocations();
              if(legalMoves.length == 0 && turnCount > 2){
                turnType++;
                turnType %= 2;              
                if(isPlayerOneTurn){
                  p1Store[placingPieceStoreCoor] = currPiece;
                }
                else{
                  p2Store[placingPieceStoreCoor] = currPiece;
                }
              }
            }
          }
        }
      }
      else if (!earlyExit){
        int[] whereToGo = getPlacedLocation(x, y, hexSize);
        if (whereToGo != null){
          boolean successfulAction = false;
          if (placing){
            if (addPiece(currPiece, whereToGo[0], whereToGo[1])){
              successfulAction = true;
            }
          }
          else {
            if (movePiece(currPiece, whereToGo[0], whereToGo[1])){
              successfulAction = true;
            }
          }
          if (successfulAction){
            turnType++;
            turnType %= 2;
            toggleTurn();
            turnCount++;
          }
          else{
            turnType++;
            turnType %= 2;
            if(placing){
              if(isPlayerOneTurn){
                p1Store[placingPieceStoreCoor] = currPiece;
              }
              else{
                p2Store[placingPieceStoreCoor] = currPiece;
              }
            }
          }
        }
      }
      d.display();
    }
    
    public boolean checkGameOver(){
      if (player1Queen != null && player2Queen != null){
        int gameOver = game.isGameOver();
        if (gameOver > 0){
          game.endGame(gameOver);
          return true;
        }
      }
      return false;
    }
    
    public void print2DArray(GamePiece[][] t){
      for (int i = 0; i < t.length; i++){
        for (int j = 0; j < t[i].length; j++){
          print(t[i][j] + ", ");
        }
        println();
      }
      println();
    }
    
    public void print2DArray(boolean[][] t){
      for (int i = 0; i < t.length; i++){
        for (int j = 0; j < t[i].length; j++){
          print(t[i][j] + ", ");
        }
        println();
      }
      println();
    }
    
    public void print2DArray(int[][] t){
      for (int i = 0; i < t.length; i++){
        for (int j = 0; j < t[i].length; j++){
          print(t[i][j] + ", ");
        }
        println();
      }
      println();
    }
    
    public void print2DArray(ArrayList<int[]> t){
      for (int i = 0; i < t.size(); i++){
        for (int j = 0; j < t.get(i).length; j++){
          print(t.get(i)[j] + ", ");
        }
        println();
      }
      println();
    }

    public float[] boardToProcessingCoors(int x, int y){
          int h = 36;
          float downSet = 0;
          if (y % 2 == 1){
            downSet =  (h / 2 * sqrt(3));
          }
          return new float[] {7 * h + h * 1.5 * y + 18, 10 + downSet + h * sqrt(3) * y + 30};
    }
    
    public boolean movePiece(GamePiece g, int moveX, int moveY){
      //println("You're moving a piece!");
      //println("You called movePiece: " + g.getX() + ", " + g.getY());
      if((isPlayerOneTurn && player1Queen == null) || (!isPlayerOneTurn && player2Queen == null)){
        return false;
      }
      if(g.getType() == BEETLE){
        if(g.pieceBelow != null){//on top of something
          if(g.isLegalMove(moveX, moveY)){
            if(board[moveX][moveY] != null){
              GamePiece piece = board[moveX][moveY];
              while(piece.pieceOnTop != null){
                piece = piece.pieceOnTop;
              }
              g.pieceBelow.pieceOnTop = null;
              g.pieceBelow = piece;
              piece.pieceOnTop = g;
              g.changeLocation(moveX, moveY);
              return true;
            }
            board[moveX][moveY] = g;
            g.pieceBelow.pieceOnTop = null;
            g.pieceBelow = null;
            g.changeLocation(moveX, moveY);  
            return true;
          }
          return false;
        }
        
        
        
        if(g.isLegalMove(moveX, moveY)){
          if(board[moveX][moveY] != null){
            GamePiece piece = board[moveX][moveY];
            while(piece.pieceOnTop != null){
              piece = piece.pieceOnTop;
            }
            g.pieceBelow = piece;
            piece.pieceOnTop = g;
            board[g.getX()][g.getY()] = null;
            g.changeLocation(moveX, moveY);
            return true;
          }
          board[moveX][moveY] = g;
          board[g.getX()][g.getY()] = null;
          g.changeLocation(moveX, moveY);  
          return true;
        }
        return false;
      }
      
      board[g.getX()][g.getY()] = null;
      if(!isHiveConnected()){
        //println("The hive was not connected :(");
        board[g.getX()][g.getY()] = g;
        return false;
      }
      if(g.isLegalMove(moveX, moveY)){
        //println("Successful move?!");
        board[moveX][moveY] = g;
        g.changeLocation(moveX, moveY);
        return true;
      }
      board[g.getX()][g.getY()] = g;
      //println("Not a legal move for other reasons");
      return false;
    }
    
    public boolean addPiece(GamePiece g, int placeX, int placeY){
      boolean canPlace = isLegalPlacement(placeX, placeY);
      if (! canPlace){
        //println("can't place");
      }
      if(canPlace){
        g.changeLocation(placeX, placeY);
        if(g.getType() == 0){
          if(isPlayerOneTurn)
            player1Queen = g;
          else
            player2Queen = g;
        }
        addPiece(g);
        return true;
      }
      return false;
    }
 
    
    public GamePiece getUnplacedPiece(float x, float y, int hexSize){
      int xBound1 = hexSize / 2;
          if (! isPlayerOneTurn){
            xBound1 += 2 * hexSize;
          }
          int xBound2 = xBound1 + hexSize;
          if (x >= xBound1 && x <= xBound2){
            int currY = 10;
            int currPiece = 0;
        
            while (! (y >= currY && y <= currY + hexSize * sqrt(3))){
              currY += 2 * hexSize;
              currPiece++;
              if (currPiece > 12){
                return null;
              }
            }
          
            if (isPlayerOneTurn){
              GamePiece g = p1Store[currPiece];
              if (g == null){
                return null;
              }
              p1Store[currPiece] = null;
              placingPieceStoreCoor = currPiece;
              return g;
            }
            else {
              GamePiece g = p2Store[currPiece];
              if (g == null){
                return null;
              }
              p2Store[currPiece] = null;
              placingPieceStoreCoor = currPiece;
              return g;
            }
           
           // text(y + " " + currY + " " + currPiece + " ", 500, 500);
         }
         return null;
    }
    
    public int[] getPlacedLocation(float x, float y, int hexSize){
      int currX = 7 * hexSize;
        int col = 0;
        while (! (x >= currX && x <= currX + hexSize)){
          currX += 1.5 * hexSize;
          col++;
          if (col > 23){
            return null;
          }
        }
        
        int currY = 10;
        
        if (col % 2 != 0){
          currY += hexSize / 2 * sqrt(3);
        }
        
        int row = 0;
        
        while (! (y >= currY && y <= currY + hexSize * sqrt(3))){
          row ++;
          currY += hexSize * sqrt(3);
          if (row > 23){
            return null;
          }
        }
        //movePiece(board[row][col]);
        
        //println(row + " " + col);
        return new int[]{row, col};
        
        //text("x: " + x + " currX: " + currX + " currY: " + currY + " y: " + y + " " + row + " " + col, 500, 500);
    }
      
    
    public GamePiece findAction(float x, float y, int hexSize){
      if (x > 150){
        int[] coords = getPlacedLocation(x, y, hexSize);
        placing = false;
        if(coords == null)
          return null;
        GamePiece returner = board[coords[0]][coords[1]];
        if (returner == null){
          return null;
        }
        while(returner.pieceOnTop != null){
          returner = returner.pieceOnTop;
        }
        return returner;
      }
      else {
        placing = true;
        return getUnplacedPiece(x, y, hexSize);
      }
    }
      
    
    public void initializePieceStore(){
      p1Store[0] = new Queen(0, 0, 0, true, "Queen", this);
      p2Store[0] = new Queen(0, 0, 0, false, "Queen", this);
      
      p1Store[1] = new Spider(1, 0, 0, true, "Spider", this);
      p2Store[1] = new Spider(1, 0, 0, false, "Spider", this);
      
      p1Store[2] = new Spider(1, 0, 0, true, "Spider", this);
      p2Store[2] = new Spider(1, 0, 0, false, "Spider", this);
      
      p1Store[3] = new Beetle(2, 0, 0, true, "Beetle", this);
      p2Store[3] = new Beetle(2, 0, 0, false, "Beetle", this);
      
      p1Store[4] = new Beetle(2, 0, 0, true, "Beetle", this);
      p2Store[4] = new Beetle(2, 0, 0, false, "Beetle", this);
      
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
    


    public void addPiece(GamePiece piece){
        int x = piece.getX();
        int y = piece.getY();
        if(isPlayerOneTurn){
            for(int i = 0; i < player1Pieces.length; i++){
                if(player1Pieces[i] == null){
                    player1Pieces[i] = piece;
                    i = player1Pieces.length;
                }
            }
        }
        else{
            for(int i = 0; i < player2Pieces.length; i++){
                if(player2Pieces[i] == null){
                    player2Pieces[i] = piece;
                    i = player2Pieces.length;
                }
            }
        }
        board[x][y] = piece;
    }

    public void toggleTurn(){
        isPlayerOneTurn = !isPlayerOneTurn;
    }

    public GamePiece[] getNeighbors(int x, int y){
        int[][] locs = getNeighborLocations(x, y);
        GamePiece[] g = new GamePiece[locs.length];
        
        for (int i = 0; i < locs.length; i++){
          int[] loc = locs[i];
          g[i] = board[loc[0]][loc[1]];
        }
        //println(Arrays.toString(g));
        return g;
        
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
        int[] start;
        if(!isPlayerOneTurn)
        start = new int[] {player1Pieces[0].getX(), player1Pieces[0].getY()}; //this piece has to exist if a piece exists
        else
        start = new int[] {player2Pieces[0].getX(), player2Pieces[0].getY()};
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
        beenIn[startX][startY] = true;
        a.add(new int[]{startX, startY});
        
        findSlidableMoves(startX, startY, stepNum, a, beenIn, 0);
        //println(a);
        
        a.remove(0);
        int[][] returner = new int[a.size()][2]; 
        for(int i = 0; i < a.size(); i++){
            returner[i] = a.get(i);
        }
        board[startX][startY] = temp;
        return returner;
    }

    private void findSlidableMoves(int startX, int startY, int stepNum, ArrayList<int[]> returnThis, boolean[][] beenIn, int numToStartFrom){
        if(stepNum != 0){
          int nextNumToStartFrom = numToStartFrom;
          int origSize = returnThis.size();
          for (int i = numToStartFrom; i < origSize; i++){
            //println(returnThis.get(i)[0] + " " + returnThis.get(i)[1]);
            findNextSlidableMoves(returnThis.get(i)[0], returnThis.get(i)[1], returnThis, beenIn);
            nextNumToStartFrom++;
          }
          //print2DArray(returnThis);
          findSlidableMoves(startX, startY, stepNum - 1, returnThis, beenIn, nextNumToStartFrom);  
        }
    }
    
    private void findNextSlidableMoves(int startX, int startY, ArrayList<int[]> returnThis, boolean[][] beenIn){
      int[][] neighbors = getNeighborLocations(startX, startY);
        for (int[] pos: neighbors){
          int x = pos[0];
          int y = pos[1];
          if (board[x][y] == null && hasPieceNeighbor(x, y)){
            if (!beenIn[x][y] && canPhysicallySlideToDist1(startX, startY, x, y)){
              beenIn[x][y] = true;
              returnThis.add(new int[]{x, y});
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
    
    public boolean canMove(int x, int y){     
      if(board[x][y] != null && board[x][y].pieceOnTop != null){
        GamePiece piece = board[x][y];
        GamePiece pieceSave = piece;
        while(piece.pieceOnTop != null){
          piece = piece.pieceOnTop;
        }
        if(pieceSave.getTurn() == piece.getTurn()){
          return true;
        }
        return false;
      }
      GamePiece temp = board[x][y];
      board[x][y] = null;
      boolean returner = isHiveConnected();
      board[x][y] = temp;
      return returner;
    }
    
    public int[][] getPlacableLocations(){
      ArrayList<int[]> spots = new ArrayList<int[]>();
      if(isPlayerOneTurn){
         for(int i = 0; i < player1Pieces.length; i++){
         if(player1Pieces[i] != null){
           int[][] neighbors = getNeighborLocations(player1Pieces[i].getX(), player1Pieces[i].getY());
           for(int j = 0; j < neighbors.length; j++){
             if(board[neighbors[j][0]][neighbors[j][1]] == null){
               int[][] neighborNeighbors = getNeighborLocations(neighbors[j][0],neighbors[j][1]);
               boolean hasNoOpponentNeighbors = true;
               for(int k = 0; k < neighborNeighbors.length; k++){
                 GamePiece piece = board[neighborNeighbors[k][0]][neighborNeighbors[k][1]];
                 if(piece != null){
                   while(piece.pieceOnTop != null){
                     piece = piece.pieceOnTop;
                   }
                   if(!piece.getTurn()){
                     hasNoOpponentNeighbors = false;
                   }
                 }
               }
               if(hasNoOpponentNeighbors)
                 spots.add(neighbors[j]);
             }
           }
         }
         }
         int[][] returner = new int[spots.size()][2];
         for(int i = 0; i < spots.size(); i++){
           returner[i] = spots.get(i);
         }
         return returner;
      }
      else{
         for(int i = 0; i < player2Pieces.length; i++){
         if(player2Pieces[i] != null){
           int[][] neighbors = getNeighborLocations(player2Pieces[i].getX(), player2Pieces[i].getY());
           for(int j = 0; j < neighbors.length; j++){
             if(board[neighbors[j][0]][neighbors[j][1]] == null){
               int[][] neighborNeighbors = getNeighborLocations(neighbors[j][0],neighbors[j][1]);
               boolean hasNoOpponentNeighbors = true;
               for(int k = 0; k < neighborNeighbors.length; k++){
                 GamePiece piece = board[neighborNeighbors[k][0]][neighborNeighbors[k][1]];
                 if(piece != null){
                   while(piece.pieceOnTop != null){
                     piece = piece.pieceOnTop;
                   }
                   if(piece.getTurn()){
                     hasNoOpponentNeighbors = false;
                   }
                 }
               }
               if(hasNoOpponentNeighbors)
                 spots.add(neighbors[j]);
             }
           }
         }
         }
         int[][] returner = new int[spots.size()][2];
         for(int i = 0; i < spots.size(); i++){
           returner[i] = spots.get(i);
         }
         return returner;
      }
    }
    
    public boolean isLegalPlacement(int x, int y){
      if (turnCount <= 1){
        return true;
      }
      if (turnCount == 2){
        return hasPieceNeighbor(x, y);
      }
      int[][] places = getPlacableLocations();
      for(int i = 0; i < places.length; i++){
        if(places[i][0] == x && places[i][1] == y){
          return true;
        }
      }
      return false;
    }
    
    public void endGame(int trapped){
      String endText = "The game has ended. Player ";
      if (trapped == 1){
        endText += "2\'s queen is trapped and they lose the game. Player 1 is victorious.";
      }
      if (trapped == 2){
        endText += "1\'s queen is trapped and they lose the game. Player 2 is victorious.";
      }
      
      if (trapped == 3){
        endText += "1 and 2\'s queens are both trapped and the game ends in a draw.";
      }
      d.textBox(endText, width / 2 - 200, height / 2 - 100, 400, 12); //12 is textSize
    }

  private boolean nothingLegal(){
    if(turnCount <= 2){
      return false;
    }
    GamePiece[] pieces;
    if(isPlayerOneTurn){
      pieces = player1Pieces;
    }
    else{
      pieces = player2Pieces;
    }
    for(GamePiece piece : pieces){
      if(piece != null && piece.getLegalMoves().length != 0 && canMove(piece.getX(), piece.getY())){
        return false;
      }
    }
    if(isPlayerOneTurn){
      pieces = p1Store;
    }
    else{
      pieces = p2Store;
    }
    if(getPlacableLocations().length != 0 && pieces.length != 0){
      return false;
    }
    return true;
  }
  
}
