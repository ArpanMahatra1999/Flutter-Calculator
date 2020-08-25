import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({
    this.color, this.textColor, this.buttonText, this.buttonTapped
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        margin: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 8.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,16.0),
          child: ClipOval(
              child: Container(
                color: color,
                child: Center(
                  child: Text(buttonText, style: TextStyle(color: textColor, fontSize: 25),),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
