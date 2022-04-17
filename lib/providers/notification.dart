import 'package:flutter/material.dart';
import  "../models/notification.dart";
import 'dart:async';

class NotificationProvider extends ChangeNotifier{  
  List<ModelNotification> items = [];

  Map<String,dynamic> itemsPagination = {    
    "total" : "0",
    "per_page" : "10",
    "current_page" : "0",
    "last_page" : "0",
    "search" : "",  
    "column" : "id",
    "order" : "desc"
  };  

  void setPagination(Map<String,dynamic> pagination){
    itemsPagination = pagination;
  }

  Future<void> onLoad() async {
    Timer(const Duration(seconds: 5), () async{    
      var newItems = [];

      var page = int.parse(itemsPagination["current_page"]) + 1;
      
      for(var i= ( (page - 1)* 20 ) ;i<page*20;i++){
        newItems.add(<String,dynamic>{
          "id" : i,
          "title" : "title"+i.toString(),
          "content" : "contne"+i.toString(),
          "read" : i / 2 == 0 
            ? true 
            : false
        }); 
      }

        items = [
          ...items,
          ...newItems.map((item){
            return ModelNotification(
              id: item["id"], 
              title: item["title"], 
              content: item["content"], 
              read : item["read"]     
            );
          }).toList()
        ];      

        itemsPagination = {
          "current_page" : page.toString(),
          "total" : "0",
          "per_page" : "10",
          "last_page" : "0",
          "search" : "",  
          "column" : "id",
          "order" : "desc"   
        };

        notifyListeners();
    });
  }
}
