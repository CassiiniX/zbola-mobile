import 'package:flutter/material.dart';
import 'package:zbola/providers/notification.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
Widget NotificationModal(BuildContext context){    
  return FractionallySizedBox(
    heightFactor: 0.8,
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
                const Padding(
                  padding : EdgeInsets.only(top : 20,bottom: 20),
                  child : Text("Notification",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                ),
                Container(
                  constraints: BoxConstraints.loose(const Size(double.infinity, 350)),
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

  // ignore: use_key_in_widget_constructors
  const NotificationModalScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  NotificationModalScreenState createState() => NotificationModalScreenState(parentContext);
}

class NotificationModalScreenState extends State<NotificationModalScreen>{
  final BuildContext parentContext;

  NotificationModalScreenState(this.parentContext);

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: Provider.of<NotificationProvider>(context,listen : false).onLoad(),
      builder: (ctx,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(color: Colors.greenAccent),
          );
        }

        if(snapshot.error != null){
          return const Center(
            child: Text("Terjadi Kesalahan",style : TextStyle(color: Colors.red)),
          );
        }   

        return Consumer<NotificationProvider>(
          builder: (context,notification,child){
            if(notification.items.isEmpty){
              return Column(children: [
                Padding(
                    padding : const EdgeInsets.only(top : 20,bottom: 20),
                    child : Image.asset(
                      'images/404.png',
                      // alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      fit : BoxFit.cover
                    )
                  ),
                  const Padding(
                    padding : EdgeInsets.only(top : 20,bottom: 20),
                    child : Text('Data tidak ditemukan',style : TextStyle(fontWeight: FontWeight.bold))
                  ) 
              ]);
            } 
            
            return Padding(
              padding: const EdgeInsets.only(left : 20,right : 20),
              child : ListView.builder(
                itemCount : notification.items.length,
                itemBuilder :(ctx,i){                                 
                  Widget mainNotification = Padding(
                      padding: const EdgeInsets.only(left: 5,right: 4),
                      child : Container(    
                        key : ValueKey(notification.items[i].id),
                        margin: const EdgeInsets.only(top : 30),              
                        decoration: BoxDecoration(              
                          shape: BoxShape.rectangle,
                          color : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 1), // changes position of shadow
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child : Row(
                            children: [
                              const Expanded(
                                flex : 2,
                                child : Icon(Icons.notifications_active_outlined,size: 50)
                              ),
                              Expanded(
                                flex : 8,
                                child : Container(       
                                    margin: const EdgeInsets.only(left : 10),
                                    child : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children : [
                                        Padding(
                                          padding: const EdgeInsets.only(top : 10),
                                          child : Text(notification.items[i].title ?? "-",style : const TextStyle(fontWeight:  FontWeight.bold,fontSize: 14))
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top : 5),
                                          child : Text(notification.items[i].content ?? "-",style : const TextStyle(fontSize: 12))
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top : 5),
                                          child : Row(                               
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: const [
                                              Text("27 detik yang lalu",style: TextStyle(fontSize: 9))
                                            ]
                                          )
                                        )
                                      ]
                                    )
                                )
                              )
                            ]
                          )
                      )
                    )
                  );

                  if(notification.items.length == (i+1)){
                    return Column(         
                      key : ValueKey(notification.items[i].id),           
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : [
                         mainNotification,

                         Container(
                          margin: const EdgeInsets.only(top : 20),
                          alignment: Alignment.center,
                          child : TextButton(
                            child : Provider.of<NotificationProvider>(context,listen :  false).isLoadingNext ? const Text(" . . . ") : const Text("Next"),
                            onPressed: (){
                              var newPage = {
                                ...Provider.of<NotificationProvider>(context,listen : false).itemsPagination,
                                "current_page" : ( int.parse(Provider.of<NotificationProvider>(context,listen : false).itemsPagination["current_page"]) + 1).toString()
                              };

                              Provider.of<NotificationProvider>(context,listen : false).setPagination(newPage);

                              Provider.of<NotificationProvider>(context,listen : false).onNext();                             
                            }
                          )
                        ),
                      ]
                    );
                  }
                  return mainNotification;
                }
              )
            );
          }           
        );    
      }
    );
  }
}