public class Tester{
    public static void main(String[] args){
        Game game = new Game();
        Queen a1 = new Queen(0, 1, 1, true, "hi");
        game.setQueen(a1);
        game.toggleTurn();
        Queen a2 = new Queen(0, 1, 2, false, "yo");
        game.setQueen(a2);
        game.board[1][1] = a1;
        game.board[1][2] = a2;
        System.out.println(game.isGameOver());
        game.board[1][0] = new Ant(0, 1, 0, true, "a");
        game.board[0][1] = new Ant(0, 0, 1, true, "a");
        game.board[2][0] = new Ant(0, 2, 0, true, "a");
        game.board[2][1] = new Ant(0, 2, 1, true, "a");
        game.board[2][2] = new Ant(0, 2, 2, true, "a");
        System.out.println(game.isGameOver());
        game.board[1][0] = null;
        game.board[0][2] = new Ant(0, 0, 2, true, "a");
        game.board[0][3] = new Ant(0, 0, 3, true, "a");
        game.board[1][3] = new Ant(0, 1, 3, true, "a");
        System.out.println(game.isGameOver());
        game.board[1][0] = new Ant(0, 1, 0, true, "a");
        System.out.println(game.isGameOver());

    }
}