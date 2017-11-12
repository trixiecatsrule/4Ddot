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

void findAndSetSquares(boolean[][][][][] segs, player[][][][][] squares, int x, int y, int z, int w) {
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
              println(x, y, z, w, i, j);
              //delay(10000);
              
            }
          }
        }
      }
    }
  }
}

boolean noDice(int i, int j) {
  //gives whether the getConnections index for opposite sign of input (i) matches the other input (j)
  return (i - (2 * (i % 2) - 1)) == j;
}