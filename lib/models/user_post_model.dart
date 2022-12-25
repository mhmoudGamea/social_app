class UserPostModel {
  final String profileImage;
  final String name;
  final String date;
  final String postText;
  final String postImage;
  final String uId;

  UserPostModel({required this.profileImage, required this.name, required this.date, required this.postText, required this.postImage, required this.uId});

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(profileImage: json['profileImage'], name: json['name'], date: json['date'], postText: json['postText'], postImage: json['postImage'], uId: json['uId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'name': name,
      'date': date,
      'postText': postText,
      'postImage': postImage,
      'uId': uId,
    };
  }
}