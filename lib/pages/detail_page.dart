import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garagesale2/pages/inner_swiper.dart';
import 'package:garagesale2/service/database_service.dart';
import 'package:garagesale2/share/scrolling_page.dart';



class ItemDetail extends StatefulWidget {

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();

  }

  Widget buildPage(String text, Color color) {
  //Widget buildPage(String url) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        color: color,
        child: Center(child: Text(text, style: TextStyle(fontSize: 42, color: Colors.white),),),
        //child : Image.network(url),
      ),
    );
  }

  //PageController _controller;

  @override
  Widget build(BuildContext context) {
    int itemId = ModalRoute.of(context).settings.arguments;


    List<String> urls = DatabaseService.getInstance().getUrls(itemId);

    print('==========detailurls$urls');


    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.comment, 'COMMENTS'),

          _buildButtonColumn(color, Icons.person_pin, 'CHAT'),
          _buildButtonColumn(color, Icons.add_shopping_cart, 'ADD ITEM'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );


    List<Widget> items = [
      buildPage("0", Colors.red),
      buildPage("1", Colors.blue),
      buildPage("2", Colors.green),
      buildPage("3", Colors.amber),
      buildPage("4", Colors.deepPurple),
      buildPage("5", Colors.teal),
      buildPage("6", Colors.pink),
      buildPage("7", Colors.brown)
    ];
    
//    List<Widget> getImgLists (urls){
//      print('=========into function getImgLists');
//      List<Widget> temp = List();
//      if(urls!= null){
//        for(String url in urls){
//          temp.add(buildPage(url));
//        }
//      }
//      print('============temp.length=${temp.length}');
//      print('============temp.urls=${urls}');
//      return temp;
//    }
    

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Garage Sale Item Detail"),
        ),
        body: SizedBox(
          //height: 300,
          child: Column(
            children: <Widget>[
              titleSection,
              Expanded(
                child: PageView(
                  //children: getImgLists(urls),
                  children: items,
                  controller: _controller,
                ),
              ),
              ScrollingPageIndicator(
                dotColor: Colors.grey,
                dotSelectedColor: Colors.blueGrey,
                dotSize: 6,
                dotSelectedSize: 8,
                dotSpacing: 12,
                controller: _controller,
                itemCount: items.length,
                orientation: Axis.horizontal,
              ),

              textSection,
              buttonSection

            ],
          ),
        ),
      ),
//
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}


