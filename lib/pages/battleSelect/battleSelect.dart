import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/components/aboutBotton.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptions.dart';
import 'package:tictactoe/pages/battleSelect/components/topTitle.dart';
import 'package:tictactoe/pages/win/win.dart';

class BattleSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          children: <Widget>[
              TopTitle(),
              Expanded(
                flex: 4,
                child: BattleOptions(),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  child: InkWell(
                    onTap: () {
                    },
                    child: AboutButton(),
                  ),
                  alignment: FractionalOffset.bottomCenter,
                ),
              ),
            ],
          ),
      );
  }

}