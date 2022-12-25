import 'dart:io';

import 'package:flutter/material.dart';

import './image_box_widget.dart';

enum ImageState {
  cover,
  profile,
  post,
}

class CustomCoverAndProfileWidget extends StatelessWidget {
  final dynamic cover;
  final dynamic profile;
  final bool editingMode;

  const CustomCoverAndProfileWidget(
      {Key? key, required this.cover, required this.profile, this.editingMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 205,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: cover is File
                      ? Image.file(
                          cover,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        )
                      : Image.network(
                          cover,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                ),
                if (editingMode == true)
                  const Positioned(
                    right: 10,
                    top: 10,
                    child: ImageBoxWidget(image: 'assets/images/image.svg', imageState: ImageState.cover, backgroundColor: Colors.green,),
                  ),
              ],
            ),
            Positioned(
              bottom: 5,
              child: Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(130),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ]),
                    child: profile is File
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.file(
                              profile,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.network(
                              profile,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                  ),
                  if (editingMode == true)
                    const Positioned(
                      right: 0,
                      top: 70,
                      child: ImageBoxWidget(image: 'assets/images/image.svg', imageState: ImageState.profile, backgroundColor: Colors.green,),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
