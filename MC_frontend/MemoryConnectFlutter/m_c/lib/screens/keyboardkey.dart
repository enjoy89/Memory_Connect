import 'package:flutter/material.dart';

class KeyboardKey extends StatefulWidget {
  final Object label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const KeyboardKey({
    super.key,
    required this.label,
    required this.onTap,
    required this.value,
  }) : assert(value != null);

  @override
  _KeyboardKeyState createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: Container(
        child: Center(
          child: widget.label.runtimeType == String
              ? Text(
                  widget.label.toString(),
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Icon(
                  Icons.keyboard_backspace,
                  size: 30,
                ),
        ),
      ),
    );
  }
}
