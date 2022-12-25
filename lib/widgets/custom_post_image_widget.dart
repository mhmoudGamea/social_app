import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/widgets/custom_cover_profile_widget.dart';
import 'package:social_app/widgets/image_box_widget.dart';

class CustomPostImageWidget extends StatelessWidget {
  final File image;
  final VoidCallback removeFn;
  const CustomPostImageWidget({Key? key, required this.image, required this.removeFn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          SizedBox(
            height: 150,
            child: Image.file(image, fit: BoxFit.cover, width: double.infinity,),
          ),
          const Positioned(
            top: 5,
            right: 5,
            child: ImageBoxWidget(image: 'assets/images/remove.svg', imageState: ImageState.post, backgroundColor: Colors.orange),
          ),
        ],
      ),
    );
  }
}
