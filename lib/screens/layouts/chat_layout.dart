import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/user_data_model.dart';
import '../../widgets/build_user_widget.dart';

class ChatLayout extends StatelessWidget {
  const ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(usersCollection).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(color: Colors.black, backgroundColor: Colors.grey,);
          }else {
            List<UserDataModel> users = [];
            for(var user in snapshot.data!.docs) {
              if(user.data()['uId'] != FirebaseAuth.instance.currentUser!.uid) {
                users.add(UserDataModel.fromJson(user.data()));
              }
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) => BuildUserWidget(user: users[index], isChat: true),
            );
          }
        }
    );
  }
}
