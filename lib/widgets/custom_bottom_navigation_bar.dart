import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/constants.dart';

import '../providers/tabs_provider.dart';
import '../providers/user_data_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<UserDataProvider>(context).getDarkMode;
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1.2, color: Colors.black.withAlpha(50)))),
      child: Consumer<TabsProvider>(
        builder: (context, data, _) => BottomNavigationBar(
          currentIndex: data.getIndex,
          onTap: (value) {
            data.changeInitialIndex(context, value);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/home.svg',
                  color: darkMode ? (data.getIndex == 0 ? Colors.white : Colors.grey.withOpacity(0.5)) : (data.getIndex == 0 ? Colors.black : Colors.black.withAlpha(50)),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/chat.svg',
                color: darkMode ? (data.getIndex == 1 ? Colors.white : Colors.grey.withOpacity(0.5)) : (data.getIndex == 1 ? Colors.black : Colors.black.withAlpha(50)),
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/add.svg',
                color: darkMode ? (data.getIndex == 2 ? Colors.white : Colors.grey.withOpacity(0.5)) : (data.getIndex == 2 ? Colors.black : Colors.black.withAlpha(50)),
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/users.svg',
                  color: darkMode ? (data.getIndex == 3 ? Colors.white : Colors.grey.withOpacity(0.5)) : (data.getIndex == 3 ? Colors.black : Colors.black.withAlpha(50)),
                ),
                label: 'Users'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/setting.svg',
                  color: darkMode ? (data.getIndex == 4 ? Colors.white : Colors.grey.withOpacity(0.5)) : (data.getIndex == 4 ? Colors.black : Colors.black.withAlpha(50)),
                ),
                label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
