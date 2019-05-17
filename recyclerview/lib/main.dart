import 'package:flutter/material.dart';
import 'package:recyclerview/fruit.dart';
import 'package:recyclerview/query.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "List in Flutter",
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("List"),
        ),
        body: RandomFruits(),
      ),
    );
  }
}

class RandomFruits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomFruitsState();
  }
}

class RandomFruitsState extends State<RandomFruits>  {

  final _biggerFont = const TextStyle(fontSize: 18.0);
  QueryCtr _query = new  QueryCtr();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Load data from DB'),
      ),
      body: FutureBuilder<List>(
        future: _query.getAllFruits(),
        initialData: List(),
        builder: (context, snapshot) {
            return snapshot.hasData ?
             new ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return _buildRow(snapshot.data[i]);
              },
            )
            : Center(
                          child: CircularProgressIndicator(),
                        );
        },
      )
    );
  }

  Widget _buildRow(Fruits fruit) {
    return new ListTile(
      title: new Text(fruit.name, style: _biggerFont),
    );
  }
}