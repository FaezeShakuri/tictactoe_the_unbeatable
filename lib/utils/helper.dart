

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/battleSelect/components/dialogs.dart';

void goHome(BuildContext context, bool ask) {
  // navigate to battle select page and pop everything

  if (ask)
    askToGoHome(context);
  else
    navigate(BattleSelectPage(), true);
}

void navigate(Widget page, bool clear) {
  if (clear) {
    navigatorKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (route) => false
    );
  } else {
    navigatorKey.currentState.push(
      MaterialPageRoute(builder: (context) => page),
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

void alertDialog(BuildContext context, Widget title, Widget body, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog (
          title: title,
          backgroundColor: color,
          content: body
      );
    },
  );
}