import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color primaryColor = Color(0xfffc3b77);

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
return  Center(
      child: CircularProgressIndicator(
    backgroundColor: primaryColor,
    color: Color.fromARGB(255, 238, 121, 129),
    strokeWidth: 5,
  ));
}
