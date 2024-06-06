import java.util.ArrayList;
public class Game{
    public GamePiece[][] board;
    public boolean isPlayerOneTurn;
    public GamePiece[] player1Pieces, player2Pieces, p1Store, p2Store;
    public GamePiece player1Queen, player2Queen;
    public boolean placing;
    public int turnCount;
    public int placingPieceStoreCoor;
    public int turnType = 0;

    public Game(){
        player1Pieces = new GamePiece[11];
        player2Pieces = new GamePiece[11];
        p1Store = new GamePiece[11];
        p2Store = new GamePiece[11];
        //create queens when added into game
        isPlayerOneTurn = true;
        placing = true;
        board = new GamePiece[23][23];
        turnCount = 0;
        initializePieceStore();
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
        
        
        return new int[]{row, col};
        
        //text("x: " + x + " currX: " + currX + " currY: " + currY + " y: " + y + " " + row + " " + col, 500, 500);
    }
      
    
    public GamePiece findAction(float x, float y, int hexSize){
      if (x > 150){
        int[] coords = getPlacedLocation(x, y, hexSize);
        placing = false;
        if(coords == null)
          return null;
        return (board[coords[0]][coords[1]]);
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
        findSlidableMoves(startX, startY, stepNum, a);
        for(int i = 0; i < a.size(); i++){
          if(a.get(i)[0] == startX && a.get(i)[1] == startY){
            a.remove(i);
          }
        }
        //print2DArray(a);
        //print2DArray(board);
        ArrayList<int[]> aNoRepeats = new ArrayList<int[]>();
        
        for(int i = 0; i < a.size(); i++){
          boolean repeat = false;
          for (int j = 0; j < aNoRepeats.size(); j++){
            if (aNoRepeats.get(j)[0] == a.get(i)[0] && aNoRepeats.get(j)[1] == a.get(i)[1]){
              repeat = true;
            }
          }
          if (! repeat){
            aNoRepeats.add(a.get(i));
          }
        }
        
        int[][] returner = new int[aNoRepeats.size()][2];
        
        for (int i = 0; i < returner.length; i++){
          returner[i] = aNoRepeats.get(i);
        }
        
        board[startX][startY] = temp;
        //println("Startx: " + startX + "  Starty: " + startY + "  Stepnum: " + stepNum);
        //print2DArray(returner);
        return returner;
    }

    private void findSlidableMoves(int startX, int startY, int stepNum, ArrayList<int[]> returnThis){
       // println("x: " + startX + " y: " + startY + " stepnum: " + stepNum);
       // print2DArray(returnThis);
        if(stepNum != 0){
            
            
            int[][] neighbors = getNeighborLocations(startX, startY);            
            for(int[] pos: neighbors){
                if(board[pos[0]][pos[1]] == null && hasPieceNeighbor(pos[0], pos[1])){
                  //empty space w piece neighbor
                    //need to see if we can fit through there
                    if(canPhysicallySlideToDist1(startX, startY, pos[0], pos[1])){
                      returnThis.add(new int[]{pos[0],pos[1]});
                      findSlidableMoves(pos[0], pos[1], stepNum - 1, returnThis);
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
    
    public boolean canMove(int x, int y){
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
                 if(!(board[neighborNeighbors[k][0]][neighborNeighbors[k][1]] == null || board[neighborNeighbors[k][0]][neighborNeighbors[k][1]].getTurn()))
                   hasNoOpponentNeighbors = false;
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
                 if(!(board[neighborNeighbors[k][0]][neighborNeighbors[k][1]] == null || !board[neighborNeighbors[k][0]][neighborNeighbors[k][1]].getTurn()))
                   hasNoOpponentNeighbors = false;
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
      if (turnCount <= 2){
        return true;
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
      text(endText, 500, height - 100);
    }
    
    public void displayInfo(){
       String text1 = "Player ";
       if (isPlayerOneTurn){
         text1 += "1";
         fill(GREEN);
       }
       else {
         text1 += "2";
         fill(BLUE);
       }
       text1 += "\'s turn";
       
       String text2 = "";
       if (turnType % 2 == 0){
         text2 = "Click a piece to place or move.";
       }
       else {
         if (placing){
           text2 = "Select a hexagon to place your piece.";
         }
         else {
           text2 = "Select a hexagon to move your piece.";
         }
       }
       
       //fill(BLUE);
       //println("got here");
       textSize(15);
       rect(hexSize * 4, 0, 2 * hexSize, height);
       rotate(-PI/2);
       fill(BLACK);
       text(text1, -750, 190);
       text(text2, -750, 210);
       fill(WHITE);
       rotate(PI/2);
       textSize(12);
    }
}
