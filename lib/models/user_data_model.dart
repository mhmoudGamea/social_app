class UserDataModel {
  final String email;
  final String name;
  final String phone;
  final String uId;
  final String? coverImage;
  final String? profileImage;
  final String? bio;
  final bool isVerify;

  UserDataModel({required this.email, required this.name, required this.phone, required this.uId, required this.isVerify, this.coverImage, this.profileImage, this.bio});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(email: json['email'], name: json['name'], phone: json['phone'], uId: json['uId'], isVerify: json['isVerify'], coverImage: json['coverImage'], profileImage: json['profileImage'], bio: json['bio']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'coverImage': coverImage,
      'profileImage': profileImage,
      'bio': bio,
      'isVerify': isVerify,
    };
  }
}