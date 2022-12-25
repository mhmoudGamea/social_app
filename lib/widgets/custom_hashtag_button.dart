import 'package:flutter/material.dart';

class CustomHashTagButton extends StatelessWidget {
  final String text;
  final double textSize;
  final Color color;

  const CustomHashTagButton({
    Key? key,
    required this.text,
    this.textSize = 13,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, ),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: textSize, color: color),
        ),
      ),
    );
  }
}
