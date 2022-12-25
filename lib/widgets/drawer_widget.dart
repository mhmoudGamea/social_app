import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';

class DrawerWidget extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback function;

  const DrawerWidget({Key? key, required this.text, required this.icon, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkModeData = Provider.of<UserDataProvider>(context);
    return InkWell(
      onTap: function,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(right: 7, left: 7),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black),
            ),
            const Spacer(),
            if (!text.contains('Dark'))
              SvgPicture.asset(
                icon,
                color: Colors.black,
              ),
            if (text.contains('Dark'))
              Switch(
                value: darkModeData.getDarkMode,
                onChanged: (value) {
                  darkModeData.setSharedPreferenceData(value);
                },
                activeColor: Colors.black,
              )
          ],
        ),
      ),
    );
  }
}
