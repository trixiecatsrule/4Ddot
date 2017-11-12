enum player {none, p1, p2}
//x+, y+, z+, w+
boolean[][][][][] fieldDataSegs = new boolean[3][3][3][3][4];
//xy, xz, yz, wx, wy, wz
player[][][][][] fieldDataSquares = new player[3][3][3][3][6];

float x = 100;
float y = 100;
float z = 100;

void setup() {
  size(700, 700);
  background(255);
  smooth(0);
  initFieldDataSquares();
  //noLoop();
}

void draw() {
  /*
  fieldDataSegs[0][0][0][2][2] = true;
  fieldDataSegs[0][0][0][1][0] = true;
  fieldDataSegs[0][0][0][0][2] = true;
  fieldDataSegs[1][0][0][2][0] = true;
  fieldDataSegs[0][1][0][2][1] = true;
  fieldDataSegs[0][0][1][2][2] = true;
  */
  fieldDataSegs[0][0][0][0][0] = true;
  fieldDataSegs[0][0][0][0][2] = true;
  fieldDataSegs[1][0][0][0][2] = true;
  fieldDataSegs[0][0][1][0][0] = true;
  
  fieldDataSegs[0][0][0][1][0] = true;
  fieldDataSegs[0][0][0][1][2] = true;
  fieldDataSegs[1][0][0][1][2] = true;
  fieldDataSegs[0][0][1][1][0] = true;
  
  fieldDataSegs[0][0][0][2][0] = true;
  fieldDataSegs[0][0][0][2][2] = true;
  fieldDataSegs[1][0][0][2][2] = true;
  fieldDataSegs[0][0][1][2][0] = true;
  //boolean[] test = getConnections(fieldDataSegs, 0, 0, 0, 0);
  //println(test);
  //test = getConnections(fieldDataSegs, 1, 0, 0, 0);
  //println(test);
  /*
  initFieldDataSquares();
  fieldDataSquares[0][0][0][0][0] = player.p1;
  println(playerToString(fieldDataSquares[0][0][0][0][0]));
  *//*
  background(255);
  draw3DLine(0, 500, 0, x, 500+y, z, color(127, 256, 0));
  
  float tx = x;
  float ty = y;
  x = tx * cos(PI/20) - ty * sin(PI/20);
  y = tx * sin(PI/20) + ty * cos(PI/20);
  //println(x, y);
  delay(50);
  */
  background(0);
  drawCube(fieldDataSegs, millis()/8000.0*PI, PI*sin(millis()/4000.0*PI)/20);
  ndrawSquareFace(0, 0, 0, 0, 2, millis()/8000.0*PI, PI*sin(millis()/4000.0*PI)/20);
  //drawSquareFace(0, 0, 0, 0, 1, 1, 1, millis()/8000.0*PI, PI*sin(millis()/4000.0*PI)/20);
  //rotateAndDraw3DLine(-200, 0, 0, 200, 0, 0, color(255, 255, 255), millis()/8000.0*PI, PI*sin(millis()/4000.0*PI)/20);
  //drawCube(fieldDataSegs, 0, 0);
  /*
  for(int i = 0; i <= 7; i++) {
    println(dcTrueToXYZWOffset(i));
  }*/
  
  //println(anyOutOfBounds(1, 0, 2, 2));
  //findAndSetSquares(fieldDataSegs, fieldDataSquares, 0, 0, 0, 0, player.p1);
  //println(fieldDataSquares[0][0][0][0][2]);
}