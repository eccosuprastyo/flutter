import 'package:flutter/material.dart';
import 'cart_list.dart';
import 'models/shopping_cart.dart';
import 'models/item.dart';

class ShopListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListWidget> {
  ShoppingCart cart = ShoppingCart();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Item> items = Item.dummyItems;

  @override
  Widget build(BuildContext context) {
    final columnCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;

    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;

    List<Widget> items = [];
    for (var x = 0; x < this.items.length; x++) {
      bool isSideLine;
      if (columnCount == 2) {
        isSideLine = x % 2 == 0;
      } else {
        isSideLine = x % 4 != 3;
      }
      final item = this.items[x];

      items.add(_ShopListItem(
        item: item,
        isInCart: cart.isExists(item),
        isSideLine: isSideLine,
        onTap: (item) {
          _scaffoldKey.currentState.hideCurrentSnackBar();

          if (cart.isExists(item)) {
            cart.remove(item);
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Item is removed from cart!'),
            ));
          } else if (item.inStock) {
            cart.add(item);
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Item is added to cart!'),
            ));
          } else {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Item is out of stock!'),
            ));
          }
          this.setState(() {});
        },
      ));
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Apple Store"),
        ),
        body: GridView.count(
          childAspectRatio: width / height,
          scrollDirection: Axis.vertical,
          crossAxisCount: columnCount,
          children: items,
        ),
        floatingActionButton: cart.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartListWidget(
                            cart: this.cart,
                          )));
                },
                icon: Icon(Icons.shopping_cart),
                label: Text("${cart.numOfItems}"),
              ));
  }
}

class _ShopListItem extends StatelessWidget {
  final Item item;
  final bool isInCart;
  final bool isSideLine;
  dynamic onTap;

  _ShopListItem({this.item, this.isInCart, this.isSideLine, this.onTap});

  @override
  Widget build(BuildContext context) {
    Border border;
    if (isSideLine) {
      border = Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5));
    } else {
      border = Border(bottom: BorderSide(color: Colors.grey, width: 0.5));
    }

    return InkWell(
        onTap: () => this.onTap(item),
        child: Container(
            decoration: BoxDecoration(border: border),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(item.imageUrl),
                  ),
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(item.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(fontSizeFactor: 0.8)),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(item.formattedPrice,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .apply(fontSizeFactor: 0.8)),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(this.isInCart ? "In Cart" : item.formattedAvailability,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.apply(
                        fontSizeFactor: 0.8,
                        color:
                            isInCart ? Colors.blue : item.availabilityColor)),
              ],
            )));
  }
}