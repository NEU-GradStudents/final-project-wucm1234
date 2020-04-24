import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyStructure{
  final int id;
  final String text;
  MyStructure({this.id, this.text});
}

class InnerSwiper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _InnerSwiperState();
  }
}

class MyWidget extends StatelessWidget{
  final MyStructure widgetStructure;
  MyWidget(this.widgetStructure);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(widgetStructure.id.toString() + widgetStructure.text),

    );
  }
}

class _InnerSwiperState extends State<InnerSwiper> {
  SwiperController controller;

  List<bool> autoplayes;

  List<SwiperController> controllers;
  List<MyStructure> widgetList = [];

  @override
  void initState() {
    controller = new SwiperController();
    autoplayes = new List()
      ..length = 10
      ..fillRange(0, 10, false);
    controllers = new List()
      ..length = 10
      ..fillRange(0, 10, new SwiperController());

    for(int i=0;i < 10; i++) {
      widgetList.add(MyStructure(id:i,text: ' this is index ${i}'));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: new Scaffold(

        body: new Swiper(

          loop: false,
          itemCount: widgetList.length,
          controller: controller,
          pagination: new SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {

            return new Column(
              children: <Widget>[
                new SizedBox(
                  height: 400,
                  child: new Swiper(
                    controller: controllers[index],
                    pagination: new SwiperPagination(),
                    itemCount: widgetList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyWidget(widgetList[index]);
                    },
                    autoplay: autoplayes[index],
                  ),

                ),
                new RaisedButton(
                  onPressed: () {
                    setState(() {
                      autoplayes[index] = true;
                    });
                  },
                  child: new Text("Start autoplay"),
                ),
                new RaisedButton(
                  onPressed: () {
                    setState(() {
                      autoplayes[index] = false;
                    });
                  },
                  child: new Text("End autoplay"),
                ),
                new Text("is autoplay: ${autoplayes[index]}")
              ],
            );
          },
        ),
      ),
    );
  }
}