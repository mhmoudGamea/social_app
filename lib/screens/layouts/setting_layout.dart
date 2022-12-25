import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/screens/edit_profile_screen.dart';

import '../../providers/user_data_provider.dart';
import '../../widgets/custom_cover_profile_widget.dart';

class SettingLayout extends StatelessWidget {
  const SettingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context).getUserDataModel;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          CustomCoverAndProfileWidget(
              cover: userData!.coverImage!, profile: userData.profileImage!),
          Text(
            userData.name,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 17),
          ),
          Text(
            userData.bio!,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.grey),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('20',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                    Text('Posts',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Text('100',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                    Text('Photo',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Text('10k',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                    Text('Followers',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Text('50',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                    Text('Followings',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: BorderSide(width: 1.5, color: Colors.grey.shade300)),
                  child: const Text(
                    'Add photo',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              OutlinedButton(onPressed: (){Navigator.of(context).pushNamed(EditProfileScreen.rn);}, style: OutlinedButton.styleFrom(side: BorderSide(width: 1.5, color: Colors.grey.shade300)),
                  child: SvgPicture.asset('assets/images/userEdit.svg', color: Colors.green, width: 18,))
            ],
          ),
        ],
      ),
    );
  }
}
