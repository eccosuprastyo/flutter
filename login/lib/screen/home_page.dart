import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  HomeScreen(this.signOut);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  signOut() {
   setState(() {
     widget.signOut();
   });
 }

 var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
 void initState() {
   // TODO: implement initState
   super.initState();
   getPref();
 }


   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        actions: <Widget>[
           IconButton(
             onPressed: () {
               signOut();
             },
             icon: Icon(Icons.lock_open),
           )
         ],
      ),
      body: new Center(
        child: new Text("Home Page"),
      ),
    );
  }
}