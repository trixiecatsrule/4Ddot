boolean[] getConnections(boolean[][][][][] segs, int x, int y, int z, int w) {
  boolean[] result = new boolean[8];
  if(x < 0 || x > 2 || y < 0 || y > 2 || z < 0 || z > 2 || w < 0 || w > 2) {
    throw new IllegalArgumentException();
  }
  
  //checks if result is in bounds for having connections, then gets the connection
  //x+
  result[0] = segs[x][y][z][w][0];
  //x-
  if(x >= 1) {
    result[1] = segs[x-1][y][z][w][0];
  } else {
    result[1] = false;
  }
  //y+
  result[2] = segs[x][y][z][w][1];
  //y-
  if(y >= 1) {
    result[3] = segs[x][y-1][z][w][1];
  } else {
    result[3] = false;
  }
  //z+
  result[4] = segs[x][y][z][w][2];
  //z-
  if(z >= 1) {
    result[5] = segs[x][y][z-1][w][2];
  } else {
    result[5] = false;
  }
  //w+
  result[6] = segs[x][y][z][w][3];
  //w-
  if(w >= 1) {
    result[7] = segs[x][y][z][w-1][3];
  } else {
    result[7] = false;
  }
  
  //x+, x-, y+, y-, z+, z-, w+, w-
  return result;
}