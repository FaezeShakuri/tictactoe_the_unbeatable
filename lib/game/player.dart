enum PlayerType {
  X,
  O
}

class Player {
  PlayerType type;
  int key;

  Player(this.type){
    if (type == PlayerType.X)
      key = 0;
    else
      key = 1;
  }

  String getRepresentation() {
    if (type == PlayerType.X)
      return "X";
    return "O";
  }

}