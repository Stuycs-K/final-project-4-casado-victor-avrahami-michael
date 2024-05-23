
  int[][] gameBoard;

  void setup(){
    size(500, 500);
    background(255);
    gameBoard = new int[22][22];
  }

  void draw(){
    for (int i = 0; i < gameBoard.length; i++){
      for (int j = 0; j < gameBoard.length; j++){
        int extra20 = 0;
        if (j % 2 == 1){
          extra20 = 20;
        }
        
        polygon((j + 1) * 30, (i + 1) * 30 + extra20, 20, 6);
      }
    }
  }
  
  void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  }  
