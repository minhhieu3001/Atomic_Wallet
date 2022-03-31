import 'package:flutter/material.dart';

Widget appBar({ Widget? left, required String title, Widget? right}) {
  return Container(
    color: const Color.fromRGBO(32, 43, 71, 1),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left!,
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          right!,
        ],
      ),
    ),
  );
}
