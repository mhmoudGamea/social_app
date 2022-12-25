import 'package:flutter/material.dart';
import 'package:social_app/models/user_data_model.dart';

import '../screens/chat_screen.dart';

class BuildUserWidget extends StatelessWidget {
  final UserDataModel user;
  final bool isChat;
  const BuildUserWidget({Key? key, required this.user, this.isChat = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isChat ? null : (){
        Navigator.of(context).pushNamed(ChatScreen.rn, arguments: user);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.profileImage!),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16),),
                Text(user.bio!, style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.grey,
                  fontSize: 13,
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
