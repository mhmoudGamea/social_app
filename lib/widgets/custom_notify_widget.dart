import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNotifyWidget extends StatelessWidget {
  final String icon;
  final String message;
  final String buttonText;
  final VoidCallback function;
  const CustomNotifyWidget({Key? key, required this.icon, required this.message, required this.buttonText, required this.function,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.amber.withAlpha(150),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(
            icon,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(fontSize: 14, color: Colors.black, letterSpacing: 1.1, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          TextButton(
            onPressed: function,
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
/*
Consumer<UserDataProvider>(
      builder: (context, data, _) {
        final userData = data.getUserDataModel;
        if (userData != null && userData.isVerify == false) {
          return CustomNotifyWidget(
            icon: 'assets/images/warning.svg',
            message: 'please verify your email.',
            buttonText: 'Send',
            function: emailVerification,
          );
        } else {
          return const CircleProgressWidget();
        }
      },
    );
 */
