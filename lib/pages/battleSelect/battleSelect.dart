import 'package:flutter/cupertino.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptions.dart';
import 'package:tictactoe/pages/battleSelect/components/topTitle.dart';

class BattleSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          children: <Widget>[
            // TIC TAC TOE THE UNBEATABLE
              TopTitle(),
              BattleOptions()
            ],
          ),
      );
  }

}