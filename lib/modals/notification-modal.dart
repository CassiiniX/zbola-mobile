import 'package:flutter/material.dart';
import 'package:zbola/providers/notification.dart';
import 'package:provider/provider.dart';

Widget NotificationModal(BuildContext context){    
    return FractionallySizedBox(
      heightFactor: 0.8,
      child : Container(
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
        child: Column(
          children: [
            Container(  
              clipBehavior: Clip.none,
              height: 70,
              width: 70,
              // alignment: Alignment.start,    
              decoration: BoxDecoration(color: Colors.transparent),
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
                              offset: Offset(0, 1), // changes position of shadow
                            )
                          ],
                        ),
                        width: 70,
                        height: 70,
                        // alignment: Alignment.center,    
                        child : Padding(
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
              decoration: BoxDecoration(color: Colors.transparent),
              // alignment: Alignment.center,
              child : Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding : EdgeInsets.only(top : 20,bottom: 20),
                    child : Text("Notification",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ),
                  Container(
                    constraints: BoxConstraints.loose(Size(double.infinity, 300)),
                    child: NotificationModalScreen(context)                    
                  )
                  // Padding(
                  //   padding : EdgeInsets.only(top : 20,bottom: 20),
                  //   child : Image.asset(
                  //     'images/404.png',
                  //     // alignment: Alignment.center,
                  //     height: 200,
                  //     width: 200,
                  //     fit : BoxFit.cover
                  //   )
                  // ),
                  // Padding(
                  //   padding : EdgeInsets.only(top : 20,bottom: 20),
                  //   child : Text('Data tidak ditemukan',style : TextStyle(fontWeight: FontWeight.bold))
                  // )
                ]
              )
            ),        
          ]
        )
      ),                      
    ));                    
}

class NotificationModalScreen extends StatefulWidget{
  final BuildContext parentContext;

  NotificationModalScreen(this.parentContext);

  @override 
  NotificationModalScreenState createState() => NotificationModalScreenState(parentContext);
}

class NotificationModalScreenState extends State<NotificationModalScreen>{
   final BuildContext parentContext;

  NotificationModalScreenState(this.parentContext);

  Widget build(BuildContext context){
    return FutureBuilder(
      future: Provider.of<NotificationProvider>(context,listen : false).onLoad(),

      builder: (ctx,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.error != null){
          return Center(
            child: Text("Terjadi Kesalahan"),
          );
        }   

        return Padding(
          padding: EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
          child: RefreshIndicator(
            onRefresh: () => Provider.of<NotificationProvider>(context,listen : false).onLoad(),
            child: Consumer<NotificationProvider>(
              builder: (context,notification,child) => notification.items.length == 0 
              ? Center(child: Text("Data tidak ditemukan"))
              : ListView.builder(
                itemCount : notification.items.length,
                itemBuilder :(ctx,i) => Card(
                  key : ValueKey(notification.items[i].id),
                  elevation: 2.5,
                  child:  Text(notification.items[i].title ?? "-")                  
                )
              ),
            ),
          ),
        );  
      }
    );
  }
}