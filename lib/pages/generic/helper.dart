

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';

void goHome(BuildContext context) {
  // navigate to battle select page and pop everything
  navigate(context, BattleSelectPage(), true);
}

void navigate(BuildContext context, Widget page, [bool clear=true]) {

  if (clear) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Entry(page)),
            (r) => false
    );
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Entry(page))
    );
  }
}

void toastError(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void toastSuccess(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}


void toastInfo(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );
}