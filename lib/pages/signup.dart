import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
// import 'dart:convert';

import "../helpers/toast.dart";
import '../widgets/spinner.dart';

import '../providers/user.dart';

import "./dashboard.dart";

 // ignore: must_be_immutable
 class Signup extends StatelessWidget{
  bool? isLogin;

  Signup(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context)
      .getIsLogin();
  } 

  @override
  Widget build(BuildContext context){
    if(isLogin == true){
      return Dashboard(context);
    }

    return MaterialApp(
      home : Scaffold(      
        backgroundColor : Colors.white,
        body : 
        SingleChildScrollView(
          child: Padding(
          padding : const EdgeInsets.only(
            left : 40,
            right : 40
          ),
          child : Column(    
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'images/welcome.png',
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
              ),

              Container(
                margin: const EdgeInsets.only(top : 25,bottom: 10),
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : const [
                    Text("Daftar",style :  TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                  ]
                )
              ),

              Container( 
                margin: const EdgeInsets.only(top : 25,bottom: 10),
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children : const [
                    Text("Daftar sekarang juga!")
                  ]
                )
              ),

              SignupScreen(context),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [                
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed("/");
                      },
                      child : const Text("Sudah punya akun?",
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
    )
    );
  }
}

class SignupScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const SignupScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  SignupScreenState createState() => SignupScreenState(parentContext);
}

class SignupScreenState extends State<SignupScreen>{
  final BuildContext parentContext;

  SignupScreenState(this.parentContext);

  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String username = '';
  String phone = '';
  bool isLoadingForm = false;

  @override 
  void dispose(){    
    super.dispose();
  }

  @override 
  Widget build(BuildContext context){
    return Form(
        key: formKey,
        child: Column(
          children: [
            usernameField(),
            phoneField(),
            emailField(),
            passwordField(),           
            Row(      
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                signinButton()
              ]
            ),            
          ],
        ),
    );
  }

  Widget usernameField(){
    return Container( 
      margin : const EdgeInsets.only(top : 10,bottom :10),
      child : TextFormField(
        decoration: const InputDecoration(
          labelText: "Username",
        ),
        validator: (value) {        
          if(value!.isEmpty){
            return "Username tidak boleh kosong";
          }

          return null;
        },
        onSaved: (String? value) { 
          username = value.toString();
        },
      )
    );
  }

  Widget phoneField(){
    return Container( 
      margin : const EdgeInsets.only(top : 10,bottom :10),
      child : Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Telp",
          ),
          validator: (value) {        
            if(value!.isEmpty){
              return "Telp tidak boleh kosong";
            }

            return null;
          },
          onSaved: (String? value) { 
            phone = value.toString();
          },
        ),
        Padding(
          padding : EdgeInsets.only(top : 10,bottom: 2),
          child : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("No telp harus *08",style : TextStyle(color: Colors.lightBlue,fontSize: 12))
          ]
        ))
      ]
      )
    );
  }

  Widget emailField(){
    return Container( 
      margin : const EdgeInsets.only(top : 10,bottom :10),
      child : TextFormField(
        decoration: const InputDecoration(
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

  Widget passwordField(){
    return Container(
      margin : const EdgeInsets.only(top : 10,bottom :10),
      child : TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
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

  Widget signinButton(){
    return Container(
      margin: const EdgeInsets.only(top : 30,bottom: 20),
      child : ElevatedButton(        
        style : ElevatedButton.styleFrom(
            primary: isLoadingForm == true 
              ? Colors.lightGreen[200] 
              : Colors.lightGreen[600],
            onPrimary: Colors.white,          
            textStyle: const TextStyle(
              fontSize: 14
            ),
            fixedSize : const Size(130,40),
            shape: const StadiumBorder()
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoadingForm == true
                ? const Spinner( icon: Icons.rotate_right )        
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save),
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
      ToastSuccess("Berhasil mendaftarkan user");

      // SUCCESS SIMULATION
      Timer(const Duration(seconds: 5), () async{    
        Navigator.of(parentContext).pushReplacementNamed("/");         
      });
    }catch(e){
      // print(e);

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