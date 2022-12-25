import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/user_data_model.dart';

import '../constants.dart';
import '../services/toast_message.dart';

class Authentications {
  // sign up user
  static Future<void> createUserByEmailAndPassword(
      {required String email,
      required String name,
      required String phone,
      required String password}) async {
    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ToastMessage.show(message: 'Sign up done successfully', backColor: Colors.green);

      // save user data in cloud firestore
      final db = FirebaseFirestore.instance;
      UserDataModel userDataModel = UserDataModel(
        email: email,
        name: name,
        phone: phone,
        uId: credentials.user!.uid,
        isVerify: false,
        coverImage:
            'https://img.freepik.com/free-photo/portrait-attractive-barefooted-young-female-with-curvy-body-exercising-home-sportwear-stretching-body-doing-upward-facing-dog-pose-opening-shoulders-chest-bending-her-back_343059-2040.jpg?w=1380&t=st=1670906555~exp=1670907155~hmac=10b8d52e87201effd9c356d92c42c48ac6a3b383185a41174b825879a88b3a38',
        profileImage: 'https://img.freepik.com/free-photo/attractive-plus-size-young-woman-practicing-meditation-living-room-achieve-mentally-calm-stable-state-keeping-eyes-closed_343059-2055.jpg?w=1380&t=st=1670906997~exp=1670907597~hmac=7ba84cb34e317b82b533086b86cc3298e62e0dd228b32576d109037534db2756',
        bio: 'Write ur bio..',
      );

      await db.collection('users').doc(credentials.user!.uid).set(userDataModel.toMap());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        ToastMessage.show(message: 'The password provided is too weak.', backColor: lightPurple);
      } else if (error.code == 'email-already-in-use') {
        ToastMessage.show(
            message: 'The account already exists for that email.', backColor: lightPurple);
      }
    } catch (error) {
      debugPrint('----------error in signup user--------------');
      ToastMessage.show(message: error.toString(), backColor: Colors.red);
    }
  }

  // sign in user
  static Future<void> signInUserByEmailAndPassword(String email, String password) async {
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      ToastMessage.show(message: 'Sign in done successfully', backColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastMessage.show(message: 'No user found for that email.', backColor: lightPurple);
      } else if (e.code == 'wrong-password') {
        ToastMessage.show(
            message: 'Wrong password provided for that user.', backColor: lightPurple);
      }
    } catch (error) {
      debugPrint('----------error in sign in user--------------');
      ToastMessage.show(message: error.toString(), backColor: Colors.red);
    }
  }
}
