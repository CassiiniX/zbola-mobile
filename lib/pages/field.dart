import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import "../widgets/sidebar.dart";
import "../widgets/default-app-bar.dart";
import '../providers/user.dart';
import "../providers/field.dart";

import './signin.dart';


// ignore: must_be_immutable
class Field extends StatelessWidget{
  bool? isLogin;

  Field(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  @override
  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        appBar: defaultAppBar("Lapangan",context),
        drawer: Sidebar(parentContext: context),
        body : SingleChildScrollView(        
          child : FieldScreen(context)
        )        
    ));
  }
}

class FieldScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const FieldScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  FieldScreenState createState() => FieldScreenState(parentContext);

}

class FieldScreenState extends State<FieldScreen>{
  final BuildContext parentContext;

  FieldScreenState(this.parentContext);
  
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future:  Provider.of<FieldProvider>(context,listen : false).onLoad(),
      builder: (ctx,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              heightFactor:  15,
              child: CircularProgressIndicator(color: Colors.greenAccent),
            );
          }

          if(snapshot.error != null){
            return const Center(
              heightFactor:  15,
              child: Text("Terjadi Kesalahan",style : TextStyle(color: Colors.red)),
            );
          }   

          return Consumer<FieldProvider>(
            builder: (context,field,child){
            return Padding(  
              padding: const EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
              child: ListView.builder(
                    shrinkWrap: true,
                    itemCount : field.items.length,
                    itemBuilder :(ctx,i){  
                      var mainContainer =  Container(
                          alignment : Alignment.center,
                          child : Column(
                          children: [               
                            Container(
                              // clipBehavior: Clip.hardEdge,
                              width : 350,
                              margin: const EdgeInsets.only(top : 30),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,                    
                                borderRadius: const BorderRadius.only(
                                  topLeft : Radius.circular(10),
                                  topRight : Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight : Radius.circular(10)
                                ),
                                color : Colors.white,
                                boxShadow:  [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 1), // changes position of shadow
                                    )
                                  ],
                              ),
                              child : Column(
                                children: [
                                  Container(
                                    height : 200,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,                    
                                      borderRadius: BorderRadius.only(
                                        topLeft : Radius.circular(10),
                                        topRight : Radius.circular(10),
                                      )                                                
                                    ),
                                    child : Image.asset(
                                      'images/product-1.png',
                                      alignment: Alignment.topCenter,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    )
                                  ),

                                Container(  
                                  clipBehavior: Clip.none,
                                  height: 10,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent
                                  ),
                                  child : Stack(
                                    clipBehavior: Clip.none,
                                    children : [
                                      Positioned(
                                        top : -20,
                                        right: -10,        
                                        child : Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 120,
                                          ),
                                          alignment: Alignment.center,
                                          decoration : BoxDecoration(
                                            color: Colors.yellow[800],
                                            shape: BoxShape.rectangle,                    
                                            borderRadius: const BorderRadius.only(topLeft : Radius.circular(10),bottomLeft : Radius.circular(10)),              
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3), // changes position of shadow
                                              )
                                            ],
                                          ),                            
                                          child : const Padding(
                                            padding : EdgeInsets.only(top : 10,bottom : 10,left : 10,right : 10),
                                            child : Text("Pending",style: TextStyle(fontWeight: FontWeight.bold,color : Colors.white))                               
                                          )
                                        ) 
                                      ),
                                      Positioned(    
                                        top : -20,                        
                                        left : -20,
                                        child : ElevatedButton(                                                
                                          style: ElevatedButton.styleFrom(                        
                                            primary: Colors.white,
                                            shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(16),  
                                          ),
                                          onPressed: (){
                                            Navigator.of(parentContext).pushReplacementNamed("/field-detail");
                                          },
                                          child : const Icon(Icons.shopping_basket,color: Colors.blueGrey,size: 28,),                                                                                                         
                                        ),      
                                      )
                                    ]
                                  )
                                ),

                                SizedBox(        
                                  width : double.infinity,        
                                  child : Padding(
                                    padding: const EdgeInsets.all(15),
                                      child : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top : 5,bottom: 5),
                                            child : Text("Address"+i.toString(),style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                                          ),
                                          Padding( 
                                            padding : EdgeInsets.only(top : 5,bottom: 5),
                                            child : Text("Rp 50.000.00 Perjam",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color : Colors.green))
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.star,color : Colors.yellowAccent),
                                              Icon(Icons.star,color : Colors.yellowAccent),
                                              Icon(Icons.star,color : Colors.yellowAccent),
                                            ],
                                          )                             
                                        ]
                                      )
                                    )
                                  )
                              ])
                            ),
                          ])
                        );             

                      if(field.items.length == (i+1)){
                        return Column(         
                          key : ValueKey(i),           
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                            mainContainer,

                            Container(
                              margin: const EdgeInsets.only(top : 20),
                              alignment: Alignment.center,
                              child : TextButton(
                                child : Provider.of<FieldProvider>(context,listen :  false).isLoadingNext ? const Text(" . . . ") : const Text("Next"),
                                onPressed: (){
                                  var newPage = {
                                    ...Provider.of<FieldProvider>(context,listen : false).itemsPagination,
                                    "current_page" : ( int.parse(Provider.of<FieldProvider>(context,listen : false).itemsPagination["current_page"]) + 1).toString()
                                  };

                                  Provider.of<FieldProvider>(context,listen : false).setPagination(newPage);

                                  Provider.of<FieldProvider>(context,listen : false).onNext();                             
                                }
                              )
                            ),
                          ]
                        );
                      }    

                      return mainContainer;                                    
              }));
            });
      }
    );
  }
}
