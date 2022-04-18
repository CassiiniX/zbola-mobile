import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import "../widgets/sidebar.dart";
import "../widgets/default-app-bar.dart";
import '../providers/user.dart';

import './signin.dart';
import 'package:flutter/services.dart' show rootBundle;


// ignore: must_be_immutable
class Dashboard extends StatelessWidget{
  bool? isLogin;

  Dashboard(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  @override
  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        appBar: defaultAppBar("Dashboard",context),
        drawer: Sidebar(parentContext: context),
        body : DashboardScreen(context)
    ));
  }
}

class DashboardScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const DashboardScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  DashboardScreenState createState() => DashboardScreenState(parentContext);

}

class DashboardScreenState extends State<DashboardScreen>{
  final BuildContext parentContext;

  DashboardScreenState(this.parentContext);

  Map<String,dynamic>? invoice;

  Future<String> getJson() {
    return rootBundle.loadString('json/invoice.json');
  }

  Future<String> onLoad() async{
    try{
      return Future<String>.delayed(
        const Duration(seconds: 2),
        () async {
          if(invoice == null){
            var jsonInvoice = json.decode(await getJson());
            
            setState((){
              invoice = jsonInvoice;
            });
          }

          return Future.value("Berhasil");
        });    
    }catch(e){
      print(e);
      
      return Future.error("Terjadi Kesalahan");
    }
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: onLoad(),
      builder: (ctx,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            );
          }

          if(snapshot.error != null){
            return const Center(
              child: Text("Terjadi Kesalahan",style : TextStyle(color: Colors.red)),
            );
          }   

         return Padding(
          padding: const EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
          child: RefreshIndicator(
            onRefresh: () async => onLoad(),            
            child : invoice != null 
              ? const Text("Invoice Found")
              : Container(
                margin: const EdgeInsets.only(top : 100),
                child : Column(
                    children: [
                      Image.asset(
                      'images/invoice-404.png',
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 200,
                    ),
                    const Padding(
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
