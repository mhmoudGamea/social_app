import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double radius;
  final Color firstGradient;
  final Color secondGradient;
  final String text;
  final double textSize;
  final Color textColor;
  final VoidCallback function;
  double? letterSpacing;
  ButtonWidget({Key? key,required this.radius, required this.firstGradient, required this.secondGradient, required this.text, required this.textSize, required this.textColor,this.letterSpacing, required this.function,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 54,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(colors: [
              firstGradient,
              secondGradient,
            ])),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: textSize, color: textColor, letterSpacing: letterSpacing),
        ),
      ),
    );
  }
}
