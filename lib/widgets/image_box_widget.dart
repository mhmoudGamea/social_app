import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';
import './custom_cover_profile_widget.dart';

class ImageBoxWidget extends StatelessWidget {
  final String image;
  final ImageState imageState;
  final Color backgroundColor;
  const ImageBoxWidget({Key? key, required this.image, required this.imageState, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserDataProvider>(context, listen: false);
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: IconButton(
        onPressed: () async{
          if(imageState == ImageState.cover) {
            await data.updateCoverImage();
          } else if(imageState == ImageState.profile) {
            await data.updateProfileImage();
          } else {
            data.removePostImage();
          }
        },
        icon: SvgPicture.asset(
          image,
          color: Colors.white,
          width: 30,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
