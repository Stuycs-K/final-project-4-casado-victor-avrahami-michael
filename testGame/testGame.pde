  Game game; 
  
  void setup(){
    size(1500, 800);
    game = new Game();
  }

  void draw(){   
    game.checkGameOver();
  }
  
  void mouseClicked(){
    
    float x = mouseX;
    float y = mouseY;
    
    game.move(x, y);
  }
 
