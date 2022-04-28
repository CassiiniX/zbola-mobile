import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget InvoiceBankModal(BuildContext context){    
  return FractionallySizedBox(
    heightFactor: 0.8,
    child : Container(
    decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,       
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

          Expanded(child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child : Container(
                  constraints: BoxConstraints(minHeight: 100,maxWidth: 400),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(child: Text("Bank Info",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

                      Padding(padding: EdgeInsets.only(top :20),),

                      Container(
                          decoration: BoxDecoration(              
                          color : Colors.white,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), 
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bank"),
                            Padding(padding: EdgeInsets.only(top :20),),
                            Text("Bank Account"),
                            Text("Bank Nomor")
                          ]
                        )),
                      ),
                      Padding(padding: EdgeInsets.only(top :20),),

                        Container(
                          decoration: BoxDecoration(              
                          color : Colors.white,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), 
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bank"),
                            Padding(padding: EdgeInsets.only(top :20),),
                            Text("Bank Account"),
                            Text("Bank Nomor")
                          ]
                        )),
                      ),
                      Padding(padding: EdgeInsets.only(top :20),),

                      Container(
                          decoration: BoxDecoration(              
                          color : Colors.white,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), 
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bank"),
                            Padding(padding: EdgeInsets.only(top :20),),
                            Text("Bank Account"),
                            Text("Bank Nomor")
                          ]
                        )),
                      ),

                       Padding(padding: EdgeInsets.only(top :20),),

                      Container(
                          decoration: BoxDecoration(              
                          color : Colors.white,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), 
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bank"),
                            Padding(padding: EdgeInsets.only(top :20),),
                            Text("Bank Account"),
                            Text("Bank Nomor")
                          ]
                        )),
                      ),

                       Padding(padding: EdgeInsets.only(top :20),),

                      Container(
                          decoration: BoxDecoration(              
                          color : Colors.white,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), 
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bank"),
                            Padding(padding: EdgeInsets.only(top :20),),
                            Text("Bank Account"),
                            Text("Bank Nomor")
                          ]
                        )),
                      ),


                    ],
                  )
                )                 
            
          )),        
        ]
      )
    ),                      
  ));                    
}
