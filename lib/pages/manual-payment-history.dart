import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import "../widgets/sidebar.dart";
import "../widgets/default-app-bar.dart";
import '../providers/user.dart';
import "../providers/manual-payment-history.dart";

import './signin.dart';
import "../modals/manual-payment-history-search.modal.dart";
import "../modals/manual-payment-history-detail.modal.dart";

// ignore: must_be_immutable
class ManualPaymentHistory extends StatelessWidget{
  bool? isLogin;

  ManualPaymentHistory(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  final GlobalKey<ManualPaymentHistoryScreenState> manualPaymentHistoryScreenState = GlobalKey();


  @override
  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        floatingActionButton : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(                                                
              style: ElevatedButton.styleFrom(                        
                primary: Colors.white,
                shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),  
              ),
              onPressed: (){
                if(manualPaymentHistoryScreenState.currentState != null){
                  Provider.of<ManualPaymentHistoryProvider>(context,listen : false).setFilters({
                    "search" : ""
                  });

                  manualPaymentHistoryScreenState.currentState!.refresh();
                }
              },
              child : const Icon(Icons.restore,color: Colors.blueGrey,size: 28,),                                                                                                         
            ),  
            ElevatedButton(                                                
              style: ElevatedButton.styleFrom(                        
                primary: Colors.white,
                shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),  
              ),
              onPressed: (){
                showModalBottomSheet(      
                  backgroundColor: Colors.transparent,         
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => ManualPaymentHistorySearchModal(context,manualPaymentHistoryScreenState)                
                );
              },
              child : const Icon(Icons.search,color: Colors.blueGrey,size: 28,),                                                                                                         
            ),  
          ],
        ),
        appBar: defaultAppBar("Pembayaran Manual",context),
        drawer: Sidebar(parentContext: context),
        body : SingleChildScrollView(        
          child : ManualPaymentHistoryScreen(context,key : manualPaymentHistoryScreenState)
        )        
    ));
  }
}

class ManualPaymentHistoryScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const ManualPaymentHistoryScreen(this.parentContext,{Key? key}) : super(key: key);

  @override 
  // ignore: no_logic_in_create_state
  ManualPaymentHistoryScreenState createState() => ManualPaymentHistoryScreenState(parentContext);

}

class ManualPaymentHistoryScreenState extends State<ManualPaymentHistoryScreen>{
  final BuildContext parentContext;

  bool isRefresh = true;

  ManualPaymentHistoryScreenState(this.parentContext);

  refresh(){
    setState((){
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future:  Provider.of<ManualPaymentHistoryProvider>(context,listen : false).onLoad(),
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

          return Consumer<ManualPaymentHistoryProvider>(
            builder: (context,manualPaymentHistory,child){
              if(manualPaymentHistory.items.isEmpty){
              return Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Padding(
                    padding : const EdgeInsets.only(top : 20,bottom: 20),
                    child : Image.asset(
                      'images/404.png',
                      // alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      fit : BoxFit.cover
                    )
                  ),
                  const Padding(
                    padding : EdgeInsets.only(top : 20,bottom: 20),
                    child : Text('Data tidak ditemukan',style : TextStyle(fontWeight: FontWeight.bold))
                  ) 
              ]));
            } 

            return Padding(  
              padding: const EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
              child: ListView.builder(
                    shrinkWrap: true,
                    itemCount : manualPaymentHistory.items.length,
                    itemBuilder :(ctx,i){  
                      var mainContainer =  Container(
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [  
                              GestureDetector(
                              onTap: (){
                                  showModalBottomSheet(      
                                    backgroundColor: Colors.transparent,         
                                    context: parentContext,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) => ManualPaymentHistoryDetailModal(context)                
                                  );
                              },  
                              child : Container(
                                width : 350,
                                margin: const EdgeInsets.only(top : 50),
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
                                child : Padding(padding: EdgeInsets.all(10),child : Column(
                                  
                                  children: [   
                                    

                                  Container(
                                    height : 150,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,                    
                                      borderRadius: BorderRadius.only(
                                        topLeft : Radius.circular(20),
                                        topRight : Radius.circular(20),
                                      )                                                
                                    ),
                                    child : Image.asset(
                                      'images/product-1.png',
                                      width: double.infinity,
                                      height: 150,
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
                                          right : 0,
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
                                      ]
                                    )
                                  ),         

                                  Padding(
                                    padding: EdgeInsets.only(top : 20),
                                    child : Text("Address"+i.toString(),style : TextStyle(fontSize: 13))
                                  ),

                                  Row(
                                    mainAxisAlignment : MainAxisAlignment.end, 
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child : Text("1 Jam yang lalu",style : TextStyle(fontSize: 13))
                                      ),
                                    ],
                                  )
                      
                              ]))
                            )),
                          ])
                        );             

                      if(manualPaymentHistory.items.length == (i+1)){
                        return Column(         
                          key : ValueKey(i),           
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children : [
                            mainContainer,

                            Container(
                              margin: const EdgeInsets.only(top : 20),
                              alignment: Alignment.center,
                              child : TextButton(
                                child : Provider.of<ManualPaymentHistoryProvider>(context,listen :  false).isLoadingNext ? const Text(" . . . ") : const Text("Next"),
                                onPressed: (){
                                  var newPage = {
                                    ...Provider.of<ManualPaymentHistoryProvider>(context,listen : false).itemsPagination,
                                    "current_page" : ( int.parse(Provider.of<ManualPaymentHistoryProvider>(context,listen : false).itemsPagination["current_page"]) + 1).toString()
                                  };

                                  Provider.of<ManualPaymentHistoryProvider>(context,listen : false).setPagination(newPage);

                                  Provider.of<ManualPaymentHistoryProvider>(context,listen : false).onNext();                             
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
