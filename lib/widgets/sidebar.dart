import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

class Sidebar extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  final parentContext;

  const Sidebar({@required this.parentContext,Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Drawer(child : SidebarScreen(parentContext));
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
  Widget build(BuildContext context){
    return Column(
        children: isShowSubMenu == true ? subMenu() : mainMenu()
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

    Provider.of<UserProvider>(context,listen : false).setIsLogin(false);
    
    Navigator.of(context).pushReplacementNamed("/");     
  }

  List<Widget> subMenu(){
    return <Widget>
      [
        const Divider(),

        ListTile(
          leading: const Icon(Icons.book_sharp),
          title : const Text("Invoice"),
          onTap: () => Navigator.of(parentContext).pushReplacementNamed("/invoice")        
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.bookmark),
          title : const Text("Riwayat Invoice"),
          onTap: () => Navigator.of(parentContext).pushReplacementNamed("/invoice-history")          
        ),

        const Divider(),

        ListTile(          
          title :Row( 
            mainAxisAlignment: MainAxisAlignment.end,
            children : const [
              Icon(Icons.arrow_back,color: Colors.red,),
              Padding(
                  padding: EdgeInsets.only(left : 3),
                  child: Text("Back",style : TextStyle(color: Colors.red))
              )
            ]
          ),
          onTap: () => onHideSubMenu()          
        )
      ];
  }

  List<Widget> mainMenu(){
    return <Widget>
      [
          AppBar(
            backgroundColor: Colors.greenAccent[700],        
            toolbarHeight : 90,
            automaticallyImplyLeading :  false,
            flexibleSpace : Padding(              
              padding: const EdgeInsets.all(20),              
              child : SizedBox(              
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
                          padding : const EdgeInsets.only(left: 10),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("username",style: TextStyle(color: Colors.white)),
                              Text("user@gmail.com",style: TextStyle(color: Colors.white)),
                            ]
                          )
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment : MainAxisAlignment.end,                      
                      children: [
                        TextButton(                  
                          child : const Icon(Icons.edit,color: Colors.white),
                          onPressed: () => Navigator.of(parentContext).pushReplacementNamed("/profil")                          
                        ),
                      ]
                    ),
                  ],
                ))              
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Dashboard"),
            onTap: () => Navigator.of(parentContext).pushReplacementNamed("/dashboard")            
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text("Lapangan"),
            onTap: () => Navigator.of(parentContext).pushReplacementNamed("/field")            
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.book_rounded),
            title : const Text("Invoice"),
            onTap: () => onShowSubMenu()
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.money),
            title : const Text("Riwayat Pembayaran Manual"),
            onTap: () => Navigator.of(parentContext).pushReplacementNamed("/manual-payment-history")            
          ),

          const Divider(),

          ListTile(          
            title :Row( 
              mainAxisAlignment: MainAxisAlignment.end,
              children : const [
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