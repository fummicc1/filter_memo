import 'package:flutter/material.dart';

class Memo {
  final List<String> features;
  final String content;
  final DateTime postDate;

  Memo(this.features, this.postDate, this.content);
}