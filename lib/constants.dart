import 'package:flutter/material.dart';

const Color darkPurple = Color(0xff663ca7);
const Color intermediatePurple = Color(0xffa059f1);
const Color lightPurple = Color(0xffa780e8);

const Color darkBlack = Color(0xff1c1c1c);
const Color lightBlack = Color(0xff292927);

const String fontName = 'M PLUS Rounded 1c';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black.withAlpha(50),
    showUnselectedLabels: true,
  ),
  fontFamily: fontName,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    subtitle1: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
    // what i use
    subtitle2: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(color: darkBlack, elevation: 0),
    scaffoldBackgroundColor: darkBlack,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBlack,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      showUnselectedLabels: true,
    ),
    fontFamily: fontName,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
      // what i use
      subtitle2: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    ));

// collections names in cloud firestore
const String usersCollection = 'users';
const String postsCollection = 'posts';
const String likesCollection = 'likes';
const String chatsCollection = 'chats';
const String messagesCollection = 'messages';

// shared preferences dark & light mode
const String darkMode = 'isDark';
