import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';
import '../widgets/custom_post_image_widget.dart';

class PostScreen extends StatelessWidget {
  static const String rn = '/post_screen';

  PostScreen({Key? key}) : super(key: key);

  final _postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserDataProvider>(context);
    final userData = data.getUserDataModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/images/arrowBack.svg',
              color: data.getDarkMode ? Colors.white : Colors.black,
              width: 24,
            )),
        titleSpacing: 10,
        title: Text(
          'Create Post',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 19),
        ),
        actions: [
          TextButton(
            onPressed: () async{
              await data.createUserPost(date: DateTime.now().toIso8601String(), text: _postController.text);
            },
            child: const Text(
              'POST',
              style: TextStyle(color: Colors.orange, fontSize: 16.2),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 9, right: 9, top: 10, bottom: 10),
        child: Column(
          children: [
            if(data.getIsPostLoading) LinearProgressIndicator(color: Colors.orange, backgroundColor: Colors.orange.shade100,),
            if(data.getIsPostLoading) const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userData!.profileImage!),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userData.name,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16)),
                    Text('Public',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.grey)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextFormField(
                controller: _postController,
                cursorColor: Colors.orange,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.grey),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What\'s in ur mind...',
                    hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.grey)),
              ),
            ),
            if(data.getPostImage != null) Consumer<UserDataProvider>(
              builder: (context, data, child) {
                return Column(
                  children: [
                    CustomPostImageWidget(image: data.getPostImage!, removeFn: data.removePostImage,),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      data.postPickedImage();
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    icon: SvgPicture.asset('assets/images/image.svg', width: 22, color: Colors.orange,),
                    label: const Text(
                      'ADD IMAGE',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    icon: SvgPicture.asset('assets/images/hashtag.svg', width: 21, color: Colors.orange,),
                    label: const Text(
                      'TAGS',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
