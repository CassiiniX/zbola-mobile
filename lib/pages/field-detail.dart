import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import "../widgets/sidebar.dart";

import '../providers/user.dart';
import "../providers/review.dart";

import "../modals/order.modal.dart";

import './signin.dart';

// ignore: must_be_immutable
class FieldDetail extends StatelessWidget{
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  bool? isLogin;
  
  FieldDetail(BuildContext context, {Key? key}) : super(key: key){
    isLogin = Provider.of<UserProvider>(context).getIsLogin();
  } 

  backgroundContainer(context){
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color : Colors.greenAccent[700],      
      ),
      child: Padding(
        padding : const EdgeInsets.only(top : 20,left : 10,right : 30),
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            TextButton(
              child : const Icon(Icons.align_horizontal_left,size : 30,color: Colors.white),
              onPressed: () => _keyScaffold.currentState!.openDrawer()            
            ),

            TextButton(
              child : const Icon(Icons.notifications_active,size : 30,color: Colors.white),
              onPressed: () => _keyScaffold.currentState!.openDrawer()            
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    if(isLogin != true){
      return Signin(context);
    }

    return MaterialApp(
      home : Scaffold(
        key : _keyScaffold,
        drawer: Sidebar(parentContext: context),
         floatingActionButton :  Column(           
          mainAxisAlignment: MainAxisAlignment.end,           
          children: [
            ElevatedButton(        
              style : ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                primary: Colors.greenAccent,
                onPrimary: Colors.white,          
                textStyle: const TextStyle(fontSize: 12),
                fixedSize : const Size(60,60),
                shape: const CircleBorder(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_basket,size: 15),
                  Padding(
                    padding: EdgeInsets.only(left : 3),
                    child : Text("Pesan",style: TextStyle(fontSize: 12))
                  )
                ]                                                
              ),
              onPressed: (){
                showModalBottomSheet(      
                  backgroundColor: Colors.transparent,         
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => OrderModal(context)                
                );                 
              },
            ),
          ]
          ),



        body :  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(height: MediaQuery.of(context).size.height  + 900), 

                  backgroundContainer(context),

                  Positioned(
                    top : 70,              
                    width: MediaQuery.of(context).size.width,                                   
                    child: Column(
                      children: [
                        FieldDetailPhoto(),

                        Padding(padding: EdgeInsets.only(top : 10)),
                    
                        FieldDetailInfo(),

                        Padding(padding: EdgeInsets.only(top : 10)),

                        FieldDetailReview()
                      ]
                    ),
                  )
                ],
              ),  
            ]
          )
        )
      )
    );
  }
}

class FieldDetailPhoto extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color:  Colors.transparent
      ),
      constraints: const BoxConstraints(
        minHeight: 250,
      ),
      width: MediaQuery.of(context).size.width  * 0.8,
      child : Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[         
            const Padding(padding: EdgeInsets.only(top : 10),),

            Container(   
              clipBehavior: Clip.none,
              height: 200,            
              decoration: const BoxDecoration(color: Colors.transparent),                
              child :  Stack(
                clipBehavior: Clip.none,
                children : [
                  Positioned(
                    child : 
                      Container(   
                        child: Image.asset(
                              'images/product-1.png',
                              alignment: Alignment.center,
                              height : 200,
                              fit : BoxFit.cover
                          )                  
                    ),        
                  ),
                  Positioned(
                    right: -20,
                    top : 80,
                    child :ElevatedButton(                                                
                      style: ElevatedButton.styleFrom(                        
                        primary: Colors.white,
                        shape: const CircleBorder(),
                        padding: const  EdgeInsets.all(15),  
                      ),
                      onPressed: (){
                      },
                      child : const Icon(Icons.keyboard_arrow_right,color: Colors.blueAccent,size: 28,),                                                                      
                    )                      
                  ),
                  Positioned(
                    left: -20,
                    top : 80,
                    child :ElevatedButton(                                                
                      style: ElevatedButton.styleFrom(                        
                        primary: Colors.white,
                        shape: const CircleBorder(),
                        padding: const  EdgeInsets.all(15),  
                      ),
                      onPressed: (){
                      },
                      child : const Icon(Icons.keyboard_arrow_left,color: Colors.blueAccent,size: 28,),                                                                      
                    )                      
                  )                          
              ])                                                
            ),                                    
          ]
        )      
    );
  }
}


class FieldDetailInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
        constraints: const BoxConstraints(
          minHeight: 200,
        ),
        width: MediaQuery.of(context).size.width  * 0.8,
        child : Card(
          elevation: 1.5,
          child: Padding(padding: EdgeInsets.all(20),child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top : 5,bottom: 5),
                  child : Text("Address",style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
              ),
              Padding( 
                padding : EdgeInsets.only(top : 5,bottom: 5),
                child : Text("Rp 50.000.00 Perjam",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color : Colors.green))
              ),
              
              Container(
              margin: EdgeInsets.only(top : 20,bottom : 20),
              // color: Colors.black,
              child : Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex : 1,
                     child: Container(
                      child : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.star,color : Colors.black,size : 20),
                          Padding(padding : EdgeInsets.only(top : 5,bottom: 5),),
                          Text("Bintang"),
                          Padding(padding : EdgeInsets.only(top : 5,bottom: 5),),
                          Icon(Icons.star,color: Colors.yellow,size : 14)
                        ],
                      ),
                      color : Colors.white
                    )
                  ),
                  Flexible(
                    flex : 1,
                    child: Container(
                      child : Column(
                        children: [
                          Icon(Icons.wb_sunny,color : Colors.black,size : 20),
                          Padding(padding : EdgeInsets.only(top : 5,bottom: 5),),
                          Text("Status"),
                          Padding(padding : EdgeInsets.only(top : 5,bottom: 5),),
                          Text("Tidak Tersewa",style : TextStyle(color : Colors.greenAccent,fontSize : 14))
                        ],
                      ),
                      color : Colors.white
                    )
                  ),
                  Flexible(
                    flex : 1,
                      child: Container(
                      child : Column(
                        children: [
                          Icon(Icons.calendar_today, color : Colors.black,size : 20),
                          Padding(padding : EdgeInsets.only(top : 5,bottom: 5),),
                          Text("Di publish"),
                          Padding(padding : EdgeInsets.only(top : 5,bottom: 5),),
                          Text("10 jam yang lalu",style : TextStyle(color : Colors.greenAccent,fontSize : 14))
                        ],
                      ),
                      color : Colors.white
                    )
                  )
                ],
              ),
            ),
              
              Padding(
                  padding: EdgeInsets.only(top : 10,bottom: 5),
                  child : Text("Deskripsi",style : TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
              ),
              Padding( 
                padding : EdgeInsets.only(top : 5,bottom: 5),
                child : Text("deskripsi",style: TextStyle(fontSize: 12))
              ),

              Padding(
                  padding: EdgeInsets.only(top : 10,bottom: 5),
                  child : Text("Fasilitas",style : TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
              ),
              Padding( 
                padding : EdgeInsets.only(top : 5,bottom: 5),
                child : Text("Fasilitas",style: TextStyle(fontSize: 12))
              ),

              Padding(
                  padding: EdgeInsets.only(top : 10,bottom: 5),
                  child : Text("Pertanyaan",style : TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
              ),
              Padding( 
                padding : EdgeInsets.only(top : 5,bottom: 5),
                child : Text("Pertanyaan",style: TextStyle(fontSize: 12))
              ),
            ]
          )),
        )
      );    
  }
}



class FieldDetailReview extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        shape : BoxShape.rectangle,
      ),
      clipBehavior: Clip.hardEdge,
        constraints: const BoxConstraints(
          maxHeight: 500,          
        ),
        width: MediaQuery.of(context).size.width  * 0.8,
        child : Card(
          elevation: 1.5,
          child: Padding(padding: EdgeInsets.all(20),child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top : 5,bottom: 5),
                  child : Text("Review",style : TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
              ),
           
              Expanded(child: Container(
                margin: EdgeInsets.only(top : 20,bottom : 20),
                // color: Colors.black,
                child : FieldDetailReviewScreen()
              ))            
            ]
          )),
        )
      );    
  }
}

class FieldDetailReviewScreen extends StatefulWidget{
  @override 
  FieldDetailReviewScreenState createState() => FieldDetailReviewScreenState();
}

class FieldDetailReviewScreenState extends State<FieldDetailReviewScreen>{

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future:  Provider.of<ReviewProvider>(context,listen : false).onLoad(),
      builder: (ctx,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              heightFactor:  15,
              child: CircularProgressIndicator(color: Colors.greenAccent),
            );
          }

          if(snapshot.error != null){
            return const Center(
              heightFactor:  15,
              child: Text("Terjadi Kesalahan",style : TextStyle(color: Colors.red)),
            );
          }   

          return Consumer<ReviewProvider>(
            builder: (context,review,child){
                if(review.items.isEmpty){
                  return Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ]));
                } 

            return Padding(  
              padding: const EdgeInsets.only(top: 10,right : 10,left: 10,bottom : 50),
              child: ListView.builder(
                    shrinkWrap: true,
                    itemCount : review.items.length,
                    itemBuilder :(ctx,i){  
                        var mainContainer =  Container(
                          child : Column(
                            children: [  
                             Container(           
                                margin: const EdgeInsets.only(top : 50),                               
                                child : Padding(padding: EdgeInsets.all(10),
                                  child : Column(  
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,       
                                  children: [                                     
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children : [
                                        Image.asset(
                                          'images/default.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,                                    
                                        ),
                                        Padding(padding: EdgeInsets.only(left : 10)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("User",style: TextStyle(fontSize: 12)),
                                            Icon(Icons.star,color: Colors.yellow,size : 14)
                                          ],
                                        )]
                                    ),                             

                                    Padding(padding: EdgeInsets.only(top : 20)),

                                    Text("Description",style : TextStyle(fontSize : 15)),

                                    Padding(padding: EdgeInsets.only(top : 10)),

                                    Row(
                                      mainAxisAlignment : MainAxisAlignment.end, 
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child : Text("1 Jam yang lalu",style : TextStyle(fontSize: 13))
                                        ),
                                      ],
                                    )
                                  ])                                                    
                            )),
                          ])
                        );             

                      if(review.items.length == (i+1)){
                        return Column(         
                          key : ValueKey(i),           
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children : [
                            mainContainer,

                            Container(
                              margin: const EdgeInsets.only(top : 20),
                              alignment: Alignment.center,
                              child : TextButton(
                                child : Provider.of<ReviewProvider>(context,listen :  false).isLoadingNext ? const Text(" . . . ") : const Text("Next"),
                                onPressed: (){
                                  var newPage = {
                                    ...Provider.of<ReviewProvider>(context,listen : false).itemsPagination,
                                    "current_page" : ( int.parse(Provider.of<ReviewProvider>(context,listen : false).itemsPagination["current_page"]) + 1).toString()
                                  };

                                  Provider.of<ReviewProvider>(context,listen : false).setPagination(newPage);

                                  Provider.of<ReviewProvider>(context,listen : false).onNext();                             
                                }
                              )
                            ),
                          ]
                        );
                      }    

                      return mainContainer;       
                    }
              ));
          });
      });
  }
}