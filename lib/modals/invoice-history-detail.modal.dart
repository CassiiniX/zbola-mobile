import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget InvoiceHistoryDetailModal(BuildContext context){    
  return FractionallySizedBox(
    heightFactor: 0.9,
    child : Container(
    decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80.0),
          topRight:  Radius.circular(80.0),      
        ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(  
            clipBehavior: Clip.none,
            height: 70,
            width: 70,
            decoration: const BoxDecoration(color: Colors.transparent),
            child : Stack(
              clipBehavior: Clip.none,
              children : [
                Positioned(
                  top : -30,    
                  child : TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(              
                        shape: BoxShape.rectangle,
                        color : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 1), 
                          )
                        ],
                      ),
                      width: 70,
                      height: 70,
                      child : const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.close,size: 50,color: Colors.redAccent)
                      )
                    )
                  ),
                )
              ]
            )
          ),

          Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child :Column(
              children: [                               
                Container(
                  constraints: BoxConstraints(maxWidth: double.infinity,maxHeight: 400),
                  child :  SingleChildScrollView(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top :20),),

                      Center(child: Text("Detail",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

                      Padding(padding: EdgeInsets.only(top :20),),

                      Image.asset(
                        'images/product-1.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.contain,                                    
                      ),

                      Padding(padding: EdgeInsets.only(top :20),),


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
                              top : -30,
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

                      Padding(
                        padding : EdgeInsets.all(20),
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                    
                            Padding(padding: EdgeInsets.only(top :20),),
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
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Text("1 Jam Lalu")]
                            )
                        ],)      
                      )                                    
                    ],
                  )
                )                 
                )]
            )
          ),        
        ]
      )
    ),                      
  ));                    
}
