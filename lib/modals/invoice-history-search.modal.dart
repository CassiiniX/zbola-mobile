import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zbola/providers/invoice-history.dart';

// ignore: non_constant_identifier_names
Widget InvoiceHistorySearchModal(BuildContext context,invoiceHistoryScreenState){    
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
                  child: InvoiceHistorySearchModalScreen(context,invoiceHistoryScreenState)
                )                 
              ]
            )
          ),        
        ]
      )
    ),                      
  ));                    
}

class InvoiceHistorySearchModalScreen extends StatefulWidget{
  final BuildContext parentContext;
  final invoiceHistoryScreenState;

  // ignore: use_key_in_widget_constructors
  const InvoiceHistorySearchModalScreen(this.parentContext,this.invoiceHistoryScreenState);

  @override 
  // ignore: no_logic_in_create_state
  InvoiceHistorySearchModalScreenState createState() => InvoiceHistorySearchModalScreenState(parentContext,this.invoiceHistoryScreenState);
}

class InvoiceHistorySearchModalScreenState extends State<InvoiceHistorySearchModalScreen> {
  final BuildContext parentContext;
  final invoiceHistoryScreenState;

  InvoiceHistorySearchModalScreenState(this.parentContext,this.invoiceHistoryScreenState);

  final formKey = GlobalKey<FormState>();

  String search = '';

  @override
  Widget build(BuildContext context){
     return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Consumer<InvoiceHistoryProvider>(
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

                        Provider.of<InvoiceHistoryProvider>(context,listen : false).setFilters({
                          "search" : search
                        });                  

                        if (invoiceHistoryScreenState.currentState != null){
                         invoiceHistoryScreenState.currentState.refresh();
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