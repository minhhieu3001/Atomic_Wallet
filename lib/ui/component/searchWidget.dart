import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}