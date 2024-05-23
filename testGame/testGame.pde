
  int[][] gameBoard;

  void setup(){
    size(500, 500);
    background(255);
    gameBoard = new int[22][22];
  }

  void draw(){
    polygon(20, 20, 20, 6);
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
