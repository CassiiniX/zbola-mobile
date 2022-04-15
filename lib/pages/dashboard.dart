import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import "../components/sidebar.dart";

import '../providers/user.dart';

import './signin.dart';
// import "../providers/product.dart";
// import "../models/product.dart";

class Dashboard extends StatelessWidget{
  bool? isLogin;

  Dashboard(BuildContext context){
    this.isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        appBar: AppBar(
          title : Text("Dashboard"),      
        ),
        body : Text('Hello')
      )
    );
  }
}