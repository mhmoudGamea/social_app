import 'package:flutter/material.dart';

import '../screens/layouts/chat_layout.dart';
import '../screens/layouts/setting_layout.dart';
import '../screens/layouts/users_layout.dart';
import '../screens/layouts/home_layout.dart';
import '../screens/post_screen.dart';

class TabsProvider with ChangeNotifier {
  var _initialIndex = 0;

  int get getIndex {
    return _initialIndex;
  }

  void changeInitialIndex(BuildContext context, int value) {
    if(value == 2) {
      Navigator.of(context).pushNamed(PostScreen.rn);
    }else {
      _initialIndex = value;
      notifyListeners();
    }
  }

  final List<Map<String, dynamic>> _screens = [
    {'title': 'Home', 'screen': const HomeLayout()},
    {'title': 'Chat', 'screen': const ChatLayout()},
    {'title': 'Post', 'screen': PostScreen()},
    {'title': 'Users', 'screen': const UsersLayout()},
    {'title': 'Setting', 'screen': const SettingLayout()},
  ];

  Map<String, dynamic> getScreen(int value) {
    return _screens.elementAt(value);
  }

}