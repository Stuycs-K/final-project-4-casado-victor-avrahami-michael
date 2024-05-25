public class Tester{
    public static void main(String[] args){
        Game game = new Game();
        game.addPiece(new Queen(0,0,0,true,"a", game));
        game.addPiece(new Queen(0,0,1,true,"a", game));
        game.addPiece(new Queen(0,1,1,true,"a",game));
        game.addPiece(new Queen(0,2,1,true,"a",game));
        game.addPiece(new Queen(0,3,1,true,"a",game));
        game.addPiece(new Queen(0,3,2,true,"a",game));
        int[][] hi = game.findSlidableMoves(3, 2, 10);
        for(int i = 0; i < hi.length; i++){
            System.out.print(hi[i][0]);
            System.out.print(hi[i][1]);
            System.out.println();
        }

    }
}