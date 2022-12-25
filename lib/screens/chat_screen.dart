import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/user_data_provider.dart';

import '../constants.dart';
import '../models/user_message_model.dart';
import '../models/user_data_model.dart';
import '../widgets/send_message_widget.dart';

class ChatScreen extends StatelessWidget {
  static const String rn = '/chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserDataModel;
    final senderUid = FirebaseAuth.instance.currentUser!.uid;
    final darkMode = Provider.of<UserDataProvider>(context).getDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/images/arrowBack.svg',
            color: darkMode ? Colors.white : Colors.black,
            width: 24,
          ),
        ),
        titleSpacing: 5,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.profileImage!),
            ),
            const SizedBox(width: 10),
            Text(user.name, style: Theme.of(context).textTheme.subtitle2)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(usersCollection)
                      .doc(senderUid)
                      .collection(chatsCollection)
                      .doc(user.uId)
                      .collection(messagesCollection)
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LinearProgressIndicator(
                          color: Colors.black, backgroundColor: Colors.grey);
                    } else if (snapshot.hasError) {
                      debugPrint(snapshot.error.toString());
                    }
                    List<UserMessageModel> userMessages = [];
                    for (var my in snapshot.data!.docs) {
                      userMessages.add(UserMessageModel.fromJson(my.data()));
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: userMessages.length,
                      itemBuilder: (context, index) => buildMessageWidget(context,
                          senderUid == userMessages[index].sender, userMessages[index].message),
                    );
                  }),
            ),
            SendMessageWidget(receiverId: user.uId),
          ],
        ),
      ),
    );
  }

  Widget buildMessageWidget(BuildContext context, bool isMe, String text) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        constraints: const BoxConstraints(maxWidth: 250, maxHeight: 200),
        decoration: BoxDecoration(
          color: isMe ? Colors.green[300] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
            bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
          ),
        ),
        child:
            Text(text, style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black)),
      ),
    );
  }
}
