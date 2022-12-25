import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/user_data_provider.dart';

import '../../constants.dart';
import '../../models/user_post_model.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(left: 8, right: 8),
            elevation: 3,
            child: Image(
              image: AssetImage('assets/images/g3.webp'),
              fit: BoxFit.cover,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection(postsCollection).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) return const LinearProgressIndicator(color: Colors.black, backgroundColor: Colors.grey,);
              List<UserPostModel> userPosts = [];
              List<String> postsId = [];
              for (var element in snapshot.data!.docs) {
                postsId.add(element.id);
                userPosts.add(UserPostModel.fromJson(element.data()));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userPosts.length,
                itemBuilder: (context, index) => buildPostItem(userPosts[index], context, postsId[index]),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(UserPostModel model, BuildContext context, String postId) {
    final darkMode = Provider.of<UserDataProvider>(context).getDarkMode;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
      elevation: 3,
      color: darkMode ? Colors.grey.withOpacity(0.5) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(model.profileImage),
                  radius: 30,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 15, height: 1.1),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/images/verify.svg',
                          color: Colors.blue,
                          width: 15,
                        )
                      ],
                    ),
                    Text(
                      DateFormat.yMMMd().add_jm().format(DateTime.parse(model.date)),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 12, color: Colors.grey, height: 1.8),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_rounded, color: Colors.black))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(thickness: 1),
            ),
            Text(
              model.postText,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.8,
                  ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: Wrap(
            //     children: const [
            //       CustomHashTagButton(text: '#software'),
            //       CustomHashTagButton(text: '#flutter'),
            //       CustomHashTagButton(text: '#programming'),
            //       CustomHashTagButton(text: '#dart'),
            //       CustomHashTagButton(text: '#firebase'),
            //     ],
            //   ),
            // ),
            if(model.postImage.isNotEmpty) Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.only(top: 8, bottom: 5),
              elevation: 3,
              child: Image.network(
                model.postImage,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/heart.svg',
                      width: 18,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '0',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/comment.svg',
                      width: 18,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    '0 comments',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Divider(thickness: 1),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(model.profileImage),
                  radius: 17,
                ),
                const SizedBox(width: 8),
                InkWell(
                    onTap: () {},
                    child: Text(
                      'Write a comment..',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 12, color: Colors.grey),
                    )),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/heart.svg',
                    width: 18,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Like',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
                ),
                const SizedBox(width: 15),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/share.svg',
                    width: 18,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'share',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
