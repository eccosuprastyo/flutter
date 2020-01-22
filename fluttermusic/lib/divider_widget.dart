import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  EdgeInsets _margin;

  DividerWidget({margin: EdgeInsets}) {
    if (margin != null) {
      this._margin = margin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).dividerColor,
      margin: _margin,
    );
  }
}
