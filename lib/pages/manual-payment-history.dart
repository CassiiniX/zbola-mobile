import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import "../widgets/sidebar.dart";
import "../widgets/default-app-bar.dart";

import '../providers/user.dart';

import './signin.dart';

class ManualPaymentHistory extends StatelessWidget{
  bool? isLogin;

  ManualPaymentHistory(BuildContext context){
    this.isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        appBar: defaultAppBar("Manual Payment History",context),
        drawer: Sidebar(parentContext: context),
        body : Container(
          alignment: Alignment.center, 
          child : Text('Manual Payment History') 
        )
      )
    );
  }
}