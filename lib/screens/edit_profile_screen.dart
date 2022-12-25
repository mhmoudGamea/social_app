import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';
import '../widgets/custom_cover_profile_widget.dart';
import '../widgets/custom_text_form.dart';

class EditProfileScreen extends StatelessWidget {
  static const String rn = '/edit_profile';

  EditProfileScreen({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();
  String? name;
  String? bio;
  String? phone;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context).getUserDataModel;
    final data = Provider.of<UserDataProvider>(context);
    _nameController.text = userData!.name;
    _bioController.text = userData.bio!;
    _phoneController.text = userData.phone;

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
          ),
        ),
        titleSpacing: 5,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 19),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<UserDataProvider>(context, listen: false)
                  .updateUserData(name, bio, phone);
            },
            child: const Text(
              'UPDATE',
              style: TextStyle(color: Colors.green, fontSize: 16.2),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              if(data.getIsUpdateLoading) LinearProgressIndicator(
                  color: Colors.green, backgroundColor: Colors.green.shade100, minHeight: 4.5),
              if(data.getIsUpdateLoading) const SizedBox(height: 4),
              Consumer<UserDataProvider>(
                builder: (context, updatedData, _) {
                  return CustomCoverAndProfileWidget(
                    cover: updatedData.getUpdatedCoverImage ?? userData.coverImage!,
                    profile: updatedData.getUpdatedProfileImage ?? userData.profileImage!,
                    editingMode: true,
                  );
                },
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    CustomTextForm(
                      hint: 'Name',
                      onChange: (value) {
                        name = value;
                      },
                      validate: (value) {
                        return null;
                      },
                      borderColor: data.getDarkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
                      text: _nameController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      hint: 'Bio',
                      onChange: (value) {
                        bio = value;
                      },
                      validate: (value) {
                        return null;
                      },
                      borderColor: data.getDarkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
                      text: _bioController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      hint: 'Phone',
                      onChange: (value) {
                        phone = value;
                      },
                      validate: (value) {
                        return null;
                      },
                      borderColor: data.getDarkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
                      text: _phoneController,
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
