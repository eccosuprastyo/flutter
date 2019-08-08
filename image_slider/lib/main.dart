import 'package:flutter/material.dart';
import 'package:simple_slider/simple_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  final _imageUrls = [
    "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
    "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
    "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
  ];


  @override
  Widget build(BuildContext context) {
    var title = "Image Slider Widget";
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child: ImageSliderWidget(
            imageUrls: _imageUrls,
            imageBorderRadius: BorderRadius.circular(10.0),
            imageHeight: 8,
          ),
        ),
      ),
    );
  }
}