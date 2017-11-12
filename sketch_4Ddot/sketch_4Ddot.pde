enum player {none, p1, p2}
//x+, y+, z+, w+
boolean[][][][][] fieldDataSegs = new boolean[3][3][3][3][4];
//xy, xz, yz, wx, wy, wz
player[][][][][] fieldDataSquares = new player[3][3][3][3][6];

float x = 100;
float y = 100;
float z = 100;

void setup() {
  size(400, 400);
  background(255);
  smooth(4);
}

void draw() {
  fieldDataSegs[0][0][0][2][2] = true;
  fieldDataSegs[0][0][0][1][0] = true;
  fieldDataSegs[0][0][0][0][2] = true;
  fieldDataSegs[1][0][0][2][0] = true;
  fieldDataSegs[0][1][0][2][1] = true;
  fieldDataSegs[0][0][1][2][2] = true;
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
  background(255);
  drawCube(fieldDataSegs, millis()/4000.0*PI, PI*sin(millis()/2000.0*PI)/10);
  //drawCube(fieldDataSegs, 0, 0);
}