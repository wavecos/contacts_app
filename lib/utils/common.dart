import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget, bool fullscreen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget, fullscreenDialog: fullscreen));
}

void changeScreenReplacement(BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
}
