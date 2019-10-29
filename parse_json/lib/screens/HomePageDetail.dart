import 'package:flutter/material.dart';

class HomePageDetail extends StatefulWidget {
  String dName, dEmail, dPhone, dCity, dZip;

  HomePageDetail({this.dName, this.dEmail, this.dPhone, this.dCity, this.dZip});

  @override
  _HomePageDetailState createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'With One Class',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${widget.dName}",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Email : ${widget.dEmail}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Phone : ${widget.dPhone}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "City : ${widget.dCity}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Zip Postal : ${widget.dZip}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              children: <Widget>[
                new NameDetail(
                  name: widget.dName,
                  email: widget.dEmail,
                ),
                new BagianIcon(),
                new BagianContact(
                  phone: widget.dPhone,
                  city: widget.dCity,
                  postal: widget.dZip,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NameDetail extends StatelessWidget {
  final String name, email;
  NameDetail({this.name, this.email});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 24),
                ),
                Text(
                  "Email : $email",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.star,
                size: 40,
                color: Colors.orange,
              ),
              Text(
                "12",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}

class BagianIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          IconText(iconData: Icons.camera, text: "Camera",),

          IconText(iconData: Icons.phone, text: "Phone",),

          IconText(iconData: Icons.message, text: "Message",),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  IconText({this.iconData, this.text});
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Column(
        children: <Widget>[
          Icon(
            iconData,
            size: 20,
            color: Colors.green,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class BagianContact extends StatelessWidget {
  String phone, city, postal;

  BagianContact({this.phone, this.city, this.postal});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'With many Class',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Text(
                  phone,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  city,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Text(
                  postal,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}