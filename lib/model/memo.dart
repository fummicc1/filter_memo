import 'package:flutter/material.dart';

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
  final List<String> features;
  final String content;
  final DateTime postDate;


  Memo(this.features, this.postDate, this.content);
}