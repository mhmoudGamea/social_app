import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import './my_drawer.dart';
import '../providers/tabs_provider.dart';
import '../providers/user_data_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class TabsScreen extends StatefulWidget {
  static const String rn = '/tabs_screen';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    Provider.of<UserDataProvider>(context, listen: false).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TabsProvider>(context);
    final darkMode = Provider.of<UserDataProvider>(context).getDarkMode;
    final tabIndex = data.getIndex;
    final myScreen = data.getScreen(tabIndex);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset('assets/images/hamburger.svg', color: darkMode ? Colors.white : Colors.black),
            );
          }
        ),
        title: Text(
          myScreen['title'],
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 19),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: SvgPicture.asset(
                'assets/images/notification.svg',
                color: darkMode ? Colors.white : Colors.black,
              ))
        ],
      ),
      drawer: const MyDrawer(),
      body: myScreen['screen'],
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
