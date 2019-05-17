class Fruits {
  int _id;
  String _name;

  Fruits(this._name);

  Fruits.fromMap(dynamic obj) {
    this._name = obj['name'];
  }

  String get name => _name;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    return map;
  }
}