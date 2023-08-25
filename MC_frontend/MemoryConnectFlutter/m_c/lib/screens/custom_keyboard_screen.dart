import 'package:flutter/material.dart';
import 'package:m_c/screens/keyboardkey.dart';

class CustomKeyboardScreen extends StatefulWidget {
  const CustomKeyboardScreen({super.key});

  @override
  _CustomKeyboardScreenState createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  late String amount;

  @override
  void initState() {
    super.initState();

    amount = '';
  }

  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', const Icon(Icons.keyboard_backspace)],
  ];

  onNumberPress(val) {
    setState(() {
      amount = amount + val;
    });
  }

  onBackspacePress(val) {
    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: y is Widget ? onBackspacePress : onNumberPress,
                  value: y,
                ),
              );
            }).toList(),
          ),
        )
        .toList();
  }

  renderConfirmButton() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              print(amount);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff7DBC85),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  renderText() {
    String display = '숫자를 입력해 주세요.';
    TextStyle style = const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 32.0,
    );

    if (amount.isNotEmpty) {
      display = amount;
      style = style.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 400,
        height: 450,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              renderText(),
              ...renderKeyboard(),
              Container(height: 16.0),
              renderConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}
