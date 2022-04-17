import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import "../widgets/sidebar.dart";
import '../modals/notification-modal.dart';

import '../providers/user.dart';

import './signin.dart';

class Invoice extends StatelessWidget{
  bool? isLogin;

  Invoice(BuildContext context){
    this.isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[700],
          title : Container(
            alignment: Alignment.center,
            child : Text("Invoice")
          ),   
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              onPressed: (){
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,         
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context){
                    return NotificationModal(context);
                  }
                );
              },
              icon: Icon(Icons.notifications_active)
            ),
          ]   
        ),
        drawer: Sidebar(parentContext: context),
        body : Container(
          alignment: Alignment.center, 
          child : Text('Invoice') 
        )
      )
    );
  }
}