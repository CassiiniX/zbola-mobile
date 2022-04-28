import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './providers/user.dart';
import './providers/notification.dart';
import './providers/field.dart';
import './providers/manual-payment-history.dart';
import './providers/invoice-history.dart';

import "./pages/signin.dart";
import "./pages/signup.dart";
import "./pages/dashboard.dart";
import "./pages/profil.dart";
import "./pages/invoice.dart";
import "./pages/invoice-history.dart";
import "./pages/manual-payment-history.dart";
import "./pages/field.dart";
import "./pages/field-detail.dart";

void main() async {
  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();

  final isLogin = prefs.getString('token') != null ? true : false;

  runApp(MyApp(isLogin));
}

class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final isLogin;

  // ignore: use_key_in_widget_constructors
  const MyApp(this.isLogin);

  @override
  Widget build(BuildContext context){    
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(
          create: (context) => UserProvider(isLogin)
        ),      
        ChangeNotifierProvider(
          create: (context) => NotificationProvider()
        ),      
        ChangeNotifierProvider(
          create: (context) => FieldProvider()
        ),  
        ChangeNotifierProvider(
          create: (context) => ManualPaymentHistoryProvider()
        ),
        ChangeNotifierProvider(
          create: (context) => InvoiceHistoryProvider(),
        )
      ],
      child : MaterialApp(
        routes: {
          '/' : (context) => Signin(context),
          '/signup' : (context) => Signup(context),    
          '/dashboard' : (context) => Dashboard(context),     
          '/profil' : (context) => Profil(context),
          '/invoice' : (context) => Invoice(context),
          '/invoice-history' : (context) => InvoiceHistory(context),
          '/manual-payment-history' : (context) => ManualPaymentHistory(context),
          '/field' : (context) => Field(context),
          '/field-detail' : (context) => FieldDetail(context)
        },
      )    
    );
  }
} 