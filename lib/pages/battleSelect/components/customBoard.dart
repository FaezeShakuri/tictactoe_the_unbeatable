import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/game/board.dart';

import '../../battle/battle.dart';

class CustomBoard extends StatefulWidget {
  // initializes a new game board
  // always sets the game starter to X

  _CustomBoardState currentState;

  @override
  _CustomBoardState createState() {
    currentState = _CustomBoardState();
    return currentState;
  }
}

class _CustomBoardState extends State<CustomBoard> {
  int boardSize = 8;
  int winBy = 5;
  bool withAi = true;
  String aiPlayer = "O";
  String starter = "X";
  GameMode gameMode = GameMode.AI;
  int level = 1;
  int maxLevel = 4;

  var aiPlayerWidget;

  String playingAs() {
    var _playingAs;
    _playingAs = aiPlayer == "X" ? "O" : "X";
    return _playingAs;
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery.of(context).size.width / 9;
    TextStyle _style = TextStyle(color: Colors.white, fontSize: tileSize / 2.8);
    setState(() {
      if (gameMode == GameMode.AI) {
        aiPlayerWidget = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                "AI PLAYER",
                style: _style,
              ),
            ),
            Container(
              child: DropdownButton<String>(
                underline: SizedBox(),
                dropdownColor: Color(0xff323232),
                value: aiPlayer,
                elevation: 20,
                onChanged: (String value) {
                  setState(() {
                    aiPlayer = value;
                  });
                },
                items: <String>["X", "O"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontFamily: "", color: Color(0xaaffbd69)),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        );
      } else if (gameMode == GameMode.ONLINE) {
        aiPlayerWidget = Center(
            child: Text(
          "YOU WILL BE THE STARTING PLAYER",
          style: TextStyle(color: Colors.grey, fontFamily: ""),
        ));
      } else {
        aiPlayerWidget = SizedBox();
      }
    });

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Game size
          Container(
            child: Text(
              "BOARD SIZE " + boardSize.toString(),
              style: _style,
            ),
          ),
          Container(
            child: Slider(
              value: boardSize.toDouble(),
              min: 4,
              max: 10,
              divisions: 6,
              label: '$boardSize',
              inactiveColor: Colors.black,
              activeColor: Color(0xaaffbd69),
              onChanged: (val) {
                setState(() {
                  boardSize = val.ceil();
                  if (winBy > boardSize) winBy = boardSize;
                  if (boardSize > 8) {
                    maxLevel = 3;
                    if (level > maxLevel) level = 3;
                  } else
                    maxLevel = 4;
                });
              },
            ),
          ),
          // win by
          Container(
            child: Text(
              "WIN BY " + winBy.round().toString() + " IN A LINE",
              style: _style,
            ),
          ),
          Slider(
            value: winBy.toDouble(),
            min: 4,
            max: boardSize.toDouble(),
            divisions: (boardSize - 4 > 0) ? boardSize - 4 : 1,
            label: "$winBy",
            inactiveColor: Colors.black,
            activeColor: Color(0xaaffbd69),
            onChanged: (val) {
              setState(() {
                winBy = val.ceil();
              });
            },
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: gameMode == GameMode.AI
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "AI LEVEL " + level.toString(),
                          style: _style,
                        ),
                      ),
                      Slider(
                        value: level.toDouble(),
                        min: 1,
                        max: maxLevel.toDouble(),
                        divisions: maxLevel - 1,
                        label: "$level",
                        inactiveColor: Colors.black,
                        activeColor: Color(0xaaffbd69),
                        onChanged: (val) {
                          setState(() {
                            level = val.round();
                          });
                        },
                      ),
                    ],
                  )
                : SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "GAME MODE",
                  style: _style,
                ),
              ),
              Flexible(
                child: Container(
                  width: tileSize*3.3,
                  child: DropdownButton<GameMode>(
                    dropdownColor: Color(0xff323232),
                    underline: SizedBox(),
                    isExpanded: true,
                    isDense: false,
                    value: gameMode,
                    elevation: 20,
                    onChanged: (GameMode value) {
                      setState(() {
                        gameMode = value;
                      });
                    },
                    items: <GameMode>[
                      GameMode.AI,
                      GameMode.ONLINE,
                      GameMode.LOCAL
                    ].map<DropdownMenuItem<GameMode>>((GameMode value) {
                      var strVal;
                      if (value == GameMode.AI)
                        strVal = "1 PLAYER";
                      else if (value == GameMode.ONLINE)
                        strVal = "2 PLAYERS - ONLINE";
                      else
                        strVal = "2 PLAYERS - OFFLINE";
                      return DropdownMenuItem<GameMode>(
                        value: value,
                        child: SizedBox(
                          width: tileSize*3.3,
                          child: Text(
                            strVal,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: "",
                              color: Color(0xaaffbd69),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "STARTING PLAYER",
                  style: _style,
                ),
              ),
              Container(
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  dropdownColor: Color(0xff323232),
                  value: starter,
                  elevation: 20,
                  onChanged: (String value) {
                    setState(() {
                      starter = value;
                    });
                  },
                  items: <String>["X", "O"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            TextStyle(fontFamily: "", color: Color(0xaaffbd69)),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 100),
              child: aiPlayerWidget,
            ),
          ),
        ],
      ),
    );
  }
}
