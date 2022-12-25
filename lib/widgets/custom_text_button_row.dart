import 'package:flutter/material.dart';
import 'package:social_app/constants.dart';

class CustomTextButtonRow extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback navigate;
  const CustomTextButtonRow({Key? key, required this.text, required this.buttonText, required this.navigate,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text, style: Theme.of(context).textTheme.subtitle1,),
          const SizedBox(width: 10),
          InkWell(
            onTap: navigate,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey.withOpacity(0.4)
              ),
              child: Text(buttonText, style: const TextStyle(fontSize: 14, color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
