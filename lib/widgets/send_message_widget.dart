import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';

class SendMessageWidget extends StatelessWidget {
  String receiverId;
  SendMessageWidget({Key? key, required this.receiverId}) : super(key: key);

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black, fontSize: 13),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something...',
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 13, color: Colors.black)
                ),
              ),
            ),
            Consumer<UserDataProvider>(
              builder: (context, data, ch) {
                return InkWell(
                  onTap: (){
                    data.sendMessage(receiver: receiverId, message: _controller.text, date: DateTime.now().toIso8601String());
                    _controller.clear();
                  },
                  child: ch,
                );
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: SvgPicture.asset('assets/images/send.svg', fit: BoxFit.scaleDown, color: Colors.black,),
              ),
            ),
          ],
        )
    );
  }
}
