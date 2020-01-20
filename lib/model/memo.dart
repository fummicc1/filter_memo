import 'package:intl/intl.dart';

class Memo {
  String content;
  DateTime postDate;
  String get postDateFormatted {
    final formatter = DateFormat("yyyy-MM-dd HH:mm");
    return formatter.format(postDate);
  }

  Memo(this.postDate, this.content);

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "post_date": postDate.millisecondsSinceEpoch,
    };
  }

  Memo.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    postDate = DateTime.fromMillisecondsSinceEpoch(json["post_date"]);
  }
}