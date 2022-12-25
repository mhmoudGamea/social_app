class UserMessageModel {
  final String date;
  final String sender;
  final String receiver;
  final String message;

  UserMessageModel({required this.date, required this.sender, required this.receiver, required this.message});

  factory UserMessageModel.fromJson(Map<String, dynamic> json) {
    return UserMessageModel(date: json['date'], sender: json['sender'], receiver: json['receiver'], message: json['message']);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'sender': sender,
      'receiver': receiver,
      'message': message,
    };
  }
}