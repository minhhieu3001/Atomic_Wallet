import 'package:flutter/material.dart';

Widget card(
    {double width = double.maxFinite, double padding = 20, required Widget child}) {
  return Container(
    width: width,
    padding: EdgeInsets.all(padding),
    decoration: const BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: child,
  );
}
