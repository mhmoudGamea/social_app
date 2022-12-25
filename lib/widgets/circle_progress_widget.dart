import 'package:flutter/material.dart';
import 'package:social_app/constants.dart';

class CircleProgressWidget extends StatelessWidget {
  final Color color;
  const CircleProgressWidget({Key? key, this.color = darkPurple}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color,),);
  }
}
