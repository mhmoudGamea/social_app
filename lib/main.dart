import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './providers/tabs_provider.dart';
import './providers/user_data_provider.dart';
import './constants.dart';
import './screens/user/sign_in_screen.dart';
import './screens/user/sign_up_screen.dart';
import './firebase_options.dart';
import './screens/tabs_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/post_screen.dart';
import './screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserDataProvider.init(); // initialize sharedPreferences

  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final isDark = Provider.of<UserDataProvider>(context).getSharedPreferenceData(darkMode);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabsProvider()),
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
      ],
      child: Consumer<UserDataProvider>(
        builder: (context, data, _) {
          final isDark = data.getSharedPreferenceData(darkMode);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark != null ? (isDark == true ? ThemeMode.dark :  ThemeMode.light) : ThemeMode.light,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return snapshot.hasData ? const TabsScreen() : const SignInScreen();
              },
            ),
            routes: {
              SignInScreen.rn : (context) => const SignInScreen(),
              SignUpScreen.rn : (context) => const SignUpScreen(),
              TabsScreen.rn : (context) => const TabsScreen(),
              EditProfileScreen.rn : (context) => EditProfileScreen(),
              PostScreen.rn: (context) => PostScreen(),
              ChatScreen.rn: (context) => const ChatScreen(),
            },
          );
        },
      ),
    );
  }
}
