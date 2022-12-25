import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/user_data_provider.dart';

import '../widgets/drawer_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
          child: Column(
            children: [
              DrawerWidget(
                text: 'Dark mode',
                icon: 'assets/images/moon.svg',
                function: () {},
              ),
              DrawerWidget(
                text: 'Sign out',
                icon: 'assets/images/signOut.svg',
                function: signOut,
              ),
            ],
          ),
        ));
  }
}
