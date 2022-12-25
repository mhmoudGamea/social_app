import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_message_model.dart';
import '../models/user_post_model.dart';
import '../constants.dart';
import '../models/user_data_model.dart';

class UserDataProvider with ChangeNotifier {
  // the data that i save while sign up (email, name, phone, uId, isEmailVerified)
  // by using FirebaseFirestore
  UserDataModel? _userDataModel;

  UserDataModel? get getUserDataModel {
    return _userDataModel;
  }

  void getUserData() async {
    final uId = FirebaseAuth.instance.currentUser!.uid;
    final userData = await FirebaseFirestore.instance.collection(usersCollection).doc(uId).get();
    _userDataModel = UserDataModel.fromJson(userData.data()!);
    notifyListeners();
  }

  /* user profile and update profile data section */
  //get updated user Cover picture
  final ImagePicker _picker = ImagePicker();

  File? _cover;

  File? get getUpdatedCoverImage {
    return _cover;
  }

  Future<void> updateCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _cover = File(image!.path);
    notifyListeners();
  }

  //get updated user profile picture
  File? _profile;

  File? get getUpdatedProfileImage {
    return _profile;
  }

  Future<void> updateProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _profile = File(image!.path);
    notifyListeners();
  }

  // uploading the selected image
  final _storageRef = FirebaseStorage.instance.ref();

  String? _coverUrl;

  Future<void> uploadCoverImage() async {
    final coverImage = _storageRef.child('users').child(Uri.file(_cover!.path).pathSegments.last);
    try {
      await coverImage.putFile(_cover!);
      _coverUrl = await coverImage.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  String? _profileUrl;

  Future<void> uploadProfileImage() async {
    final coverImage = _storageRef.child('users').child(Uri.file(_profile!.path).pathSegments.last);
    try {
      await coverImage.putFile(_profile!);
      _profileUrl = await coverImage.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  var _isUpdateLoading = false;

  bool get getIsUpdateLoading {
    return _isUpdateLoading;
  }

  void updateUserData(String? name, String? bio, String? phone) async {
    _isUpdateLoading = true;
    notifyListeners();
    if (_cover != null) {
      await uploadCoverImage();
    } else if (_profile != null) {
      await uploadProfileImage();
    }
    _userDataModel = UserDataModel(
      email: _userDataModel!.email,
      name: name ?? _userDataModel!.name,
      bio: bio ?? _userDataModel!.bio,
      phone: phone ?? _userDataModel!.phone,
      uId: _userDataModel!.uId,
      isVerify: false,
      coverImage: _coverUrl ??= _userDataModel!.coverImage,
      profileImage: _profileUrl ??= _userDataModel!.profileImage,
    );
    try {
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(_userDataModel!.uId)
          .update(_userDataModel!.toMap());
      _isUpdateLoading = false;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /* user posts uploads section */

  // pick post image first
  File? _postImage;

  File? get getPostImage {
    return _postImage;
  }

  void removePostImage() {
    _postImage = null;
    notifyListeners();
  }

  void postPickedImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _postImage = File(image!.path);
    notifyListeners();
  }

  // upload postImage to FirebaseFireStorage second
  String? _postImageUrl;

  Future<void> uploadPostImage() async {
    final uploadPostImage =
        _storageRef.child('posts').child(Uri.file(_postImage!.path).pathSegments.last);
    try {
      await uploadPostImage.putFile(_postImage!);
      _postImageUrl = await uploadPostImage.getDownloadURL();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // create the post third
  var _isPostLoading = false;

  bool get getIsPostLoading {
    return _isPostLoading;
  }

  Future<void> createUserPost({required String date, required String text}) async {
    _isPostLoading = true;
    notifyListeners();
    if (_postImage != null) {
      await uploadPostImage();
    }
    UserPostModel userPostModel = UserPostModel(
      name: _userDataModel!.name,
      uId: _userDataModel!.uId,
      profileImage: _userDataModel!.profileImage!,
      postImage: _postImageUrl ??= '',
      date: date,
      postText: text,
    );
    try {
      await FirebaseFirestore.instance.collection(postsCollection).add(userPostModel.toMap());
      _isPostLoading = false;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /* add & get post Likes for each user */

  // // add like in firestore to the post when user press heart icon
  // void postLike(String postId) async {
  //   await FirebaseFirestore.instance.collection(postsCollection).doc(postId).collection(likesCollection).doc(_userDataModel!.uId).set({
  //     'like': true
  //   });
  //   await showLikes(postId);
  // }
  //
  // // show likes to user
  // var count = 0;
  // int get getLikesCounts {
  //   return count;
  // }
  // Future<void> showLikes(String postId) async {
  //   count = 0;
  //   final usersLikes = await FirebaseFirestore.instance.collection(postsCollection).doc(postId).collection(likesCollection).get();
  //   for (var element in usersLikes.docs) {
  //     if(element['like']) {
  //       count++;
  //     }
  //   }
  //   notifyListeners();
  // }

  /* send message section */

  UserMessageModel? _userMessageModel;

  void sendMessage(
      {required String receiver, required String message, required String date}) async {
    _userMessageModel = UserMessageModel(
        date: date, sender: _userDataModel!.uId, receiver: receiver, message: message);
    await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(_userDataModel!.uId)
        .collection(chatsCollection)
        .doc(receiver)
        .collection(messagesCollection)
        .add(_userMessageModel!.toMap());
    await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(receiver)
        .collection(chatsCollection)
        .doc(_userDataModel!.uId)
        .collection(messagesCollection)
        .add(_userMessageModel!.toMap());
  }

  /* storing data in sharedPreferences */
  static late SharedPreferences _sharedPreferences;
  static Future<void> init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  var _darkMode = false;

  bool get getDarkMode {
    return _darkMode;
  }

  void setSharedPreferenceData(bool value) async{
    _darkMode = value;
    notifyListeners();
    await _sharedPreferences.setBool(darkMode, value);
  }

  bool? getSharedPreferenceData(String key) {
    return _sharedPreferences.getBool(key);
  }
}
