import 'package:tictactoe/game/board.dart';
import 'package:tuple/tuple.dart';

Board result(Board base, i, j){
  var r = base.clone();
  r.moveTo(i, j);
  return r;
}

int dist(Tuple2<int,int> p1, Tuple2<int,int> p2){
  int dx = p1.item1 - p2.item1;
  int dy = p1.item2 - p2.item2;

  return dx*dx + dy*dy;
}

int cmp(Tuple2<int, int > p1, Tuple2<int ,int > p2, Tuple2<int,int> base){
  int d1 = dist(p1, base);
  int d2 = dist(p2, base);

  return d1 - d2;
}

Tuple2<int, Tuple2<int, int>> maxValue(Board board, int alpha, int beta, int depth){
  var terminated = board.terminal();
  if (terminated.item1 || depth == 0)
    return Tuple2(board.utility(), null);
  
  int value = - inf * inf;
  var bestMove;

  board.possibleMoves.sort( (a, b) {
    return cmp(a, b, board.lastMove);
  });

  for (var move in board.possibleMoves){
    var data = minValue(result(board, move.item1, move.item2), alpha, beta, depth - 1);
    
    if (data.item1 > value){
      value = data.item1;
      bestMove = move;
    }

    alpha = value > alpha ? value : alpha;

    if (alpha > beta)
      break;

  }

  return Tuple2(value, bestMove);
}

Tuple2<int, Tuple2<int, int>> minValue(Board board, int alpha, int beta, int depth){
  var terminated = board.terminal();
  if (terminated.item1 || depth == 0)
    return Tuple2(board.utility(), null);
  
  int value = inf * inf;
  var bestMove;
  
  board.possibleMoves.sort( (a, b) {
    return cmp(a, b, board.lastMove);
  });

  for (var move in board.possibleMoves){
    var data = maxValue(result(board, move.item1, move.item2), alpha, beta, depth - 1);
    
    if (data.item1 < value){
      value = data.item1;
      bestMove = move;
    }

    beta = value < beta ? value : beta;
    if (alpha > beta)
      break;

  }

  return Tuple2(value, bestMove);
}


Tuple2 <int, int> alphabeta(Board board){

  int d = inf;

  if (board.size == 5){
    if (board.ration() > 0.8)
      d = 5;
    else if (board.ration() > 0.3)
      d = 5;
    else if (board.ration() <= 0.3)
      d = inf;
  } else if (board.size == 7) {
    if (board.ration() > 0.8)
      d = 4;
    else if (board.ration() > 0.3)
      d = 4;
    else if (board.ration() <= 0.3)
      d = inf;
  }



  if (board.player == x)
    return maxValue(board, -inf, inf, d).item2;
  
  return minValue(board, -inf, inf, d).item2;
}