String playerToString(player p) {
  switch(p) {
    case none:
      return "none";
    case p1:
      return "p1";
    case p2:
      return "p2";
    default:
      return "invalid";
  }
}

void initFieldDataSquares() {
  for(int x = 0; x <= 2; x++) {
    for(int y = 0; y <= 2; y++) {
      for(int z = 0; z <= 2; z++) {
        for(int w = 0; w <= 2; w++) {
          for(int i = 0; i <=5; i++) {
            fieldDataSquares[x][y][z][w][i] = player.none;
          }
        }
      }
    }
  }
}

//converts the number for index from getConnections' return array to xyzw offsets for access to the pointed-to point
int[] dcTrueToXYZWOffset(float dirTrue) {
  int[] result = new int[4];
  //x+, x-, y+, y-, z+, z-, w+, w-
  result[(int) (floor(dirTrue/2))] = (int) (1 - 2 * (dirTrue % 2));
  return result;
}

boolean anyOutOfBounds(int a, int b, int c, int d) {
  return !(a >=0 && a <=2 && b >=0 && b <=2 && c >=0 && c <=2 && d >=0 && d <=2);
}

void findAndSetSquares(boolean[][][][][] segs, player[][][][][] squares, int x, int y, int z, int w, player p) {
  //x+, x-, y+, y-, z+, z-, w+, w-
  //point connections
  boolean[] pcons = getConnections(segs, x, y, z, w);
  
  for(int i = 0; i <= 7; i++) {//direction 1
    if(pcons[i]) {
      for(int j = 0; j <= 7; j++) {//other directions to find perpendicular segments
        if(noDice(i, j) || i == j) j++;
        if(pcons[j]) {
          int[] newPointDir = dcTrueToXYZWOffset(j);
          int tx = newPointDir[0]+x;
          int ty = newPointDir[1]+y;
          int tz = newPointDir[2]+z;
          int tw = newPointDir[3]+w;
          if(anyOutOfBounds(tx, ty, tz, tw)) break;
          boolean[] newPointConnections = getConnections(segs, tx, ty, tz, tw);
          if(newPointConnections[i]) {//direction 1 again, but from tip of perpendicular segment
            int[] initialDirPointDir = dcTrueToXYZWOffset(i);
            int txb = initialDirPointDir[0]+x;
            int tyb = initialDirPointDir[1]+y;
            int tzb = initialDirPointDir[2]+z;
            int twb = initialDirPointDir[3]+w;
            if(anyOutOfBounds(txb, tyb, tzb, twb)) break;
            boolean[] initialDirectionPointConnections = getConnections(segs, txb, tyb, tzb, twb);
            if(initialDirectionPointConnections[j]) {//initial direction's point has edge in found perpendicular direction
              
              //face found in direction i/j
              setSquare(squares, x, y, z, w, i, j, p);
            }
          }
        }
      }
    }
  }
}

void setSquare(player[][][][][] squares, int x, int y, int z, int w, int i, int j, player p) {
  //x+, x-, y+, y-, z+, z-, w+, w-
  int[] iOff = dcTrueToXYZWOffset(i);
  //shifts square in - dir if needed because squares stored in + direction
  if(hasNegative(iOff)) {
    x += iOff[0];
    y += iOff[2];
    z += iOff[2];
    w += iOff[3];
    i--;
  }
  int[] jOff = dcTrueToXYZWOffset(j);
  if(hasNegative(jOff)) {
    x += jOff[0];
    y += jOff[2];
    z += jOff[2];
    w += jOff[3];
    j--;
  }
  //i, j, and coords are now properly set up for adding a square
  //0   1   2   3   4   5   6   7
  //x+, x-, y+, y-, z+, z-, w+, w-
  //xy, xz, yz, wx, wy, wz
  if((i == 0 && j == 2) || (i == 2 && j == 0)) squares[x][y][z][w][0] = p;//xy
  if((i == 0 && j == 4) || (i == 4 && j == 0)) squares[x][y][z][w][1] = p;//xz
  if((i == 2 && j == 4) || (i == 4 && j == 2)) squares[x][y][z][w][2] = p;//yz
  if((i == 6 && j == 0) || (i == 0 && j == 6)) squares[x][y][z][w][3] = p;//wx
  if((i == 6 && j == 2) || (i == 2 && j == 6)) squares[x][y][z][w][4] = p;//wy
  if((i == 6 && j == 4) || (i == 4 && j == 6)) squares[x][y][z][w][5] = p;//wz
}

boolean hasNegative(int[] in) {
  boolean result = false;
  for(int i : in) {
    if(i < 0) result = true;
  }
  return result;
}

boolean noDice(int i, int j) {
  //gives whether the getConnections index for opposite sign of input (i) matches the other input (j)
  return (i - (2 * (i % 2) - 1)) == j;
}