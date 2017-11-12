void draw3DLine(float x1, float y1, float z1, float x2, float y2, float z2, color c) {
  stroke(c);
  y1 = y1 + 1000;
  y2 = y2 + 1000;
  line(width/2 + x1/(y1/CLEN), height/2 + z1/(y1/CLEN), width/2 + x2/(y2/CLEN), height/2 + z2/(y2/CLEN));
}
void drawCube(boolean[][][][][] data, float r, float rb) {
  for(int x = 0; x <=  2; x++) {
    for(int y = 0; y <= 2; y++) {
      for(int z = 0; z <= 2; z++) {
        if(x <= 1) drawCubeLine(x, y, z, x + 1, y, z, r, rb, -1);
        if(y <= 1) drawCubeLine(x, y, z, x, y + 1, z, r, rb, -1);
        if(z <= 1) drawCubeLine(x, y, z, x, y, z + 1, r, rb, -1);
        for(int w = 0; w <= 2; w++) {
          if(x <= 1 && data[x][y][z][w][0]){
            drawCubeLine(x, y, z, x + 1, y, z, r, rb, w);
          }
          if(y <= 1 && data[x][y][z][w][1]) {
            drawCubeLine(x, y, z, x, y + 1, z, r, rb, w);
          }
          if(z <= 1 && data[x][y][z][w][2]) {
            drawCubeLine(x, y, z, x, y, z + 1, r, rb, w);
          }
        }
      }
    }
  }
}

void drawCubeLine(float x1, float y1, float z1, float x2, float y2, float z2, float r, float rb, int w) {
  boolean useZRend = z1 != z2;
  z1 = z1-1;
  z2 = z2-1;
  
  float tx = x1-1;
  float ty = y1-1;
  float tz;
  x1 = tx * cos(r) - ty * sin(r);
  y1 = tx * sin(r) + ty * cos(r);
  tx = x2-1;
  ty = y2-1;
  x2 = tx * cos(r) - ty * sin(r);
  y2 = tx * sin(r) + ty * cos(r);
  
  ty = y1;
  tz = z1;
  y1 = ty * cos(rb) - tz * sin(rb);
  z1 = ty * sin(rb) + tz * cos(rb);
  ty = y2;
  tz = z2;
  y2 = ty * cos(rb) - tz * sin(rb);
  z2 = ty * sin(rb) + tz * cos(rb);
  if(!useZRend) {
    switch(w) {
      case -1:
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2, color(0, 0, 0));
        break;
      case 0:
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1 + DPXO, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2 + DPXO, color(255, 0, 0));
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1 - DPXO, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2 - DPXO, color(255, 0, 0));
        break;
      case 1:
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1 + DPXO * 2, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2 + DPXO * 2, color(0, 255, 0));
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1 - DPXO * 2, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2 - DPXO * 2, color(0, 255, 0));
        break;
      case 2:
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1 + DPXO * 3, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2 + DPXO * 3, color(0, 0, 255));
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1 - DPXO * 3, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2 - DPXO * 3, color(0, 0, 255));
        break;
    }
  } else {
    switch(w) {
      case -1:
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2, color(0, 0, 0));
        break;
      case 0:
        draw3DLine(BLOCKSIZE * x1 + DPXO, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2 + DPXO, BLOCKSIZE * y2, BLOCKSIZE * z2, color(255, 0, 0));
        draw3DLine(BLOCKSIZE * x1 - DPXO, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2 - DPXO, BLOCKSIZE * y2, BLOCKSIZE * z2, color(255, 0, 0));
        break;
      case 1:
        draw3DLine(BLOCKSIZE * x1 + DPXO * 2, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2 + DPXO * 2, BLOCKSIZE * y2, BLOCKSIZE * z2, color(0, 255, 0));
        draw3DLine(BLOCKSIZE * x1 - DPXO * 2, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2 - DPXO * 2, BLOCKSIZE * y2, BLOCKSIZE * z2, color(0, 255, 0));
        break;
      case 2:
        draw3DLine(BLOCKSIZE * x1 + DPXO * 3, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2 + DPXO * 3, BLOCKSIZE * y2, BLOCKSIZE * z2, color(0, 0, 255));
        draw3DLine(BLOCKSIZE * x1 - DPXO * 3, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2 - DPXO * 3, BLOCKSIZE * y2, BLOCKSIZE * z2, color(0, 0, 255));
        break;
    }
  }
}