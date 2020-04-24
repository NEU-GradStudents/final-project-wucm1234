import 'package:flutter/cupertino.dart';

class ItemDescription extends StatelessWidget {
  const ItemDescription({
    Key key,
    this.title,
    this.price,
    this.description,
  }) : super(key: key);

  final String title;
  final int price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            price.toString(),
            style: const TextStyle(fontSize: 12.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            description,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}