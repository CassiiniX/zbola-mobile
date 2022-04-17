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
                    constraints: BoxConstraints.loose(Size(double.infinity, 350)),
                    child: NotificationModalScreen(context)                    
                  )                 
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
        return Consumer<NotificationProvider>(
          builder: (context,notification,child){
            if(notification.items.length == 0){
              return Column(children: [
                Padding(
                    padding : EdgeInsets.only(top : 20,bottom: 20),
                    child : Image.asset(
                      'images/404.png',
                      // alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      fit : BoxFit.cover
                    )
                  ),
                  Padding(
                    padding : EdgeInsets.only(top : 20,bottom: 20),
                    child : Text('Data tidak ditemukan',style : TextStyle(fontWeight: FontWeight.bold))
                  ) 
              ]);
            } 
            
            return Padding(padding: EdgeInsets.only(left : 20,right : 20),child : ListView.builder(
              itemCount : notification.items.length,
              itemBuilder :(ctx,i){   
                if(notification.items.length == (i+1)){
                  return Column(         
                    key : ValueKey(notification.items[i].id),           
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                       Container(
                        child : Padding(padding: EdgeInsets.only(left: 5,right: 4),child : Container(    
                        decoration: BoxDecoration(              
                          shape: BoxShape.rectangle,
                          color : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 1), // changes position of shadow
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top : 30),              
                        key : ValueKey(notification.items[i].id),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child : Row(
                            children: [
                              Expanded(
                                flex : 2,
                                child : Icon(Icons.notifications_active_outlined,size: 50)
                              ),
                              Expanded(
                                flex : 8,
                                child : 
                                  Container(       
                                    margin: EdgeInsets.only(left : 10),
                                    child : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children : [
                                        Padding(padding: EdgeInsets.only(top : 10),child : Text(notification.items[i].title ?? "-",style : TextStyle(fontWeight:  FontWeight.bold,fontSize: 14))),
                                        Padding(padding: EdgeInsets.only(top : 5),child : Text(notification.items[i].content ?? "-",style : TextStyle(fontSize: 12))),
                                        Padding(padding: EdgeInsets.only(top : 5),child : Row(                               
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [Text("27 detik yang lalu",style: TextStyle(fontSize: 9))]
                                          )
                                        )
                                      ]
                                    )
                                  )
                              )
                            ]
                          )
                        )                  
                      ))),
                      Container(
                        margin: EdgeInsets.only(top : 20),
                        alignment: Alignment.center,child : TextButton(
                        child : Text("Next"),
                        onPressed: (){
                          var newPage = {
                            ...Provider.of<NotificationProvider>(context,listen : false).itemsPagination,
                            "current_page" : ( int.parse(Provider.of<NotificationProvider>(context,listen : false).itemsPagination["current_page"]) + 1).toString()
                          };

                          Provider.of<NotificationProvider>(context,listen : false).setPagination(newPage);

                          Provider.of<NotificationProvider>(context,listen : false).onLoad();
                        }
                      )),
                    ]
                  );
                }

                return Container(
                  child : Padding(padding: EdgeInsets.only(left: 5,right: 4),child : Container(    
                  decoration: BoxDecoration(              
                    shape: BoxShape.rectangle,
                    color : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top : 30),              
                  key : ValueKey(notification.items[i].id),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child : Row(
                      children: [
                        Expanded(
                          flex : 2,
                          child : Icon(Icons.notifications_active_outlined,size: 50)
                        ),
                        Expanded(
                          flex : 8,
                          child : 
                            Container(       
                              margin: EdgeInsets.only(left : 10),
                              child : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children : [
                                  Padding(padding: EdgeInsets.only(top : 10),child : Text(notification.items[i].title ?? "-",style : TextStyle(fontWeight:  FontWeight.bold,fontSize: 14))),
                                  Padding(padding: EdgeInsets.only(top : 5),child : Text(notification.items[i].content ?? "-",style : TextStyle(fontSize: 12))),
                                  Padding(padding: EdgeInsets.only(top : 5),child : Row(                               
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [Text("27 detik yang lalu",style: TextStyle(fontSize: 9))]
                                    )
                                  )
                                ]
                              )
                            )
                        )
                      ]
                    )
                  )                  
                )));
              }
            ));
          }           
        );    
      }
    );
  }
}