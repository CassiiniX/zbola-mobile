import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import "../helpers/toast.dart";
import '../widgets/spinner.dart';

import '../providers/user.dart';

import "./dashboard.dart";
import 'dart:async';

class Signin extends StatelessWidget{
  bool? isLogin;

  Signin(BuildContext context){
    this.isLogin = Provider.of<UserProvider>(context)
      .getIsLogin();
  } 

  Widget build(BuildContext context){
    if(isLogin == true){
      return Dashboard(context);
    }

    return MaterialApp(
      home : Scaffold(      
        backgroundColor : Colors.white,
        body : Padding(
          padding : EdgeInsets.only(
            left : 40,
            right : 40
          ),
          child : Column(    
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(                      
                child: Image.asset(
                  'images/welcome.png',
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                )
              ),      

              Container(
                margin: EdgeInsets.only(top : 25,bottom: 10),
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Masuk",style : TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                  ]
                )
              ),

              Container( 
                margin: EdgeInsets.only(top : 25,bottom: 10),
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children : [
                    Text("Masuk ke akun anda sekarang")
                  ]
                )
              ),

              SigninScreen(context),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [                
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed("/signup");
                      },
                      child : Text("Belum punya akun?",
                        style : TextStyle(
                          color: Colors.blueAccent
                        )
                    )
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }
}

class SigninScreen extends StatefulWidget{
  final BuildContext parentContext;

  SigninScreen(this.parentContext);

  @override 
  SigninScreenState createState() => SigninScreenState(this.parentContext);
}

class SigninScreenState extends State<SigninScreen>{
  final BuildContext parentContext;

  SigninScreenState(this.parentContext);

  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool isLoadingForm = false;

  @override 
  void dispose(){    
    super.dispose();
  }

  @override 
  Widget build(BuildContext context){
    return Container(
      child : Form(
        key: formKey,
        child: Column(
          children: [
            EmailField(),
            PasswordField(),           
            Row(      
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SigninButton()
              ]
            ),            
          ],
        ),
      )
    );
  }

  Widget EmailField(){
    return Container( 
      margin : EdgeInsets.only(top : 10,bottom :10),
      child : TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
        ),
        validator: (value) {        
          if(value!.isEmpty){
            return "Email tidak boleh kosong";
          }

          if(value.contains('@') == false){
            return "Email tidak valid";
          }

          return null;
        },
        onSaved: (String? value) { 
          email = value.toString();
        },
      )
    );
  }

  Widget PasswordField(){
    return Container(
      margin : EdgeInsets.only(top : 10,bottom :10),
      child : TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
        ),
        validator: (value){
          if(value!.isEmpty){
            return "Password tidak boleh kosong";
          }

          if(value.length <= 7){
            return "Password tidak boleh kurang dari 8";
          }

          return null;
        },
        onSaved: (String? value) { 
          password = value.toString();
        },
      )
    );
  }

  Widget SigninButton(){
    return Container(
      margin: EdgeInsets.only(top : 30,bottom: 20),
      child : ElevatedButton(        
        style : ElevatedButton.styleFrom(
            primary: isLoadingForm == true 
              ? Colors.lightGreen[200] 
              : Colors.lightGreen[600],
            onPrimary: Colors.white,          
            textStyle: TextStyle(
              fontSize: 14
            ),
            fixedSize : Size(130,40),
            shape: StadiumBorder()
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoadingForm == true
                ? Spinner( icon: Icons.rotate_right )        
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon( Icons.save),
                    Padding(
                      padding: EdgeInsets.only(left : 3),
                      child : Text("Kirim",style: TextStyle(fontSize: 14))
                    )
                  ])              
            ],
          )
        ),
        onPressed: (){
          if(formKey.currentState!.validate()){
              formKey.currentState?.save(); 
              onSubmit();
          }
        },
      )
    );
  }

  void onSubmit(){
    if(isLoadingForm) return;

    setState((){
      isLoadingForm = true;
    });

    try{   
      // SUCCESS SIMULATION
      Timer(Duration(seconds: 5), () async{      
          var responseBody = <String,dynamic>{
            "access_token" : "TOKEN",
            "user" : <String,dynamic>{
              "id" : 1,
              "username" : "user",
              "email" : "user@gmail.com",
              "photo" : "default.png",
              "role" : "user"
            }
          };

          final prefs = await SharedPreferences.getInstance();

          await prefs.setString('token', 'Bearer '+responseBody["access_token"]);
          
          Provider.of<UserProvider>(context,listen: false)
            .setUser(<String,dynamic>{
              "id" : responseBody["user"]["id"],
              "username" : responseBody["user"]["username"],
              "email" : responseBody["user"]["email"],
              "photo" : responseBody["user"]["photo"],
              "role"   : responseBody["user"]["role"]
          });

          Provider.of<UserProvider>(context,listen: false)
            .setIsLogin(true);               
      });
    }catch(e){
      print(e);

      ToastFailed("Terjadi Kesalahan");

      setState(() {    
        isLoadingForm = false;
      });
    }  
  }

  // void onSubmit() async {
  //   if(isLoadingForm) return;

  //   setState(() {    
  //     isLoadingForm = true;
  //   });    
    
  //   try{    
  //       var response = await http.post(
  //         Uri.parse(dotenv.env['API_URL']! + "/signin"),
  //         headers : {
  //            "Content-Type": "application/json"
  //         },
  //         body : jsonEncode({
  //           "email" : email,
  //           "password" : password,
  //         })
  //       );    

  //       if(response.statusCode != 200){
  //         setState(() {    
  //           isLoadingForm = false;
  //         });
  //       }

  //       if(response.statusCode == 404){
  //         ToastFailed("Url tidak ditemukan");         
  //       }else if(response.statusCode == 422){        
  //         ToastFailed(json.decode(response.body)["message"] ?? "Terjadi Kesalahan");
  //       }else if(response.statusCode == 500){
  //         ToastFailed(json.decode(response.body)["message"] ?? "Terjadi Kesalahan");
  //       }else if(response.statusCode == 200){
  //         var responseBody = json.decode(response.body);

  //         final prefs = await SharedPreferences.getInstance();

  //         await prefs.setString('token', 'Bearer '+responseBody["access_token"]);
          
  //         Provider.of<UserProvider>(context,listen: false)
  //           .setUser(<String,dynamic>{
  //             "id" : responseBody["user"]["id"],
  //             "username" : responseBody["user"]["username"],
  //             "email" : responseBody["user"]["email"],
  //             "photo" : responseBody["user"]["photo"],
  //             "role"   : responseBody["user"]["role"]
  //         });

  //         Provider.of<UserProvider>(context,listen: false)
  //           .setIsLogin(true);                  
  //       }else{
  //         print(response.statusCode);
          
  //         ToastFailed("Terjadi Kesalahan");
  //       }
  //   }catch(e){
  //     print(e);

  //     ToastFailed("Terjadi Kesalahan");

  //     setState(() {    
  //       isLoadingForm = false;
  //     });
  //   }
  // }
}