import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

class Sidebar extends StatelessWidget{
  final parentContext;

  Sidebar({
    @required this.parentContext
  });

  @override 
  Widget build(BuildContext context){
    return Drawer(
      child : SidebarScreen(parentContext)
    );
  }
}

class SidebarScreen extends StatefulWidget{
  final BuildContext parentContext;

  // ignore: use_key_in_widget_constructors
  const SidebarScreen(this.parentContext);

  @override 
  // ignore: no_logic_in_create_state
  SidebarScreenState createState() => SidebarScreenState(parentContext);
}

class SidebarScreenState extends State<SidebarScreen>{
  final BuildContext parentContext;

  bool isShowSubMenu = false;

  SidebarScreenState(this.parentContext);

  @override 
  void dispose(){    
    super.dispose();
  }

  @override 
  Widget build(BuildContext context){
    return Column(
        children: isShowSubMenu == true 
          ? subMenu() 
          : mainMenu()
    );
  }

  void onShowSubMenu(){
    setState(() => {
      isShowSubMenu = true
    });
  }

  void onHideSubMenu(){
    setState(() => {
      isShowSubMenu = false
    });
  }

  void onLogout(context) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');

    // await prefs.remove("user");

    Provider.of<UserProvider>(context,listen : false).setIsLogin(false);

    // await Future.delayed(Duration(seconds: 30));
    
    Navigator.of(context).pushReplacementNamed("/");     
    
    // Navigator.of(context).pop();           
  }

  List<Widget> subMenu(){
    return <Widget>[
        Divider(),

        ListTile(
          leading: Icon(Icons.book_sharp),
          title : Text("Invoice"),
          onTap: (){
            Navigator.of(parentContext).pushReplacementNamed("/invoice");
          },
        ),

        Divider(),

        ListTile(
          leading: Icon(Icons.bookmark),
          title : Text("Riwayat Invoice"),
          onTap: (){
            Navigator.of(parentContext).pushReplacementNamed("/invoice-history");
          },
        ),

        Divider(),

        ListTile(          
          title :Row( 
            mainAxisAlignment: MainAxisAlignment.end,
            children : [
              Icon(Icons.arrow_back,color: Colors.red,),
              Padding(
                  padding: EdgeInsets.only(left : 3),
                  child: Text("Back",style : TextStyle(color: Colors.red))
              )
            ]
          ),
          onTap: () => {
            onHideSubMenu()
          }
        )
    ];
  }

  List<Widget> mainMenu(){
    return <Widget>[
          AppBar(
            backgroundColor: Colors.greenAccent[700],
            // title: Text("Menu"),
            flexibleSpace : Padding(              
                padding: EdgeInsets.all(20),              
                child : Container(
                  // decoration: BoxDecoration(color: Colors.red),              
                  height: 45,
                  child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textBaseline: TextBaseline.alphabetic,                
                  children: [
                    Row(
                      children: [
                        Image.asset(
                            'images/default.png',
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            fit : BoxFit.cover
                        ),
                        Padding(
                          padding :EdgeInsets.only(left: 10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text("username",style: TextStyle(color: Colors.white)),
                          Text("user@gmail.com",style: TextStyle(color: Colors.white),),
                        ]))
                      ],
                    ),
                    Column(
                      mainAxisAlignment : MainAxisAlignment.end,                      
                      children: [
                        TextButton(                  
                          child : Icon(Icons.edit,color: Colors.white),
                          onPressed: (){
                            Navigator.of(parentContext).pushReplacementNamed("/profil");
                          }
                        ),
                      ]
                    ),
                  ],
                ))              
            ),
            toolbarHeight : 90,
            automaticallyImplyLeading :  false
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dashboard"),
            onTap: (){
              Navigator.of(parentContext).pushReplacementNamed("/dashboard");
            }
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text("Lapangan"),
            onTap: (){
              Navigator.of(parentContext).pushReplacementNamed("/field");
            }
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.book_rounded),
            title : Text("Invoice"),
            onTap: (){
              onShowSubMenu();
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.money),
            title : Text("Riwayat Pembayaran Manual"),
            onTap: (){
              Navigator.of(parentContext).pushReplacementNamed("/manual-payment-history");
            },
          ),

          Divider(),

          ListTile(          
            title :Row( 
              mainAxisAlignment: MainAxisAlignment.end,
              children : [
                Icon(Icons.logout,color: Colors.red,),
                Padding(
                    padding: EdgeInsets.only(left : 3),
                    child: Text("Logout",style : TextStyle(color: Colors.red))
                )
              ]
            ),
            onTap: () => onLogout(parentContext)
          )
        ];
  }
}