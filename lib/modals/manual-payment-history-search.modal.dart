import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zbola/providers/manual-payment-history.dart';

// ignore: non_constant_identifier_names
Widget ManualPaymentHistorySearchModal(BuildContext context,manualPaymentHistoryScreenState){    
  return FractionallySizedBox(
    heightFactor: 0.4,
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
            child : Column(
              children: [                               
                Container(
                  constraints: BoxConstraints(minHeight: 100,maxWidth: 400),
                  child: ManualPaymentHistorySearchModalScreen(context,manualPaymentHistoryScreenState)
                )                 
              ]
            )
          ),        
        ]
      )
    ),                      
  ));                    
}

class ManualPaymentHistorySearchModalScreen extends StatefulWidget{
  final BuildContext parentContext;
  final manualPaymentHistoryScreenState;

  // ignore: use_key_in_widget_constructors
  const ManualPaymentHistorySearchModalScreen(this.parentContext,this.manualPaymentHistoryScreenState);

  @override 
  // ignore: no_logic_in_create_state
  ManualPaymentHistorySearchModalScreenState createState() => ManualPaymentHistorySearchModalScreenState(parentContext,this.manualPaymentHistoryScreenState);
}

class ManualPaymentHistorySearchModalScreenState extends State<ManualPaymentHistorySearchModalScreen> {
  final BuildContext parentContext;
  final manualPaymentHistoryScreenState;

  ManualPaymentHistorySearchModalScreenState(this.parentContext,this.manualPaymentHistoryScreenState);

  final formKey = GlobalKey<FormState>();

  String search = '';

  @override
  Widget build(BuildContext context){
     return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Consumer<ManualPaymentHistoryProvider>(
              builder: (context,manualPaymentHistory,child){
              return Container( 
                margin : const EdgeInsets.only(top : 10,bottom :10),
                child : TextFormField(
                  initialValue : manualPaymentHistory.filters["search"], 
                  decoration: const InputDecoration(
                    labelText: "Search",
                  ),          
                  onSaved: (String? value) { 
                    search = value.toString();
                  },
                )
              );
              }),  

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

                        Provider.of<ManualPaymentHistoryProvider>(context,listen : false).setFilters({
                          "search" : search
                        });

                      // Provider.of<ManualPaymentHistoryProvider>(context,listen : false).onLoad();



                        if (manualPaymentHistoryScreenState.currentState != null){
                         manualPaymentHistoryScreenState.currentState.refresh();
                        }
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