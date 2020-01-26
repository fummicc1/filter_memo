import 'package:intl/intl.dart';

class Memo {
  String content;

  Memo(this.content);

  Map<String, dynamic> toJson() {
    return {
      "content": content,
    };
  }

  Memo.fromJson(Map<String, dynamic> json) {
    content = json["content"];
  }
}