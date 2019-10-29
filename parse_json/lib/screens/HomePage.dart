import 'dart:convert';

import 'package:parse_json/models/user.dart';
import 'package:parse_json/screens/HomePageDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Membuat List Dari data Internet
  List<User> listModel = [];
  var loading = false;
  
  Future<Null> getData() async{
    setState(() {
      loading = true;
    });
    
    final responseData = await http.get("https://jsonplaceholder.typicode.com/users");

    if(responseData.statusCode == 200){
      final data = jsonDecode(responseData.body);
      print(data);
      setState(() {
        for(Map i in data){
          listModel.add(User.fromJson(i));
        }
        loading = false;
      });
    }
  }

  //Panggil Data / Call Data
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Home Page List User'),
        centerTitle: true,
      ),

      body: Container(
        child: loading ? Center (child: CircularProgressIndicator()) : ListView.builder(
          itemCount: listModel.length,
            itemBuilder: (context, i){
              final nDataList = listModel[i];
              return Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageDetail(
                      dName: nDataList.name,
                      dEmail: nDataList.email,
                      dPhone: nDataList.phone,
                      dCity: nDataList.address.city,
                      dZip: nDataList.address.zipcode,
                    )));
                  },
                  child: Card(
                    color: Colors.amber[100],
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(nDataList.name, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green),
                          ),
                          Text(nDataList.email),
                          Text(nDataList.phone),
                          Text(nDataList.website),

                          SizedBox(height: 10,),
                          Text("Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(nDataList.address.street),
                          Text(nDataList.address.city),
                          Text(nDataList.address.suite),
                          Text(nDataList.address.zipcode),

                          SizedBox(height: 10,),
                          Text("Company", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(nDataList.company.name),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),

    );
  }
}