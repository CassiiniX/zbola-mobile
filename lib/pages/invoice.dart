import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import "../widgets/sidebar.dart";
import "../widgets/default-app-bar.dart";
import '../providers/user.dart';

import './signin.dart';
import 'package:flutter/services.dart' show rootBundle;

import "../modals/invoice-payment.modal.dart";
import "../modals/invoice-review.modal.dart";
import "../modals/invoice-bank.modal.dart";

// ignore: must_be_immutable
class Invoice extends StatelessWidget{
  bool? isLogin;

  Invoice(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  @override
  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        appBar: defaultAppBar("Invoice",context),
        drawer: Sidebar(parentContext: context),
        floatingActionButton :  Column(           
          mainAxisAlignment: MainAxisAlignment.end,           
          children: [
            ElevatedButton(        
              style : ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.redAccent,
                onPrimary: Colors.white,          
                textStyle: const TextStyle(fontSize: 12),
                fixedSize : const Size(60,60),
                shape: const CircleBorder(),
              ),
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.close,size: 15),
                          Padding(
                            padding: EdgeInsets.only(left : 3),
                            child : Text("Cancel",style: TextStyle(fontSize: 12))
                          )
                    ]                                                
              ),
              onPressed: (){
                  showDialog(
                  context: context, 
                  builder: (ctx) => AlertDialog(
                    title : Text("Kamu Yakin"),
                    content: Text("Kamu Mengahpus Data Ini"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){
                          Navigator.of(ctx).pop(false);
                        }, 
                        child: Text(
                          "Tidak",
                          style : TextStyle(
                            color : Colors.grey,
                            fontWeight : FontWeight.bold
                          )
                        )
                      ),  
                      TextButton(
                        onPressed: (){
                          Navigator.of(ctx).pop(false);                               
                        }, 
                        child: Text(
                          "Iya",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          )
                        )
                      )
                    ],
                  )
                );                  
              },
            ),

            Padding(padding :EdgeInsets.only(top:10)),

            ElevatedButton(        
               style : ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.greenAccent,
                onPrimary: Colors.white,          
                textStyle: const TextStyle(fontSize: 12),
                fixedSize : const Size(60,60),
                shape: const CircleBorder(),
              ),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.money,size: 15),
                      Padding(
                        padding: EdgeInsets.only(left : 3),
                        child : Text("Bayar",style: TextStyle(fontSize: 10))
                      )
                ]                                                
              ),
              onPressed: (){
                showModalBottomSheet(      
                  backgroundColor: Colors.transparent,         
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => InvoicePaymentModal(context)                
                );   
              },
            ),
            
            Padding(padding :EdgeInsets.only(top:10)),

            ElevatedButton(        
               style : ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.greenAccent[800],
                onPrimary: Colors.white,          
                textStyle: const TextStyle(fontSize: 12),
                fixedSize : const Size(60,60),
                shape: const CircleBorder(),
              ),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.comment,size: 15),
                      Padding(
                        padding: EdgeInsets.only(left : 3),
                        child : Text("Review",style: TextStyle(fontSize: 12))
                      )
                ]                                                
              ),
              onPressed: (){
                showModalBottomSheet(      
                  backgroundColor: Colors.transparent,         
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => InvoiceReviewModal(context)                
                );   
              },
            ),
            
          ],
        ),
        body : SingleChildScrollView(        
            child : InvoiceScreen(context)
          )        
    ));
  }
}

class InvoiceScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const InvoiceScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  InvoiceScreenState createState() => InvoiceScreenState(parentContext);

}

class InvoiceScreenState extends State<InvoiceScreen>{
  final BuildContext parentContext;

  InvoiceScreenState(this.parentContext);

  Map<String,dynamic>? invoice;

  Future<String> getJson() {
    return rootBundle.loadString('json/invoice.json');
  }

  Future<String> onLoad() async{
    try{
      return Future<String>.delayed(
        const Duration(seconds: 0),
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

         return Padding(  
          padding: const EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
          child: RefreshIndicator(
            onRefresh: () async => onLoad(),            
            child : invoice != null 
              ? Container(alignment : Alignment.center,child : Column(
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
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top : 5,bottom: 5),
                                child : Text("Address",style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                              ),
                              Padding( 
                                padding : EdgeInsets.only(top : 5,bottom: 5),
                                child : Text("Rp 50.000.00 Perjam",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color : Colors.green))
                              ),
                              Padding( 
                                padding : EdgeInsets.only(top : 5,bottom: 5),
                                child : Text("Total : Rp 50.000.00 - (1 jam)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                              ),
                              Padding(
                                padding : EdgeInsets.only(top : 10,bottom: 5),
                                child : Text("Tanggal Mulai : 2020-09-09 00:08:00",style : TextStyle(fontSize:  12,color : Colors.grey))
                              ),
                              Padding( 
                                padding: EdgeInsets.only(top : 5,bottom: 5),
                                child : Text("Dibuat Pada : 2020-09-09 00:00:00",style : TextStyle(fontSize: 12,color : Colors.grey))
                              )
                            ]
                          )
                        )
                      )
                  ])
                ),

                Container(
                    alignment : Alignment.center,
                    width : 350,
                    margin: const EdgeInsets.only(top : 30),
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
                      ]),
                      child: Padding(padding : const EdgeInsets.all(20),child : Column(children: [
                       Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding : const EdgeInsets.only(right: 5,left : 5),
                                child : Column(children: const [
                                  Text("2",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                                  Divider(thickness : 0),
                                  Text("Hari",style : TextStyle(fontSize :10))
                                ])
                              ),
                              Padding(
                                padding : const EdgeInsets.only(right: 5,left : 5),
                                child : Column(children:[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right : 10),
                                        child : Text(":",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
                                      ),
                                      Text("12",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
                                    ]
                                  ),
                                  const Divider(thickness : 0),
                                  const Padding(
                                    padding: EdgeInsets.only(left : 10),
                                    child : Text("Jam",style : TextStyle(fontSize :10))
                                  )
                                ])
                              ),
                              Padding(
                                padding : const EdgeInsets.only(right: 5,left : 5),
                                child : Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right : 10),
                                        child : Text(":",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
                                      ),
                                      Text("12",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
                                    ]
                                  ),
                                  const Divider(thickness : 0),
                                  const Padding(
                                    padding: EdgeInsets.only(left : 10),
                                    child: Text("Menit",style : TextStyle(fontSize :10))
                                  )
                                ])
                              ),
                              Padding(
                                padding : const EdgeInsets.only(right: 5,left : 5),
                                child : Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right : 10),
                                        child : Text(":",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
                                      ),
                                      Text("12",style : TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
                                    ]
                                  ),
                                  const Divider(thickness : 0),
                                  const Padding(
                                    padding: EdgeInsets.only(left : 10),
                                    child : Text("Detik",style : TextStyle(fontSize :10))
                                  )
                                ])
                              ),
                        ]),                        
                        Container(
                          margin : const EdgeInsets.only(top : 15,bottom : 10),
                          child : const Text("*Menunggu divalidasi admin",style : TextStyle(fontSize :10))
                        )                       
                    ])
                  ))
                ]))              
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
