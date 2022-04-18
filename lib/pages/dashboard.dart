import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import "../widgets/sidebar.dart";
import '../modals/notification-modal.dart';

import '../providers/user.dart';

import './signin.dart';

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
          backgroundColor: Colors.greenAccent[700],
          title : Container(
            alignment: Alignment.center,
            child : Text("Dashboard")
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
        body : DashboardScreen(context)
    ));
  }
}

class DashboardScreen extends StatefulWidget{
  final BuildContext parentContext;

  DashboardScreen(this.parentContext);

  @override 
  DashboardScreenState createState() => DashboardScreenState(parentContext);

}

class DashboardScreenState extends State<DashboardScreen>{
  final BuildContext parentContext;

  DashboardScreenState(this.parentContext);

  Map<String,dynamic>? invoice = null;


  Future<String> onLoad() async{
    return Future<String>.delayed(
      const Duration(seconds: 2),
      (){
        if(invoice == null){
          setState(() {
            invoice = {
              "id" : "",
              "status" : ""
            };
          });
        }

        return Future.value("Berhasil");
        // return Future.error("Terjadi Kesalahan");
      });    
  }

  Widget build(BuildContext context){
    return FutureBuilder(
      future: onLoad(),
      builder: (ctx,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.error != null){
            return Center(
              child: Text("Terjadi Kesalahan"),
            );
          }   

         return Padding(
          padding: EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
          child: RefreshIndicator(
            onRefresh: () async {
              print("Refresh");
            },

            child : invoice != null 
              ? Text("Invoice")
              : Container(
                margin: EdgeInsets.only(top : 100),
                child : Column(
                    children: [
                      Image.asset(
                      'images/invoice-404.png',
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 200,
                    ),
                    Padding(
                      padding : EdgeInsets.only(top : 30),
                      child : Text('Data tidak ditemukan',style : TextStyle(fontWeight: FontWeight.bold))
                    )
                  ]
                )
              )
          ));
      }
    );
  }
}
