import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MaterialApp(
      home: CameraConnect(),
      debugShowCheckedModeBanner: false,
    ));

class CameraConnect extends StatefulWidget {
  @override
  _CameraConnectState createState() => _CameraConnectState();
}

class _CameraConnectState extends State<CameraConnect> {
  File image;

  //connect camera
  cameraConnect() async {
    print('Picker is Called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Connect'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          child: image == null ? Text('No Image Showing') : Image.file(image),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_a_photo),
        onPressed: cameraConnect,
      ),
    );
  }
}
