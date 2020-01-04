const List<String> featureList = [
  "大学生",
  "会社員",
  "パート",
  "メガネ",
  "プログラミング",
  "野球",
  "サッカー",
  "テニス",
  "卓球",
  "バドミントン",
  "バスケットボール",
  "水泳"
];

class Memo {
  List<String> features;
  String content;
  DateTime postDate;

  Memo(this.features, this.postDate, this.content);

  Map<String, dynamic> toJson() {
    return {
      "features": features,
      "content": content,
      "post_date": postDate.millisecondsSinceEpoch,
    };
  }

  Memo.fromJson(Map<String, dynamic> json) {
    features = json["features"];
    content = json["content"];
    postDate = DateTime.fromMillisecondsSinceEpoch(json["post_date"]);
  }
}