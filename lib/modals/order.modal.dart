import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget OrderModal(BuildContext context){    
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

          Expanded(child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child : Column(
              children: [ 
          
                Image.asset(
                  'images/product-1.png',
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.contain,                                    
                ),

                Padding(padding: EdgeInsets.only(top :20),),

                Padding(
                  padding: EdgeInsets.only(top : 5,bottom: 5),
                  child : Text("Address",style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                ),
                Padding( 
                  padding : EdgeInsets.only(top : 5,bottom: 5),
                  child : Text("Rp 50.000.00 Perjam",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color : Colors.green))
                ),

                Expanded(child: Container(
                  constraints: BoxConstraints(minHeight: 100,maxWidth: 400),
                  child: SingleChildScrollView(
                    child : OrderModalScreen(context)
                  )
                ))                 
              ]
            )
          )),        
        ]
      )
    ),                      
  ));                    
}

class OrderModalScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const OrderModalScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  OrderModalScreenState createState() => OrderModalScreenState(parentContext);
}

class OrderModalScreenState extends State<OrderModalScreen> {
  final BuildContext parentContext;

  OrderModalScreenState(this.parentContext);

  final formKey = GlobalKey<FormState>();

  String start_date = '';
  String start_hour = '';
  String hours = '';
  String total = '';

  @override
  Widget build(BuildContext context){
     return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container( 
              margin : const EdgeInsets.only(top : 10,bottom :10),
              child : TextFormField(
                decoration: const InputDecoration(
                  labelText: "Tgl Mulai",
                ),          
                onSaved: (String? value) { 
                  start_date = value.toString();
                },
              )
            ),

             Container( 
              margin : const EdgeInsets.only(top : 10,bottom :10),
              child : TextFormField(
                decoration: const InputDecoration(
                  labelText: "Jam Mulai",
                ),          
                onSaved: (String? value) { 
                  start_hour = value.toString();
                },
              )
            ),

             Container( 
              margin : const EdgeInsets.only(top : 10,bottom :10),
              child : TextFormField(
                decoration: const InputDecoration(
                  labelText: "Berapa Jam",
                ),          
                onSaved: (String? value) { 
                  hours = value.toString();
                },
              )
            ),

             Container( 
              margin : const EdgeInsets.only(top : 10,bottom :10),
              child : TextFormField(
                decoration: const InputDecoration(
                  labelText: "Total",
                ),          
                onSaved: (String? value) { 
                  total = value.toString();
                },
              )
            ),

            Row(      
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(        
                  style : ElevatedButton.styleFrom(              
                    onPrimary: Colors.white,          
                    textStyle: const TextStyle(fontSize: 14),
                    fixedSize : const Size(130,40),
                    shape: const StadiumBorder()
                  ),
                  onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState?.save(); 
                        
                        Navigator.pop(context);
                      }
                  },
                  child : Text("Search")
                ),
              ]
            ),            
          ],
        ),
    );
  }
}