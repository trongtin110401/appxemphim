import 'Token.dart';
class Message {
  String? message;
  Token? token;

  Message({this.message, this.token});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}