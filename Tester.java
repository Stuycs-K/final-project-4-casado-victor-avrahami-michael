public class Tester{
    public static void main(String[] args){
        Game game = new Game();
        game.addPiece(new Queen(0, 1, 2, true, "a"), 1, 2);
        game.addPiece(new Queen(0, 1, 4, true, "a"), 1, 4);
        System.out.println(game.isHiveConnected());
        game.addPiece(new Queen(0, 1, 3, true, "a"), 1, 3);
        System.out.println(game.isHiveConnected());

    }
}