void draw3DLine(float x1, float y1, float z1, float x2, float y2, float z2, color c) {
  stroke(c);
  y1 = y1 + 1750;
  y2 = y2 + 1750;
  line(width/2 + x1/(y1/CLEN), height/2 + z1/(y1/CLEN), width/2 + x2/(y2/CLEN), height/2 + z2/(y2/CLEN));
}

void drawCubeFace(int x, int y, int z, int w, int d, float r, float rb) {
  //0   1   2   3   4   5
  //xy, xz, yz, wx, wy, wz
  switch(d) {
    case 0:
      drawSquareFace(x, y, z, x+1, y+1, z, w, r, rb);
      break;
    case 1:
      drawSquareFace(x, y, z, x+1, y, z+1, w, r, rb);
      break;
    case 2:
      drawSquareFace(x, y, z, x, y+1, z+1, w, r, rb);
      break;
    case 3:
      drawSegFace(x, y, z, x+1, y, z, w, r, rb);
      break;
    case 4:
      drawSegFace(x, y, z, x, y+1, z, w, r, rb);
      break;
    case 5:
      drawSegFace(x, y, z, x, y, z+1, w, r, rb);
      break;
  }
}

void ndrawSquareFace(float x, float y, float z, int w, int d, float r, float rb) {
  float littleOffset = w * .05;
  float bigOffset = .6*BLOCKSIZE - BLOCKSIZE*2*littleOffset;
  color c;
  switch(w) {
    case 0:
      c = color(255, 0, 0);
      break;
    case 1:
      c = color(0, 255, 0);
      break;
    case 2:
      c = color(0, 0, 255);
      break;
    default:
     c = color(255, 255, 255);
     break;
  }
  x = -.8 + x + littleOffset;
  y = -.8 + y + littleOffset;
  z = -.8 + z + littleOffset;
  x *= BLOCKSIZE;
  y *= BLOCKSIZE;
  z *= BLOCKSIZE;
  //xy, xz, yz, wx, wy, wz
  switch(d) {
    case 0:
      rotateAndDraw3DLine(x, y, z, x + bigOffset, y, z, c, r, rb);
      rotateAndDraw3DLine(x, y, z, x, y + bigOffset, z, c, r, rb);
      rotateAndDraw3DLine(x + bigOffset, y, z, x + bigOffset, y + bigOffset, z, c, r, rb);
      rotateAndDraw3DLine(x, y + bigOffset, z, x + bigOffset, y + bigOffset, z, c, r, rb);
      break;
    case 1:
      rotateAndDraw3DLine(x, y, z, x + bigOffset, y, z, c, r, rb);
      rotateAndDraw3DLine(x, y, z, x, y, z + bigOffset, c, r, rb);
      rotateAndDraw3DLine(x + bigOffset, y, z, x + bigOffset, y, z + bigOffset, c, r, rb);
      rotateAndDraw3DLine(x, y, z + bigOffset, x + bigOffset, y, z + bigOffset, c, r, rb);
      break;
    case 2:
      rotateAndDraw3DLine(x, y, z, x, y + bigOffset, z, c, r, rb);
      rotateAndDraw3DLine(x, y, z, x, y, z + bigOffset, c, r, rb);
      rotateAndDraw3DLine(x, y + bigOffset, z, x, y + bigOffset, z + bigOffset, c, r, rb);
      rotateAndDraw3DLine(x, y, z + bigOffset, x, y + bigOffset, z + bigOffset, c, r, rb);
      break;
  }
}

void drawSquareFace(float x1, float y1, float z1, float x2, float y2, float z2, int w, float r, float rb) {
  //transform to account for centering on center, not cube corner
  x1 -= 1;
  y1 -= 1;
  x2 -= 1;
  y2 -= 1;
  //transform to scale down the shaded square to fit in the wireframe rectangle
  x1 += .2;
  y1 += .2;
  z1 += .2;
  x2 -= .2;
  y2 -= .2;
  z2 -= .2;
  //multiply to scale to screen size
  x1 *= BLOCKSIZE;
  y1 *= BLOCKSIZE;
  z1 *= BLOCKSIZE;
  x2 *= BLOCKSIZE;
  y2 *= BLOCKSIZE;
  z2 *= BLOCKSIZE;
  color c = color(255, 255, 255);
  switch(w) {
    case 0:
      c = color(255, 0, 0);
      break;
    case 1:
      c = color(0, 255, 0);
      break;
    case 2:
      c = color(0, 0, 255);
      break;
  }
  
  
  
  //for(float s = w/30; s <=1; s+=.1) {
    //rotateAndDraw3DLine(x1*(1-s) + x2*s, y1*(1-s) + y2*s, z1*(1-s) + z2*s, x1*s + x2*(1-s), y1*s + y2*(1-s), z1*s + z2*(1-s), c, r, rb);
    //rotateAndDraw3DLine(x1*(1-s) + x2*s, y1*(1-s) + y2*s, z1, x1*s + x2*(1-s), y1*s + y2*(1-s), z1, c, r, rb);
  //}
}

void rotateAndDraw3DLine(float x1, float y1, float z1, float x2, float y2, float z2, color c, float r, float rb) {
  float tx = x1;
  float ty = y1;
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
  draw3DLine(x1, y1, z1, x2, y2, z2, c);
}

void drawSegFace(float x1, float y1, float z1, float x2, float y2, float z2, float w, float r, float rb) {
  //w = 0 for first 2, 1 for second 2
  color c = color(255, 255, 255);
  boolean useZRend = z1 != z2;
  x1 -= 1;
  x2 -= 1;
  y1 -= 1;
  y2 -= 1;
  z1 -= 1;
  z2 -= 1;
  float o = DPXO * (w + 1.5);
  if(abs(x1-x2) > .001) {//if the x is the one that changes, shorten that direction
    x1 += .1;
    x2 -= .1;
    x1 *= BLOCKSIZE;
    y1 *= BLOCKSIZE;
    z1 *= BLOCKSIZE;
    x2 *= BLOCKSIZE;
    y2 *= BLOCKSIZE;
    z2 *= BLOCKSIZE;
    rotateAndDraw3DLine(x1, y1, z1-o, x1, y1, z1+o, c, r, rb);
    rotateAndDraw3DLine(x2, y1, z1-o, x2, y1, z1+o, c, r, rb);
    rotateAndDraw3DLine(x1, y1, z1-o, x2, y1, z1-o, c, r, rb);
    rotateAndDraw3DLine(x1, y1, z1+o, x2, y1, z1+o, c, r, rb);
  }
  if(abs(y1-y2) > .001) {
    y1 += .1;
    y2 -= .1;
    x1 *= BLOCKSIZE;
    y1 *= BLOCKSIZE;
    z1 *= BLOCKSIZE;
    x2 *= BLOCKSIZE;
    y2 *= BLOCKSIZE;
    z2 *= BLOCKSIZE;
    rotateAndDraw3DLine(x1, y1, z1-o, x1, y1, z1+o, c, r, rb);
    rotateAndDraw3DLine(x1, y2, z1-o, x1, y2, z1+o, c, r, rb);
    rotateAndDraw3DLine(x1, y1, z1-o, x1, y2, z1-o, c, r, rb);
    rotateAndDraw3DLine(x1, y1, z1+o, x1, y2, z1+o, c, r, rb);
  }
  if(abs(z1-z2) > .001) {
    z1 += .1;
    z2 -= .1;
    x1 *= BLOCKSIZE;
    y1 *= BLOCKSIZE;
    z1 *= BLOCKSIZE;
    x2 *= BLOCKSIZE;
    y2 *= BLOCKSIZE;
    z2 *= BLOCKSIZE;
    rotateAndDraw3DLine(x1-o, y1, z1, x1+o, y1, z1, c, r, rb);
    rotateAndDraw3DLine(x1-o, y1, z2, x1+o, y1, z2, c, r, rb);
    rotateAndDraw3DLine(x1-o, y1, z1, x1-o, y1, z2, c, r, rb);
    rotateAndDraw3DLine(x1+o, y1, z1, x1+o, y2, z2, c, r, rb);
  }
  /*
  if x changes
    rotate and draw 3d line for: +- offset z, +z to x changed, -z to x changed, +-offset z at changed x
    rotateAndDraw3DLine(
    */
}

float[] rotatePoints(float x, float y, float z, float r, float rb) {
  float tx = x;
  float ty = y;
  float tz = z;
  x = tx * cos(r) - ty * sin(r);
  y = tx * sin(r) + ty * cos(r);
  ty = y;
  tz = z;
  y = ty * cos(rb) - tz * sin(rb);
  z = ty * sin(rb) + tz * cos(rb);
  float[] result = {x, y, z};
  return result;
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
  if(w==-1) {
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
  } else {
    if(abs(x1-x2) > .001) {//if the x is the one that changes
      x1 -= .8;
      x2 -= 1.2;
    } else {
      x1 -= 1;
      x2 -= 1;
    }
    if(abs(y1-y2) > .001) {//if the y is the one that changes
      y1 -= .8;
      y2 -= 1.2;
    } else {
      y1 -= 1;
      y2 -= 1;
    }
    if(abs(z1-z2) > .001) {//if the z is the one that changes
      z1 -= .8;
      z2 -= 1.2;
    } else {
      z1 -= 1;
      z2 -= 1;
    }
    float tx = x1;
    float ty = y1;
    float tz = z1;
    
    x1 = tx * cos(r) - ty * sin(r);
    y1 = tx * sin(r) + ty * cos(r);
    tx = x2;
    ty = y2;
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
  }
  
  if(!useZRend) {
    switch(w) {
      case -1:
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2, color(255, 255, 255));
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
        draw3DLine(BLOCKSIZE * x1, BLOCKSIZE * y1, BLOCKSIZE * z1, BLOCKSIZE * x2, BLOCKSIZE * y2, BLOCKSIZE * z2, color(255, 255, 255));
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