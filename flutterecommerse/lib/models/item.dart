import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  String id;
  String name;
  String description;
  int price;
  bool inStock;
  String imageUrl;

  Item(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.inStock,
      this.imageUrl});

  String get formattedAvailability => inStock ? "Available" : "Out of stock";
  String get formattedPrice => Item.formatter.format(this.price);
  Color get availabilityColor => inStock ? Colors.grey : Colors.red;

  static final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: "Rp ");

  static List<Item> get dummyItems => [
        Item(
            id: "1",
            name: "iPhone X🅁 (Product RED)             ",
            description: 'More magical than ever.',
            price: 12499999,
            inStock: true,
            imageUrl:
                'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone/xr/iphone-xr-red-select-201809?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1551226038669'),
        Item(
            id: "2",
            name: "AirPods with Wireless Charging Case",
            description: 'More magical than ever.',
            price: 2999999,
            inStock: true,
            imageUrl:
                'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/M/RX/MRXJ2/MRXJ2?wid=1144&hei=1144&fmt=jpeg&qlt=95&op_usm=0.5%2C0.5&.v=1551489675083'),
        Item(
            id: "3",
            name: "iPhone X🅂 Max (GOLD)",
            description: 'More magical than ever.',
            price: 18999999,
            inStock: true,
            imageUrl:
                'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone/xs/iphone-xs-max-gold-select-2018?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1550795409154'),
        Item(
            id: "4",
            name: "iPhone X🅂 (SILVER)",
            description: 'More magical than ever.',
            price: 14999999,
            inStock: true,
            imageUrl:
                'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone/xs/iphone-xs-silver-select-2018?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1550795411708'),
        Item(
            id: "5",
            name: "iPad Pro (SPACE GRAY)",
            description: 'More magical than ever.',
            price: 13999999,
            inStock: true,
            imageUrl:
                'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/i/pa/ipad/pro/ipad-pro-11-select-cell-spacegray-201810?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1540591731427'),
        Item(
            id: "6",
            name: "Apple Watch Silver Aluminum (44 mm)",
            description: 'More magical than ever.',
            price: 8999999,
            inStock: false,
            imageUrl:
                'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/4/4/44/alu/44-alu-silver-sport-white-s4-1up?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1539190366920'),
      ];
}