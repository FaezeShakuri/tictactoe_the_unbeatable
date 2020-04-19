import 'package:tuple/tuple.dart';

var x = "X";
var o = "O";
var inf = 99999999999999;

class Board{
  List<List<String>> board;               // the game board
  List<Tuple2<int,int>> possibleMoves;    // free cells
  Tuple2<int, int> lastMove;              // last move made by a player
  String player;                          // player who has the turn 
  int size;                               // board size
  int moves;                              // number of moves made so far
  int maxMoves;                           // max number of moves (size * size)

  double ration(){
    return (possibleMoves.length/maxMoves);
  }

  Board clone(){
    // return a clone of this board
    
    Board cloned = Board(size, player);
    cloned.moves = moves; cloned.maxMoves = maxMoves;
    cloned.lastMove = Tuple2(lastMove.item1, lastMove.item2);

    cloned.possibleMoves = List<Tuple2<int,int>>.generate(possibleMoves.length, (i){
      return Tuple2(possibleMoves[i].item1, possibleMoves[i].item2);
    });

    cloned.board = List<List<String>>.generate(board.length, (i){
      return List<String>.generate(board[i].length, (j){
        return board[i][j];
      });
    });

    return cloned;
  }

  Board(this.size, this.player) {
    possibleMoves = List<Tuple2<int,int>>();

    // setup the board
    board = List<List<String>>.generate(size, (i) {
        return List<String>.generate(size, (j) {
          
          // add this cell to free celss
          possibleMoves.add(Tuple2(i,j));

          return "";
        }); 
      }
    );
    maxMoves = size * size;

    // no last move yet
    lastMove = Tuple2<int, int>(-1, -1);
    
    // no moves yet
    moves = 0;

  }

  void moveTo(i, j){
    
    // make the move
    if (board[i][j] == ""){
      board[i][j] = player;
      
      lastMove = Tuple2(i,j);
      possibleMoves.remove(Tuple2(i,j));
      moves++;
      // switch the player
      if (player == x)
        player = o;
      else
        player =x;
    }

  }

  String winnerInBox(List<List<String>> box, int winby, int li, int lj){
    // if there is a winner - based on the last move - in the given box, return it
    // null other wise
    var pl = [o, x];
    for (var i = 0; i < pl.length; i ++){
      var p = pl[i];

      // winner by row
      if (countTargetInRow(box, p, li) == winby)
        return p;
      
      // winner by col
      if (countTargetInCol(box, p, lj) == winby)
        return p;
      
      // winner by main axis
      if (countInMainAxis(box, p) == winby)
        return p;
      
      // winner by cross axsis
      if (countInCrossAxis(box, p) == winby)
        return p;
      
    }
    
    // no winnners found
    return null;
  }

  String winner(){
    // return the winner of the board
    // if no winners, return null

    // no last move, don't check
    if (lastMove.item1 == -1 && lastMove.item2 == -1)
      return null;

    int winby = board.length == 3 ? 3 : 4;

    if (winby == 3)
      return winnerInBox(board, winby, lastMove.item1, lastMove.item2);
    
    int pad = board.length - winby;

    // check for winner in each winby x winby boxes
    for (var i = 0 ; i <= pad; i ++){
      for (var j = 0; j <=pad ; j++){

        // if last move, is not inside this box, don't botther
        int startr = i;
        int endr = i + winby - 1;
        int startc = j;
        int endc = j + winby - 1;

        if (lastMove.item1 > endr || lastMove.item1 < startr)
          continue;
        if (lastMove.item2 > endc || lastMove.item2 < startc)
          continue;

        var box = List<List<String>>.generate(winby, (k){
          return List<String>.generate(winby, (l){
            return board[k+i][l+j];
          });
        });

        var winner = winnerInBox(box, winby, lastMove.item1 - i, lastMove.item2 -j);
        if (winner == null)
          continue;
        return winner;
      }
    }
    return null;
  }

  Tuple2<bool, String> terminal(){
    // (game finished, winner)

    var theWinner = winner();
    if (theWinner != null)
      return Tuple2(true, theWinner);

    if (possibleMoves.length == 0)
      return Tuple2(true, null);
    
    return Tuple2(false, null);
  }

  static int countTargetInRow(List<List<String>> box, String target, int row){
    int c = 0;
    box[row].forEach((cell){ if (cell == target) c++; });
    return c;
  }

  static int countTargetInCol(List<List<String>> box, String target, int col){
    int c = 0;
    for (var i = 0 ; i < box.length; i ++){
      if (box[i][col] == target)
        c++;
    }
    return c;
  }

  static int countInMainAxis(List<List<String>> box, String target){
    int c = 0;
    for (int i = 0;i < box.length;i++){
      if (box[i][i] == target)
        c++;
    }
    return c;
  }

  static int countInCrossAxis(List<List<String>> box, String target){
    int c = 0;
    for (int i = 0;i < box.length;i++){
      if (box[i][box.length - 1 - i] == target)
        c++;
    }
    return c;
  }
  
  List <List <List < String >>> boxes(int winby){
    // return a list of boxes of the current board

    int pad = board.length - winby;
    List <List <List < String >>> _boxes = List();

    for (var i = 0 ; i <= pad; i ++){
      for (var j = 0; j <=pad ; j++){
        var box = List<List<String>>.generate(winby, (k){
          return List<String>.generate(winby, (l){
            return board[k+i][l+j];
          });
        });
        _boxes.add(box);
      }
    }
    return _boxes;
  }

  int getRawScore(int me, int opp, Tuple3 extra){
    int s = 0;

    if (opp == 0)
      s += me + 1;
    if (opp == 2 && me ==0)
      s -= 100;
    if (opp == 3 && me == 0)
      s -= 1000;
    return s;
  }

  int getTargetScore(List <List < String >> box, String target){
    int score = 0;
    String opp = target == x ? o : x;
    var extra;

    for (var i = 0; i < box.length; i ++){
      score += getRawScore(countTargetInRow(box, target, i), countTargetInRow(box, opp, i), extra);
      score += getRawScore(countTargetInCol(box, target, i), countTargetInCol(box, opp, i), extra);
    }

    score += getRawScore(countInMainAxis(box, target), countInMainAxis(box, opp), extra) * 100;
    score += getRawScore(countInCrossAxis(box, target), countInCrossAxis(box, opp), extra) * 100;

    // int forks = 0;
    // for (var i = 0 ; i < box.length; i++) {
    //   for (var j = 0 ; j < box.length; j++){
    //     if (box[i][j] == "" || box[i][j] != target)
    //       continue;
        
    //     // left fork
    //     if (i - 1 >=0 && j + 1 < box.length){
    //       if (box[i-1][j] == box[i][j] && box[i][j+1] == box[i][j])
    //         forks += 5;
          
    //     }

    //     // right fork
    //     if (i - 1 >=0 && j - 1 >= 0){
    //       if (box[i-1][j] == box[i][j] && box[i][j-1] == box[i][j])
    //         forks ++;
    //     }

    //     // top left fork
    //     if (i + 1 < box.length && j + 1 < box.length){
    //       if (box[i+1][j] == box[i][j] && box[i][j+1] == box[i][j])
    //         forks ++;
    //     }

    //     // top right fork
    //     if (i + 1 < box.length && j - 1 >= 0){
    //       if (box[i+1][j] == box[i][j] && box[i][j-1] == box[i][j])
    //         forks ++;
    //     }
    //   }
    // }

    // score += (forks * 1000);

    // if (lforks != 0)
    //   print("detected");

    return score;
  }

  int boxScore(List <List < String >> box){
    // score of the given box: sum of scores of each row, col, main axsis and cross axsis
    return getTargetScore(box, x) - getTargetScore(box, o);
  }

  int utility(){
    // utitlity of the current board
    var terminated = terminal();
    if (terminated.item1){
      if (terminated.item2 == x)
        return inf;
      else if (terminated.item2 == o)
        return -inf;
      
      return 0;
    } else if (size == 5){
      int score = 0;
      var _boxes = boxes(4);
      for (var i = 0 ; i  < _boxes.length; i++){
        int tmpScore = boxScore(_boxes[i]);
        if (tmpScore.abs() > score.abs())
          score = tmpScore;
        // score += tmpScore;
      }
      return score;
    } else {
      int score = 0;
      var _boxes = boxes(4);
      for (var i = 0 ; i  < _boxes.length; i++){
        int tmpScore = boxScore(_boxes[i]);
        if (tmpScore.abs() > score.abs())
          score = tmpScore;
        // score += tmpScore;
      }
      return score;
    }
  }

}