import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import "../widgets/sidebar.dart";

import '../providers/user.dart';

import './signin.dart';

// ignore: must_be_immutable
class Profil extends StatelessWidget{
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  bool? isLogin;
  
  Profil(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  backgroundContainer(context){
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color : Colors.greenAccent[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(150),
          bottomRight: Radius.circular(150)
        )
      ),
      child: Padding(
        padding : const EdgeInsets.only(top : 20,left : 10,right : 30),
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            TextButton(
              child : const Icon(Icons.align_horizontal_left,size : 30,color: Colors.white),
              onPressed: () => _keyScaffold.currentState!.openDrawer()            
            )        
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        key : _keyScaffold,
        drawer: Sidebar(parentContext: context),
        body :  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(height: MediaQuery.of(context).size.height  + 300), 

                  backgroundContainer(context),

                  Positioned(
                    top : 70,              
                    width: MediaQuery.of(context).size.width,                                   
                    child: Column(
                      children: const [
                        ProfilUpdatePhoto(),

                        Padding(padding: EdgeInsets.only(top : 10)),

                        ProfilUpdateData(),

                        Padding(padding: EdgeInsets.only(top : 10)),

                        ProfilUpdatePassword()                                                   
                      ]
                    ),
                  )
                ],
              ),  
            ]
          )
        )
      )
    );
  }
}

class ProfilUpdatePhoto extends StatefulWidget{
  const ProfilUpdatePhoto({Key? key}) : super(key: key);

  @override 
  _ProfilUpdatePhoto createState() =>  _ProfilUpdatePhoto();
}

class _ProfilUpdatePhoto extends State<ProfilUpdatePhoto>{
  final ImagePicker _picker = ImagePicker();
  File? uploadimage; 

  Future<void> chooseImage() async {        
    var picker = await _picker.pickImage(
      source: ImageSource.gallery
    );
        
    setState(() {
      uploadimage = File(picker!.path);
    });
  }

 Future<void> uploadImage() async {}

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color:  Colors.transparent
      ),
      constraints: const BoxConstraints(
        minHeight: 250,
      ),
      width: MediaQuery.of(context).size.width  * 0.8,
      child : Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Photo",style : TextStyle(color: Colors.white,fontSize: 20))
              ],
            ),

            const Padding(padding: EdgeInsets.only(top : 10),),

            Container(   
              clipBehavior: Clip.none,
              height: 200,            
              decoration: const BoxDecoration(color: Colors.transparent),                
              child :  Stack(
                clipBehavior: Clip.none,
                children : [
                  Positioned(
                    child : 
                      Container(   
                        child:  uploadimage == null 
                        ? Image.asset(
                              'images/default.png',
                              alignment: Alignment.center,
                              height : 200,
                              fit : BoxFit.cover
                          )
                        : Image.file(
                            uploadimage!,
                            alignment: Alignment.center,
                            height : 200,
                            fit : BoxFit.cover,
                            errorBuilder: (_ctx,_ob,_tr){                    
                              return Image.asset(
                                'images/404.png',
                                alignment: Alignment.center,
                                height : 200,
                                fit : BoxFit.cover
                              );
                            },                        
                        )
                    ),        
                  ),
                  Positioned(
                    right: 0,
                    bottom : 20,
                    child :ElevatedButton(                                                
                      style: ElevatedButton.styleFrom(                        
                        primary: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),  
                      ),
                      onPressed: () => chooseImage(),
                      child : Icon(Icons.edit,color: Colors.blueAccent,size: 28,),                                                                      
                    )                      
                  ),
                  Positioned(                
                    bottom : 20,
                    child: SizedBox(                         
                      width: 100,
                      child: uploadimage == null
                        ? Container() 
                        : ElevatedButton(                                                
                          style: ElevatedButton.styleFrom(                        
                            primary: Colors.white,
                            shape: CircleBorder(),
                          padding: EdgeInsets.all(15),  
                          ),
                          onPressed: () => print("Testing"),
                          child : Icon(Icons.save,color: Colors.blueAccent,size: 28,),                                                                                                         
                        ),                      
                    )  
                  ),                    
              ])                                                
            ),                                    
          ]
        )      
    );
  }
}

class ProfilUpdateData extends StatefulWidget{
  const ProfilUpdateData({Key? key}) : super(key: key);

  @override 
  _ProfilUpdateData createState() => _ProfilUpdateData();
}

class _ProfilUpdateData extends State<ProfilUpdateData>{
  String name = '';
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();

  onSubmit() async {}

  @override
  Widget build(BuildContext context){
    return Container(
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        width: MediaQuery.of(context).size.width  * 0.8,
        child : Card(
          elevation: 1.5,
          child: Form(            
            key: formKey,            
            child: Padding(padding: const EdgeInsets.all(20),
            child : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Edit Data",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                  ],
                ),

                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                TextFormField(              
                  initialValue: "Username",
                  decoration: const InputDecoration(
                    labelText: "Username",                
                  ),
                  validator: (value){                
                    return null;
                  },
                  onSaved: (String? value) { 
                    name = value.toString();
                  },
                ),

                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                TextFormField(
                  initialValue: "Email",
                  decoration: const InputDecoration(
                    labelText: "Email",            
                  ),
                  validator: (value){                    
                    return null;
                  },
                  onSaved: (String? value) { 
                    email = value.toString();
                  },
                ),

                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",              
                  ),
                  validator: (value){                    
                    return null;
                  },
                  onSaved: (String? value) { 
                    password = value.toString();
                  },
                ),
                
                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                ElevatedButton(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [            
                        Padding(
                          padding: EdgeInsets.only(left : 5),
                          child : Text("Kirim")
                        )
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
              ]
            )
        )
      )
    ));
  }
}

class ProfilUpdatePassword extends StatefulWidget{
  const ProfilUpdatePassword({Key? key}) : super(key: key);

  @override 
  _ProfilUpdatePassword createState() => _ProfilUpdatePassword();
}

class _ProfilUpdatePassword extends State<ProfilUpdatePassword>{
  String? password;
  String? passwordConfirmation;

  final formKey = GlobalKey<FormState>();

  onSubmit() async{    
   
  }

  @override
  Widget build(BuildContext context){
    return Container(
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        width: MediaQuery.of(context).size.width  * 0.8,
        child : Card(
          elevation: 1.5,
          child: Form(
            key: formKey,
            child: Padding(padding: const EdgeInsets.all(10),
              child : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Edit Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                  ],
                ),

                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value){                   
                    return null;
                  },
                  onSaved: (String? value) { 
                    password = value.toString();
                  },
                ),

                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password Konfirmasi",
                    // hintText: "*Masukan password"
                  ),
                  validator: (value){                    
                    return null;
                  },
                  onSaved: (String? value) { 
                    passwordConfirmation = value.toString();
                  },
                ),

                const Padding(padding: EdgeInsets.only(top : 10,bottom: 5),),

                ElevatedButton(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [            
                        Padding(
                          padding: EdgeInsets.only(left : 5),
                          child : Text("Kirim")
                        )
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
              ]
            )
        ))
      )
    );
  }
}