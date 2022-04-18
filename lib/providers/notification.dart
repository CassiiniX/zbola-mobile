import 'package:flutter/material.dart';
import  "../models/notification.dart";
import 'dart:async';

class NotificationProvider extends ChangeNotifier{  
  List<ModelNotification> items = [];
  // GUNAKAN ISLOADINGNEXT DI WIDGET ASLINYA DENGAN MENGUNAKAN SETSTATE JIKA INGIN MENGANTI SELURUH COPOMENENT
  bool isLoadingNext = false;

  Map<String,dynamic> itemsPagination = {    
    "current_page" : "1",
    // "total" : "0",
    // "per_page" : "10",
    // "last_page" : "0",
    // "search" : "",  
    // "column" : "id",
    // "order" : "desc"
  };  

  void setPagination(Map<String,dynamic> pagination){
    itemsPagination = pagination;
  }

  Future<void> onNext() async {
    Timer(const Duration(seconds: 0), () async{    
      isLoadingNext = true;  
      notifyListeners();
    });

    return Future<void>.delayed(
      const Duration(seconds: 3),
      (){
        var newItems = [];

        var page = int.parse(itemsPagination["current_page"]);
      
        for(var i= ( (page - 1)* 10 ) ;i<page*10;i++){
          newItems.add(<String,dynamic>{
            "id" : i,
            "title" : "title"+i.toString(),
            "content" : "contne"+i.toString(),
            "read" : i / 2 == 0  ? true : false
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
          // "total" : "0",
          // "per_page" : "10",
          // "last_page" : "0",
          // "search" : "",  
          // "column" : "id",
          // "order" : "desc"   
        };

        isLoadingNext = false; 

        notifyListeners();
      });    
  }

  Future<String> onLoad() async{
    return Future<String>.delayed(
      const Duration(seconds: 3),
      (){
        var newItems = [];

        for(var i=1;i<10;i++){
          newItems.add(<String,dynamic>{
            "id" : i,
            "title" : "title"+i.toString(),
            "content" : "contne"+i.toString(),
            "read" : i / 2 == 0  ? true : false
          }); 
        }

        items = [
          ...newItems.map((item){
            return ModelNotification(
              id: item["id"], 
              title: item["title"], 
              content: item["content"], 
              read : item["read"]     
            );
          }).toList()
        ];      
          
        return Future.value("Berhasil");
        // return Future.error("Terjadi Kesalahan");
      });    
  }
}
