import 'package:flutter/material.dart';
import 'dart:async';

class FieldProvider extends ChangeNotifier{  
  List<int> items = [];
  bool isLoadingNext = false;

  Map<String,dynamic> itemsPagination = {    
    "current_page" : "1",    
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
          newItems.add(1); 
        }

        items = [
          ...items,
          ...newItems
        ];      

        itemsPagination = {
          "current_page" : page.toString(),          
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
          newItems.add(1);
        }

        items = [
          ...newItems
        ];      
          
        return Future.value("Berhasil");
        // return Future.error("Terjadi Kesalahan");
      });    
  }
}
