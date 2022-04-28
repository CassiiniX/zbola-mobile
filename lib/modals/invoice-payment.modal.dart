import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "./invoice-bank.modal.dart";
import 'dart:io';

// ignore: non_constant_identifier_names
Widget InvoicePaymentModal(BuildContext context){    
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

          Expanded(child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),      
            constraints: BoxConstraints(minHeight: 100,maxWidth: 400),
            child: InvoicePaymentModalScreen(context)                                      
          )),                                                            
        ]
      )
    ),                      
  ));                    
}

class InvoicePaymentModalScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const InvoicePaymentModalScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  InvoicePaymentModalScreenState createState() => InvoicePaymentModalScreenState(parentContext);
}

class InvoicePaymentModalScreenState extends State<InvoicePaymentModalScreen> {
  final BuildContext parentContext;
  final ImagePicker _picker = ImagePicker();
  File? uploadimage; 

  Future<void> chooseImage() async {        
    var picker = await _picker.pickImage(
      source: ImageSource.gallery
    );
        
    setState(() {
      uploadimage = File(picker!.path);
    });
  }

 Future<void> uploadImage() async {}

  InvoicePaymentModalScreenState(this.parentContext);

  final formKey = GlobalKey<FormState>();

  String description = '';

  @override
  Widget build(BuildContext context){
     return Form(
        key: formKey,
        child:  ListView(
          shrinkWrap: true,
          children: [            
            Center(child: Text("Pembayaran",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

            Padding(padding: EdgeInsets.only(top :20),),

            Image.asset(
              'images/modal-payment.png',
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
            ),

            Padding(padding: EdgeInsets.only(top :20),),

            Container( 
                margin : const EdgeInsets.only(top : 10,bottom :10),
                child : TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Keterangan",
                  ),          
                  onSaved: (String? value) { 
                    description = value.toString();
                  },
                )
              ),

            Padding(padding: EdgeInsets.only(top :20),),

          uploadimage == null 
            ? Container()
            : Container(     
              constraints: BoxConstraints(maxHeight: 100,minHeight: 0),        
              child: Image.file(
                    uploadimage!,
                    alignment: Alignment.center,
                    width: 100,
                    errorBuilder: (_ctx,_ob,_tr){                    
                      return Image.asset(
                        'images/404.png',
                        alignment: Alignment.center,
                        width: 100,
                      );
                    },                        
                )
            ),

            Padding(padding: EdgeInsets.only(top :20),),

            ElevatedButton(        
                style : ElevatedButton.styleFrom(              
                  onPrimary: Colors.white,          
                  textStyle: const TextStyle(fontSize: 14),
                  fixedSize : const Size(130,40),
                  shape: const StadiumBorder()
                ),
                onPressed: () => chooseImage(),              
                child : Text("Upload")
            ),

            Padding(padding: EdgeInsets.only(top :20),),

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
         
            Container(
                  margin: EdgeInsets.only(top : 20),
                  child : TextButton(
                    child: Text("Bank Info"),
                    onPressed: (){
                    showModalBottomSheet(      
                      backgroundColor: Colors.transparent,         
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) => InvoiceBankModal(context)                
                    );   
                  },)                 
                )
          ],
        ),
    );
  }
}