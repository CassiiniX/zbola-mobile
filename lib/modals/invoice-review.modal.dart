import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget InvoiceReviewModal(BuildContext context){    
  return FractionallySizedBox(
    heightFactor: 0.9,
    child : Container(
    decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white        
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
                  child: InvoiceReviewModalScreen(context)
                )                 
              ]
            )
          ),        
        ]
      )
    ),                      
  ));                    
}

class InvoiceReviewModalScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const InvoiceReviewModalScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  InvoiceReviewModalScreenState createState() => InvoiceReviewModalScreenState(parentContext);
}

class InvoiceReviewModalScreenState extends State<InvoiceReviewModalScreen> {
  final BuildContext parentContext;

  InvoiceReviewModalScreenState(this.parentContext);

  final formKey = GlobalKey<FormState>();

  String comment = '';
  int star = 0;

  @override
  Widget build(BuildContext context){
     return Form(
        key: formKey,
        child: SingleChildScrollView(child : Column(
          children: [
            Center(child: Text("Review",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

            Padding(padding: EdgeInsets.only(top :20),),

            Image.asset(
              'images/modal-review.png',
              alignment: Alignment.center,
              width: double.infinity,
              height: 180,
            ),

            Padding(padding: EdgeInsets.only(top :20),),

            Container( 
                margin : const EdgeInsets.only(top : 10,bottom :10),
                child : TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Komentar",
                  ),          
                  onSaved: (String? value) { 
                    comment = value.toString();
                  },
                )
              ),

            Padding(padding: EdgeInsets.only(top :20),),

            Container( 
              margin : const EdgeInsets.only(top : 10,bottom :10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        star = 1;
                      });
                    },
                    icon: Icon(Icons.star,size : 30,color : star >= 1 ? Colors.yellowAccent : Colors.grey)
                  ),
                   IconButton(
                    onPressed: (){
                      setState(() {
                        star = 2;
                      });
                    },
                    icon: Icon(Icons.star,size : 30,color : star >= 2 ? Colors.yellowAccent : Colors.grey)
                   ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        star = 3;
                      });
                    },
                    icon: Icon(Icons.star,size : 30,color : star >= 3 ? Colors.yellowAccent : Colors.grey)
                   ),
                    IconButton(
                    onPressed: (){
                      setState(() {
                        star = 4;
                      });
                    },
                    icon: Icon(Icons.star,size : 30,color : star >= 4 ? Colors.yellowAccent : Colors.grey)
                   ),
                    IconButton(
                    onPressed: (){
                      setState(() {
                        star = 5;
                      });
                    },
                    icon: Icon(Icons.star,size : 30,color : star >= 5 ? Colors.yellowAccent : Colors.grey)
                   ),
              ]),
            ),

            Padding(padding: EdgeInsets.only(top :20),),

            Row(      
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(        
                  style : ElevatedButton.styleFrom(              
                    onPrimary: Colors.white,          
                    textStyle: const TextStyle(fontSize: 14),
                    fixedSize : const Size(200,40),
                    shape: const StadiumBorder()
                  ),
                  onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState?.save(); 

                        // Provider.of<InvoiceHistoryProvider>(context,listen : false).setFilters({
                        //   "search" : search
                        // });                  

                        // if (invoiceHistoryScreenState.currentState != null){
                        //  invoiceHistoryScreenState.currentState.refresh();
                        // }

                        Navigator.pop(context);
                      }
                  },
                  child : Text("Kirim")
                ),
              ]
            ),            
          ],
        )),
    );
  }
}