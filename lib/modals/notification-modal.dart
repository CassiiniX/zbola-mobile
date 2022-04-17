import 'package:flutter/material.dart';

Widget NotificationModal(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80.0),
            topRight:  Radius.circular(80.0),      
          ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(  
             clipBehavior: Clip.none,
            height: 50,
  decoration: BoxDecoration(color: Colors.black),
  child : Stack(
            clipBehavior: Clip.none ,
            children : [
                Positioned(
                  top : -20,
                  child : Container(
                    decoration: BoxDecoration(              
                      shape: BoxShape.rectangle,
                      color : Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow:  [BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        )],
                    ),
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,    
                    child : Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.close,size: 50,color: Colors.redAccent)
                    )),

          )])),
          Text("Notification"),
          Text("Image"),
          Text("Data tidak ditemukan")
        ])
      ),                      
    );                    
}