import 'package:flutter/material.dart';

import '../modals/notification-modal.dart';

PreferredSizeWidget defaultAppBar(String title,BuildContext context){
  return AppBar(
        backgroundColor: Colors.greenAccent[700],
        title : Container(
          alignment: Alignment.center,
          child : Text(title)
        ),  
        // leading: IconButton(
        //   icon: const Icon(Icons.align_horizontal_left),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ), 
        actions: <Widget>[
          IconButton(
            iconSize: 30,
            onPressed: (){
              showModalBottomSheet(      
                backgroundColor: Colors.transparent,         
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) => NotificationModal(context)                
              );
            },
            icon: const Icon(Icons.notifications_active)
          ),
        ]   
      );
}
