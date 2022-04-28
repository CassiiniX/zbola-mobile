import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import "../widgets/sidebar.dart";
import "../widgets/default-app-bar.dart";
import '../providers/user.dart';
import "../providers/invoice-history.dart";

import './signin.dart';
import "../modals/invoice-history-search.modal.dart";
import "../modals/invoice-history-detail.modal.dart";

// ignore: must_be_immutable
class InvoiceHistory extends StatelessWidget{
  bool? isLogin;

  InvoiceHistory(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  final GlobalKey<InvoiceHistoryScreenState> invoiceHistoryScreenState = GlobalKey();


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
                if(invoiceHistoryScreenState.currentState != null){
                  Provider.of<InvoiceHistoryProvider>(context,listen : false).setFilters({
                    "search" : ""
                  });

                  invoiceHistoryScreenState.currentState!.refresh();
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
                  builder: (BuildContext context) => InvoiceHistorySearchModal(context,invoiceHistoryScreenState)                
                );
              },
              child : const Icon(Icons.search,color: Colors.blueGrey,size: 28,),                                                                                                         
            ),  
          ],
        ),
        appBar: defaultAppBar("Riwayat Invoice",context),
        drawer: Sidebar(parentContext: context),
        body : SingleChildScrollView(        
          child : InvoiceHistoryScreen(context,key : invoiceHistoryScreenState)
        )        
    ));
  }
}

class InvoiceHistoryScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const InvoiceHistoryScreen(this.parentContext,{Key? key}) : super(key: key);

  @override 
  // ignore: no_logic_in_create_state
  InvoiceHistoryScreenState createState() => InvoiceHistoryScreenState(parentContext);

}

class InvoiceHistoryScreenState extends State<InvoiceHistoryScreen>{
  final BuildContext parentContext;

  bool isRefresh = true;

  InvoiceHistoryScreenState(this.parentContext);

  refresh(){
    setState((){
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future:  Provider.of<InvoiceHistoryProvider>(context,listen : false).onLoad(),
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

          return Consumer<InvoiceHistoryProvider>(
            builder: (context,invoiceHistory,child){
              if(invoiceHistory.items.isEmpty){
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
                    itemCount : invoiceHistory.items.length,
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
                                    builder: (BuildContext context) => InvoiceHistoryDetailModal(context)                
                                  );
                              },  
                              child : Container(
                                width : 400,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [                                       
                                    Row(
                                      children : [
                                        Image.asset(                                      
                                          'images/product-1.png',
                                          width: 100,
                                          height: 60,
                                          fit: BoxFit.contain,                                    
                                        ),                                  

                                        Padding(padding: EdgeInsets.only(left : 10)),

                                        Column(
                                          crossAxisAlignment : CrossAxisAlignment.start,
                                          children : [
                                            Padding(
                                              padding: EdgeInsets.only(top : 5,bottom: 5),
                                              child : Text("Address",style : TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                                            ),
                                            Padding( 
                                              padding : EdgeInsets.only(top : 5,bottom: 5),
                                              child : Text("Rp 50.000.00 Perjam",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color : Colors.green))
                                            ),
                                          ]
                                        )
                                      ]
                                    ),

                                  Padding( 
                                    padding : EdgeInsets.only(top : 10,bottom: 5),
                                    child : Text("Total : Rp 50.000.00 - (1 jam)",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                                  ),
                                  Padding(
                                    padding : EdgeInsets.only(top : 5,bottom: 5),
                                    child : Text("Tanggal Mulai : 2020-09-09 00:08:00",style : TextStyle(fontSize:  12,color : Colors.grey))
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
                                          top : -80,
                                          right : -20,
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

                                  Row(
                                    mainAxisAlignment : MainAxisAlignment.end, 
                                    children: [
                                      Text("1 Jam yang lalu",style : TextStyle(fontSize: 13))                                    
                                    ],
                                  )
                      
                              ]))
                            )),
                          ])
                        );             

                      if(invoiceHistory.items.length == (i+1)){
                        return Column(         
                          key : ValueKey(i),           
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children : [
                            mainContainer,

                            Container(
                              margin: const EdgeInsets.only(top : 20),
                              alignment: Alignment.center,
                              child : TextButton(
                                child : Provider.of<InvoiceHistoryProvider>(context,listen :  false).isLoadingNext ? const Text(" . . . ") : const Text("Next"),
                                onPressed: (){
                                  var newPage = {
                                    ...Provider.of<InvoiceHistoryProvider>(context,listen : false).itemsPagination,
                                    "current_page" : ( int.parse(Provider.of<InvoiceHistoryProvider>(context,listen : false).itemsPagination["current_page"]) + 1).toString()
                                  };

                                  Provider.of<InvoiceHistoryProvider>(context,listen : false).setPagination(newPage);

                                  Provider.of<InvoiceHistoryProvider>(context,listen : false).onNext();                             
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
