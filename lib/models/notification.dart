import 'package:flutter/foundation.dart';

class ModelNotification{
  int? id;  
  String? title;
  String? content;
  bool? read;

  ModelNotification({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.read,
  });  
}