import 'package:flutter/foundation.dart';

class ModelUser{
  int? id;  
  String? username;
  String? email;
  String? photo;
  String? role;

  ModelUser({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.photo,
    @required this.role
  });  
}