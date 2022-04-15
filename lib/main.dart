import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './providers/user.dart';

import "./pages/signin.dart";
import "./pages/signup.dart";

void main() async {
  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();

  final isLogin = prefs.getString('token') != null 
    ? true
    : false;

  runApp(MyApp(isLogin));
}

class MyApp extends StatelessWidget {
  final isLogin;

  MyApp(this.isLogin);

  Widget build(BuildContext context){    
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(
          create: (context) => UserProvider(isLogin)
        ),      
      ],
      child : MaterialApp(
        routes: {
          '/' : (context) => Signin(context),
          '/signup' : (context) => Signup(context),         
        },
      )    
    );
  }
} 