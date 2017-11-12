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
/*
void findAndSetSquares(boolean[][][][][] segs, player[][][][][] squares, int x, int y, int z, int w) {
  boolean[] pcons = getConnections(segs, x, y, z, w);
  if(pcons[0]) {
    boolean[] 
}
*/